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

namespace Geodezija
{
    public partial class Loko : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = User.Identity.Name;
            Calendar1.SelectedDate = DateTime.Now;
            btnTerenski.Visible = false;
        }

        protected void GridView1_RowCommand(object sender,
  GridViewCommandEventArgs e)
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
                int loko = Insert_Loko(Convert.ToDateTime(datum), selectan.Pocetna, selectan.Dolazna, selectan.Km, selectan.Relacija, selectan.Auto, selectan.Vozac, selectan.Iznos, selectan.Dat_kreir, selectan.Dat_azu,
                        selectan.Kreirao, radnik, selectan.Izvj, selectan.Vrijeme, selectan.Rega);
                if (loko == -1)
                {
                    lblStatus.Text = "Greška prilikom kopiranja loko vožnje. ";
                }
                else
                {
                    GridView1.DataBind();
                    // show the result
                    lblStatus.Text = "Uspješno je spremljena loko vožnja sa šifrom " + loko;
                    // sada prikaži dialog box gdje pita ako je km>70 da obračuna terenski dodatak
                    if (selectan.Km > 70)
                    { 
                    
                    }
                }


            }

        }

        // metoda za kopiranje loko vožnje
        public int Insert_Loko(DateTime datum, decimal pocetna, decimal dolazna, int km, string relacija,
            string auto, string vozac, decimal iznos, DateTime dat_kreir, DateTime dat_azu, string kreirao, int radnikID, string izvj, string vrijeme, string rega)
        {
            int lokoID = 0;
            string insertSQL;

            insertSQL = "INSERT INTO Loko (datum, pocetna, dolazna, km, relacija, auto, vozac, iznos,dat_kreiranja, dat_azu, kreirao, radnikID, izvjesce, vrijeme, registracija) VALUES (@datum, @pocetna, @dolazna, @km, @relacija, @auto, @vozac, @iznos, @dat_kreiranja, @dat_azu, @kreirao, @radnikID, @izvjesce, @vrijeme, @registracija);SELECT SCOPE_IDENTITY();";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@datum", datum);
            cmd.Parameters.AddWithValue("@pocetna", pocetna);
            cmd.Parameters.AddWithValue("@dolazna", dolazna);
            cmd.Parameters.AddWithValue("@km", km);
            cmd.Parameters.AddWithValue("@relacija", relacija);
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
                    selLoko.Km = Convert.ToInt32(reader["km"]);
                    selLoko.Relacija = reader["relacija"].ToString();
                    selLoko.Auto = reader["auto"].ToString();
                    selLoko.Vozac = reader["vozac"].ToString();
                    selLoko.Iznos = Convert.ToDecimal(reader["iznos"]);
                    selLoko.Dat_kreir = Convert.ToDateTime(reader["dat_kreiranja"]);
                    selLoko.Dat_azu = Convert.ToDateTime(reader["dat_azu"]);
                    selLoko.Kreirao = reader["kreirao"].ToString();
                    selLoko.RadnikID = Convert.ToInt32(reader["radnikID"]);
                    selLoko.Izvj = reader["izvjesce"].ToString();
                    selLoko.Vrijeme = reader["vrijeme"].ToString();
                    selLoko.Rega = reader["registracija"].ToString();
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
    }
}


