using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Security;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Geodezija
{
    public class Helper
    {
        //za rad sa korisnicima
        public static DataSet CustomGetAllUsers()
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt = ds.Tables.Add("Users");

            MembershipUserCollection muc;
            muc = Membership.GetAllUsers();

            dt.Columns.Add("UserName", Type.GetType("System.String"));
            dt.Columns.Add("Email", Type.GetType("System.String"));
            dt.Columns.Add("CreationDate", Type.GetType("System.DateTime"));

            /* Here is the list of columns returned of the Membership.GetAllUsers() method
             * UserName, Email, PasswordQuestion, Comment, IsApproved
             * IsLockedOut, LastLockoutDate, CreationDate, LastLoginDate
             * LastActivityDate, LastPasswordChangedDate, IsOnline, ProviderName
             */

            foreach (MembershipUser mu in muc)
            {
                DataRow dr;
                dr = dt.NewRow();
                dr["UserName"] = mu.UserName;
                dr["Email"] = mu.Email;
                dr["CreationDate"] = mu.CreationDate;
                dt.Rows.Add(dr);
            }
            return ds;
        }


        public static string NadiOdgovoran(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string insertSQL;

            //   insertSQL = "UPDATE [Biljeske] SET [datum] = @datum, [opis] = @opis, [projektID] = @projektID, [unio] = @unio, [kraj]= @kraj, [odgovoran]= @odgovoran WHERE [sifra] = @sifra";
            insertSQL = "SELECT [username] FROM [Radnik] WHERE [sifra] = @sifra";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@sifra", sifra);
            SqlDataReader reader;
            int added = 0;
            string user = "";
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    user = reader["username"].ToString();
                }
                reader.Close();
                return user;
            }
            catch (Exception err)
            {
                return "error";
                //  lblStatus.Text = "Error inserting record. ";
                //  lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }

        }


        //za rad sa korisnicima
        public static string DohvatiIzradio(int sifra)
        {

            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string insertSQL;

            //   insertSQL = "UPDATE [Biljeske] SET [datum] = @datum, [opis] = @opis, [projektID] = @projektID, [unio] = @unio, [kraj]= @kraj, [odgovoran]= @odgovoran WHERE [sifra] = @sifra";
            insertSQL = "SELECT ime, prezime AS IZRADIO FROM Radnik WHERE (sifra = @sifra)";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@sifra", sifra);
            SqlDataReader reader;

            string user = "";
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    user = reader["IZRADIO"].ToString();
                }
                reader.Close();
                return user;
            }
            catch (Exception err)
            {
                return "error";
                //  lblStatus.Text = "Error inserting record. ";
                //  lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }


        }



        public static List<Prilozi> DohvatiPriloge(int proj_id)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM PRILOZI WHERE PROJ_ID =@proj_id");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@proj_id", proj_id);
                cnn.Open();
                List<Prilozi> listaPriloga = new List<Prilozi>();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    Prilozi noviPrilog = new Prilozi(0, 0, string.Empty, string.Empty, string.Empty, DateTime.MinValue);
                    noviPrilog.Proj_id = Convert.ToInt32(reader["PROJ_ID"]);
                    noviPrilog.Rbr = Convert.ToInt32(reader["RBR"]);
                    noviPrilog.Opis = reader["OPIS"].ToString();
                    noviPrilog.Putanja = reader["PUTANJA"].ToString();
                    noviPrilog.Tip_sadrzaja = reader["TIP_SADRZAJA"].ToString();
                    noviPrilog.Dt_ins = Convert.ToDateTime(reader["DT_INS"]);

                    listaPriloga.Add(noviPrilog);
                }
                return listaPriloga;
            }
            catch (SqlException ex)
            {

                throw ex;
            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }
        }


        public static Prilozi GetPrilog(int proj, int rbr)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM PRILOZI WHERE PROJ_ID =@proj_id AND RBR=@rbr");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@proj_id", proj);
                cmd.Parameters.AddWithValue("@rbr", rbr);
                cnn.Open();
                Prilozi noviPrilog = new Prilozi(0, 0, string.Empty, string.Empty, string.Empty, DateTime.MinValue);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {


                    noviPrilog.Proj_id = Convert.ToInt32(reader["PROJ_ID"]);
                    noviPrilog.Rbr = Convert.ToInt32(reader["RBR"]);
                    noviPrilog.Opis = reader["OPIS"].ToString();
                    noviPrilog.Putanja = reader["PUTANJA"].ToString();
                    noviPrilog.Tip_sadrzaja = reader["TIP_SADRZAJA"].ToString();
                    noviPrilog.Dt_ins = Convert.ToDateTime(reader["DT_INS"]);

                }
                return noviPrilog;
            }

            catch (SqlException ex)
            {

                throw ex;
            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }

        }



        public static bool UnesiPrilog(int projID, int rbr, string opis, string putanja, string tip_sadrz, DateTime dt_ins)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO PRILOZI (PROJ_ID, RBR, OPIS, PUTANJA, TIP_SADRZAJA, DT_INS) VALUES (@proj_id, @rbr, @opis, @putanja, @tip_sadr,@dt_ins); ");

                cmd.Connection = cnn;
                cmd.Parameters.AddWithValue("@proj_id", projID);
                cmd.Parameters.AddWithValue("@rbr", rbr);
                cmd.Parameters.AddWithValue("@opis", opis);
                cmd.Parameters.AddWithValue("@putanja", putanja);
                cmd.Parameters.AddWithValue("@tip_sadr", tip_sadrz);
                cmd.Parameters.AddWithValue("@dt_ins", dt_ins);

                cnn.Open();
                int brojUbacenih = 0;
                brojUbacenih = cmd.ExecuteNonQuery();
                if (brojUbacenih != 0)
                {
                    Prilozi noviPrilog = new Prilozi(0, 0, string.Empty, string.Empty, string.Empty, DateTime.MinValue);
                    List<Prilozi> listPrilog = new List<Prilozi>();
                    listPrilog.Add(noviPrilog);
                    return true;

                }

                else
                {
                    return false;
                }


            }
            catch (SqlException ex)
            {

                throw ex;
            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }


        }

        public static DataTable DohvatiPredmet(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT Projekt.naziv AS NAZPREDMETA, Projekt.dat_ugov, Projekt.dat_predaja, Klijent.naziv AS KLNAZIV, Klijent.grad AS KLGRAD, " +
                     "Klijent.adresa AS KLADRESA, Klijent.email AS KLMAIL, Klijent.mob AS KLMOB, Klijent.oib AS KLOIB, Projekt.ugov_iznos AS IZNOS FROM Klijent INNER JOIN " +
                    "Projekt ON Klijent.sifra = Projekt.klijentID WHERE (Projekt.sifra = @sifra)");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@sifra", sifra);
                DataTable workTable = new DataTable();
                cnn.Open();
                Predmet predmet = new Predmet();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                   // predmet.Sifra = sifra;
                    predmet.NazPredmeta = reader["NAZPREDMETA"].ToString();
                    predmet.KlOib = reader["KLOIB"].ToString();
                    predmet.KlAdresa = reader["KLADRESA"].ToString();
                    predmet.KlNaziv = reader["KLNAZIV"].ToString();
                    predmet.KlGrad = reader["KLGRAD"].ToString();
                    predmet.KlMail = reader["KLMAIL"].ToString();
                    predmet.KlMob = reader["KLMOB"].ToString();
                    predmet.Dat_placanja = reader["DAT_UGOV"].ToString();
                    //  predmet.Racun_id = reader["RACUN_ID"].ToString();
                    //  predmet.Racun_id = reader["RACUN_ID"].ToString();
                    // predmet.Operater = reader["OPERATER"].ToString();
                    predmet.Iznos = Convert.ToDecimal(reader["IZNOS"]);
                }
                int oper = Helper.NadjiOperatera("Test10");
                // string izradio = Helper.DohvatiIzradio(sifra);
                string izradio = "Adriano Ković";
                DataColumn workCol = workTable.Columns.Add("Sifra", typeof(Int32));
                string dat_izd = DateTime.Now.ToShortDateString();
                string dat_isp = DateTime.Now.ToShortDateString();
                string dat_placanja = DateTime.Now.ToShortDateString();
                string sat_izd = "08:01";
                decimal pdv = decimal.Multiply(predmet.Iznos, 0.25m);
                decimal ukupno = predmet.Iznos + pdv;
                int racun = 12;
             //   workTable.Columns.Add("SIFRA", typeof(Int32));
                workTable.Columns.Add("NAZPREDMETA", typeof(String));
                workTable.Columns.Add("KLOIB", typeof(String));
                workTable.Columns.Add("KLADRESA", typeof(String));
                workTable.Columns.Add("KLNAZIV", typeof(String));
                workTable.Columns.Add("KLGRAD", typeof(String));
                workTable.Columns.Add("KLMOB", typeof(String));
                workTable.Columns.Add("KLMAIL", typeof(String));
                workTable.Columns.Add("DAT_IZD", typeof(String));
                workTable.Columns.Add("DAT_ISP", typeof(String));
                workTable.Columns.Add("DAT_PLACANJA", typeof(String));
                workTable.Columns.Add("SAT_IZD", typeof(String));
                workTable.Columns.Add("RACUN_ID", typeof(Int32));
                workTable.Columns.Add("OPERATER", typeof(Int32));
                workTable.Columns.Add("IZNOS", typeof(Decimal));


                workTable.Columns.Add("PDV", typeof(Decimal));
                workTable.Columns.Add("UKUPNO", typeof(Decimal));
                workTable.Columns.Add("IZRADIO", typeof(String));
                workTable.Rows.Add(sifra, predmet.NazPredmeta, predmet.KlOib, predmet.KlAdresa, predmet.KlNaziv, predmet.KlGrad, predmet.KlMob, predmet.KlMail, dat_izd, dat_isp, dat_placanja, sat_izd, racun, oper, predmet.Iznos, pdv, ukupno, izradio);
                return workTable;
            }

            catch (SqlException ex)
            {

                throw ex;

            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }


        }



        public static int MaxPredmet()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT MAX(SIFRA) FROM PROJEKT");

                cmd.Connection = cnn;
                cnn.Open();
                int maxZahtjevId = Convert.ToInt32(cmd.ExecuteScalar().ToString());
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId > 0)
                {
                    return maxZahtjevId;
                }

                else
                {
                    return 0;
                }


            }
            catch (SqlException ex)
            {

                throw ex;
            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }


        }


        public static List<Status> DohvatiStatuse()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM statusi ORDER BY naziv");
                cmd.Connection = cnn;

                cnn.Open();
                List<Status> tempList = new List<Status>();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    Status noviStatus = new Status(0, string.Empty, string.Empty);
                    noviStatus.Sifra = Convert.ToInt32(reader["sifra"]);
                    noviStatus.Naziv = reader["naziv"].ToString();
                    noviStatus.Boja = reader["boja"].ToString();
                    tempList.Add(noviStatus);

                }
                return tempList; ;
            }

            catch (SqlException ex)
            {

                throw ex;
            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }

        }


        public static List<VrstaPosla> DohvatiPosao()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM vrsta_posla ORDER BY naziv");
                cmd.Connection = cnn;
                List<VrstaPosla> tempList = new List<VrstaPosla>();
                cnn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    VrstaPosla vrsta = new VrstaPosla(0, string.Empty);
                    vrsta.Sifra = Convert.ToInt32(reader["sifra"]);
                    vrsta.Naziv = reader["naziv"].ToString();
                    tempList.Add(vrsta);


                }
                return tempList;
            }

            catch (SqlException ex)
            {

                throw ex;
            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }

        }


        public static int NadjiOperatera(string user)
        {
            int oper;
            switch (user)
            {
                case "Test10":
                    oper = 1;
                    break;
                case "test20":
                    oper = 2;
                    break;
                case "Adriano":
                    oper = 3;
                    break;
                case "Sabina":
                    oper = 4;
                    break;
                case "Boris":
                    oper = 5;
                    break;
                case "Pripravnik":
                    oper = 6;
                    break;
                default:
                    oper = 99;
                    break;
            }
            return oper;

        }


        public static List<Klijent> DohvatiKlijente()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT sifra, naziv FROM Klijent ORDER BY naziv");
                cmd.Connection = cnn;
                List<Klijent> tempList = new List<Klijent>();
                cnn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    Klijent naruc = new Klijent(0, string.Empty);
                    naruc.Sifra = Convert.ToInt32(reader["sifra"]);
                    naruc.Naziv = reader["naziv"].ToString();
                    tempList.Add(naruc);


                }
                return tempList;
            }

            catch (SqlException ex)
            {

                throw ex;
            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }
        }

        //za rad sa korisnicima
        public static DataSet DohvatiUsername()
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt = ds.Tables.Add("Users");

            dt.Columns.Add("UserName", Type.GetType("System.String"));
            dt.Columns.Add("sifra", Type.GetType("System.Int32"));
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string insertSQL;

            //   insertSQL = "UPDATE [Biljeske] SET [datum] = @datum, [opis] = @opis, [projektID] = @projektID, [unio] = @unio, [kraj]= @kraj, [odgovoran]= @odgovoran WHERE [sifra] = @sifra";
            insertSQL = "SELECT [username],[sifra] FROM [Radnik]";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);

            SqlDataReader reader;

            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    DataRow dr;
                    dr = dt.NewRow();
                    dr["UserName"] = reader["username"].ToString();
                    dr["sifra"] = Convert.ToInt32(reader["sifra"]);
                    dt.Rows.Add(dr);
                }
                reader.Close();
                return ds;
            }

            finally
            {
                con.Close();
            }

        }

        public static Narucitelj DohvatiKlijenta(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT sifra, naziv, grad, adresa, tekuci, ziro FROM Klijent ORDER BY naziv");
                cmd.Connection = cnn;
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@sifra", sifra);
                
                cnn.Open();
                Narucitelj nar = new Narucitelj();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    
                    nar.Sifra=  Convert.ToInt32(reader["sifra"].ToString());
                    nar.Naziv = reader["naziv"].ToString();
                    nar.Grad = reader["grad"].ToString();
                    nar.Adresa = reader["adresa"].ToString();
                    nar.Tekuci = reader["tekuci"].ToString();
                    nar.Ziro = reader["ziro"].ToString();
                }
               
                return nar;
            }

            catch (SqlException ex)
            {

                throw ex;

            }
            finally
            {
                if (cnn.State != System.Data.ConnectionState.Closed) cnn.Close();
            }
        
        
        }
    
    
    }
}