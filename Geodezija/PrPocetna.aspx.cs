using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Text;
using System.Drawing;

namespace Geodezija
{
    public partial class PrPocetna : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            gvProjekti.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            GridView1.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (gvProjekti.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'gvProjekti', 'HeaderDiv');</script>");
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
            gvProjekti.AllowPaging = false;
            gvProjekti.DataBind();
            gvProjekti.RenderControl(hw);
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
                gvProjekti.AllowPaging = false;
                gvProjekti.DataBind();

                gvProjekti.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in gvProjekti.HeaderRow.Cells)
                {
                    cell.BackColor = gvProjekti.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gvProjekti.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gvProjekti.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gvProjekti.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gvProjekti.RenderControl(hw);

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

        protected void gvProjekti_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvProjekti.Rows)
            {
                if (row.RowIndex == gvProjekti.SelectedIndex)
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
            Response.Redirect("ProjektiCRUD.aspx?ID=" + gvProjekti.SelectedValue);
        }

        protected void btnSveStrane_Click(object sender, ImageClickEventArgs e)
        {
            gvProjekti.AllowPaging = false;

            gvProjekti.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvProjekti.RenderControl(hw);

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

            gvProjekti.AllowPaging = true;

            gvProjekti.DataBind();
        }

        protected void btnAktivnaStrana_Click(object sender, ImageClickEventArgs e)
        {
            gvProjekti.PagerSettings.Visible = false;

            gvProjekti.DataBind();

            StringWriter sw = new StringWriter();

            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvProjekti.RenderControl(hw);

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

            gvProjekti.PagerSettings.Visible = true;

            gvProjekti.DataBind();
        }

        protected void gvProjekti_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvProjekti, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }
    }
}