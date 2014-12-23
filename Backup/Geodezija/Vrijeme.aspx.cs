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
    public partial class Vrijeme : System.Web.UI.Page
    {
        string user;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = User.Identity.Name;

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
                Vrijeme selectan = Select_Vrijeme(sifra);

                user = lblUser.Text;
                int radnik = Helper.NadjiOperatera(user);
                string datum = DateTime.Now.ToShortDateString();
                int vrijeme = Insert_Vrijeme(Convert.ToDateTime(datum), selectan.Dolazak, selectan.Odlazak, selectan.Blagdan, selectan.Godisnji, selectan.Bolovanje, selectan.Napomena, radnik);

                if (vrijeme == -1)
                {
                    lblStatus.Text = "Greška prilikom kopiranja radnog vremena. ";
                }
                else
                {
                    GridView1.DataBind();
                    // show the result
                    lblStatus.Text = "Uspješno je spremljeno radno vrijeme sa šifrom " + vrijeme;
                    // sada prikaži dialog box gdje pita ako je km>70 da obračuna terenski dodatak

                }


            }
        }

        public static Vrijeme Select_Vrijeme(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string selectSQL = "SELECT * FROM [Evid_vrijeme] WHERE sifra = @sifra";
            SqlConnection con = new SqlConnection(connectionString);
            Vrijeme selVrijeme = new Vrijeme();
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            cmd.Parameters.AddWithValue("@sifra", sifra);
            SqlDataReader reader;

            try
            {
                con.Open();
                reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    selVrijeme.Sifra = Convert.ToInt32(reader["sifra"]);
                    selVrijeme.Datum = Convert.ToDateTime(reader["datum"]);
                    selVrijeme.Dolazak = reader["dolazak"].ToString();
                    selVrijeme.Odlazak = reader["odlazak"].ToString();
                    selVrijeme.Blagdan = Convert.ToBoolean(reader["blagdan"]);
                    selVrijeme.Godisnji = Convert.ToBoolean(reader["godisnji"]);
                    selVrijeme.Bolovanje = Convert.ToBoolean(reader["bolovanje"]);
                    selVrijeme.Napomena = reader["napomena"].ToString();
                    selVrijeme.radnikID = Convert.ToInt32(reader["radnikID"]);

                }
                reader.Close();
                return selVrijeme;

            }
            /*
        catch (Exception err)
        {
             lblStatus.Text = "Greška prilikom spremanja loko vožnje. ";
            lblStatus.Text += err.Message;
        }
           */
            finally
            {
                con.Close();
            }
        }

        // metoda za kopiranje radnog vremena
        public int Insert_Vrijeme(DateTime datum, string dolazak, string odlazak, bool blagdan, bool godisnji, bool bolovanje,
            string napomena, int radnikID)
        {
            int vrijemeID = 0;
            string insertSQL;

            insertSQL = "INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID);SELECT SCOPE_IDENTITY();";
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@datum", datum);
            cmd.Parameters.AddWithValue("@dolazak", dolazak);
            cmd.Parameters.AddWithValue("@odlazak", odlazak);
            cmd.Parameters.AddWithValue("@blagdan", blagdan);
            cmd.Parameters.AddWithValue("@godisnji", godisnji);
            cmd.Parameters.AddWithValue("@bolovanje", bolovanje);
            cmd.Parameters.AddWithValue("@napomena", napomena);
            cmd.Parameters.AddWithValue("@radnikID", radnikID);

            try
            {
                con.Open();
                // added = cmd.ExecuteNonQuery();
                vrijemeID = Convert.ToInt32(cmd.ExecuteScalar());
                lblStatus.Text = "Uneseno je radno vrijeme sa šifrom " + vrijemeID;
            }
            catch (Exception err)
            {
                vrijemeID = -1;
                lblStatus.Text = "Greška prilikom spremanja radnog vremena. ";
                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            return (vrijemeID);
        }



    }
}