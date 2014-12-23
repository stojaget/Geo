using System;

using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Text;
using iTextSharp.text;
using System.Collections.Generic;
using iTextSharp.text.pdf;
using System.Web.UI.WebControls.WebParts;

using System.Collections;
using System.Collections.Specialized;
using System.Globalization;
using System.Drawing;
using System.Configuration;
using System.Data;


namespace Geodezija
{
    public partial class Vrijeme : System.Web.UI.Page
    {
        
        int vrijemeID;
        string user;
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (GridView1.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'GridView1', 'HeaderDiv');</script>");
            }
            lblStatus.Text = "";
            lblUser.Text = User.Identity.Name;
            if (!IsPostBack)
            {
               
            }
            if (Session["FiltExp"] != null)
                SqlDataSource1.FilterExpression = Session["FiltExp"].ToString();
            NapuniGrid();
        }

        private void NapuniGrid()
        {
            int radnik = -1;
            string od = "";
            string dod = "";
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("dbo.spVrijeme", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RADNIKID", DBNull.Value);
            cmd.Parameters.AddWithValue("@OD", DBNull.Value);
            cmd.Parameters.AddWithValue("@DO", DBNull.Value);


            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dset = new DataSet();
            adapter.Fill(dset, "t1");
            var result = cmd.ExecuteReader();
            GridView1.EmptyDataText = "No Records Found";
            //DataView dvEmp = dset.Tables["t1"].DefaultView;
            //dvEmp.Sort = ViewState["SortExpr"].ToString();
            GridView1.DataSource = dset.Tables["t1"];
            GridView1.DataBind();

            conn.Close();

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Kopiraj")
            {
                // dohvaćamo šifru i onda radimo select podataka za nju

                // Retrieve the row index stored in the 
                // CommandArgument property.
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView1.Rows[index];

                int sifra = Convert.ToInt32(row.Cells[1].Text);
                Vrijeme selectan = Select_Vrijeme(sifra);

                user = lblUser.Text;
                int radnik = Helper.NadjiOperatera(user);
                string datum = DateTime.Now.ToShortDateString();
                int vrijeme = Insert_Vrijeme(Convert.ToDateTime(datum), selectan.Dolazak, selectan.Odlazak, selectan.Blagdan, selectan.Godisnji, selectan.Bolovanje, selectan.Napomena, radnik, selectan.sati);

                if (vrijeme == -1)
                {
                    lblStatus.Text = "Greška prilikom kopiranja radnog vremena. ";
                }
                else
                {
                    GridView1.DataBind();
                    // show the result
                    lblStatus.Text = "Uspješno je spremljeno radno vrijeme sa šifrom " + vrijeme;
                    // sada prikaži dialog box gdje pita ako je km>70 da obračuna terenski dodatak

                }
            }
            if (e.CommandName == "MKopiraj")
            {
                LinkButton btndetails = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btndetails.NamingContainer;

                int sifra = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex].Value.ToString());
                Session["vrijeme"] = sifra;
                vrijemeID = sifra;
                //Calendar1.SelectedDates.Clear();
                lblPor.Text = "";
                ViewState["MultipleSelectedDates"] = null;
                Popup(true);
            }
        }

        public static Vrijeme Select_Vrijeme(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string selectSQL = "SELECT * FROM [Evid_vrijeme] WHERE sifra = @sifra";
            SqlConnection con = new SqlConnection(connectionString);
            Vrijeme selVrijeme = new Vrijeme();
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            cmd.Parameters.AddWithValue("@sifra", sifra);
            SqlDataReader reader;

            try
            {
                con.Open();
                reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    selVrijeme.Sifra = Convert.ToInt32(reader["sifra"]);
                    selVrijeme.Datum = Convert.ToDateTime(reader["datum"]);
                    if (reader["dolazak"] != DBNull.Value)
                    {
                        selVrijeme.Dolazak = 0.00m; ;
                    }
                    selVrijeme.Dolazak = Convert.ToDecimal(reader["dolazak"]);
                    if (reader["odlazak"] != DBNull.Value)
                    {
                        selVrijeme.Odlazak = 0.00m;
                    }

                    selVrijeme.Odlazak = Convert.ToDecimal(reader["odlazak"]);
                    if (reader["blagdan"] != DBNull.Value)
                    {
                        selVrijeme.Blagdan = Convert.ToBoolean(reader["blagdan"]);
                    }
                    if (reader["godisnji"] != DBNull.Value)
                    {
                        selVrijeme.Godisnji = Convert.ToBoolean(reader["godisnji"]);
                    }
                    if (reader["bolovanje"] != DBNull.Value)
                    {
                        selVrijeme.Bolovanje = Convert.ToBoolean(reader["bolovanje"]);
                    }

                    selVrijeme.Napomena = reader["napomena"].ToString();
                    selVrijeme.radnikID = Convert.ToInt32(reader["radnikID"]);
                    selVrijeme.sati = Convert.ToDecimal(reader["sati"]);
                }
                reader.Close();
                return selVrijeme;

            }
            /*
        catch (Exception err)
        {
             lblStatus.Text = "Greška prilikom spremanja loko vožnje. ";
            lblStatus.Text += err.Message;
        }
           */
            finally
            {
                con.Close();
            }
        }


        // metoda za kopiranje radnog vremena
        public int Insert_Vrijeme(DateTime datum, decimal dolazak, decimal odlazak, bool blagdan, bool godisnji, bool bolovanje,
            string napomena, int radnikID, decimal sati)
        {
            int vrijemeID = 0;
            string insertSQL;

            insertSQL = "INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID, @sati);SELECT SCOPE_IDENTITY();";
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@datum", datum);
            cmd.Parameters.AddWithValue("@dolazak", dolazak);
            cmd.Parameters.AddWithValue("@odlazak", odlazak);
            cmd.Parameters.AddWithValue("@blagdan", blagdan);
            cmd.Parameters.AddWithValue("@godisnji", godisnji);
            cmd.Parameters.AddWithValue("@bolovanje", bolovanje);
            cmd.Parameters.AddWithValue("@napomena", napomena);
            cmd.Parameters.AddWithValue("@radnikID", radnikID);
            cmd.Parameters.AddWithValue("@sati", sati);
            try
            {
                con.Open();
                // added = cmd.ExecuteNonQuery();
                vrijemeID = Convert.ToInt32(cmd.ExecuteScalar());
                lblStatus.Text = "Uneseno je radno vrijeme sa šifrom " + vrijemeID;
            }
            catch (Exception err)
            {
                vrijemeID = -1;
                lblStatus.Text = "Greška prilikom spremanja radnog vremena. ";
                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            return (vrijemeID);
        }

        protected void btnPdf_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition",
                                        "attachment;filename=Export.pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                StringWriter sw = new StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                GridView1.AllowPaging = false;
                GridView1.DataBind();
                GridView1.RenderControl(hw);
                GridView1.HeaderStyle.BackColor = System.Drawing.Color.Aqua;
                GridView1.HeaderRow.Style.Add("width", "15%");
                GridView1.HeaderRow.Style.Add("font-size", "10px");
                GridView1.HeaderRow.Style.Add("font-color", "Black");
                GridView1.Style.Add("text-decoration", "none");
                GridView1.Style.Add("font-family", "Arial, Helvetica, sans-serif;");
                GridView1.Style.Add("font-size", "8px");
                StringReader sr = new StringReader(sw.ToString());
                iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document(PageSize.A4, 7f, 7f, 7f, 0f);
                iTextSharp.text.html.simpleparser.HTMLWorker htmlparser = new iTextSharp.text.html.simpleparser.HTMLWorker(pdfDoc);
                PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();
                htmlparser.Parse(sr);
                pdfDoc.Close();
                Response.Write(pdfDoc);
                Response.End();
            }
            catch (Exception ex)
            {
                string ErrMsg = ex.Message;
            }
        }

        protected void ExportToExcel(object sender, EventArgs e)
        {

            //  pass the grid that for exporting ...
            // 
            GridView1.DataBind();
            //GridViewExportUtil.Export("Customers.xls", this.GridView1);
            ExportToExcel("Excel.xls", GridView1);
            GridView1 = null;
            GridView1.Dispose();

        }

        private void ExportToExcel(string strFileName, GridView gv)
        {
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment; filename=" + strFileName);
            Response.ContentType = "application/excel";
            System.IO.StringWriter sw = new System.IO.StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            gv.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void DetailsView1_ItemCreated(object sender, EventArgs e)
        {
            GridView1.DataBind();
        }

        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {

            GridView1.DataBind();
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            GridView1.DataBind();
        }


        //protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        //{
        //    CheckBox blagdan = ((CheckBox)DetailsView1.FindControl("CheckBox1"));
        //    CheckBox godisnji = ((CheckBox)DetailsView1.FindControl("CheckBox2"));
        //    CheckBox bolovanje = ((CheckBox)DetailsView1.FindControl("CheckBox3"));
        //    Label ukSati = new Label();
        //    ukSati = (Label)DetailsView1.FindControl("Label1");
        //    if (ukSati.Text == null)
        //    {
        //        ukSati.Text = "";
        //    }

        //    if (blagdan.Checked == true)
        //    {
        //        ukSati.Text = "8";

        //        godisnji.Visible = false;
        //        bolovanje.Visible = false;
        //    }
        //    else
        //    {
        //        ukSati.Text = "";


        //    }

        //}

        //protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
        //{
        //    CheckBox godisnji = ((CheckBox)DetailsView1.FindControl("CheckBox2"));
        //    Label ukSati = ((Label)DetailsView1.FindControl("sati"));
        //    CheckBox blagdan = ((CheckBox)DetailsView1.FindControl("CheckBox1"));

        //    CheckBox bolovanje = ((CheckBox)DetailsView1.FindControl("CheckBox3"));

        //    if (godisnji.Checked == true)
        //    {
        //        ukSati.Text = "8";
        //        blagdan.Visible = false;
        //        bolovanje.Visible = false;
        //    }
        //    else
        //    {
        //        ukSati.Text = "";


        //    }

        //}

        //protected void CheckBox3_CheckedChanged(object sender, EventArgs e)
        //{
        //    CheckBox bolovanje = ((CheckBox)DetailsView1.FindControl("CheckBox3"));
        //    Label ukSati = ((Label)DetailsView1.FindControl("sati"));
        //    CheckBox blagdan = ((CheckBox)DetailsView1.FindControl("CheckBox1"));
        //    CheckBox godisnji = ((CheckBox)DetailsView1.FindControl("CheckBox2"));



        //    if (bolovanje.Checked == true)
        //    {
        //        ukSati.Visible = true;
        //        blagdan.Visible = false;
        //        godisnji.Visible = false;
        //    }
        //    else
        //    {
        //        ukSati.Text = "";


        //    }

        //}
        /// <summary>
        /// dohvaća sve vrijednosti iz detailsview-a kao key/value parove
        /// </summary>
        /// <param name="detailsView"></param>
        /// <returns></returns>
        //public static IDictionary GetValues(DetailsView detailsView)
        //{
        //    IOrderedDictionary values = new OrderedDictionary();
        //    foreach (DetailsViewRow row in detailsView.Rows)
        //    {
        //        // Only look at Data Rows
        //        if (row.RowType != DataControlRowType.DataRow)
        //        {
        //            continue;
        //        }
        //        // Assume the first cell is a header cell
        //        DataControlFieldCell dataCell = (DataControlFieldCell)row.Cells[0];
        //        // If we are showing the header for this row then the data is in the adjacent cell
        //        if (dataCell.ContainingField.ShowHeader)
        //        {
        //            dataCell = (DataControlFieldCell)row.Cells[1];
        //        }

        //        dataCell.ContainingField.ExtractValuesFromCell(values, dataCell, row.RowState, true);
        //    }
        //    return values;
        //}

        protected void DetailsView1_ItemUpdating(object sender, System.Web.UI.WebControls.DetailsViewUpdateEventArgs e)
        {
            decimal dol, odl;
            decimal satnica = 0.00m;
            CheckBox godisnji = ((CheckBox)DetailsView1.FindControl("CheckBox2"));

            CheckBox blagdan = ((CheckBox)DetailsView1.FindControl("CheckBox1"));

            CheckBox bolovanje = ((CheckBox)DetailsView1.FindControl("CheckBox3"));
            TextBox dolazak = ((TextBox)DetailsView1.FindControl("TextBox2"));
            TextBox odlazak = ((TextBox)DetailsView1.FindControl("TextBox3"));
            Label lbl = (Label)(DetailsView1.FindControl("Label1"));
            DropDownList ddl = DetailsView1.FindControl("ddlOdg") as DropDownList;
            if ((godisnji.Checked == true) || (blagdan.Checked == true) || (bolovanje.Checked == true))
            {
                satnica = 8.00m;
            }
            else
            {
                if (dolazak.Text == null)
                {
                    dol = 0.00m;
                }
                else
                {
                    //dol = Convert.ToDecimal(dolazak.Text.Trim(), CultureInfo.InvariantCulture);
                    dol = Convert.ToDecimal(dolazak.Text.Trim());
                }
                if (odlazak.Text == null)
                {
                    odl = 0.00m;
                }
                else
                {
                    odl = Convert.ToDecimal(odlazak.Text.Trim());
                }

                satnica = odl - dol;
            }

            lbl.Text = satnica.ToString();

            e.NewValues["sati"] = lbl.Text;
            int radID = Helper.NadjiOperatera(lblUser.Text);
            e.NewValues["radnikID"] = ddl.SelectedValue;
        }



        protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {


            decimal dol, odl;
            decimal satnica = 0.00m;
            CheckBox godisnji = ((CheckBox)DetailsView1.FindControl("CheckBox2"));

            CheckBox blagdan = ((CheckBox)DetailsView1.FindControl("CheckBox1"));
            DropDownList ddl = DetailsView1.FindControl("ddlOdg") as DropDownList;
            CheckBox bolovanje = ((CheckBox)DetailsView1.FindControl("CheckBox3"));
            TextBox dolazak = ((TextBox)DetailsView1.FindControl("TextBox2"));
            TextBox odlazak = ((TextBox)DetailsView1.FindControl("TextBox3"));
            //TextBox lbl = (TextBox)(DetailsView1.FindControl("TextBox4"));
            //if (lbl == null)
            //{
            //   lbl.Text = "0.00";
            //}
            if ((godisnji.Checked == true) || (blagdan.Checked == true) || (bolovanje.Checked == true))
            {
                satnica = 8.00m;
            }
            else
            {
                if (dolazak.Text == null)
                {
                    dol = 0.00m;
                }
                else
                {
                    dol = Convert.ToDecimal(dolazak.Text.Trim(), CultureInfo.InvariantCulture);
                    //dol = Convert.ToDecimal(dolazak.Text.Trim());
                }
                if (odlazak.Text == null)
                {
                    odl = 0.00m;
                }
                else
                {
                    odl = Convert.ToDecimal(odlazak.Text.Trim(), CultureInfo.InvariantCulture);
                }

                satnica = odl - dol;
            }

            // lbl.Text = satnica.ToString();

            e.Values["sati"] = satnica;

            int radID = Helper.NadjiOperatera(lblUser.Text);
            e.Values["radnikID"] = ddl.SelectedValue;

        }



        protected void btnSveStrane_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.AllowPaging = false;

            GridView1.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            GridView1.RenderControl(hw);

            string gridHTML = sw.ToString().Replace("\"", "'")

                .Replace(System.Environment.NewLine, "");

            StringBuilder sb = new StringBuilder();

            sb.Append("<script type = 'text/javascript'>");

            sb.Append("window.onload = new function(){");

            sb.Append("var printWin = window.open('', '', 'left=0");

            sb.Append(",top=0,width=1000,height=600,status=0');");

            sb.Append("printWin.document.write(\"");

            sb.Append(gridHTML);

            sb.Append("\");");

            sb.Append("printWin.document.close();");

            sb.Append("printWin.focus();");

            sb.Append("printWin.print();");

            sb.Append("printWin.close();};");

            sb.Append("</script>");

            ClientScript.RegisterStartupScript(this.GetType(), "GridPrint", sb.ToString());

            GridView1.AllowPaging = true;

            GridView1.DataBind();
        }

        protected void btnAktivnaStrana_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PagerSettings.Visible = false;

            GridView1.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            GridView1.RenderControl(hw);

            string gridHTML = sw.ToString().Replace("\"", "'")

                .Replace(System.Environment.NewLine, "");

            StringBuilder sb = new StringBuilder();

            sb.Append("<script type = 'text/javascript'>");

            sb.Append("window.onload = new function(){");

            sb.Append("var printWin = window.open('', '', 'left=0");

            sb.Append(",top=0,width=1000,height=600,status=0');");

            sb.Append("printWin.document.write(\"");

            sb.Append(gridHTML);

            sb.Append("\");");

            sb.Append("printWin.document.close();");

            sb.Append("printWin.focus();");

            sb.Append("printWin.print();");

            sb.Append("printWin.close();};");

            sb.Append("</script>");

            ClientScript.RegisterStartupScript(this.GetType(), "GridPrint", sb.ToString());

            GridView1.PagerSettings.Visible = true;

            GridView1.DataBind();
        }



        //protected string IzracunajSatnicu()
        //{

        //    decimal dol, odl;
        //    decimal satnica = 0.00m;
        //    CheckBox godisnji = ((CheckBox)DetailsView1.FindControl("CheckBox2"));

        //    CheckBox blagdan = ((CheckBox)DetailsView1.FindControl("CheckBox1"));

        //    CheckBox bolovanje = ((CheckBox)DetailsView1.FindControl("CheckBox3"));
        //    TextBox dolazak = ((TextBox)DetailsView1.FindControl("TextBox2"));
        //    TextBox odlazak = ((TextBox)DetailsView1.FindControl("TextBox3"));
        //    Label lbl = (Label)(DetailsView1.FindControl("Label1"));

        //    if ((godisnji.Checked == true) || (blagdan.Checked == true) || (bolovanje.Checked == true))
        //    {
        //        satnica = 8.00m;
        //    }
        //    else
        //    {
        //        if (dolazak.Text == null)
        //        {
        //            dol = 0.00m;
        //        }
        //        else
        //        {
        //            //dol = Convert.ToDecimal(dolazak.Text.Trim(), CultureInfo.InvariantCulture);
        //            dol = Convert.ToDecimal(dolazak.Text.Trim());
        //        }
        //        if (odlazak.Text == null)
        //        {
        //            odl = 0.00m;
        //        }
        //        else
        //        {
        //            odl = Convert.ToDecimal(odlazak.Text.Trim());
        //        }

        //        satnica = odl - dol;
        //    }

        //    return satnica.ToString();
        //}

        //protected void Calendar1_PreRender(object sender, EventArgs e)
        //{

        //    Calendar1.SelectedDates.Clear();

        //    foreach (DateTime dt in MultipleSelectedDates)
        //    {
        //        Calendar1.SelectedDates.Add(dt);
        //    }
        //}
        //protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        //{

        //    if (MultipleSelectedDates.Contains(Calendar1.SelectedDate))
        //    {
        //        MultipleSelectedDates.Remove(Calendar1.SelectedDate);
        //    }
        //    else
        //    {
        //        MultipleSelectedDates.Add(Calendar1.SelectedDate);
        //    }

        //    ViewState["MultipleSelectedDates"] = MultipleSelectedDates;
        //    Popup(true);
        //}


        public List<DateTime> MultipleSelectedDates
        {
            get
            {
                if (ViewState["MultipleSelectedDates"] == null)

                    ViewState["MultipleSelectedDates"] = new List<DateTime>();
                return (List<DateTime>)ViewState["MultipleSelectedDates"];
            }
            set
            {
                ViewState["MultipleSelectedDates"] = value;
            }
        }



        protected void btnSave_Click(object sender, EventArgs e)
        {
            //if (MultipleSelectedDates.Count != 0)
            //{
            //    int sif = Convert.ToInt32(Session["vrijeme"]);
            //    //Vrijeme selectan = Select_Vrijeme(vrijemeID);
            //    Vrijeme selectan = Select_Vrijeme(sif);
            //    user = lblUser.Text;
            //    int radnik = Helper.NadjiOperatera(user);
            //    List<DateTime> datumi = new List<DateTime>();

            //    foreach (DateTime dt in MultipleSelectedDates)
            //    {
            //        int vrijeme = Insert_Vrijeme(dt, selectan.Dolazak, selectan.Odlazak, selectan.Blagdan, selectan.Godisnji, selectan.Bolovanje, selectan.Napomena, radnik, selectan.sati);

            //        if (vrijeme == -1)
            //        {
            //            lblPor.Text = "Greška prilikom kopiranja radnog vremena. ";
            //            break;
            //        }

            //    }

            //    lblPor.Text = "Uspješno je kopirano";
            //    Popup(false);
            //}
            //else
            //{
            //    lblPor.Text = "Nije odabran niti jedan";
            //}
            if (TextBox123.Text != "")
            {
                List<DateTime> datumi = new List<DateTime>();

                int sif = Convert.ToInt32(Session["vrijeme"]);
                //Vrijeme selectan = Select_Vrijeme(vrijemeID);
                Vrijeme selectan = Select_Vrijeme(sif);
                user = lblUser.Text;
                int radnik = Helper.NadjiOperatera(user);

                string dat = TextBox123.Text;
                string[] words = dat.Split(',');
                foreach (string word in words)
                {
                    datumi.Add(Convert.ToDateTime(word));
                }

                foreach (DateTime dt in datumi)
                {
                    int vrijeme = Insert_Vrijeme(dt, selectan.Dolazak, selectan.Odlazak, selectan.Blagdan, selectan.Godisnji, selectan.Bolovanje, selectan.Napomena, radnik, selectan.sati);

                    if (vrijeme == -1)
                    {
                        lblPor.Text = "Greška prilikom kopiranja radnog vremena. ";
                        break;
                    }

                }

                lblPor.Text = "Uspješno je kopirano";
                GridView1.DataBind();
                Popup(false);
            }

            else
            {
                lblPor.Text = "Nije odabran niti jedan datum za kopiranje";
            }

        }


        //protected void btnClear_Click(object sender, EventArgs e)
        //{

        //    Calendar1.SelectedDates.Clear();
        //    ViewState["MultipleSelectedDates"] = null;
        //}


        void Popup(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> ShowPopup(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowPopup", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> HidePopup(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "HidePopup", builder.ToString());
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowIndex == GridView1.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                    row.ToolTip = string.Empty;
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                    row.ToolTip = "Click to select this row.";
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void btnPregled_Click(object sender, EventArgs e)
        {
            // var sql = "SELECT [sifra], [datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati] FROM [Evid_vrijeme] WHERE radnikID=@radnik OR radnikID IS NULL AND ((datum between @ood AND @doo) OR (datum IS NULL))  ORDER BY DATUM DESC";

            //if (Session["FiltExp"] == null)
            //{
            //    sql = "SELECT [firstname], [lastname] FROM [XYZ]";
            //}
            // SqlDataSource1.SelectCommand = sql;

            //      if (!String.IsNullOrEmpty(txtDate.Text) &&
            //!String.IsNullOrEmpty(txtDateDo.Text))
            //      {
            SqlDataSource1.SelectParameters.Clear();
            int rad = Convert.ToInt32(DropDownList1.SelectedValue);
            DateTime dt;
            DateTime.TryParse(txtDate.Text, out dt);
            DateTime dt2;
            DateTime.TryParse(txtDateDo.Text, out dt2);
            //SqlDataSource1.SelectParameters.Add("radnik", rad.ToString());
            //SqlDataSource1.SelectParameters.Add("ood",  txtDate.Text);
            //SqlDataSource1.SelectParameters.Add("doo", txtDateDo.Text);
            //SqlDataSource1.SelectParameters[0].DefaultValue = rad.ToString();
            //SqlDataSource1.SelectParameters[1].DefaultValue = txtDate.Text;
            //SqlDataSource1.SelectParameters[2].DefaultValue = txtDateDo.Text;


            SqlDataSource1.FilterExpression = "radnikID='{0}' AND ('{1}' = '' OR datum >= '{1}') AND ('{2}' = '' OR datum <= '{2}')";
            Session["FiltExp"] = "radnikID='{0}' AND ('{1}' = '' OR datum >= '{1}') AND ('{2}' = '' OR datum <= '{2}')";
        }


        protected void btnSvi_Click(object sender, EventArgs e)
        {
            var sql = "SELECT [sifra], [datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati] FROM [Evid_vrijeme]   ORDER BY DATUM DESC";
            //if (Session["FiltExp"] == null)
            //{
            //    sql = "SELECT [firstname], [lastname] FROM [XYZ]";
            //}
            SqlDataSource1.FilterExpression = null;
            Session["FiltExp"] = null;
            SqlDataSource1.SelectCommand = sql;
            GridView1.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlDataSource1.FilterExpression = "radnikID='" +
     DropDownList1.SelectedValue + "'";
            Session["FiltExp"] = "radnikID='" + DropDownList1.SelectedValue + "'";
        }

        protected void btnTrazi_Click(object sender, EventArgs e)
        {
            int radnik = Convert.ToInt32(DropDownList1.SelectedValue);

            string od = txtDate.Text;
            string dod = txtDateDo.Text;


            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("dbo.spVrijeme", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (radnik == -1)
            {
                cmd.Parameters.AddWithValue("@RADNIKID", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@RADNIKID", radnik);
            }
            if (od == "")
            {
                cmd.Parameters.AddWithValue("@OD", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@OD", Convert.ToDateTime(od));
            }
            if (dod == "")
            {
                cmd.Parameters.AddWithValue("@DO", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@DO", Convert.ToDateTime(dod) );
            }
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dset = new DataSet();
            adapter.Fill(dset, "t1");
            var result = cmd.ExecuteReader();
            GridView1.EmptyDataText = "No Records Found";

            GridView1.DataSource = dset.Tables["t1"];
            GridView1.DataBind();

            conn.Close();
        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        //protected void GridView1_PreRender(object sender, EventArgs e)
        //{
        //    GridView1.UseAccessibleHeader = true;
        //    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        //}


    }
}