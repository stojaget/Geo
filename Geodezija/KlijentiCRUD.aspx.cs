using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Text;
using System.Data.Common;
using jQueryNotification.Helper;
using System.Drawing;
using System.Data.SqlClient;
using Aspose.Words;
using System.Data;

namespace Geodezija
{
    public partial class KlijentiCRUD : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            gvKlijentProj.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (gvKlijentProj.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'gvKlijentProj', 'HeaderDiv');</script>");
            }

            //if (Page.User.IsInRole("Pripravnik"))
            //{
            //    gvKlijentProj.Columns[5].Visible = false;
            //}

            lblUser.Text = User.Identity.Name;
            Calendar1.SelectedDate = DateTime.Now;
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);
            btnKontakti.Visible = false;
            if (sifra == 999999)
            {
                DetailsView1.ChangeMode(DetailsViewMode.Insert);
            }
            txtZadnjaPonuda.Text = Helper.MaxPonudaKlijent();
            if (!IsPostBack)
            {

                int brojKontakta = Helper.PrebrojiKontakteZaKlijenta(sifra);
                if (brojKontakta != 0)
                {
                    btnKontakti.Visible = true;
                }
                else
                {
                    btnKontakti.Visible = false;
                }
                DetailsView1.DataBind();
            }

        }

        protected void gvKlijentProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvKlijentProj.Rows)
            {
                if (row.RowIndex == gvKlijentProj.SelectedIndex)
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
            //kada user odabere klijneta odvede ga na stranicu za uređivanje
            Response.Redirect("ProjektiCRUD.aspx?ID=" + gvKlijentProj.SelectedValue);
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
            gvKlijentProj.AllowPaging = false;
            gvKlijentProj.DataBind();
            gvKlijentProj.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document(PageSize.A4, 10f, 10f, 10f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
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
                gvKlijentProj.AllowPaging = false;
                gvKlijentProj.DataBind();

                gvKlijentProj.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in gvKlijentProj.HeaderRow.Cells)
                {
                    cell.BackColor = gvKlijentProj.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gvKlijentProj.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gvKlijentProj.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gvKlijentProj.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gvKlijentProj.RenderControl(hw);

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

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {


            int klijentID = Convert.ToInt32(Request.QueryString["ID"]);
            //kreira se novi folder sa šifrom predmeta
            var folder = Server.MapPath("~/Dokumenti/Klijenti/" + klijentID);
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            gvKlijentProj.DataBind();
            DetailsView1.DataBind();
        }

        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            gvKlijentProj.DataBind();
            DetailsView1.DataBind();
        }

        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            gvKlijentProj.DataBind();
            DetailsView1.DataBind();
        }

        protected void btnAktivnaStrana_Click(object sender, ImageClickEventArgs e)
        {
            gvKlijentProj.PagerSettings.Visible = false;

            gvKlijentProj.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvKlijentProj.RenderControl(hw);

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

            gvKlijentProj.PagerSettings.Visible = true;

            gvKlijentProj.DataBind();
        }

        protected void btnSveStrane_Click(object sender, ImageClickEventArgs e)
        {
            gvKlijentProj.AllowPaging = false;

            gvKlijentProj.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvKlijentProj.RenderControl(hw);

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

            gvKlijentProj.AllowPaging = true;

            gvKlijentProj.DataBind();
        }

        protected void sdsKlijentiCRUD_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            DbCommand command = e.Command;
            string user = command.Parameters["@kreirao"].Value.ToString();
            //int ID = (int)command.Parameters["@sifra"].Value;
            //Session["ID"] = ID;
            // The label displays the primary key of the recently inserted row.
            // command.Parameters["@PK_New"].Value.ToString();
            string poruka = "Unesen je klijent sa nazivom " + command.Parameters["@naziv"].Value.ToString() + " od korisnika " + user;
            bool uspjeh = Helper.UnesiObavijest(DateTime.Now, "svi", poruka, false);
            if (uspjeh)
            {
                this.ShowSuccessfulNotification(poruka, 3000);
            }
            else
            {
                this.ShowErrorNotification("Nije uspjelo kreiranje obavijesti");
            }
        }

        protected void gvKlijentProj_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvKlijentProj, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void DetailsView1_DataBound(object sender, EventArgs e)
        {
            if (DetailsView1.CurrentMode == DetailsViewMode.Insert)
            {

                TextBox tbdate = (TextBox)DetailsView1.Rows[0].FindControl("TextBox4");

                tbdate.Text = "Hrvatska";

            }
        }

        protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["ID"]);
            if (e.CommandName == "Prilozi")
            {
                Response.Redirect("KlijentiPriloz.aspx?ID=" + id);
            }
            /*
            protected void sdsKlijentiCRUD_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {

                sdsKlijentiCRUD.InsertParameters["@dat_kreiranja"].DefaultValue = Convert.ToString(DateTime.Now); 
                sdsKlijentiCRUD.Insert();
            }
             * */
        }

        protected void btnKontakti_Click(object sender, EventArgs e)
        {
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);
            Response.Redirect("Kontakt.aspx?ID=" + sifra);
        }

        protected void sdsKlijentiCRUD_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            bool potencijalni, povezani;
            DbCommand command = e.Command;
            if (command.Parameters["@potencijalni"].Value != null)
            {
                potencijalni = (bool)command.Parameters["@potencijalni"].Value;
            }
            else
            {
                potencijalni = false;
            }
            //potencijalni = command.Parameters["@potencijalni"].Value == null ? false : true;
            if (command.Parameters["@povezani"].Value != null)
            {
                povezani = (bool)command.Parameters["@povezani"].Value;
            }
            else
            {
                povezani = false;
            }
            //povezani = command.Parameters["@povezani"].Value == null ? false : true;
            if (potencijalni == true) command.Parameters["@vrsta"].Value = "Potencijalni";
            if (povezani == true) command.Parameters["@vrsta"].Value = "Nepovezani";

            if ((potencijalni == false) && (povezani == false))
            {
                command.Parameters["@vrsta"].Value = "Standardni";
            }


            //sdsKlijentiCRUD.Insert();
        }

        protected void sdsKlijentiCRUD_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            bool potencijalni, povezani;
            DbCommand command = e.Command;
            if (command.Parameters["@potencijalni"].Value != null)
            {
                potencijalni = (bool)command.Parameters["@potencijalni"].Value;
            }
            else
            {
                potencijalni = false;
            }
            //potencijalni = command.Parameters["@potencijalni"].Value == null ? false : true;
            if (command.Parameters["@povezani"].Value != null)
            {
                povezani = (bool)command.Parameters["@povezani"].Value;
            }
            else
            {
                povezani = false;
            }
            //povezani = command.Parameters["@povezani"].Value == null ? false : true;
            if (potencijalni == true) command.Parameters["@vrsta"].Value = "Potencijalni";
            if (povezani == true) command.Parameters["@vrsta"].Value = "Nepovezani";

            if ((potencijalni == false) && (povezani == false))
            {
                command.Parameters["@vrsta"].Value = "Standardni";
            }
        }

        protected void sdsKlijentiCRUD_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            DbCommand command = e.Command;
            string user = command.Parameters["@kreirao"].Value.ToString();
            //int ID = (int)command.Parameters["@sifra"].Value;
            //Session["ID"] = ID;
            // The label displays the primary key of the recently inserted row.
            // command.Parameters["@PK_New"].Value.ToString();
            string poruka = "Unesen je klijent sa nazivom " + command.Parameters["@naziv"].Value.ToString() + " od korisnika " + user;
            // bool uspjeh = Helper.UnesiObavijest(DateTime.Now, "svi", poruka, false);

            this.ShowSuccessfulNotification(poruka, 3000);
        }



        protected void btnPonuda_Click(object sender, EventArgs e)
        {
            string content = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            string datum = DateTime.Now.Day.ToString();
            string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/Ponuda.docx");
            int klijID = Convert.ToInt32(Request.QueryString["ID"]);
            int rbr = Convert.ToInt32(Helper.MaxKlijent(klijID)) + 1;
            string izradio = lblUser.Text;
            // Otvori dokument (Nalazi se u web siteu, u folderu Predlosci)
            try
            {

                string dok = "Ponuda_" + datum + ".docx";
                string putanjaWord = System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Klijenti/" + klijID + "/" + dok);

                bool zaht = Helper.UnesiKlijentPrilog(klijID, rbr, "Ponuda_" + datum, putanjaWord, content, DateTime.Now);
                DataTable predmet = Helper.DohvatiKlij(klijID, izradio, txtZadnjaPonuda.Text);

                Aspose.Words.Document doc = new Aspose.Words.Document(putanjaOriginal);
                doc.MailMerge.Execute(predmet);
                if (!Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Klijenti/" + klijID)))
                {
                    Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Klijenti/" + klijID));
                }
                doc.Save(putanjaWord);
                Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                Response.AddHeader("Content-Disposition", "attachment; filename=Ponuda1.docx");
                Response.WriteFile(putanjaWord);
                Response.End();
            }
            catch (Exception err)
            {

                string poruka = "Dogodila se greška prilikom kreiranja obrasca Ponude";

                this.ShowErrorNotification(poruka, 3000);
            }
        }

        protected void gvKlijentProj_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (Page.User.IsInRole("Pripravnik"))
            {
                gvKlijentProj.Columns[4].Visible = false;
            }
        }
    }
}