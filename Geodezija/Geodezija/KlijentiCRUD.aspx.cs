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

namespace Geodezija
{
    public partial class KlijentiCRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = User.Identity.Name;
            Calendar1.SelectedDate = DateTime.Now;
        }

        protected void gvKlijentProj_SelectedIndexChanged(object sender, EventArgs e)
        {
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
        /*
        protected void sdsKlijentiCRUD_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {

            sdsKlijentiCRUD.InsertParameters["@dat_kreiranja"].DefaultValue = Convert.ToString(DateTime.Now); 
            sdsKlijentiCRUD.Insert();
        }
         * */
    }
}