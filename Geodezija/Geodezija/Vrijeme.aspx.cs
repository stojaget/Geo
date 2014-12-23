using System;
using System.Collections.Generic;
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

using iTextSharp.text.pdf;
using System.Web.UI.WebControls.WebParts;

using System.Collections;
using System.Collections.Specialized;
using System.Globalization;


namespace Geodezija
{
    public partial class Vrijeme : System.Web.UI.Page
    {
        string user;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = User.Identity.Name;
            if (!IsPostBack)
            {
                GridView1.DataBind();
            }

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
                    selVrijeme.Dolazak = Convert.ToDecimal(reader["dolazak"]);
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
            e.NewValues["radnikID"] = radID;
        }



        protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            

            decimal dol, odl;
            decimal satnica = 0.00m;
            CheckBox godisnji = ((CheckBox)DetailsView1.FindControl("CheckBox2"));

            CheckBox blagdan = ((CheckBox)DetailsView1.FindControl("CheckBox1"));

            CheckBox bolovanje = ((CheckBox)DetailsView1.FindControl("CheckBox3"));
            TextBox dolazak = ((TextBox)DetailsView1.FindControl("TextBox2"));
            TextBox odlazak = ((TextBox)DetailsView1.FindControl("TextBox3"));
            TextBox lbl = (TextBox)(DetailsView1.FindControl("TextBox4"));
            if (lbl == null)
            {
               lbl.Text = "0.00";
            }
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

            lbl.Text = satnica.ToString();

            e.Values["sati"] = satnica;

            int radID = Helper.NadjiOperatera(lblUser.Text);
            e.Values["radnikID"] = radID;
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

    }
}