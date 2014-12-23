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
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Geodezija
{
    public partial class Klijenti : System.Web.UI.Page
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
                NapuniGrid();
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
            //kada user odabere klijneta odvede ga na stranicu za uređivanje
            Response.Redirect("KlijentiCRUD.aspx?ID=" + GridView1.SelectedValue);
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {


            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //int index = GetColumnIndexByHeaderText(GridView1, "ind_prilog");
                //int indexKon = GetColumnIndexByHeaderText(GridView1, "ind_kontakt");
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
                foreach (GridViewRow row in GridView1.Rows)
                {
                    string kon = ((Label)e.Row.FindControl("lblInd")).Text;
                    // string kon = e.Row.Cells[indexKon].Text.Trim();
                    if ((kon != "") && (kon != "&nbsp;"))
                    {
                        if ((kon == "True") || (kon == "1"))
                        {
                            HyperLink hyp = (HyperLink)e.Row.FindControl("hlPrilozi");

                            hyp.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {

                            HyperLink hyp = (HyperLink)e.Row.FindControl("hlPrilozi");
                            hyp.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        HyperLink hyp = (HyperLink)e.Row.FindControl("HyperLink9");
                        hyp.ForeColor = System.Drawing.Color.Red;
                    }
                    //string pred = e.Row.Cells[index].Text.Trim();
                    string pred = ((Label)e.Row.FindControl("lblIndKon")).Text;
                    if ((pred != "") && (pred != "&nbsp;"))
                    {
                        if ((pred == "True") || (pred == "1"))
                        {
                            HyperLink hyp = (HyperLink)e.Row.FindControl("HyperLink9");
                            hyp.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {

                            HyperLink hyp = (HyperLink)e.Row.FindControl("HyperLink9");
                            hyp.ForeColor = System.Drawing.Color.Red;
                        }

                    }
                    else
                    {
                        HyperLink hyp = (HyperLink)e.Row.FindControl("HyperLink9");
                        hyp.ForeColor = System.Drawing.Color.Red;
                    }

                }
            }


            if (e.Row.RowType == DataControlRowType.Header && this.ViewState["SortExp"] != null)
            {
                System.Web.UI.WebControls.Image ImgSort = new System.Web.UI.WebControls.Image();
                if (this.ViewState["SortOrder"].ToString() == "ASC")
                    ImgSort.ImageUrl = "Styles/images/downarrow.gif";
                else
                    ImgSort.ImageUrl = "Styles/images/uparrow.gif";

                switch (this.ViewState["SortExp"].ToString())
                {
                    case "sifra":
                        PlaceHolder placeholderSifra = (PlaceHolder)
                                                                   e.Row.FindControl("placeholderSifra");
                        placeholderSifra.Controls.Add(ImgSort);
                        break;

                    case "naziv":
                        PlaceHolder placeholderNaziv = (PlaceHolder)
                                                                   e.Row.FindControl("placeholderNaziv");
                        placeholderNaziv.Controls.Add(ImgSort);
                        break;

                    case "grad":
                        PlaceHolder placeholderGrad = (PlaceHolder)
                                                                   e.Row.FindControl("placeholderGrad");
                        placeholderGrad.Controls.Add(ImgSort);
                        break;
                }


            }
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("KlijentiCRUD.aspx?ID=999999");
        }

        protected void btnKontakt_Click(object sender, EventArgs e)
        {
            Response.Redirect("Kontakt.aspx?ID=999999");
        }

        // ---- GetColumnIndexByHeaderText ----------------------------------
        //
        // pass in a GridView and a Column's Header Text
        // returns index of the column if found
        // returns -1 if not found 


        public int GetColumnIndexByHeaderText(GridView aGridView, String ColumnText)
        {
            TableCell Cell;
            for (int Index = 0; Index < aGridView.HeaderRow.Cells.Count; Index++)
            {
                Cell = aGridView.HeaderRow.Cells[Index];
                if (Cell.Text.ToString() == ColumnText)
                    return Index;
            }
            return -1;
        }

        protected void btnTrazi_Click(object sender, EventArgs e)
        {
            string vrsta = ddlVrsta.SelectedItem.Text;


            int sif;

            string naziv = txtNaziv.Text;


            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("dbo.spKlijenti", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (vrsta == "Svi")
            {
                cmd.Parameters.AddWithValue("@VRSTA", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@VRSTA", vrsta);
            }
            if (txtSifra.Text.Trim() == "")
            {
                cmd.Parameters.AddWithValue("@SIFRA", DBNull.Value);

            }
            else
            {
                sif = Convert.ToInt32(txtSifra.Text.Trim());
                cmd.Parameters.AddWithValue("@SIFRA", sif);
            }

            cmd.Parameters.AddWithValue("@NAZIV", naziv);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dset = new DataSet();
            adapter.Fill(dset, "t1");
            var result = cmd.ExecuteReader();
            GridView1.EmptyDataText = "No Records Found";

            GridView1.DataSource = dset.Tables["t1"];
            GridView1.DataBind();

            conn.Close();
        }

        private void NapuniGrid()
        {
            string vrsta = "";
            int sifra = -1;
            string naziv = "";
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("dbo.spKlijenti", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@VRSTA", DBNull.Value);
            cmd.Parameters.AddWithValue("@SIFRA", DBNull.Value);
            cmd.Parameters.AddWithValue("@NAZIV", DBNull.Value);

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dset = new DataSet();
            adapter.Fill(dset, "t1");
            var result = cmd.ExecuteReader();
            GridView1.EmptyDataText = "No Records Found";
            DataTable dt = new DataTable();
            dt = dset.Tables[0];
            DataView dv = dt.DefaultView;

            if (this.ViewState["SortExp"] != null)
            {
                dv.Sort = this.ViewState["SortExp"].ToString()
                         + " " + this.ViewState["SortOrder"].ToString();
            }

            //GridView1.DataSource = dset.Tables["t1"];
            GridView1.DataSource = dv;
            GridView1.DataBind();

            conn.Close();


        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName.Equals("Sort"))
            {
                if (this.ViewState["SortExp"] == null)
                {
                    this.ViewState["SortExp"] = e.CommandArgument.ToString();
                    this.ViewState["SortOrder"] = "ASC";
                }
                else
                {
                    if (this.ViewState["SortExp"].ToString() == e.CommandArgument.ToString())
                    {
                        if (this.ViewState["SortOrder"].ToString() == "ASC")
                            this.ViewState["SortOrder"] = "DESC";
                        else
                            this.ViewState["SortOrder"] = "ASC";
                    }
                    else
                    {
                        this.ViewState["SortOrder"] = "ASC";
                        this.ViewState["SortExp"] = e.CommandArgument.ToString();
                    }
                }

                NapuniGrid();
            }
        }





    }
}
