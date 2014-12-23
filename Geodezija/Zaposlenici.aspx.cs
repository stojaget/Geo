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
using System.Drawing;

namespace Geodezija
{
    public partial class Zaposlenici : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            gvRadnik.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (gvRadnik.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'gvRadnik', 'HeaderDiv');</script>");
            }
        }

        protected void btnPregled_Click(object sender, EventArgs e)
        {
            string dat_od = Request.Form[txtDate.UniqueID];
            string dat_do = Request.Form[txtDateDo.UniqueID];
            string url = "Loko.aspx?od="+dat_od+"&do="+dat_do;
            Response.Redirect(url);
            
          
        }

        protected void btnTerenski_Click(object sender, EventArgs e)
        {
            string dat_od = Request.Form[txtOd.UniqueID];
            string dat_do = Request.Form[txtDo.UniqueID];
            string url = "Terenski.aspx?dod=" + dat_od + "&ddo=" + dat_do;
            Response.Redirect(url);
        }

        protected void gvRadnik_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvRadnik.Rows)
            {
                if (row.RowIndex == gvRadnik.SelectedIndex)
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
            Response.Redirect("ZaposlCRUD.aspx?ID=" + gvRadnik.SelectedValue);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Write("Valid!");
            //after validation, run server-side code here
        }

        protected void ExportToPDF(object sender, EventArgs e)
        {
            //export grida u pdf
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition",
             "attachment;filename=GridViewExport.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gvRadnik.AllowPaging = false;
            gvRadnik.DataBind();
            gvRadnik.RenderControl(hw);
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
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void btnPdf_Click(object sender, ImageClickEventArgs e)
        {
            //export grida u pdf
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    //To Export all pages
                    gvRadnik.AllowPaging = false;
                    gvRadnik.DataBind();

                    gvRadnik.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(PageSize.A2, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
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
                gvRadnik.AllowPaging = false;
                gvRadnik.DataBind();

                gvRadnik.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in gvRadnik.HeaderRow.Cells)
                {
                    cell.BackColor = gvRadnik.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gvRadnik.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gvRadnik.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gvRadnik.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gvRadnik.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        protected void btnSveStrane_Click(object sender, ImageClickEventArgs e)
        {
            gvRadnik.AllowPaging = false;

            gvRadnik.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvRadnik.RenderControl(hw);

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

            gvRadnik.AllowPaging = true;

            gvRadnik.DataBind();
        }

        protected void btnAktivnaStrana_Click(object sender, ImageClickEventArgs e)
        {
            gvRadnik.PagerSettings.Visible = false;

            gvRadnik.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvRadnik.RenderControl(hw);

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

            gvRadnik.PagerSettings.Visible = true;

            gvRadnik.DataBind();
        }

        protected void btnLokoNovi_Click(object sender, EventArgs e)
        {
            string dat_od = DateTime.Now.ToShortDateString();
            string dat_do = DateTime.Now.ToShortDateString();
            string url = "Loko.aspx?od=" + dat_od + "&do=" + dat_do;
            Response.Redirect(url);
        }

        protected void btnNoviTeren_Click(object sender, EventArgs e)
        {
            string dat_od = DateTime.Now.ToShortDateString();
            string dat_do = DateTime.Now.ToShortDateString();
            string url = "Terenski.aspx?dod=" + dat_od + "&ddo=" + dat_do;
            Response.Redirect(url);
        }

        protected void gvRadnik_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvRadnik, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

      
    }
}