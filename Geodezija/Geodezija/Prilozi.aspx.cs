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
using System.IO;

namespace Geodezija
{
    public partial class Prilozi1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);
            lblPredmet.Text = sifra.ToString();
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);
            if (UploadTest.PostedFile != null && UploadTest.PostedFile.ContentLength > 0)
            {
                // Get the filename and folder to write to
                Prilozi noviPril = new Prilozi();

                int rbr = Convert.ToInt32(Helper.MaxPredmet()) + 1;

                string fileName = Path.GetFileName(UploadTest.PostedFile.FileName);
                string folder = Server.MapPath("~/Dokumenti/Predmeti/" + rbr);
                string putanja = Server.MapPath("~/Dokumenti/Predmeti/" + rbr + @"/" + UploadTest.FileName);
                string contentType = UploadTest.PostedFile.ContentType;
                // Ensure the folder exists
                if (!Directory.Exists(folder))
                {
                    Directory.CreateDirectory(folder);
                }


                // Save the file to the folder
                UploadTest.PostedFile.SaveAs(Path.Combine(folder, fileName));
                bool zaht = Helper.UnesiPrilog(sifra, rbr, txtNaziv.Text, putanja, contentType, DateTime.Now);

                if (zaht)
                {
                    lblMessage.Text = "Uspješno ste dodali prilog " + fileName;

                    GridView1.DataBind();
                    //  Response.Write("Uploaded: " + fileName);
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

    }
}