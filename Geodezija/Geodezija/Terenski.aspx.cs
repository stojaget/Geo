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

namespace Geodezija
{
    public partial class Terenski : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            lblUser.Text = User.Identity.Name;
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
                int teren = Insert_Teren(Convert.ToDateTime(datum), selectan.Odlazak, selectan.Dolazak, selectan.Sati, selectan.Opis, selectan.Iznos, selectan.Dat_kreir, selectan.Dat_azu,
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
                    selTeren.Napomena = reader["napomena"].ToString();
                    selTeren.Kreirao = reader["kreirao"].ToString();
                    selTeren.Dat_kreir = Convert.ToDateTime(reader["dat_kreiranja"]);
                    selTeren.Dat_azu = Convert.ToDateTime(reader["dat_azu"]);

                    selTeren.RadnikID = Convert.ToInt32(reader["radnikID"]);
                    selTeren.Opis = reader["opis"].ToString();
                    selTeren.Vrsta = reader["vrsta"].ToString();

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
            int radnik = Helper.NadjiOperatera(lblUser.Text);
           // e.NewValues["radnikID"] = radnik.ToString(); 
        }

    }
}
