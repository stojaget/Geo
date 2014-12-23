using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

using System.Text;
using jQueryNotification.Helper;
namespace Geodezija
{
    public partial class Prilozi : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (GridView1.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'GridView1', 'HeaderDiv');</script>");
            }
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);
            lblPredmet.Text = sifra.ToString();
            if (!Page.IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);
            if (UploadTest.PostedFile != null && UploadTest.PostedFile.ContentLength > 0)
            {
                // Get the filename and folder to write to
                Prilozi noviPril = new Prilozi();

                int rbr = Convert.ToInt32(Helper.MaxPredmet(sifra)) + 1;

                string fileName = Path.GetFileName(UploadTest.PostedFile.FileName);
                //string folder = Server.MapPath("~/Dokumenti/Predmeti/" + rbr);
                //string putanja = Server.MapPath("~/Dokumenti/Predmeti/" + rbr + @"/" + UploadTest.FileName);
                string folder = Server.MapPath("~/Dokumenti/Predmeti/" + sifra + @"/" + rbr);
                string putanja = Server.MapPath("~/Dokumenti/Predmeti/" + sifra + @"/" + rbr + @"/" + UploadTest.FileName);
                string contentType = UploadTest.PostedFile.ContentType;
                // Ensure the folder exists
                if (!Directory.Exists(folder))
                {
                    Directory.CreateDirectory(folder);
                }

                string poruka;
                // Save the file to the folder
                UploadTest.PostedFile.SaveAs(Path.Combine(folder, fileName));
                bool zaht = Helper.UnesiPrilog(sifra, rbr, UploadTest.FileName, putanja, contentType, DateTime.Now);

                if (zaht)
                {
                    poruka = "Uspješno ste dodali prilog " + fileName + " pod rednim brojem " + rbr.ToString();
                    lblMessage.Text = poruka;
                    this.ShowSuccessfulNotification(poruka, 3000);
                    txtNaziv.Text = "";
                    bool ind = true;
                    bool uspj = Helper.ProjektInd(sifra, ind);
                    GridView1.DataBind();
                    //  Response.Write("Uploaded: " + fileName);
                }
                else
                {
                    poruka = "Dogodila se greška prilikom spremanja podataka";
                    lblMessage.Text = poruka;
                    this.ShowErrorNotification(poruka, 3000);
                }

                //    Response.Redirect("~/");
            }
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
            GridView1.AllowPaging = false;
            GridView1.DataBind();
            GridView1.RenderControl(hw);
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
                GridView1.AllowPaging = false;
                GridView1.DataBind();

                GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                GridView1.RenderControl(hw);

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


    }
}