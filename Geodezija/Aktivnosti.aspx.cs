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
using jQueryNotification.Helper;
using System.Data.SqlClient;
using System.Data.Common;
using System.Drawing;
namespace Geodezija
{
    public partial class Aktivnosti : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (GridView1.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'GridView1', 'HeaderDiv');</script>");
            }
            if (!IsPostBack)
            {

            }
        }

        DateTime odd, dod;
        string odgovoran, opis = string.Empty;

        /// <summary>
        /// Gets the first day of a week where day (parameter) belongs. weekStart (parameter) specifies the starting day of week.
        /// </summary>
        /// <returns></returns> 
        private static DateTime firstDayOfWeek(DateTime day, DayOfWeek weekStarts)
        {
            DateTime d = day;
            while (d.DayOfWeek != weekStarts)
            {
                d = d.AddDays(-1);
            }

            return d;
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

        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            GridView1.DataBind();
            //string poruka = "Uspješno je unesena aktivnost sa šifrom ";
            //this.ShowSuccessfulNotification(poruka);
        }

        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
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

        protected void SqlDataSource2_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            DbCommand command = e.Command;
            string user = command.Parameters["@odgovoran"].Value.ToString();
            // The label displays the primary key of the recently inserted row.
            // command.Parameters["@PK_New"].Value.ToString();
            string poruka = "Unesena je aktivnost sa trajanjem od " + command.Parameters["@pocetak"].Value.ToString() + " do " +
                command.Parameters["@kraj"].Value.ToString() + ", a odgovorna osoba je " + command.Parameters["@odgovoran"].Value.ToString();
            bool uspjeh = Helper.UnesiObavijest(DateTime.Now, user, poruka, false);
            if (uspjeh)
            {
                this.ShowSuccessfulNotification(poruka, 3000);
            }
            else
            {
                this.ShowErrorNotification("Nije uspjelo kreiranje obavijesti");
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

        protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            DbCommand command = e.Command;
            string user = command.Parameters["@izvrsena"].Value.ToString();
            // The label displays the primary key of the recently inserted row.
            // command.Parameters["@PK_New"].Value.ToString();
            if (user == "True")
            {
                string poruka = "Izvršena je aktivnost sa trajanjem od " + command.Parameters["@pocetak"].Value.ToString() + " do " +
                command.Parameters["@kraj"].Value.ToString() + ", a odgovorna osoba je " + command.Parameters["@odgovoran"].Value.ToString();
                bool uspjeh = Helper.UnesiObavijest(DateTime.Now, "svi", poruka, true);
                if (uspjeh)
                {
                    // this.ShowSuccessfulNotification(poruka, 10000);
                    AspNetNotify1.AddMessage(poruka);
                }
                else
                {
                    this.ShowErrorNotification("Nije uspjelo kreiranje obavijesti");
                }
            }

        }

        protected void SqlDataSource2_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            //string poc = SqlDataSource2.InsertParameters["pocetak"].ToString() + ":00";
            //DateTime pocetak, zavrsetak;
            //DateTime.TryParse(poc, out pocetak);
            //string kraj = SqlDataSource2.InsertParameters["kraj"].ToString() + ":00";
            //DateTime.TryParse(kraj, out zavrsetak);
        }

        protected void SqlDataSource2_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {

            // string poc = SqlDataSource2.UpdateParameters["@pocetak"].ToString() + ":00";
            // 
            //string poc = SqlDataSource2.UpdateParameters["pocetak"].ToString() + ":00";
         
            //int p = poc.LastIndexOf(".");
            //poc.Remove(p, 1);
            //DateTime pocetak, zavrsetak;
            //IFormatProvider theCultureInfo = new System.Globalization.CultureInfo("hr-HR", true);
            ////pocetak = Convert.ToDateTime(poc);
            //pocetak = DateTime.ParseExact(poc, "dd.mm.yyyy HH:MM:ss", theCultureInfo);
            //e.Command.Parameters["@pocetak"].Value = pocetak;
            //string kraj = SqlDataSource2.UpdateParameters["kraj"].ToString() + ":00";
            //int k = kraj.LastIndexOf(".");
            //kraj.Remove(k, 1);
            //zavrsetak = DateTime.ParseExact(kraj, "dd.mm.yyyy HH:MM:ss", theCultureInfo);
            //e.Command.Parameters["@kraj"].Value = zavrsetak;
            //SqlDataSource2.Update();
        }

        protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            TextBox pocetak = ((TextBox)DetailsView1.FindControl("TextBox1"));
            TextBox kraj = ((TextBox)DetailsView1.FindControl("TextBox2"));
            string poc, kr;
            poc = pocetak.Text;
           // int p = poc.LastIndexOf(".");
          //  poc.Remove(p-1, 1);
            DateTime po, zavr;
            IFormatProvider theCultureInfo = new System.Globalization.CultureInfo("hr-HR", true);
            po = Convert.ToDateTime(poc);
           // po = DateTime.ParseExact(poc, "dd.mm.yyyy HH:MM:ss", theCultureInfo);
            kr = kraj.Text;
          //  int k = kr.LastIndexOf(".");
          //  kr.Remove(k-1, 1);
            zavr = Convert.ToDateTime(kr);
            //zavr = DateTime.ParseExact(kr, "dd.mm.yyyy HH:MM:ss", theCultureInfo);
            e.NewValues["pocetak"] = po;
            e.NewValues["kraj"] = zavr;
        }

        protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            TextBox pocetak = ((TextBox)DetailsView1.FindControl("TextBox1"));
            TextBox kraj = ((TextBox)DetailsView1.FindControl("TextBox2"));
            string poc, kr;
            poc = pocetak.Text;
            int p = poc.LastIndexOf(".");
            poc.Remove(p - 1, 1);
            DateTime po, zavr;
            IFormatProvider theCultureInfo = new System.Globalization.CultureInfo("hr-HR", true);
            po = Convert.ToDateTime(poc);
            // po = DateTime.ParseExact(poc, "dd.mm.yyyy HH:MM:ss", theCultureInfo);
            kr = kraj.Text;
            int k = kr.LastIndexOf(".");
            kr.Remove(k - 1, 1);
            zavr = Convert.ToDateTime(kr);
            //zavr = DateTime.ParseExact(kr, "dd.mm.yyyy HH:MM:ss", theCultureInfo);
            e.Values["pocetak"] = po;
            e.Values["kraj"] = zavr;
        }





    }
}