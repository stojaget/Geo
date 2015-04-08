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
using System.Web.Security;

namespace Geodezija
{
    public partial class Projekti : System.Web.UI.Page
    {
        decimal ukIznos = 0.00M;
        decimal ukLova = 0.00M;
        protected void Page_Load(object sender, EventArgs e)
        {
            

            if (Roles.IsUserInRole("Pripravnik"))
            {
                Response.Redirect("PrProjekti.aspx");
            }

            GridView1.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            //  GridView1.AlternatingRowStyle.BackColor = System.Drawing.Color.Green;
            if (GridView1.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'GridView1', 'HeaderDiv');</script>");
            }



            if (!IsPostBack)
            {

                FillKlijenti();
                FillZavrsio();

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
            Response.Redirect("ProjektiCRUD.aspx?ID=" + GridView1.SelectedValue);
        }


        public void FillZavrsio()
        {

            // create the connection
            ddlZavrsio.DataSource = Helper.DohvatiUsername();

            ddlZavrsio.DataTextField = "username";
            ddlZavrsio.DataValueField = "sifra";
            ddlZavrsio.DataBind();

        }
        public void FillKlijenti()
        {
            ddlKlij.DataSource = Helper.DohvatiKlijente();
            ddlKlij.DataTextField = "naziv";
            ddlKlij.DataValueField = "sifra";
            ddlKlij.DataBind();
            // ddlKlijent.Items.Insert(0, new ListItem("- Select Status -", ""));
        }
        private void NapuniGrid()
        {
            DateTime odd, dod; // dguPodnesenOD dguPotvrdenOD, dguPodnesenDO, dguPotvrdenDO;
            odd = new DateTime(2001, 1, 1);
            dod = new DateTime(2055, 1, 1);
            int vrsta = -1;
            int status = -1;
            string kat = "";
            int klijent = -1;
            string zavrsio = "";
            //dguPodnesenOD = new DateTime(2001, 1, 1);
            //dguPodnesenDO = new DateTime(2055, 1, 1);
            //dguPotvrdenOD = new DateTime(2001, 1, 1);
            //dguPotvrdenDO = new DateTime(2055, 1, 1);

            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("dbo.spProjekti", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@STATUS", DBNull.Value);
            cmd.Parameters.AddWithValue("@VRSTA", DBNull.Value);
            cmd.Parameters.AddWithValue("@KAT", DBNull.Value);
            cmd.Parameters.AddWithValue("@NAZIV", DBNull.Value);
            cmd.Parameters.AddWithValue("@KLIJENT", DBNull.Value);
            cmd.Parameters.AddWithValue("@ZAVRSIO", DBNull.Value);
            cmd.Parameters.AddWithValue("@OD", odd);
            cmd.Parameters.AddWithValue("@DO", dod);
            //cmd.Parameters.AddWithValue("@DGUPODNESENOD", dguPodnesenOD);
            //cmd.Parameters.AddWithValue("@DGUPODNESENDO", dguPodnesenDO);
            //cmd.Parameters.AddWithValue("@DGUPOTVRDENOD", dguPotvrdenOD);
            //cmd.Parameters.AddWithValue("@DGUPOTVRDENDO", dguPotvrdenDO);
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {


            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
                //ukIznos += Convert.ToDecimal((DataBinder.Eval(e.Row.DataItem, "ugov_iznos")));
                //ukLova += Convert.ToDecimal((DataBinder.Eval(e.Row.DataItem, "lova")));
                Label ugov = (Label)e.Row.FindControl("Label14");
                Label lova = (Label)e.Row.FindControl("Label18");
                if ((ugov.Text == "0,00") || (lova.Text == "0,00"))
                {
                    ukIznos += 0;
                    ukLova += 0;
                }
                // ukIznos += Convert.ToDecimal(((Label)e.Row.FindControl("Label14")).Text);
                // ukLova += Convert.ToDecimal(((Label)e.Row.FindControl("Label18")).Text);
                ukIznos += Decimal.Parse(ugov.Text);
                ukLova += Decimal.Parse(lova.Text);
                foreach (GridViewRow row in GridView1.Rows)
                {


                    int inde = GetColumnIndexByHeaderText("Status");
                    //string status = e.Row.Cells[inde].Text;
                    string status = ((Label)e.Row.FindControl("lblStatus")).Text;
                    switch (status)
                    {
                        case "Početak":
                            e.Row.ForeColor = System.Drawing.Color.Black;
                            break;
                        case "Odrađen teren":

                            e.Row.ForeColor = System.Drawing.Color.Green;
                            //  e.Row.ForeColor = System.Drawing.Color.Green;

                            break;

                        case "Na čekanju (papiri)":
                            e.Row.ForeColor = System.Drawing.Color.Orange;
                            break;

                        case "Otvoren- storniran":
                            e.Row.ForeColor = System.Drawing.Color.LightPink;
                            break;

                        case "Gotovo":
                            e.Row.ForeColor = System.Drawing.Color.Red;
                            break;


                        default:
                            e.Row.ForeColor = System.Drawing.Color.Black;
                            break;
                    }
                    int index = GetColumnIndexByHeaderText("ind_prilog");
                    string pred = ((Label)e.Row.FindControl("lblInd")).Text;
                    // string pred = e.Row.Cells[index].Text.Trim();
                    if ((pred != "") && (pred != "&nbsp;"))
                    {
                        //int sifra = Convert.ToInt32(pred);
                        //int brojKontakta = Helper.PrebrojiPrilogeZaProjekt(sifra);
                        //if (brojKontakta != 0)
                        if ((pred == "True") || (pred == "1"))
                        {
                            HyperLink hyp = (HyperLink)e.Row.FindControl("HyperLink1");
                            hyp.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {

                            HyperLink hyp = (HyperLink)e.Row.FindControl("HyperLink1");
                            hyp.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        HyperLink hyp = (HyperLink)e.Row.FindControl("HyperLink1");
                        hyp.ForeColor = System.Drawing.Color.Red;
                    }
                }


            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {

                Label lblUkPredmeta = (Label)e.Row.FindControl("lblUkPredmeta");
                lblUkPredmeta.Text = GridView1.Rows.Count.ToString();
                Label lblUkLova = (Label)e.Row.FindControl("lblUkLova");
                lblUkLova.Text = ukLova.ToString("c");
                Label lblUkIznos = (Label)e.Row.FindControl("lblUkIznos");
                lblUkIznos.Text = ukIznos.ToString("c");

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
                    case "arh_broj":
                        PlaceHolder placeholderArh = (PlaceHolder)
                                                                   e.Row.FindControl("placeholderArh");
                        placeholderArh.Controls.Add(ImgSort);
                        break;

                    case "godina":
                        PlaceHolder placeholderGodina = (PlaceHolder)
                                                                   e.Row.FindControl("placeholderGodina");
                        placeholderGodina.Controls.Add(ImgSort);
                        break;

                    case "dat_kreiranje":
                        PlaceHolder placeholderDatkreiranja = (PlaceHolder)
                                                                   e.Row.FindControl("placeholderDatkreiranja");
                        placeholderDatkreiranja.Controls.Add(ImgSort);
                        break;

                    case "dat_zavrs":
                        PlaceHolder placeholderDatzatv = (PlaceHolder)
                                                                e.Row.FindControl("placeholderDatzatv");
                        placeholderDatzatv.Controls.Add(ImgSort);
                        break;

                    case "Klijent":
                        PlaceHolder placeholderKlijent = (PlaceHolder)
                                                             e.Row.FindControl("placeholderKlijent");
                        placeholderKlijent.Controls.Add(ImgSort);
                        break;
                    case "Status":
                        PlaceHolder placeholderStatus = (PlaceHolder)
                                                             e.Row.FindControl("placeholderStatus");
                        placeholderStatus.Controls.Add(ImgSort);
                        break;
                    case "Naziv":
                        PlaceHolder placeholderNaziv = (PlaceHolder)
                                                             e.Row.FindControl("placeholderNaziv");
                        placeholderNaziv.Controls.Add(ImgSort);
                        break;
                    case "kat_opc":
                        PlaceHolder placeholderKat_opc = (PlaceHolder)
                                                             e.Row.FindControl("placeholderKat_opc");
                        placeholderKat_opc.Controls.Add(ImgSort);
                        break;
                    case "kat_cest":
                        PlaceHolder placeholderKat_cest = (PlaceHolder)
                                                             e.Row.FindControl("placeholderKat_cest");
                        placeholderKat_cest.Controls.Add(ImgSort);
                        break;
                    case "narucen_kat":
                        PlaceHolder placeholderNar_kat = (PlaceHolder)
                                                             e.Row.FindControl("placeholderNar_kat");
                        placeholderNar_kat.Controls.Add(ImgSort);
                        break;


                    case "stigli_kat":
                        PlaceHolder placeholderStigli_kat = (PlaceHolder)
                                                             e.Row.FindControl("placeholderStigli_kat");
                        placeholderStigli_kat.Controls.Add(ImgSort);
                        break;


                    case "ugov_iznos":
                        PlaceHolder placeholderUgov_iznos = (PlaceHolder)
                                                             e.Row.FindControl("placeholderUgov_iznos");
                        placeholderUgov_iznos.Controls.Add(ImgSort);
                        break;

                    case "lova":
                        PlaceHolder placeholderLova = (PlaceHolder)
                                                             e.Row.FindControl("placeholderLova");
                        placeholderLova.Controls.Add(ImgSort);
                        break;
                    case "faktura_sifra":
                        PlaceHolder placeholderFakt_sif = (PlaceHolder)
                                                             e.Row.FindControl("placeholderFakt_sif");
                        placeholderFakt_sif.Controls.Add(ImgSort);
                        break;
                    case "pon_nar":
                        PlaceHolder placeholderPon_nar = (PlaceHolder)
                                                             e.Row.FindControl("placeholderPon_nar");
                        placeholderPon_nar.Controls.Add(ImgSort);
                        break;
                    case "zavrsio":
                        PlaceHolder placeholderZavrsio = (PlaceHolder)
                                                             e.Row.FindControl("placeholderZavrsio");
                        placeholderZavrsio.Controls.Add(ImgSort);
                        break;
                    case "teren":
                        PlaceHolder placeholderTeren = (PlaceHolder)
                                                             e.Row.FindControl("placeholderTeren");
                        placeholderTeren.Controls.Add(ImgSort);
                        break;
                    case "placeno":
                        PlaceHolder placeholderPlaceno = (PlaceHolder)
                                                             e.Row.FindControl("placeholderPlaceno");
                        placeholderPlaceno.Controls.Add(ImgSort);
                        break;
                }
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

        protected void Button1_Click(object sender, EventArgs e)
        {

            Response.Redirect("ProjektiCRUD.aspx");
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            //GridView1.UseAccessibleHeader = true;
            //GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void btnTrazi_Click(object sender, EventArgs e)
        {
            //ovo je da preimenuje iz velikog u mala slova
            // UPDATE Projekt SET zavrsio = REPLACE(CAST(zavrsio AS varchar(MAX))
            //,'Sebina', 'sebina') FROM Projekt WHERE CHARINDEX('Sebina',CAST(zavrsio as nvarchar(50)))>0


            DateTime odd, dod; // dguPodnesenOD, dguPotvrdenOD, dguPodnesenDO, dguPotvrdenDO;
            int vrsta = Convert.ToInt32(ddlVrsta.SelectedValue);
            int status = Convert.ToInt32(ddlStatus.SelectedValue);
            int kat = Convert.ToInt32(ddlKat.SelectedValue);
            string zavrs = ddlZavrsio.SelectedItem.Text;
            int klijent = Convert.ToInt32(ddlKlij.SelectedValue);
            string naziv = txtTraziPredmet.Text;
            if (txtZavrsOd.Text == string.Empty)
            { odd = new DateTime(2001, 1, 1); }
            else
            {
                odd = Convert.ToDateTime(txtZavrsOd.Text);
            }
            if (txtZavrsDo.Text == string.Empty)
            {
                dod = DateTime.Now.AddYears(10);
            }
            else
            {
                dod = Convert.ToDateTime(txtZavrsDo.Text);
            }
            //if (txtDguPodnesenOd.Text == string.Empty)
            //{
            //    dguPodnesenOD  = new DateTime(2001, 1, 1);
            //}
            //else
            //{
            //    dguPodnesenOD = Convert.ToDateTime(txtDguPodnesenOd.Text);
            //}
            //if (txtDguPodnesenDo.Text == string.Empty)
            //{
            //    dguPodnesenDO = DateTime.Now.AddYears(10);
            //}
            //else
            //{
            //    dguPodnesenDO = Convert.ToDateTime(txtDguPodnesenDo.Text);
            //}
            //if (txtDguPotvrdenOd.Text== string.Empty)
            //{
            //    dguPotvrdenOD = new DateTime(2001, 1, 1);
            //}
            //else
            //{
            //    dguPotvrdenOD = Convert.ToDateTime(txtDguPotvrdenOd.Text);
            //}
            //if (txtDguPotvrdenDo.Text == string.Empty)
            //{
            //    dguPotvrdenDO = DateTime.Now.AddYears(10);
            //}
            //else
            //{
            //    dguPotvrdenDO = Convert.ToDateTime(txtDguPotvrdenDo.Text);
            //}
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("dbo.spProjekti", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (status == -1)
            {
                cmd.Parameters.AddWithValue("@STATUS", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@STATUS", status);
            }
            if (vrsta == -1)
            {
                cmd.Parameters.AddWithValue("@VRSTA", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@VRSTA", vrsta);
            }
            if (kat == -1)
            {
                cmd.Parameters.AddWithValue("@KAT", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@KAT", kat);
            }
            if (klijent == -1)
            {
                cmd.Parameters.AddWithValue("@KLIJENT", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@KLIJENT", klijent);
            }
            cmd.Parameters.AddWithValue("@NAZIV", naziv);
            if (zavrs == "Svi")
            {
                cmd.Parameters.AddWithValue("@ZAVRSIO", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@ZAVRSIO", zavrs);
            }

            cmd.Parameters.AddWithValue("@OD", odd);
            cmd.Parameters.AddWithValue("@DO", dod);
            //cmd.Parameters.AddWithValue("@DGUPODNESENOD", dguPodnesenOD);
            //cmd.Parameters.AddWithValue("@DGUPODNESENDO", dguPodnesenDO);
            //cmd.Parameters.AddWithValue("@DGUPOTVRDENOD", dguPotvrdenOD);
            //cmd.Parameters.AddWithValue("@DGUPOTVRDENDO", dguPotvrdenDO);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dset = new DataSet();
            adapter.Fill(dset, "t1");
            var result = cmd.ExecuteReader();
            GridView1.EmptyDataText = "No Records Found";

            GridView1.DataSource = dset.Tables["t1"];
            GridView1.DataBind();

            conn.Close();
        }



        protected void btnKatPred_Click(object sender, EventArgs e)
        {
            //ovo je da preimenuje iz velikog u mala slova
            // UPDATE Projekt SET zavrsio = REPLACE(CAST(zavrsio AS varchar(MAX))
            //,'Sebina', 'sebina') FROM Projekt WHERE CHARINDEX('Sebina',CAST(zavrsio as nvarchar(50)))>0


            DateTime odd, dod; // dguPodnesenOD, dguPotvrdenOD, dguPodnesenDO, dguPotvrdenDO;
            int vrsta = Convert.ToInt32(ddlVrsta.SelectedValue);
            int status = Convert.ToInt32(ddlStatus.SelectedValue);
            int kat = Convert.ToInt32(ddlKat.SelectedValue);
            string zavrs = ddlZavrsio.SelectedItem.Text;
            int klijent = Convert.ToInt32(ddlKlij.SelectedValue);
            string naziv = txtTraziPredmet.Text;
            if (txtZavrsOd.Text == string.Empty)
            { odd = new DateTime(2001, 1, 1); }
            else
            {
                odd = Convert.ToDateTime(txtZavrsOd.Text);
            }
            if (txtZavrsDo.Text == string.Empty)
            {
                dod = DateTime.Now.AddYears(10);
            }
            else
            {
                dod = Convert.ToDateTime(txtZavrsDo.Text);
            }

            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            conn.Open();
            SqlCommand cmd = new SqlCommand("dbo.spProjBezPotvrde", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (status == -1)
            {
                cmd.Parameters.AddWithValue("@STATUS", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@STATUS", status);
            }
            if (vrsta == -1)
            {
                cmd.Parameters.AddWithValue("@VRSTA", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@VRSTA", vrsta);
            }
            if (kat == -1)
            {
                cmd.Parameters.AddWithValue("@KAT", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@KAT", kat);
            }
            if (klijent == -1)
            {
                cmd.Parameters.AddWithValue("@KLIJENT", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@KLIJENT", klijent);
            }
            cmd.Parameters.AddWithValue("@NAZIV", naziv);
            if (zavrs == "Svi")
            {
                cmd.Parameters.AddWithValue("@ZAVRSIO", DBNull.Value);

            }
            else
            {
                cmd.Parameters.AddWithValue("@ZAVRSIO", zavrs);
            }

            cmd.Parameters.AddWithValue("@OD", odd);
            cmd.Parameters.AddWithValue("@DO", dod);
            //cmd.Parameters.AddWithValue("@DGUPODNESENOD", dguPodnesenOD);
            //cmd.Parameters.AddWithValue("@DGUPODNESENDO", dguPodnesenDO);
            //cmd.Parameters.AddWithValue("@DGUPOTVRDENOD", dguPotvrdenOD);
            //cmd.Parameters.AddWithValue("@DGUPOTVRDENDO", dguPotvrdenDO);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dset = new DataSet();
            adapter.Fill(dset, "t1");
            var result = cmd.ExecuteReader();
            GridView1.EmptyDataText = "No Records Found";

            GridView1.DataSource = dset.Tables["t1"];
            GridView1.DataBind();

            conn.Close();
        }

        protected void GridView1_Load(object sender, EventArgs e)
        {
            //800, 1050 , 20  ako neće radit postoci
            // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Key", "<script>MakeStaticHeader('" + GridView1.ClientID + "', 80, 98 , 30 ,true); </script>", false);
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

        // ---- GetColumnIndexByHeaderText ----------------------------------
        //
        // pass in a GridView and a Column's Header Text
        // returns index of the column if found
        // returns -1 if not found 


        public int GetColumnIndexByHeaderText(String name)
        {
            int index = -1;
            for (int i = 0; i < GridView1.Columns.Count; i++)
            {
                if (GridView1.Columns[i].HeaderText.ToLower().Trim() == name.ToLower().Trim())
                {
                    index = i;
                    break;
                }
            }
            return index;
        }





    }
}