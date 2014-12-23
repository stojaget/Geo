using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;

namespace Geodezija
{
    public partial class Ter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            lblUser.Text = User.Identity.Name;
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            gvTerenski.DataBind();
        }

        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            gvTerenski.DataBind();
        }

        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            gvTerenski.DataBind();
        }

        protected void gvTerenski_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Kopiraj")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvTerenski.Rows[index];

                int sifra = Convert.ToInt32(row.Cells[1].Text);
                Ter selectan = Select_Teren(sifra);

                string user = lblUser.Text;
                int radnik = Helper.NadjiOperatera(user);
                string datum = DateTime.Now.ToShortDateString();
                int teren = Insert_Teren(Convert.ToDateTime(datum), selectan.Odlazak, selectan.Dolazak, selectan.Sati, selectan.Opis, selectan.Iznos, selectan.Dat_kreir, selectan.Dat_azu,
                        selectan.Kreirao, radnik, selectan.Vrsta, selectan.Napomena);
                if (teren == -1)
                {
                    lblStatus.Text = "Greška prilikom kopiranja terenskog obračuna ";
                }
                else
                {
                    gvTerenski.DataBind();
                    // show the result
                    lblStatus.Text = "Uspješno je spremljen terenski obračun sa šifrom " + teren;


                }
            }


        }

        public static Ter Select_Teren(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string selectSQL = "SELECT * FROM [Terenski] WHERE ([sifra] = @sifra)";
            SqlConnection con = new SqlConnection(connectionString);
            Ter selTeren = new Ter();
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            cmd.Parameters.AddWithValue("@sifra", sifra);
            SqlDataReader reader;

            try
            {
                con.Open();
                reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    selTeren.Sifra = Convert.ToInt32(reader["sifra"]);
                    selTeren.Datum = Convert.ToDateTime(reader["datum"]);
                    selTeren.Odlazak = Convert.ToDecimal(reader["odlazak"]);
                    selTeren.Dolazak = Convert.ToDecimal(reader["dolazak"]);
                    selTeren.Sati = Convert.ToInt32(reader["km"]);
                    selTeren.Opis = reader["opis"].ToString();
                    selTeren.Vrsta = reader["vrsta"].ToString();
                    selTeren.Napomena = reader["napomena"].ToString();
                    selTeren.Iznos = Convert.ToDecimal(reader["iznos"]);
                    selTeren.Dat_kreir = Convert.ToDateTime(reader["dat_kreiranja"]);
                    selTeren.Dat_azu = Convert.ToDateTime(reader["dat_azu"]);
                    selTeren.Kreirao = reader["kreirao"].ToString();
                    selTeren.RadnikID = Convert.ToInt32(reader["radnikID"]);

                }
                reader.Close();
                return selTeren;

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

        // metoda za kopiranje terenske vožnje
        public int Insert_Teren(DateTime datum, decimal odlazak, decimal dolazak, int sati, string opis, decimal iznos,
            DateTime dat_kreir, DateTime dat_azu, string kreirao, int radnikID, string vrsta, string napomena)
        {
            int terenID = 0;
            string insertSQL;
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            insertSQL = "INSERT INTO [Terenski] ([datum], [iznos], [odlazak], [dolazak], [sati], [napomena], [kreirao], [dat_kreiranja], [dat_azu], [radnikID], [opis], [vrsta]) VALUES (@datum, @iznos, @odlazak, @dolazak, @sati, @napomena, @kreirao, @dat_kreiranja, @dat_azu, @radnikID, @opis, @vrsta);SELECT SCOPE_IDENTITY();";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@datum", datum);
            cmd.Parameters.AddWithValue("@iznos", iznos);
            cmd.Parameters.AddWithValue("@odlazak", odlazak);
            cmd.Parameters.AddWithValue("@dolazak", dolazak);
            cmd.Parameters.AddWithValue("@sati", sati);
            cmd.Parameters.AddWithValue("@napomena", napomena);
            cmd.Parameters.AddWithValue("@kreirao", kreirao);
            cmd.Parameters.AddWithValue("@dat_kreiranja", dat_kreir);
            cmd.Parameters.AddWithValue("@dat_azu", dat_azu);
            cmd.Parameters.AddWithValue("@radnikID", radnikID);
            cmd.Parameters.AddWithValue("@opis", opis);
            cmd.Parameters.AddWithValue("@vrsta", vrsta);

            try
            {
                con.Open();
                // added = cmd.ExecuteNonQuery();
                terenID = Convert.ToInt32(cmd.ExecuteScalar());
                lblStatus.Text = "Unesen je terenski obračun sa šifrom " + terenID;
            }
            catch (Exception err)
            {
                terenID = -1;
                lblStatus.Text = "Greška prilikom spremanja terenskog obračuna. ";
                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            return (terenID);
        }


    }
}
