using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using iTextSharp.text;
using iTextSharp.text.html;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Globalization;
using System.Data.Common;
using System.Text;
using System.Drawing;

namespace Geodezija
{
    public partial class Terenski : System.Web.UI.Page
    {
        string user;
        int terID;
        protected void Page_Load(object sender, EventArgs e)
        {
            gvTerenski.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (gvTerenski.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'gvTerenski', 'HeaderDiv');</script>");
            }
            lblUser.Text = User.Identity.Name;
            lblStatus.Text = "";
            if (!Page.IsPostBack)
            {
                gvTerenski.DataBind();
            }
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            gvTerenski.DataBind();
        }

        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            gvTerenski.DataBind();
        }

        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            gvTerenski.DataBind();

        }

        protected void gvTerenski_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Kopiraj")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvTerenski.Rows[index];

                int sifra = Convert.ToInt32(row.Cells[1].Text);
                Ter selectan = Select_Teren(sifra);

                string user = lblUser.Text;
                int radnik = Helper.NadjiOperatera(user);
                string datum = DateTime.Now.ToShortDateString();
                int teren = Insert_Teren(Convert.ToDateTime(datum), selectan.Odlazak, selectan.Dolazak, selectan.Sati, selectan.Opis, selectan.Iznos, DateTime.Now, DateTime.Now,
                        selectan.Kreirao, radnik, selectan.Vrsta, selectan.Napomena);
                if (teren == -1)
                {
                    lblStatus.Text = "Greška prilikom kopiranja terenskog obračuna ";
                }
                else
                {
                    gvTerenski.DataBind();
                    // show the result
                    lblStatus.Text = "Uspješno je spremljen terenski obračun sa šifrom " + teren;


                }
            }
            if (e.CommandName == "MKopiraj")
            {
                LinkButton lnkBtn = (LinkButton)e.CommandSource;    // the button
                GridViewRow myRow = (GridViewRow)lnkBtn.Parent.Parent;  // the row
                GridView myGrid = (GridView)sender; // the gridview
                int sifra = Convert.ToInt32(gvTerenski.DataKeys[myRow.RowIndex].Value.ToString());
                terID = sifra;
                Session["terID"] = terID;

                //Calendar1.SelectedDates.Clear();
                lblPor.Text = "";
                ViewState["MultipleSelectedDates"] = null;
                Popup(true);
            }

        }

        public static Ter Select_Teren(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string selectSQL = "SELECT * FROM [Terenski] WHERE ([sifra] = @sifra)";
            SqlConnection con = new SqlConnection(connectionString);
            Ter selTeren = new Ter();
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            cmd.Parameters.AddWithValue("@sifra", sifra);
            SqlDataReader reader;

            try
            {
                con.Open();
                reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    selTeren.Sifra = Convert.ToInt32(reader["sifra"]);
                    selTeren.Datum = Convert.ToDateTime(reader["datum"]);
                    selTeren.Iznos = Convert.ToDecimal(reader["iznos"]);
                    selTeren.Odlazak = Convert.ToDecimal(reader["odlazak"]);
                    selTeren.Dolazak = Convert.ToDecimal(reader["dolazak"]);
                    selTeren.Sati = Convert.ToDecimal(reader["sati"]);
                    if (reader["napomena"].ToString() == "")
                    { selTeren.Napomena = ""; }
                    else
                    {
                        selTeren.Napomena = reader["napomena"].ToString();
                    }

                    selTeren.Kreirao = reader["kreirao"].ToString();
                    if (reader["dat_kreiranja"].ToString() == "")
                    { selTeren.Dat_kreir = DateTime.MinValue; }
                    else
                    {
                        selTeren.Dat_kreir = Convert.ToDateTime(reader["dat_kreiranja"]);
                    }

                    if (reader["dat_azu"].ToString() == "")
                    { selTeren.Dat_azu = DateTime.MinValue; }
                    else
                    {
                        selTeren.Dat_azu = Convert.ToDateTime(reader["dat_azu"]);
                    }


                    selTeren.RadnikID = Convert.ToInt32(reader["radnikID"]);
                    if (reader["opis"].ToString() == "")
                    { selTeren.Opis = ""; }
                    else
                    {
                        selTeren.Opis = reader["opis"].ToString();
                    }
                    if (reader["vrsta"].ToString() == "")
                    { selTeren.Vrsta = ""; }
                    else
                    {
                        selTeren.Vrsta = reader["vrsta"].ToString();
                    }


                }
                reader.Close();
                return selTeren;

            }
            /*
        catch (Exception err)
        {
            return err;
        }
           * */
            finally
            {
                con.Close();
            }
        }

        // metoda za kopiranje terenske vožnje
        public int Insert_Teren(DateTime datum, decimal odlazak, decimal dolazak, decimal sati, string opis, decimal iznos,
            DateTime dat_kreir, DateTime dat_azu, string kreirao, int radnikID, string vrsta, string napomena)
        {
            int terenID = 0;
            string insertSQL;
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            insertSQL = "INSERT INTO [Terenski] ([datum], [iznos], [odlazak], [dolazak], [sati], [napomena], [kreirao], [dat_kreiranja], [dat_azu], [radnikID], [opis], [vrsta]) VALUES (@datum, @iznos, @odlazak, @dolazak, @sati, @napomena, @kreirao, @dat_kreiranja, @dat_azu, @radnikID, @opis, @vrsta);SELECT SCOPE_IDENTITY();";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@datum", datum);
            cmd.Parameters.AddWithValue("@iznos", iznos);
            cmd.Parameters.AddWithValue("@odlazak", odlazak);
            cmd.Parameters.AddWithValue("@dolazak", dolazak);
            cmd.Parameters.AddWithValue("@sati", sati);
            cmd.Parameters.AddWithValue("@napomena", napomena);
            cmd.Parameters.AddWithValue("@kreirao", kreirao);
            cmd.Parameters.AddWithValue("@dat_kreiranja", dat_kreir);
            cmd.Parameters.AddWithValue("@dat_azu", dat_azu);
            cmd.Parameters.AddWithValue("@radnikID", radnikID);
            cmd.Parameters.AddWithValue("@opis", opis);
            cmd.Parameters.AddWithValue("@vrsta", vrsta);

            try
            {
                con.Open();
                // added = cmd.ExecuteNonQuery();
                terenID = Convert.ToInt32(cmd.ExecuteScalar());
                lblStatus.Text = "Unesen je terenski obračun sa šifrom " + terenID;
            }
            catch (Exception err)
            {
                terenID = -1;
                lblStatus.Text = "Greška prilikom spremanja terenskog obračuna. ";
                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            return (terenID);
        }

        protected void ExportToExcel(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gvTerenski.AllowPaging = false;
                gvTerenski.DataBind();

                gvTerenski.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in gvTerenski.HeaderRow.Cells)
                {
                    cell.BackColor = gvTerenski.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gvTerenski.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gvTerenski.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gvTerenski.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gvTerenski.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void btnPdf_Click(object sender, ImageClickEventArgs e)
        {
            //export grida u pdf
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition",
             "attachment;filename=GridViewExport.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gvTerenski.AllowPaging = false;
            gvTerenski.DataBind();
            gvTerenski.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }

        protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            decimal dol, odl;
            decimal satnica = 0.00m;

            TextBox dolazak = ((TextBox)DetailsView1.FindControl("TextBox3"));
            TextBox odlazak = ((TextBox)DetailsView1.FindControl("TextBox2"));
            TextBox lbl = (TextBox)(DetailsView1.FindControl("TextBox5"));


            if (dolazak.Text == null)
            {
                dol = 0.00m;
            }
            else
            {
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

            lbl.Text = satnica.ToString();

            e.NewValues["sati"] = lbl.Text;
            //e.NewValues["dat_kreiranja"] = ((System.Web.UI.WebControls.Calendar)DetailsView1.FindControl("Calendar1")).SelectedDate;

        }

        protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            int radnik = Helper.NadjiOperatera(lblUser.Text);
            e.Values["radnikID"] = radnik;
            decimal dol, odl;
            decimal satnica = 0.00m;

            TextBox dolazak = ((TextBox)DetailsView1.FindControl("TextBox3"));
            TextBox odlazak = ((TextBox)DetailsView1.FindControl("TextBox2"));
            TextBox lbl = (TextBox)(DetailsView1.FindControl("TextBox5"));


            if (dolazak.Text == null)
            {
                dol = 0.00m;
            }
            else
            {
                dol = Convert.ToDecimal(dolazak.Text.Trim(), CultureInfo.InvariantCulture);
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

            lbl.Text = satnica.ToString();

            e.Values["sati"] = lbl.Text;
        }

        protected void btnAktivnaStrana_Click(object sender, ImageClickEventArgs e)
        {
            gvTerenski.PagerSettings.Visible = false;

            gvTerenski.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvTerenski.RenderControl(hw);

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

            gvTerenski.PagerSettings.Visible = true;

            gvTerenski.DataBind();
        }

        protected void btnSveStrane_Click(object sender, ImageClickEventArgs e)
        {
            gvTerenski.AllowPaging = false;

            gvTerenski.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvTerenski.RenderControl(hw);

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

            gvTerenski.AllowPaging = true;

            gvTerenski.DataBind();
        }



        //protected void SqlDataSource2_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        //{
        //    foreach (DbParameter P in e.Command.Parameters)
        //    {
        //        Response.Write(P.ParameterName + "<br />");
        //        Response.Write(P.DbType.ToString() + "<br />");
        //        Response.Write(P.Value.ToString() + "<br />");
        //    }
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
            if (TextBox123.Text != "")
            {
                List<DateTime> datumi = new List<DateTime>();

                int sifra = Convert.ToInt32(Session["terID"]);
                Ter selectan = Select_Teren(sifra);
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
                    int teren = Insert_Teren(dt, selectan.Odlazak, selectan.Dolazak, selectan.Sati, selectan.Opis, selectan.Iznos, DateTime.Now, DateTime.Now, user, radnik, selectan.Vrsta, selectan.Napomena);

                    if (teren == -1)
                    {
                        lblPor.Text = "Greška prilikom kopiranja terenskih. ";
                        break;
                    }

                }

                lblPor.Text = "Uspješno je kopirano";
                gvTerenski.DataBind();
                Popup(false);
            }

            else
            {
                lblPor.Text = "Nije odabran niti jedan datum za kopiranje";
            }
        }
           





        protected void btnClear_Click(object sender, EventArgs e)
        {

            //Calendar1.SelectedDates.Clear();
            ViewState["MultipleSelectedDates"] = null;
        }


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

        protected void gvTerenski_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvTerenski.Rows)
            {
                if (row.RowIndex == gvTerenski.SelectedIndex)
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

        protected void gvTerenski_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvTerenski, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void DetailsView1_DataBound(object sender, EventArgs e)
        {
            if (DetailsView1.CurrentMode == DetailsViewMode.Insert)
            {

                TextBox tbdate = (TextBox)DetailsView1.Rows[0].FindControl("TextBox4");

                tbdate.Text = "170.00";

            }
        }

    }
}
