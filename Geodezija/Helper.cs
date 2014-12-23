using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Security;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data.SqlTypes;

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

        /// <summary>
        /// YYYY-MM-DD ovaj foramt je sql univerzalan pa se isto može koristiti
        /// </summary>
        /// <param name="oDate"></param>
        /// <returns></returns>
        public static DateTime PretvoriDatum(string oDate)
        {
            IFormatProvider fp = new System.Globalization.CultureInfo("en-US");
            return DateTime.ParseExact(oDate, "MM/dd/yyyy", fp);
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

        public static string DohvatiIme(string user)
        {

            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;

            string insertSQL;

            //   insertSQL = "UPDATE [Biljeske] SET [datum] = @datum, [opis] = @opis, [projektID] = @projektID, [unio] = @unio, [kraj]= @kraj, [odgovoran]= @odgovoran WHERE [sifra] = @sifra";
            insertSQL = "SELECT ime +' '+ prezime AS IZRADIO FROM Radnik WHERE (username LIKE @user)";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@user", user);
            SqlDataReader reader;

            string ime = "";
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ime = reader["IZRADIO"].ToString();
                }
                reader.Close();
                return ime;
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


        public static KlPrilozi GetKlijentPrilog(int proj, int rbr)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM KLPRILOZI WHERE KLIJENTID =@proj_id AND RBR=@rbr");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@proj_id", proj);
                cmd.Parameters.AddWithValue("@rbr", rbr);
                cnn.Open();
                KlPrilozi noviPrilog = new KlPrilozi(0, 0, string.Empty, string.Empty, string.Empty, DateTime.MinValue);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {


                    noviPrilog.Klijent_id = Convert.ToInt32(reader["KLIJENTID"]);
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

        public static RadPrilozi GetRadnikPrilog(int proj, int rbr)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM RADNIKPRILOG WHERE RADNIKID =@proj_id AND RBR=@rbr");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@proj_id", proj);
                cmd.Parameters.AddWithValue("@rbr", rbr);
                cnn.Open();
                RadPrilozi noviPrilog = new RadPrilozi(0, 0, string.Empty, string.Empty, string.Empty, DateTime.MinValue);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {


                    noviPrilog.Radnik_id = Convert.ToInt32(reader["RADNIKID"]);
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

        public static bool UnesiKlijenta(string naziv, string grad, string adresa, string email, string mob, string tel1, string oib, string ziro, string kreirao)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO [Klijent] ( [naziv], [grad], [adresa], [email], [mob], [tel1], [tel2], [napomena], [oib], [tekuci], [ziro], [potencijalni], [kreirao], [dat_kreiranja], [dat_azu]) VALUES (@naziv, @grad, @adresa, @email, @mob, @tel1, @tel2, @napomena, @oib, @tekuci, @ziro, @potencijalni, @kreirao, @dat_kreiranja, @dat_azu); ");

                cmd.Connection = cnn;
                cmd.Parameters.AddWithValue("@naziv", naziv);
                cmd.Parameters.AddWithValue("@grad", grad);
                cmd.Parameters.AddWithValue("@adresa", adresa);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@mob", mob);
                cmd.Parameters.AddWithValue("@tel1", tel1);
                cmd.Parameters.AddWithValue("@tel2", string.Empty);
                cmd.Parameters.AddWithValue("@napomena", string.Empty);
                cmd.Parameters.AddWithValue("@oib", oib);
                cmd.Parameters.AddWithValue("@tekuci", string.Empty);
                cmd.Parameters.AddWithValue("@ziro", ziro);
                cmd.Parameters.AddWithValue("@potencijalni", false);
                cmd.Parameters.AddWithValue("@kreirao", kreirao);
                cmd.Parameters.AddWithValue("@dat_kreiranja", DateTime.Now);
                cmd.Parameters.AddWithValue("@dat_azu", DateTime.Now);
                cnn.Open();
                int brojUbacenih = 0;
                brojUbacenih = cmd.ExecuteNonQuery();
                if (brojUbacenih != 0)
                {
                    Klijent noviPrilog = new Klijent(0, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty);
                    List<Klijent> listPrilog = new List<Klijent>();
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

        public static bool UnesiKlijentPrilog(int klID, int rbr, string opis, string putanja, string tip_sadrz, DateTime dt_ins)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO KLPRILOZI (KLIJENTID, RBR, OPIS, PUTANJA, TIP_SADRZAJA, DT_INS) VALUES (@proj_id, @rbr, @opis, @putanja, @tip_sadr,@dt_ins); ");

                cmd.Connection = cnn;
                cmd.Parameters.AddWithValue("@proj_id", klID);
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
                    KlPrilozi noviPrilog = new KlPrilozi(0, 0, string.Empty, string.Empty, string.Empty, DateTime.MinValue);
                    List<KlPrilozi> listPrilog = new List<KlPrilozi>();
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

        public static bool UnesiRadnikPrilog(int radID, int rbr, string opis, string putanja, string tip_sadrz, DateTime dt_ins)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO RADNIKPRILOG (RADNIKID, RBR, OPIS, PUTANJA, TIP_SADRZAJA, DT_INS) VALUES (@proj_id, @rbr, @opis, @putanja, @tip_sadr,@dt_ins); ");

                cmd.Connection = cnn;
                cmd.Parameters.AddWithValue("@proj_id", radID);
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
                    RadPrilozi noviPrilog = new RadPrilozi(0, 0, string.Empty, string.Empty, string.Empty, DateTime.MinValue);
                    List<RadPrilozi> listPrilog = new List<RadPrilozi>();
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

        public static DataTable DohvatiPredmet(Int32 sifra, string izradio, string ponid, string faktid)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT Projekt.naziv AS NAZPREDMETA, Projekt.arh_broj as ARHBROJ, Projekt.kat_opc AS KATOPC, Projekt.kat_cest AS KATCEST, Projekt.dat_kreiranje, Projekt.dat_predaja, Klijent.naziv AS KLNAZIV, Klijent.grad AS KLGRAD, " +
                     "Klijent.adresa AS KLADRESA, Klijent.email AS KLMAIL, Klijent.mob AS KLMOB, Klijent.oib AS KLOIB, Projekt.racun_iznos AS IZNOS, Klijent.pon_sifra as PONUDAID, Projekt.faktura_sifra as FAKTURAID FROM Klijent INNER JOIN " +
                    "Projekt ON Klijent.sifra = Projekt.klijentID WHERE (Projekt.sifra = @sifra)");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@sifra", sifra);
                DataTable workTable = new DataTable();
                cnn.Open();
                Predmet predmet = new Predmet();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    predmet.Sifra = sifra;
                    predmet.NazPredmeta = reader["NAZPREDMETA"].ToString();
                    predmet.ArhBroj = Convert.ToInt32(reader["ARHBROJ"]);
                    predmet.KatOpc = reader["KATOPC"].ToString();
                    predmet.KatCest = reader["KATCEST"].ToString();
                    predmet.KlOib = reader["KLOIB"].ToString();
                    predmet.KlAdresa = reader["KLADRESA"].ToString();
                    predmet.KlNaziv = reader["KLNAZIV"].ToString();
                    predmet.KlGrad = reader["KLGRAD"].ToString();
                    predmet.KlMail = reader["KLMAIL"].ToString();
                    predmet.KlMob = reader["KLMOB"].ToString();
                    predmet.Dat_placanja = reader["DAT_KREIRANJE"].ToString();
                    //predmet.Ponuda_sifra = reader["PONUDAID"].ToString();
                    predmet.Faktura_sifra = reader["FAKTURAID"].ToString();

                    //  predmet.Racun_id = reader["RACUN_ID"].ToString();
                    //  predmet.Racun_id = reader["RACUN_ID"].ToString();
                    // predmet.Operater = reader["OPERATER"].ToString();
                    predmet.Iznos = Convert.ToDecimal(reader["IZNOS"]);
                }
                int oper = Helper.NadjiOperatera(izradio);
                string sastavio = Helper.NadjiIzradio(izradio);

                // DataColumn workCol = workTable.Columns.Add("Sifra", typeof(Int32));
                string dat_izd = DateTime.Now.ToShortDateString();
                string dat_isp = DateTime.Now.ToShortDateString();
                string dat_placanja = DateTime.Now.ToShortDateString();
                string sat_izd = "08:01";
                decimal pd = decimal.Multiply(predmet.Iznos, 0.25m);
                decimal pdv = Math.Round(pd, 2);
                decimal ukupn = predmet.Iznos + pdv;
                decimal ukupno = Math.Round(ukupn, 2);
                int racun = 12;
                workTable.Columns.Add("SIFRA", typeof(Int32));
                workTable.Columns.Add("NAZPREDMETA", typeof(String));
                workTable.Columns.Add("ARHBROJ", typeof(String));
                workTable.Columns.Add("KATOPC", typeof(String));
                workTable.Columns.Add("KATCEST", typeof(String));
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

                workTable.Columns.Add("PONUDAID", typeof(String));
                workTable.Columns.Add("FAKTURAID", typeof(String));
                string danas = DateTime.Now.Year.ToString().Substring(2, 2);
                string arhivski = "EL-" + predmet.ArhBroj.ToString() + "/" + danas;
                workTable.Rows.Add(sifra, predmet.NazPredmeta, arhivski, predmet.KatOpc, predmet.KatCest, predmet.KlOib, predmet.KlAdresa, predmet.KlNaziv, predmet.KlGrad, predmet.KlMob, predmet.KlMail, dat_izd, dat_isp, dat_placanja, sat_izd, racun, oper, predmet.Iznos, pdv, ukupno, sastavio, ponid, faktid);
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

        public static DataTable StaroDohvatiKlij(Int32 sifra, string izradio, string ponid)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT  Klijent.naziv as KLNAZIV , Klijent.grad AS KLGRAD, Projekt.naziv " +
                     "Klijent.adresa AS KLADRESA, Klijent.email AS KLMAIL, Klijent.mob AS KLMOB, Klijent.oib AS KLOIB, Projekt.racun_iznos AS IZNOS, Klijent.pon_sifra as PONUDAID FROM Klijent INNER JOIN " +
                    "Projekt ON Klijent.sifra = Projekt.klijentID WHERE (Klijent.sifra = @sifra)");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@sifra", sifra);
                DataTable workTable = new DataTable();
                cnn.Open();
                Narucitelj klijent = new Narucitelj();
                SqlDataReader reader = cmd.ExecuteReader();
                decimal iznos = 0.00m;
                string naziv = "";
                while (reader.Read())
                {
                    klijent.Sifra = sifra;


                    klijent.Oib = reader["KLOIB"].ToString();
                    klijent.Adresa = reader["KLADRESA"].ToString();
                    klijent.Naziv = reader["KLNAZIV"].ToString();
                    klijent.Grad = reader["KLGRAD"].ToString();
                    klijent.Email = reader["KLMAIL"].ToString();
                    klijent.Mob = reader["KLMOB"].ToString();
                    naziv = reader["naziv"].ToString();
                    iznos = Convert.ToDecimal(reader["IZNOS"]);
                }
                int oper = Helper.NadjiOperatera(izradio);
                // string sastavio = Helper.NadjiIzradio(izradio);

                // DataColumn workCol = workTable.Columns.Add("Sifra", typeof(Int32));
                string dat_izd = DateTime.Now.ToShortDateString();
                string dat_isp = DateTime.Now.ToShortDateString();
                string dat_placanja = DateTime.Now.ToShortDateString();
                string sat_izd = "08:01";
                decimal pd = decimal.Multiply(iznos, 0.25m);
                decimal pdv = Math.Round(pd, 2);
                decimal ukupn = iznos + pdv;
                decimal ukupno = Math.Round(ukupn, 2);

                workTable.Columns.Add("SIFRA", typeof(Int32));
                workTable.Columns.Add("KLNAZIV", typeof(String));
                workTable.Columns.Add("KLOIB", typeof(String));
                workTable.Columns.Add("KLADRESA", typeof(String));
                workTable.Columns.Add("NAZPREDMETA", typeof(String));
                workTable.Columns.Add("KLGRAD", typeof(String));
                workTable.Columns.Add("KLMOB", typeof(String));
                workTable.Columns.Add("KLMAIL", typeof(String));
                workTable.Columns.Add("DAT_IZD", typeof(String));

                // workTable.Columns.Add("OPERATER", typeof(Int32));
                workTable.Columns.Add("IZNOS", typeof(Decimal));


                workTable.Columns.Add("PDV", typeof(Decimal));
                workTable.Columns.Add("UKUPNO", typeof(Decimal));
                workTable.Columns.Add("IZRADIO", typeof(String));

                workTable.Columns.Add("PONUDAID", typeof(String));

                string danas = DateTime.Now.Year.ToString().Substring(2, 2);
                workTable.Rows.Add(sifra, klijent.Naziv, klijent.Oib, klijent.Adresa, naziv, klijent.Grad, klijent.Mob, klijent.Email, dat_izd, iznos, pdv, ukupno, oper, ponid);
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

        public static DataTable DohvatiKlij(Int32 sifra, string izradio, string ponid)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT  Klijent.naziv as KLNAZIV , Klijent.grad AS KLGRAD, " +
                     "Klijent.adresa AS KLADRESA, Klijent.email AS KLMAIL, Klijent.mob AS KLMOB, Klijent.oib AS KLOIB,  Klijent.pon_sifra as PONUDAID FROM Klijent" +
                    " WHERE (Klijent.sifra = @sifra)");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@sifra", sifra);
                DataTable workTable = new DataTable();
                cnn.Open();
                Narucitelj klijent = new Narucitelj();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    klijent.Sifra = sifra;


                    klijent.Oib = reader["KLOIB"].ToString();
                    klijent.Adresa = reader["KLADRESA"].ToString();
                    klijent.Naziv = reader["KLNAZIV"].ToString();
                    klijent.Grad = reader["KLGRAD"].ToString();
                    klijent.Email = reader["KLMAIL"].ToString();
                    klijent.Mob = reader["KLMOB"].ToString();

                }
                int oper = Helper.NadjiOperatera(izradio);
                string sastavio = Helper.NadjiIzradio(izradio);

                // DataColumn workCol = workTable.Columns.Add("Sifra", typeof(Int32));
                string dat_izd = DateTime.Now.ToShortDateString();
                string dat_isp = DateTime.Now.ToShortDateString();
                string dat_placanja = DateTime.Now.ToShortDateString();
                string sat_izd = "08:01";


                workTable.Columns.Add("SIFRA", typeof(Int32));
                workTable.Columns.Add("KLNAZIV", typeof(String));
                workTable.Columns.Add("KLOIB", typeof(String));
                workTable.Columns.Add("KLADRESA", typeof(String));

                workTable.Columns.Add("KLGRAD", typeof(String));
                workTable.Columns.Add("KLMOB", typeof(String));
                workTable.Columns.Add("KLMAIL", typeof(String));
                workTable.Columns.Add("DAT_IZD", typeof(String));

                workTable.Columns.Add("IZRADIO", typeof(String));

                workTable.Columns.Add("PONUDAID", typeof(String));

                string danas = DateTime.Now.Year.ToString().Substring(2, 2);
                workTable.Rows.Add(sifra, klijent.Naziv, klijent.Oib, klijent.Adresa, klijent.Grad, klijent.Mob, klijent.Email, dat_izd, sastavio, ponid);
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

        public static PredmetSredjen DohProjekt(Int32 sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM Projekt WHERE (Projekt.sifra = @sifra)");
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@sifra", sifra);

                cnn.Open();
                PredmetSredjen predmet = new PredmetSredjen();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    predmet.Sifra = sifra;
                    predmet.NazPredmeta = reader["NAZIV"].ToString();
                    predmet.ArhBroj = Convert.ToInt32(reader["ARH_BROJ"]);
                    predmet.KatOpc = reader["KAT_OPC"].ToString();
                    predmet.KatCest = reader["KAT_CEST"].ToString();
                    predmet.Kat = Convert.ToInt32(reader["KAT"]);
                    if (reader["DAT_KREIRANJE"] == DBNull.Value)
                    {
                        predmet.Dat_kreiranje = (DateTime)SqlDateTime.MinValue;
                    }
                    else
                    {
                        predmet.Dat_kreiranje = Convert.ToDateTime(reader["DAT_KREIRANJE"]);
                    }
                    if (reader["dat_azuriranja"] == DBNull.Value)
                    {
                        predmet.Dat_azuriranja = (DateTime)SqlDateTime.MinValue;
                    }
                    else
                    {
                        predmet.Dat_azuriranja = Convert.ToDateTime(reader["dat_azuriranja"]);
                    }
                    if (reader["dat_potvrde"] == DBNull.Value)
                    {
                        predmet.Dat_potvrde = (DateTime)SqlDateTime.MinValue;
                    }
                    else
                    {
                        predmet.Dat_potvrde = Convert.ToDateTime(reader["dat_potvrde"]);
                    }
                    if (reader["dat_zavrs"] == DBNull.Value)
                    {
                        predmet.Dat_zavrs = (DateTime)SqlDateTime.MinValue;
                    }
                    else
                    {
                        predmet.Dat_zavrs = Convert.ToDateTime(reader["dat_zavrs"]);
                    }
                    if (reader["dat_predaja"] == DBNull.Value)
                    {
                        predmet.Dat_predaja = (DateTime)SqlDateTime.MinValue;
                    }
                    else
                    {
                        predmet.Dat_predaja = Convert.ToDateTime(reader["dat_predaja"]);
                    }
                    if (reader["dat_predajedgu"] == DBNull.Value)
                    {
                        predmet.Dat_predajedgu = (DateTime)SqlDateTime.MinValue;
                    }
                    else
                    {
                        predmet.Dat_predajedgu = Convert.ToDateTime(reader["dat_predajedgu"]);
                    }

                    predmet.Status = Convert.ToInt32(reader["statusID"]);
                    predmet.Vrsta = Convert.ToInt32(reader["vrstaID"]);
                    predmet.KlijentID = Convert.ToInt32(reader["klijentID"]);
                    predmet.Faktura_sifra = reader["Faktura_sifra"].ToString();
                    predmet.Kreirao = reader["kreirao"].ToString();
                    predmet.Zavrsio = reader["zavrsio"].ToString();
                    predmet.Narucen = reader["narucen_kat"].ToString();
                    predmet.Stigli = reader["stigli_kat"].ToString();
                    predmet.Dgu_klasa = reader["dgu_klasa"].ToString();
                    predmet.Dgu_uru = reader["dgu_uru"].ToString();
                    predmet.Teren = reader["teren"].ToString();
                    predmet.Pon_nar = reader["pon_nar"].ToString();
                    predmet.Godina = reader["godina"].ToString();
                    if (reader["placeno"] != DBNull.Value)
                    {
                        predmet.Placeno = Convert.ToBoolean(reader["placeno"]);
                    }
                    else
                    {
                        predmet.Placeno = false;
                    }
                    if (reader["faktura_ind"] != DBNull.Value)
                    {
                        predmet.Fakt_ind = Convert.ToBoolean(reader["faktura_ind"]);
                    }
                    else
                    {
                        predmet.Fakt_ind = false;
                    }

                    predmet.Putanja_projekt = reader["putanja_projekt"].ToString();
                    if (reader["ind_prilog"] != DBNull.Value)
                    {
                        predmet.Ind = Convert.ToBoolean(reader["ind_prilog"]);
                    }
                    else
                    {
                        predmet.Ind = false;
                    }

                    predmet.Lova = Convert.ToDecimal(reader["lova"]);
                    predmet.Racun_iznos = Convert.ToDecimal(reader["racun_iznos"]);
                    predmet.Cijena_kat = Convert.ToDecimal(reader["cijena_kat"]);
                    predmet.Iznos = Convert.ToDecimal(reader["ugov_iznos"]);

                }
                return predmet;

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
        public static int PrebrojiKontakteZaKlijenta(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT COUNT(klijentID) AS broj FROM Kontakt WHERE klijentID=@sifra");
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Connection = cnn;
                cnn.Open();
                string maxZahtjevId = cmd.ExecuteScalar().ToString();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId != string.Empty)
                {
                    return Convert.ToInt32(maxZahtjevId);
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
        public static int PrebrojiPrilogeZaProjekt(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT COUNT(PROJ_ID) AS broj FROM PRILOZI WHERE PROJ_ID=@sifra");
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Connection = cnn;
                cnn.Open();
                string maxZahtjevId = cmd.ExecuteScalar().ToString();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId != string.Empty)
                {
                    return Convert.ToInt32(maxZahtjevId);
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

        public static int MaxPredmet(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT MAX(rbr) FROM Prilozi WHERE proj_id=@sifra");
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Connection = cnn;
                cnn.Open();
                var maxZahtjevId = cmd.ExecuteScalar();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId == DBNull.Value)
                {
                    return 0;
                }

                else
                {
                    return (Int32)maxZahtjevId;
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


        public static int MaxKlijent(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT MAX(rbr) FROM KlPrilozi WHERE klijentID=@sifra");
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Connection = cnn;
                cnn.Open();
                var maxZahtjevId = cmd.ExecuteScalar();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId == DBNull.Value)
                {
                    return 0;
                }

                else
                {
                    return (Int32)maxZahtjevId;
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

        public static int MaxRadnik(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT MAX(rbr) FROM RadnikPrilog WHERE radnikID=@sifra");
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Connection = cnn;
                cnn.Open();
                var maxZahtjevId = cmd.ExecuteScalar();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId == DBNull.Value)
                {
                    return 0;
                }

                else
                {
                    return (Int32)maxZahtjevId;
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

        public static string MaxPonudaSifra()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT TOP 1 pon_sifra FROM Klijent order by dat_azuriranja desc");

                cmd.Connection = cnn;
                cnn.Open();
                string maxZahtjevId = cmd.ExecuteScalar().ToString();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId != string.Empty)
                {
                    return maxZahtjevId;
                }

                else
                {
                    return "P-000";
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
        public static string MaxFakturaSifra()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT TOP 1 faktura_sifra FROM PROJEKT order by dat_azuriranja desc");

                cmd.Connection = cnn;
                cnn.Open();
                string maxZahtjevId = cmd.ExecuteScalar().ToString();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId != string.Empty)
                {
                    return maxZahtjevId;
                }

                else
                {
                    return "000-U";
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

        public static string MaxPonudaKlijent()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT TOP 1 pon_sifra FROM KLIJENT order by dat_azu desc");

                cmd.Connection = cnn;
                cnn.Open();
                string maxZahtjevId = cmd.ExecuteScalar().ToString();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId != string.Empty)
                {
                    return maxZahtjevId;
                }

                else
                {
                    return "P-000";
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


        public static string MaxArhivski()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT MAX(arh_broj) FROM Projekt");

                cmd.Connection = cnn;
                cnn.Open();
                var maxZahtjevId = cmd.ExecuteScalar();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId == DBNull.Value)
                {
                    return "";
                }

                else
                {
                    return maxZahtjevId.ToString();
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

        public static string MaxArhivskiTekucaGodina()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT MAX(arh_broj) FROM Projekt WHERE  DATEPART(year, dat_kreiranje) = YEAR(GETDATE())");

                cmd.Connection = cnn;
                cnn.Open();
                var maxZahtjevId = cmd.ExecuteScalar();
                //  cmd.Parameters.AddWithValue(":zahtjev_id", zahtjev_id);

                if (maxZahtjevId == DBNull.Value)
                {
                    return "";
                }

                else
                {
                    return maxZahtjevId.ToString();
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

                SqlCommand cmd = new SqlCommand("SELECT * FROM statusi ORDER BY sifra ASC");
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
                    oper = 11;
                    break;
                case "test20":
                    oper = 22;
                    break;
                case "sandi":
                    oper = 4;
                    break;
                case "adriano":
                    oper = 3;
                    break;
                case "sebina":
                    //staviti u 2, za testnu fazu je 22
                    oper = 2;
                    break;
                case "boris":
                    oper = 1;
                    break;
                case "pripravnik":
                    oper = 6;
                    break;
                default:
                    oper = 99;
                    break;
            }
            return oper;

        }

        public static string NadjiIzradio(string user)
        {
            string oper;
            switch (user)
            {
                case "Test10":
                    oper = "Test10";
                    break;
                case "Test20":
                    oper = "Test10";
                    break;
                case "sandi":
                    oper = "Sandi Šabić";
                    break;
                case "adriano":
                    oper = "Adriano Radolović";
                    break;
                case "sebina":
                    //staviti u 2, za testnu fazu je 22
                    oper = "Sebina Stepančić Salić";
                    break;
                case "boris":
                    oper = "Boris Manevski";
                    break;
                case "pripravnik":
                    oper = "Pripravnik";
                    break;
                default:
                    oper = "Nepoznato";
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

                SqlCommand cmd = new SqlCommand("SELECT sifra, naziv FROM Klijent WHERE povezani = 'False' OR povezani = 0 OR povezani is null  ORDER BY naziv");
                //   SqlCommand cmd = new SqlCommand("SELECT sifra, naziv FROM Klijent WHERE Klijent.povezani= 'True' OR Klijent.povezani IS NULL  ORDER BY naziv ");
                cmd.Connection = cnn;
                List<Klijent> tempList = new List<Klijent>();
                cnn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    Klijent naruc = new Klijent();
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

        public static List<Klijent> DohvatiSveKlijente()
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

                    Klijent naruc = new Klijent();
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

                SqlCommand cmd = new SqlCommand("SELECT *  FROM Klijent WHERE sifra= @sifra ORDER BY naziv");
                cmd.Connection = cnn;
                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@sifra", sifra);

                cnn.Open();
                Narucitelj nar = new Narucitelj();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    nar.Sifra = Convert.ToInt32(reader["sifra"].ToString());
                    nar.Naziv = reader["naziv"].ToString();
                    nar.Grad = reader["grad"].ToString();
                    nar.Adresa = reader["adresa"].ToString();
                    nar.Pon_sifra = reader["pon_sifra"].ToString();
                    nar.Tekuci = reader["tekuci"].ToString();
                    nar.Ziro = reader["ziro"].ToString();
                    nar.Titula = reader["titula"].ToString();
                    nar.Email = reader["email"].ToString();
                    nar.Mob = reader["mob"].ToString();
                    nar.Tel1 = reader["tel1"].ToString();
                    nar.Tel2 = reader["tel2"].ToString();
                    nar.Oib = reader["oib"].ToString();
                    nar.Email2 = reader["email2"].ToString(); ;
                    nar.Napomena = reader["napomena"].ToString();
                    nar.Napomena2 = reader["napomena2"].ToString();
                    nar.Mob2 = reader["mob"].ToString();
                    if (reader["ind_prilog"] != DBNull.Value)
                    {
                        nar.Ind = Convert.ToBoolean(reader["ind_prilog"]);
                    }
                    else
                    {
                        nar.Ind = false;
                    } 
                    nar.Dat_kreiranja = Convert.IsDBNull(reader["dat_kreiranja"]) ? DateTime.MinValue : Convert.ToDateTime(reader["dat_kreiranja"]);
                    nar.Dat_azu = Convert.IsDBNull(reader["dat_azu"]) ? DateTime.MinValue : Convert.ToDateTime(reader["dat_azu"]);
                    //if (reader["dat_kreiranja"] != null)
                    //{
                      
                    //    nar.Dat_kreiranja = Convert.ToDateTime(reader["dat_kreiranja"]);
                    //}
                    //else
                    //{
                    //    nar.Dat_kreiranja = DateTime.MinValue;
                    //}
                    //if (reader["dat_azu"] != DBNull.Value)
                    //{
                    //    nar.Dat_azu = Convert.ToDateTime(reader["dat_azu"]);
                    //}
                    //else
                    //{
                    //    nar.Dat_azu = DateTime.MinValue;
                    //}
                    
                    nar.Kreirao = reader["kreirao"].ToString();

                    if (reader["ind_kontakt"] != DBNull.Value)
                    {
                        nar.Ind_kontakt = Convert.ToBoolean(reader["ind_kontakt"]);
                    }
                    else
                    {
                        nar.Ind_kontakt = false;
                    }
                    nar.Drzava = reader["drzava"].ToString();
                    if (reader["potencijalni"] != DBNull.Value)
                    {
                        nar.Potenc = Convert.ToBoolean(reader["potencijalni"]);
                    }
                    else
                    {
                        nar.Potenc = false;
                    }
                    if (reader["povezani"] != DBNull.Value)
                    {
                        nar.Nepovezani = Convert.ToBoolean(reader["povezani"]);
                    }
                    else
                    {
                        nar.Nepovezani = false;
                    }
                    if (reader["ind_ponuda"] != DBNull.Value)
                    {
                        nar.Ind_ponuda = Convert.ToBoolean(reader["ind_ponuda"]);
                    }
                    else
                    {
                        nar.Ind_ponuda = false;
                    }

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

        public static List<Auto> DohvatiAute()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM Auto ORDER BY sifra");
                cmd.Connection = cnn;
                List<Auto> tempList = new List<Auto>();
                cnn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    Auto naruc = new Auto();
                    naruc.Sifra = Convert.ToInt32(reader["sifra"]);
                    naruc.Vlasnik = reader["vlasnik"].ToString();
                    naruc.Marka = reader["marka"].ToString();
                    naruc.Rega = reader["rega"].ToString();
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

        public static Auto DohvatiAuto(int sifra)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM Auto WHERE sifra=@sifra");
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Connection = cnn;

                cnn.Open();
                Auto naruc = new Auto();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {


                    naruc.Sifra = Convert.ToInt32(reader["sifra"]);
                    naruc.Vlasnik = reader["vlasnik"].ToString();
                    naruc.Marka = reader["marka"].ToString();
                    naruc.Rega = reader["rega"].ToString();

                }
                return naruc;
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


        public static bool UnesiObavijest(DateTime datum, string korisnik, string opis, bool izvrsen)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO PORUKE (DATUM, KORISNIK, OPIS, IZVRSEN) VALUES (@datum, @korisnik, @opis, @izvrsen); ");

                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@datum", datum);
                cmd.Parameters.AddWithValue("@korisnik", korisnik);
                cmd.Parameters.AddWithValue("@opis", opis);
                cmd.Parameters.AddWithValue("@izvrsen", izvrsen);

                cnn.Open();
                int brojUbacenih = 0;
                brojUbacenih = cmd.ExecuteNonQuery();
                if (brojUbacenih != 0)
                {

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

        /// <summary>
        /// ova metoda radi update na projekte, postavlja indikator da imaju prilog
        /// </summary>
        /// <param name="sifra"></param>
        /// <param name="ind"></param>
        /// <returns></returns>
        public static bool ProjektInd(int sifra, bool ind)
        {

            PredmetSredjen pred = Helper.DohProjekt(sifra);
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("UPDATE [Projekt] SET [naziv] = @naziv, [dat_predajedgu] = @dat_predajedgu, [dat_predaja] = @dat_predaja, [ugov_iznos] = @ugov_iznos, [statusID] = @statusID, [kreirao] = @kreirao, [vrstaID] = @vrstaID, [teren] = @teren, [narucen_kat] = @narucen_kat, [cijena_kat] = @cijena_kat, [stigli_kat] = @stigli_kat, [dgu_klasa] = @dgu_klasa, [dgu_uru] = @dgu_uru, [lova] = @lova, [kat_opc] = @kat_opc,[kat]=@kat, [kat_cest] = @kat_cest, [dat_kreiranje] = @dat_kreiranje, [putanja_projekt] = @putanja_projekt, [dat_azuriranja] = @dat_azuriranja, [klijentID] = @klijentID, [arh_broj] = @arh_broj, [pon_nar] = @pon_nar, [godina] = @godina, [placeno] = @placeno, [dat_potvrde] = @dat_potvrde, [racun_iznos] = @racun_iznos, [faktura_ind] = @faktura_ind,  [faktura_sifra] = @faktura_sifra, [dat_zavrs]= @dat_zavrs, [zavrsio]= @zavrsio, [ind_prilog]=@ind_prilog WHERE [sifra] = @sifra");

                cmd.Connection = cnn;

                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Parameters.AddWithValue("@ind_prilog", ind);

                cmd.Parameters.AddWithValue("@naziv", pred.NazPredmeta);
                cmd.Parameters.AddWithValue("@arh_broj", pred.ArhBroj);
                cmd.Parameters.AddWithValue("@statusID", pred.Status);
                cmd.Parameters.AddWithValue("@vrstaID", pred.Vrsta);
                cmd.Parameters.AddWithValue("@kat_opc", pred.KatOpc);
                cmd.Parameters.AddWithValue("@kat", pred.Kat);
                cmd.Parameters.AddWithValue("@kat_cest", pred.KatCest);
                cmd.Parameters.AddWithValue("@klijentID", pred.KlijentID);
                cmd.Parameters.AddWithValue("@kreirao", pred.Kreirao);
                cmd.Parameters.AddWithValue("@zavrsio", pred.Zavrsio);
                cmd.Parameters.AddWithValue("@narucen_kat", pred.Narucen);
                cmd.Parameters.AddWithValue("@stigli_kat", pred.Stigli);
                cmd.Parameters.AddWithValue("@dat_predajedgu", pred.Dat_ugov);
                cmd.Parameters.AddWithValue("@dat_predaja", pred.Dat_predaja);
                cmd.Parameters.AddWithValue("@dat_potvrde", pred.Dat_potvrde);
                cmd.Parameters.AddWithValue("@dat_zavrs", pred.Dat_zavrs);
                cmd.Parameters.AddWithValue("@ugov_iznos", pred.Ugov_iznos);
                cmd.Parameters.AddWithValue("@dgu_klasa", pred.Dgu_klasa);
                cmd.Parameters.AddWithValue("@dgu_uru", pred.Dgu_uru);
                cmd.Parameters.AddWithValue("@teren", pred.Teren);

                cmd.Parameters.AddWithValue("@pon_nar", pred.Pon_nar);
                cmd.Parameters.AddWithValue("@godina", pred.Godina);
                cmd.Parameters.AddWithValue("@placeno", pred.Placeno);

                cmd.Parameters.AddWithValue("@lova", pred.Lova);
                // cmd.Parameters.AddWithValue("@lova", Convert.ToDecimal(txtLova.Text));
                cmd.Parameters.AddWithValue("@putanja_projekt", string.Empty);
                //cmd.Parameters.AddWithValue("@ponuda_ind", pred.Ponuda_ind);
                cmd.Parameters.AddWithValue("@faktura_ind", pred.Fakt_ind);
                //cmd.Parameters.AddWithValue("@ponuda_sifra", pred.Ponuda_sifra);
                cmd.Parameters.AddWithValue("@faktura_sifra", pred.Faktura_sifra);
                cmd.Parameters.AddWithValue("@dat_kreiranje", pred.Dat_kreiranje);
                cmd.Parameters.AddWithValue("@dat_azuriranja", pred.Dat_azuriranja);

                cmd.Parameters.AddWithValue("@racun_iznos", pred.Racun_iznos);

                cmd.Parameters.AddWithValue("@cijena_kat", pred.Cijena_kat);
                cnn.Open();
                int brojUbacenih = 0;
                brojUbacenih = cmd.ExecuteNonQuery();
                if (brojUbacenih != 0)
                {

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


        public static List<kat_opc> DohvatiKat()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM kat_opc ORDER BY naziv");
                cmd.Connection = cnn;
                List<kat_opc> tempList = new List<kat_opc>();
                cnn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    kat_opc vrsta = new kat_opc(0, string.Empty);
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

        public static bool UnesiKat(int sifra, string naziv)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO [kat_opc] ( [sifra], [naziv]) VALUES (@sifra, @naziv); ");

                cmd.Connection = cnn;
                cmd.Parameters.AddWithValue("@naziv", naziv);
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cnn.Open();
                int brojUbacenih = 0;
                brojUbacenih = cmd.ExecuteNonQuery();
                if (brojUbacenih != 0)
                {
                    kat_opc noviPrilog = new kat_opc(0, string.Empty);
                    List<kat_opc> listPrilog = new List<kat_opc>();
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

        /// <summary>
        /// ova metoda radi update klijenata tako da postavi indikator da ima prilog kada se on unese
        /// </summary>
        /// <param name="sifra"></param>
        /// <param name="ind"></param>
        /// <returns></returns>
        public static bool KlijentPrilogInd(int sifra, bool ind)
        {
            Narucitelj nar = DohvatiKlijenta(sifra);
            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("UPDATE [Klijent] SET [naziv] = @naziv, [grad] = @grad, [adresa] = @adresa, [email] = @email,[email2]=@email2, [mob]=@mob,[mob2]=@mob2, [titula]=@titula, [povezani]=@povezani, [tel1] = @tel1, [tel2] = @tel2, [napomena] = @napomena, [oib] = @oib, [tekuci] = @tekuci, [ziro] = @ziro, [potencijalni] = @potencijalni, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [drzava] = @drzava, [napomena2]=@napomena2, [vrsta]=@vrsta, [ind_prilog]= @ind_prilog, [ind_kontakt]= @ind_kontakt, [ind_ponuda]= @ind_ponuda, [pon_sifra]= @pon_sifra WHERE [sifra] = @sifra");

                cmd.Connection = cnn;
                cmd.Parameters.AddWithValue("@ind_prilog", ind);
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Parameters.AddWithValue("@naziv", nar.Naziv);
                cmd.Parameters.AddWithValue("@grad", nar.Grad);
                cmd.Parameters.AddWithValue("@adresa", nar.Adresa);
                cmd.Parameters.AddWithValue("@email", nar.Email);
                cmd.Parameters.AddWithValue("@email2", nar.Email2);
                cmd.Parameters.AddWithValue("@mob", nar.Mob);
                cmd.Parameters.AddWithValue("@mob2", nar.Mob2);
                cmd.Parameters.AddWithValue("@tel1", nar.Tel1);
                cmd.Parameters.AddWithValue("@tel2", nar.Tel2);
                cmd.Parameters.AddWithValue("@napomena", nar.Napomena);
                cmd.Parameters.AddWithValue("@napomena2", nar.Napomena2);
                cmd.Parameters.AddWithValue("@oib", nar.Oib);
                cmd.Parameters.AddWithValue("@tekuci", nar.Tekuci);
                cmd.Parameters.AddWithValue("@ziro", nar.Ziro);
                cmd.Parameters.AddWithValue("@drzava", nar.Drzava);
                cmd.Parameters.AddWithValue("@titula", nar.Titula);
                cmd.Parameters.AddWithValue("@vrsta", nar.Vrsta);
                cmd.Parameters.AddWithValue("@potencijalni", nar.Potenc);
                cmd.Parameters.AddWithValue("@povezani", nar.Povezani);
                cmd.Parameters.AddWithValue("@kreirao", nar.Kreirao);
                cmd.Parameters.AddWithValue("@dat_kreiranja", nar.Dat_kreiranja);
                cmd.Parameters.AddWithValue("@dat_azu", DateTime.Now);
                cmd.Parameters.AddWithValue("@ind_kontakt", nar.Ind_kontakt);
                cmd.Parameters.AddWithValue("@ind_ponuda", nar.Ind_ponuda);
                cmd.Parameters.AddWithValue("@pon_sifra", nar.Pon_sifra);
                cnn.Open();
                int brojUbacenih = 0;
                brojUbacenih = cmd.ExecuteNonQuery();
                if (brojUbacenih != 0)
                {

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

        /// <summary>
        /// ova metoda radi update klijenata tako da postavi indikator da ima kontakt kada se on unese
        /// </summary>
        /// <param name="sifra"></param>
        /// <param name="ind"></param>
        /// <returns></returns>
        public static bool KlijentKonInd(int sifra, bool ind)
        {
            SqlDateTime datum;
            Narucitelj nar = DohvatiKlijenta(sifra);

            string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand("UPDATE [Klijent] SET [naziv] = @naziv, [grad] = @grad, [adresa] = @adresa, [email] = @email,[email2]=@email2, [mob]=@mob,[mob2]=@mob2, [titula]=@titula, [povezani]=@povezani, [tel1] = @tel1, [tel2] = @tel2, [napomena] = @napomena, [oib] = @oib, [tekuci] = @tekuci, [ziro] = @ziro, [potencijalni] = @potencijalni, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [drzava] = @drzava, [napomena2]=@napomena2, [vrsta]=@vrsta, [ind_prilog]=@ind_prilog, [ind_kontakt]=@ind_kon WHERE [sifra] = @sifra");
              
               
                cmd.Connection = cnn;
                cmd.Parameters.AddWithValue("@ind_prilog", nar.Ind);
                cmd.Parameters.AddWithValue("@sifra", sifra);
                cmd.Parameters.AddWithValue("@naziv", nar.Naziv);
                cmd.Parameters.AddWithValue("@vrsta", nar.Vrsta);
                cmd.Parameters.AddWithValue("@drzava", nar.Drzava);
                cmd.Parameters.AddWithValue("@titula", nar.Naziv);
                cmd.Parameters.AddWithValue("@napomena2", nar.Naziv);
                cmd.Parameters.AddWithValue("@grad", nar.Grad);
                cmd.Parameters.AddWithValue("@adresa", nar.Adresa);
                cmd.Parameters.AddWithValue("@email", nar.Email);
                cmd.Parameters.AddWithValue("@email2", nar.Email2);
                cmd.Parameters.AddWithValue("@mob", nar.Mob);
                cmd.Parameters.AddWithValue("@mob2", nar.Mob2);
                cmd.Parameters.AddWithValue("@tel1", nar.Tel1);
                cmd.Parameters.AddWithValue("@tel2", nar.Tel2);
                cmd.Parameters.AddWithValue("@napomena", nar.Napomena);
                cmd.Parameters.AddWithValue("@oib", nar.Oib);
                cmd.Parameters.AddWithValue("@tekuci", nar.Tekuci);
                cmd.Parameters.AddWithValue("@ziro", nar.Ziro);
                cmd.Parameters.AddWithValue("@potencijalni", nar.Potenc);
                cmd.Parameters.AddWithValue("@kreirao", nar.Kreirao);
                if (nar.Dat_kreiranja == DateTime.MinValue)
                {
                    datum = SqlDateTime.MinValue;
                    cmd.Parameters.AddWithValue("@dat_kreiranja", datum);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@dat_kreiranja", nar.Dat_kreiranja);
                }
                cmd.Parameters.AddWithValue("@dat_azu", DateTime.Now);
                cmd.Parameters.AddWithValue("@ind_kon", ind);
                cmd.Parameters.AddWithValue("@povezani", nar.Povezani);

                cnn.Open();
                int brojUbacenih = 0;
                brojUbacenih = cmd.ExecuteNonQuery();
                if (brojUbacenih != 0)
                {

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

    }
}