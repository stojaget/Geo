using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.html;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Globalization;
using System.Drawing;

namespace Geodezija
{
    public partial class Loko : System.Web.UI.Page
    {
        string user;
        int lokoID;
        private string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (GridView1.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'GridView1', 'HeaderDiv');</script>");
            }
            lblUser.Text = User.Identity.Name;
            //Calendar1.SelectedDate = DateTime.Now;
            btnTerenski.Visible = false;
            lblStatus.Text = "";
            if (!Page.IsPostBack)
            {
                GridView1.DataBind();
            }
        }



        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Kopiraj")
            {
                // dohvaćamo šifru i onda radimo select podataka za nju

                // Retrieve the row index stored in the 
                // CommandArgument property.
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView1.Rows[index];

                int sifra = Convert.ToInt32(row.Cells[1].Text);
                Loko selectan = Select_Loko(sifra);

                string user = lblUser.Text;
                int radnik = Helper.NadjiOperatera(user);
                string datum = DateTime.Now.ToShortDateString();
                int loko = Insert_Loko(Convert.ToDateTime(datum), selectan.Pocetna, selectan.Dolazna, selectan.Km, selectan.Relacija, selectan.Odlazak, selectan.Dolazak, selectan.Sati, selectan.Auto, selectan.Vozac, selectan.Iznos, selectan.Dat_kreir, selectan.Dat_azu,
                        selectan.Kreirao, radnik, selectan.Izvj, selectan.Vrijeme, selectan.Rega);
                if (loko == -1)
                {
                    lblStatus.Text = "Greška prilikom kopiranja loko vožnje. ";
                }
                else
                {

                    // show the result
                    lblStatus.Text = "Uspješno je spremljena loko vožnja sa šifrom " + loko;
                    // sada prikaži dialog box gdje pita ako je km>70 da obračuna terenski dodatak
                    GridView1.DataBind();
                    if (selectan.Km > 70)
                    {
                        btnTerenski.Visible = true;
                    }
                }


            }
            if (e.CommandName == "MKopiraj")
            {
                LinkButton btndetails = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btndetails.NamingContainer;

                int sifra = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex].Value.ToString());
                lokoID = sifra;
                Session["lokoID"] = lokoID;
                //Calendar2.SelectedDates.Clear();
                lblPor.Text = "";
                ViewState["MultipleSelectedDates"] = null;
                Popup(true);
            }

        }

        // metoda za kopiranje loko vožnje
        public int Insert_Loko(DateTime datum, decimal pocetna, decimal dolazna, int km, string relacija, decimal odlazak, decimal dolazak, decimal sati,
            string auto, string vozac, decimal iznos, DateTime dat_kreir, DateTime dat_azu, string kreirao, int radnikID, string izvj, string vrijeme, string rega)
        {
            int lokoID = 0;
            string insertSQL;
            dat_kreir = DateTime.Now;
            insertSQL = "INSERT INTO Loko (datum, pocetna, dolazna, km, relacija,odlazak,dolazak, sati,auto, vozac, iznos,dat_kreiranja, dat_azu, kreirao, radnikID, izvjesce, vrijeme, registracija) VALUES (@datum, @pocetna, @dolazna, @km, @relacija,@odlazak,@dolazak, @sati, @auto, @vozac, @iznos, @dat_kreiranja, @dat_azu, @kreirao, @radnikID, @izvjesce, @vrijeme, @registracija);SELECT SCOPE_IDENTITY();";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@datum", datum);
            cmd.Parameters.AddWithValue("@pocetna", pocetna);
            cmd.Parameters.AddWithValue("@dolazna", dolazna);
            cmd.Parameters.AddWithValue("@km", km);
            cmd.Parameters.AddWithValue("@relacija", relacija);
            cmd.Parameters.AddWithValue("@odlazak", odlazak);
            cmd.Parameters.AddWithValue("@dolazak", dolazak);
            cmd.Parameters.AddWithValue("@sati", sati);
            cmd.Parameters.AddWithValue("@auto", auto);
            cmd.Parameters.AddWithValue("@vozac", vozac);
            cmd.Parameters.AddWithValue("@iznos", iznos);
            cmd.Parameters.AddWithValue("@dat_kreiranja", dat_kreir);
            cmd.Parameters.AddWithValue("@dat_azu", dat_azu);
            cmd.Parameters.AddWithValue("@kreirao", kreirao);
            cmd.Parameters.AddWithValue("@radnikID", radnikID);
            cmd.Parameters.AddWithValue("@izvjesce", izvj);
            cmd.Parameters.AddWithValue("@vrijeme", vrijeme);
            cmd.Parameters.AddWithValue("@registracija", rega);
            /*
            insertSQL += "VALUES ('";
            insertSQL += datum + "', '";
            insertSQL += pocetna + "', '";
            insertSQL += dolazna + "', '";
            insertSQL += km + "', '";
            insertSQL += relacija + "', '";
            insertSQL += auto + "', '";
            insertSQL += vozac + "', '";
            insertSQL += iznos + "', '";
            insertSQL += iznos + "', '";
            insertSQL += dat_kreir + "', '";
            insertSQL += dat_azu + "', '";
            insertSQL += kreirao + "', '";
            insertSQL += radnikID + "', '";
            insertSQL += izvj + "', '";
            insertSQL += vrijeme + "', '";
            insertSQL += rega + "')";
             * */
            //insertSQL += Convert.ToInt16(chkContract.Checked) + "')";


            try
            {
                con.Open();
                // added = cmd.ExecuteNonQuery();
                lokoID = Convert.ToInt32(cmd.ExecuteScalar());
                lblStatus.Text = "Unesena je loko vožnja sa šifrom " + lokoID;
            }
            catch (Exception err)
            {
                lokoID = -1;
                lblStatus.Text = "Greška prilikom spremanja loko vožnje. ";
                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            return (lokoID);
        }


        //metoda za dohvat svih podataka o izabranoj loko vožnji

        public static Loko Select_Loko(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string selectSQL = "SELECT * FROM Loko WHERE sifra = @sifra";
            SqlConnection con = new SqlConnection(connectionString);
            Loko selLoko = new Loko();
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            cmd.Parameters.AddWithValue("@sifra", sifra);
            SqlDataReader reader;

            try
            {
                con.Open();
                reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    selLoko.Sifra = Convert.ToInt32(reader["sifra"]);
                    selLoko.Datum = Convert.ToDateTime(reader["datum"]);
                    selLoko.Pocetna = Convert.ToDecimal(reader["pocetna"]);
                    selLoko.Dolazna = Convert.ToDecimal(reader["dolazna"]);

                    if (reader["km"] is DBNull)
                    {
                        selLoko.Km = 0;
                    }
                    else
                    {
                        selLoko.Km = Convert.ToInt32(reader["km"]);
                    }

                    if (reader["relacija"] is DBNull)
                    {
                        selLoko.Relacija = "";
                    }
                    else
                    {
                        selLoko.Relacija = reader["relacija"].ToString();
                    }

                    if (reader["auto"] is DBNull)
                    {
                        selLoko.Auto = "";
                    }
                    else
                    {
                        selLoko.Auto = reader["auto"].ToString();
                    }

                    if (reader["vozac"] is DBNull)
                    {
                        selLoko.Vozac = "";
                    }
                    else
                    {
                        selLoko.Vozac = reader["vozac"].ToString();
                    }

                    selLoko.Iznos = Convert.ToDecimal(reader["iznos"]);
                    if (reader["dat_kreiranja"] is DBNull)
                    {
                        selLoko.Dat_kreir = DateTime.Now;
                    }
                    else
                    {
                        selLoko.Dat_kreir = Convert.ToDateTime(reader["dat_kreiranja"]);
                    }

                    selLoko.Dat_azu = Convert.ToDateTime(reader["dat_azu"]);
                    selLoko.Kreirao = reader["kreirao"].ToString();
                    selLoko.RadnikID = Convert.ToInt32(reader["radnikID"]);
                    selLoko.Odlazak = Convert.ToDecimal(reader["odlazak"]);
                    selLoko.Dolazak = Convert.ToDecimal(reader["dolazak"]);
                    selLoko.Sati = Convert.ToDecimal(reader["sati"]);

                    if (reader["izvjesce"] is DBNull)
                    {
                        selLoko.Izvj = "";
                    }
                    else
                    {
                        selLoko.Izvj = reader["izvjesce"].ToString();
                    }
                    selLoko.Vrijeme = reader["vrijeme"].ToString();

                    if (reader["registracija"] is DBNull)
                    {
                        selLoko.Rega = "";
                    }
                    else
                    {
                        selLoko.Rega = reader["registracija"].ToString();
                    }

                }
                reader.Close();
                return selLoko;

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



        #region metode za ispis gridview-a

        public override void VerifyRenderingInServerForm(Control control)
        {

            /* Verifies that the control is rendered */

        }

        protected void btnSveStranice_Click(object sender, EventArgs e)
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

        protected void btnStranica_Click(object sender, EventArgs e)
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

        #endregion


        protected void btnTerenski_Click(object sender, EventArgs e)
        {
            string dat_od = Request.QueryString["dod"];
            string dat_do = Request.QueryString["ddo"];
            string url = "Terenski.aspx?dod=" + dat_od + "&ddo=" + dat_do;
            Response.Redirect(url);
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

        protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            decimal dol, poc, iznos;
            decimal km = 0.00m;

            TextBox dolazna = ((TextBox)DetailsView1.FindControl("TextBox3"));
            TextBox pocetna = ((TextBox)DetailsView1.FindControl("TextBox2"));
            Label lbl = (Label)(DetailsView1.FindControl("Label12"));
            DropDownList ddl = DetailsView1.FindControl("ddlOdg") as DropDownList;

            if (dolazna.Text == null)
            {
                dol = 0.00m;
            }
            else
            {
                dol = Convert.ToDecimal(dolazna.Text.Trim());
            }
            if (pocetna.Text == null)
            {
                poc = 0.00m;
            }
            else
            {
                poc = Convert.ToDecimal(pocetna.Text.Trim());
            }

            km = dol - poc;
            int kilometri = Convert.ToInt32(km);
            lbl.Text = kilometri.ToString();
            iznos = km * 2;
            e.NewValues["km"] = lbl.Text;
            e.NewValues["iznos"] = iznos;
            e.NewValues["radnikID"] = ddl.SelectedValue;
            decimal dolazaks, odlazaks;
            decimal satnica = 0.00m;

            TextBox dolazak = ((TextBox)DetailsView1.FindControl("TextBox33"));
            TextBox odlazak = ((TextBox)DetailsView1.FindControl("TextBox22"));
            TextBox lbls = (TextBox)(DetailsView1.FindControl("TextBox55"));


            if (dolazak.Text == null)
            {
                dolazaks = 0.00m;
            }
            else
            {
                dolazaks = Convert.ToDecimal(dolazak.Text.Trim());
            }
            if (odlazak.Text == null)
            {
                odlazaks = 0.00m;
            }
            else
            {
                odlazaks = Convert.ToDecimal(odlazak.Text.Trim());
            }

            satnica = odlazaks - dolazaks;

            lbls.Text = satnica.ToString();

            e.NewValues["sati"] = lbls.Text;
        }

        protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            decimal dol, poc, iznos;
            decimal km = 0.00m;
            DropDownList ddl = DetailsView1.FindControl("ddlOdg") as DropDownList;
            TextBox dolazna = ((TextBox)DetailsView1.FindControl("TextBox2"));
            TextBox pocetna = ((TextBox)DetailsView1.FindControl("TextBox1"));
            TextBox klm = ((TextBox)DetailsView1.FindControl("TextBox7"));
            // Label lbl = (Label)(DetailsView1.FindControl("Label1"));
            decimal dolazaks, odlazaks;
            decimal satnica = 0.00m;

            if (dolazna.Text == null)
            {
                dol = 0.00m;
            }
            else
            {
                dol = Convert.ToDecimal(dolazna.Text.Trim());
            }
            if (pocetna.Text == null)
            {
                poc = 0.00m;
            }
            else
            {
                poc = Convert.ToDecimal(pocetna.Text.Trim());
            }

            km = dol - poc;
            int kilometri = Convert.ToInt32(km);
            klm.Text = kilometri.ToString();
            iznos = km * 2;
            e.Values["km"] = klm.Text;
            e.Values["iznos"] = iznos;
            string user = lblUser.Text;
            TextBox dolazak = ((TextBox)DetailsView1.FindControl("TextBox33"));
            TextBox odlazak = ((TextBox)DetailsView1.FindControl("TextBox22"));
            TextBox lbl = (TextBox)(DetailsView1.FindControl("TextBox55"));


            if (dolazak.Text == null)
            {
                dolazaks = 0.00m;
            }
            else
            {
                dolazaks = Convert.ToDecimal(dolazak.Text.Trim(), CultureInfo.InvariantCulture);
            }
            if (odlazak.Text == null)
            {
                odlazaks = 0.00m;
            }
            else
            {
                odlazaks = Convert.ToDecimal(odlazak.Text.Trim(), CultureInfo.InvariantCulture);
            }
            satnica = odlazaks - dolazaks;

            lbl.Text = satnica.ToString();

            e.Values["sati"] = lbl.Text;
            //int radnik = Helper.NadjiOperatera(user);

            //e.Values["radnikID"] = ddl.SelectedValue;
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            GridView1.DataBind();
            btnTerenski.Visible = true;
        }

        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
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

        protected void ddlAuto_SelectedIndexChanged(object sender, EventArgs e)
        {

            TextBox rega = ((TextBox)DetailsView1.FindControl("TextBox9"));
            TextBox vozac = ((TextBox)DetailsView1.FindControl("TextBox8"));
            Auto odabrani = new Auto();
            DropDownList ddl = DetailsView1.FindControl("ddlAuto") as DropDownList;
            odabrani = Helper.DohvatiAuto(Convert.ToInt32(ddl.SelectedItem.Value));

            rega.Text = odabrani.Rega;
            vozac.Text = odabrani.Vlasnik;
        }

        //protected void Calendar2_PreRender(object sender, EventArgs e)
        //{

        //    Calendar2.SelectedDates.Clear();

        //    foreach (DateTime dt in MultipleSelectedDates)
        //    {
        //        Calendar2.SelectedDates.Add(dt);
        //    }
        //}
        //protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        //{

        //    if (MultipleSelectedDates.Contains(Calendar2.SelectedDate))
        //    {
        //        MultipleSelectedDates.Remove(Calendar2.SelectedDate);
        //    }
        //    else
        //    {
        //        MultipleSelectedDates.Add(Calendar2.SelectedDate);
        //    }

        //    ViewState["MultipleSelectedDates"] = MultipleSelectedDates;
        //    Popup(true);
        //}


        public List<DateTime> MultipleSelectedDates
        {
            get
            {
                if (ViewState["MultipleSelectedDates"] == null)

                    ViewState["MultipleSelectedDates"] = new List<DateTime>();
                return (List<DateTime>)ViewState["MultipleSelectedDates"];
            }
            set
            {
                ViewState["MultipleSelectedDates"] = value;
            }
        }



        protected void btnSave_Click(object sender, EventArgs e)
        {
            //if (MultipleSelectedDates.Count != 0)
            //{
            //    int sifra = Convert.ToInt32(Session["lokoID"]);
            //    Loko selectan = Select_Loko(sifra);
            //    user = lblUser.Text;
            //    int radnik = Helper.NadjiOperatera(user);
            //    List<DateTime> datumi = new List<DateTime>();

            //    foreach (DateTime dt in MultipleSelectedDates)
            //    {
            //        int vrijeme = Insert_Loko(dt, selectan.Pocetna, selectan.Dolazna, selectan.Km, selectan.Relacija,selectan.Odlazak, selectan.Dolazak, selectan.Sati, selectan.Auto, selectan.Vozac, selectan.Iznos, DateTime.Now, DateTime.Now, user, radnik, selectan.Izvj, selectan.Vrijeme, selectan.Rega);

            //        if (vrijeme == -1)
            //        {
            //            lblPor.Text = "Greška prilikom kopiranja radnog vremena. ";
            //            break;
            //        }

            //    }

            //    lblPor.Text = "Uspješno je kopirano";
            //    GridView1.DataBind();
            //    Popup(false);
            //}
            //else
            //{
            //    lblPor.Text = "Nije odabran niti jedan";
            //}
            if (TextBox123.Text != "")
            {
                List<DateTime> datumi = new List<DateTime>();

                int sifra = Convert.ToInt32(Session["lokoID"]);
                Loko selectan = Select_Loko(sifra);
                user = lblUser.Text;
                int radnik = Helper.NadjiOperatera(user);

                string dat = TextBox123.Text;
                string[] words = dat.Split(',');
                foreach (string word in words)
                {
                    datumi.Add(Convert.ToDateTime(word));
                }

                foreach (DateTime dt in datumi)
                {
                    int vrijeme = Insert_Loko(dt, selectan.Pocetna, selectan.Dolazna, selectan.Km, selectan.Relacija, selectan.Odlazak, selectan.Dolazak, selectan.Sati, selectan.Auto, selectan.Vozac, selectan.Iznos, DateTime.Now, DateTime.Now, user, radnik, selectan.Izvj, selectan.Vrijeme, selectan.Rega);

                    if (vrijeme == -1)
                    {
                        lblPor.Text = "Greška prilikom kopiranja loko vožnje. ";
                        break;
                    }

                }

                lblPor.Text = "Uspješno je kopirano";
                GridView1.DataBind();
                Popup(false);
            }

            else
            {
                lblPor.Text = "Nije odabran niti jedan datum za kopiranje";
            }

        }


        //protected void btnClear_Click(object sender, EventArgs e)
        //{

        //    Calendar2.SelectedDates.Clear();
        //    ViewState["MultipleSelectedDates"] = null;
        //}


        void Popup(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> ShowPopup(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowPopup", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> HidePopup(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "HidePopup", builder.ToString());
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            //800, 1050 , 20  ako neće radit postoci
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Key", "<script>MakeStaticHeader('" + GridView1.ClientID + "', 600, 1150 , 20 ,true); </script>", false);
        }




    }
}


