using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Aspose.Words;
using System.IO;





namespace Geodezija
{
    public partial class ProjektiCRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //stavi textboxeve u read only
            txtKreirao.ReadOnly = true;
            txtDatKreir.ReadOnly = true;
            txtDatAzu.ReadOnly = true;
            btnUnos.Visible = false;


            lblUser.Text = User.Identity.Name;
            int projID = Convert.ToInt32(Request.QueryString["ID"]);
            if (!Page.IsPostBack)
            {

                FillStatusi();
                FillVrsta();
                FillKlijenti();
                DohvatiProjekt(projID);
                // postavlja sve textboxeve u read only  SetReadOnlyOnAllTextBox(this, true);
            }
        }




        protected void gvBiljeskeProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("Biljeske.aspx?ID=" + gvBiljeskeProj.SelectedValue);
        }

        public void DohvatiProjekt(int sifra)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            SqlDataReader rdr = null;
            using (SqlCommand com = cnn.CreateCommand())
            {
                com.CommandType = CommandType.Text;
                com.CommandText = "SELECT * FROM PROJEKT WHERE sifra = @sifra";
                //  "UPDATE Employees SET Title = @title" +" WHERE EmployeeId = @id";
                // Create a SqlParameter object for the title parameter.
                SqlParameter p1 = com.CreateParameter();
                p1.ParameterName = "@sifra";
                p1.SqlDbType = SqlDbType.Int;
                p1.Value = sifra;
                com.Parameters.Add(p1);
                // Use a shorthand syntax to add the id parameter.
                // com.Parameters.Add("@sifra", SqlDbType.Int).Value = sifra;
                // Execute the command and process the result.
                // int result = com.ExecuteNonQuery();
                try
                {
                    // open the connection
                    cnn.Open();
                    rdr = com.ExecuteReader();
                    while (rdr.Read())
                    {
                        // get the results of each column
                        txtSifra.Text = rdr["sifra"].ToString();
                        txtNaziv.Text = (string)rdr["naziv"];
                        txtArhivski.Text = rdr["arh_broj"].ToString();
                        ddlStatus.SelectedValue = rdr["statusID"].ToString();
                        ddlVrsta.SelectedValue = rdr["vrstaID"].ToString();

                        txtKatOpc.Text = (string)rdr["kat_opc"];
                        txtCestica.Text = (string)rdr["kat_cest"];
                        ddlKlijent.SelectedValue = rdr["klijentID"].ToString();
                        txtKreirao.Text = rdr["kreirao"].ToString();
                        txtNarucen.Text = rdr["narucen_kat"].ToString();
                        txtStigao.Text = rdr["stigli_kat"].ToString();
                        txtDatUgov.Text = rdr["dat_ugov"].ToString();
                        txtPredaja.Text = rdr["dat_predaja"].ToString();
                        txtPotvrda.Text = rdr["dat_potvrde"].ToString();
                        txtIznos.Text = rdr["ugov_iznos"].ToString();
                        txtKlasa.Text = rdr["dgu_klasa"].ToString();
                        txtUrud.Text = rdr["dgu_uru"].ToString();
                        txtTeren.Text = rdr["teren"].ToString();
                        txtFaktura.Text = rdr["faktura"].ToString();
                        txtPonNar.Text = rdr["pon_nar"].ToString();
                        txtPlacanje.Text = rdr["opis_placanja"].ToString();
                        chkPlaceno.Checked = Convert.ToBoolean(rdr["placeno"]);
                        txtLova.Text = rdr["lova"].ToString();
                        txtPutProj.Text = rdr["putanja_projekt"].ToString();
                        txtPutPon.Text = rdr["putanja_pon"].ToString();
                        txtPutFakt.Text = rdr["putanja_fakt"].ToString();
                        txtDatKreir.Text = rdr["dat_kreiranje"].ToString();
                        txtDatAzu.Text = rdr["dat_azuriranja"].ToString();
                        txtIznFakt.Text = rdr["racun_iznos"].ToString();
                        txtKatCijena.Text = rdr["cijena_kat"].ToString();
                    }
                }

                finally
                {

                    if (rdr != null)
                    {
                        rdr.Close();
                    }

                    // close the connection
                    if (cnn != null)
                    {
                        cnn.Close();
                    }
                }
            }
        }

        protected void btnNovi_Click(object sender, EventArgs e)
        {

            txtSifra.Text = "";
            txtSifra.Visible = false;

            txtNaziv.Text = "";
            txtArhivski.Text = "";
            ddlStatus.SelectedIndex = 0;
            ddlVrsta.SelectedIndex = 0;
            txtKatOpc.Text = "";
            txtCestica.Text = "";
            ddlKlijent.SelectedIndex = 0;
            txtKreirao.Text = "";
            txtNarucen.Text = "";
            txtStigao.Text = "";
            txtDatUgov.Text = "";
            txtPredaja.Text = "";
            txtPotvrda.Text = "";
            txtIznos.Text = "";
            txtKlasa.Text = "";
            txtUrud.Text = "";
            txtTeren.Text = "";
            txtFaktura.Text = "";
            txtPonNar.Text = "";
            txtPlacanje.Text = "";
            chkPlaceno.Checked = false;
            txtLova.Text = "";
            txtPutProj.Text = "";
            txtPutPon.Text = "";
            txtPutFakt.Text = "";
            txtDatKreir.Text = "";
            txtDatAzu.Text = "";
            txtIznFakt.Text = "";
            txtKatCijena.Text = "";
            lblStatus.Text = "Odaberite Spremi za unos podataka o predmetu";
            //miče read only sa svih textboxeva SetReadOnlyOnAllTextBox(this, false);
            btnSpremi.Visible = false;
            btnBrisi.Visible = false;
            btnPonuda.Visible = false;
            btnFaktura.Visible = false;
            btnUnos.Visible = true;
            btnPovratak.Visible = true;
            gvBiljeskeProj.Visible = false;
        }

        protected void btnBrisi_Click(object sender, EventArgs e)
        {
            btnUnos.Visible = false;
            btnSpremi.Visible = false;
            btnPovratak.Visible = true;
            // Define ADO.NET objects.
            string deleteSQL;
            deleteSQL = "DELETE FROM Projekti WHERE sifra=@sifra";
            string connectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(deleteSQL, con);
            cmd.Parameters.AddWithValue("@sifra ", txtSifra.Text);
            // Try to open the database and delete the record.
            int deleted = 0;
            try
            {
                con.Open();
                deleted = cmd.ExecuteNonQuery();
            }
            catch (Exception err)
            {
                lblStatus.Text = "Pogreška kod brisanja podataka, provjerite da li predmet ima povezanih podataka te se zbog toga ne može obrisati. ";
                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            // If the delete succeeded, refresh the author list.
            if (deleted > 0)
            {
                //briše folder sa šifrom predmeta
                var folder = Server.MapPath("~/Dokumenti/Predmeti/" + txtSifra.Text);
                if (!Directory.Exists(folder))
                {
                    Directory.Delete(folder, true);
                }
            }

        }

        protected void btnSpremi_Click(object sender, EventArgs e)
        {

            gvBiljeskeProj.Visible = false;

            string connectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            string updateSQL = "UPDATE Projekti SET ";
            updateSQL += "naziv=@naziv, arh_broj=@arh_broj, statusID = @statusID, vrstaID = @vrstaID, kat_opc = @kat_opc, kat_cest= @kat_cest, klijentID = @klijentID, kreirao = @kreirao, narucen_kat = @narucen_kat, ";
            updateSQL += "stigli_kat=@stigli_kat, dat_ugov=@dat_ugov, dat_predaja=@dat_predaja, dat_potvrde=@dat_potvrde, ugov_iznos=@ugov_iznos, dgu_klasa=@dgu_klasa, dgu_uru=@dgu_uru, teren=@teren, faktura= @faktura,  ";
            updateSQL += "pon_nar=@pon_nar, opis_placanja=@opis_placanja, placeno = @placeno, lova = @lova, putanja_projekt= @putanja_projekt, putanja_pon =@putanja_pon, putanja_fakt = @putanja_fakt  ";
            updateSQL += "dat_kreiranje=@dat_kreiranje, dat_azuriranja=@dat_azuriranja, racun_iznos = @racun_iznos, cijena_kat = @cijena_kat, sifra= @sifra  ";
            updateSQL += "WHERE sifra=@sifra";
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(updateSQL, con);
            // Add the parameters.
            string kreirao = lblUser.Text;
            string datum = DateTime.Now.ToShortDateString();
            cmd.Parameters.AddWithValue("@naziv", txtNaziv.Text);
            cmd.Parameters.AddWithValue("@arh_broj", txtArhivski.Text);
            cmd.Parameters.AddWithValue("@statusID", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@vrstaID", ddlVrsta.SelectedValue);
            cmd.Parameters.AddWithValue("@kat_opc", txtKatOpc.Text);
            cmd.Parameters.AddWithValue("@kat_cest", txtCestica.Text);
            cmd.Parameters.AddWithValue("@klijentID", ddlKlijent.SelectedValue);
            cmd.Parameters.AddWithValue("@kreirao", kreirao);
            cmd.Parameters.AddWithValue("@narucen_kat", txtNarucen.Text);
            cmd.Parameters.AddWithValue("@stigli_kat", txtStigao.Text);
            cmd.Parameters.AddWithValue("@dat_ugov", txtDatUgov.Text);
            cmd.Parameters.AddWithValue("@dat_predaja", txtPredaja.Text);
            cmd.Parameters.AddWithValue("@dat_potvrde", txtPotvrda.Text);
            cmd.Parameters.AddWithValue("@ugov_iznos", Convert.ToDecimal(txtIznos.Text));
            cmd.Parameters.AddWithValue("@dgu_klasa", txtKlasa.Text);
            cmd.Parameters.AddWithValue("@dgu_uru", txtUrud.Text);
            cmd.Parameters.AddWithValue("@teren", txtTeren.Text);
            cmd.Parameters.AddWithValue("@faktura", txtFaktura.Text);
            cmd.Parameters.AddWithValue("@pon_nar", txtPonNar.Text);
            cmd.Parameters.AddWithValue("@opis_placanja", txtPlacanje.Text);
            cmd.Parameters.AddWithValue("@placeno", chkPlaceno.Checked);
            cmd.Parameters.AddWithValue("@lova", Convert.ToDecimal(txtLova.Text));
            cmd.Parameters.AddWithValue("@putanja_projekt", txtPutProj.Text);
            cmd.Parameters.AddWithValue("@putanja_pon", txtPutPon.Text);
            cmd.Parameters.AddWithValue("@putanja_fakt", txtPutFakt.Text);
            cmd.Parameters.AddWithValue("@dat_kreiranje", txtDatKreir.Text);
            cmd.Parameters.AddWithValue("@dat_azuriranja", txtDatAzu.Text);
            cmd.Parameters.AddWithValue("@racun_iznos", Convert.ToDecimal(txtIznFakt.Text));
            cmd.Parameters.AddWithValue("@cijena_kat", Convert.ToDecimal(txtKatCijena.Text));
            cmd.Parameters.AddWithValue("@sifra", txtSifra.Text);
            // Try to open database and execute the update.
            int updated = 0;
            try
            {
                con.Open();
                updated = cmd.ExecuteNonQuery();
                lblStatus.Text = updated.ToString() + " zapis je promijenjen.";
            }
            catch (Exception err)
            {
                lblStatus.Text = "Dogodila se greška prilikom spremanja podataka";
                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            // If the update succeeded, refresh the author list.
            if (updated > 0)
            {
                //  FillAuthorList();
                lblStatus.Text = "Uspješno su promijenjeni podaci";
            }
        }


        protected void btnUnos_Click(object sender, EventArgs e)
        {
            txtSifra.Visible = false;
            btnUnos.Visible = true;
            btnSpremi.Visible = true;
            btnNovi.Visible = false;
            ProvjeriFormu();
            //provjeri sve validatore
            if (Page.IsValid)
            {
                int PredmetID = SpremiPredmet();
                if (PredmetID == -1)
                {
                    lblStatus.Text = "Greška prilikom unosa novoga predmeta. ";
                }
                else
                {
                    // show the result
                    lblStatus.Text = "Uspješno je spremljen predmet sa šifrom " + PredmetID;
                    // disable the submit button
                    btnUnos.Enabled = false;
                    //kreira se novi folder sa šifrom predmeta
                    var folder = Server.MapPath("~/Dokumenti/Predmeti/" + PredmetID);
                    if (!Directory.Exists(folder))
                    {
                        Directory.CreateDirectory(folder);
                    }
                }
            }


        }

        protected void btnPonuda_Click(object sender, EventArgs e)
        {
            int projID = Convert.ToInt32(Request.QueryString["ID"]);
            string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/Ponuda.docx");

            // Otvori dokument (Nalazi se u web siteu, u folderu Predlosci)
            DataTable predmet = Helper.DohvatiPredmet(projID);
            Document doc = new Document(putanjaOriginal);

            doc.MailMerge.Execute(predmet);
            string putanjaWord = System.Web.HttpContext.Current.Server.MapPath("~/Popunjeni/Ponuda1.docx");
            doc.Save(putanjaWord);
            Response.ContentType = "application/ms-word";
            Response.AddHeader("Content-Disposition", "attachment; filename=Ponuda1.docx");
            Response.WriteFile(putanjaWord);
            Response.End();
        }

        protected void btnFaktura_Click(object sender, EventArgs e)
        {

            string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/Racuni.docx");
            int projID = Convert.ToInt32(Request.QueryString["ID"]);
            // Otvori dokument (Nalazi se u web siteu, u folderu Predlosci)
            DataTable predmet = Helper.DohvatiPredmet(projID);
            Document doc = new Document(putanjaOriginal);

            doc.MailMerge.Execute(predmet);
            string putanjaPdf = System.Web.HttpContext.Current.Server.MapPath("~/Popunjeni/Racuni1.docx");
            doc.Save(putanjaPdf);
            Response.ContentType = "application/ms-word";
            Response.AddHeader("Content-Disposition", "attachment; filename=Ponuda1.docx");
            Response.WriteFile(putanjaPdf);
            Response.End();
        }

        public void FillStatusi()
        {

            // create the connection
            ddlStatus.DataSource = Helper.DohvatiStatuse();

            ddlStatus.DataTextField = "naziv";
            ddlStatus.DataValueField = "sifra";
            ddlStatus.DataBind();
            //  ddlStatus.Items.Insert(0, new ListItem("- Select Status -", ""));
            // close the database connection

            // force the first data bind
            //  ddlStatus_SelectedIndexChanged(null, null);
        }

        public void FillVrsta()
        {

            // create the connection
            ddlVrsta.DataSource = Helper.DohvatiPosao();
            ddlVrsta.DataTextField = "naziv";
            ddlVrsta.DataValueField = "sifra";
            ddlVrsta.DataBind();
            // close the database connection
            // ddlVrsta.Items.Insert(0, new ListItem("- Select Status -", ""));
            // force the first data bind

        }

        public void FillKlijenti()
        {
            ddlKlijent.DataSource = Helper.DohvatiKlijente();
            ddlKlijent.DataTextField = "naziv";
            ddlKlijent.DataValueField = "sifra";
            ddlKlijent.DataBind();
            // ddlKlijent.Items.Insert(0, new ListItem("- Select Status -", ""));
        }

        public void ProvjeriFormu()
        {

            if (txtLova.Text == string.Empty)
            {
                txtLova.Text = "0.00";
            }

            if (txtIznFakt.Text == string.Empty)
            {
                txtLova.Text = "0.00";
            }
            if (txtKatCijena.Text == string.Empty)
            {
                txtKatCijena.Text = "0.00";
            }
            if (txtKatCijena.Text == string.Empty)
            {
                txtKatCijena.Text = "0.00";
            }

        }

        protected void btnPovratak_Click(object sender, EventArgs e)
        {
            Response.Redirect("Projekti.aspx");
        }

        private int SpremiPredmet()
        {
            int PredmetID = 0;
            string kreirao = lblUser.Text;
            string insertSQL;
            insertSQL = "INSERT INTO Projekt (";
            insertSQL += "naziv, arh_broj, statusID, vrstaID, kat_opc, kat_cest, klijentID, kreirao, narucen_kat, stigli_kat, dat_ugov, dat_predaja, ";
            insertSQL += "dat_potvrde,ugov_iznos,dgu_klasa, dgu_uru, teren,faktura,pon_nar, opis_placanja, placeno,lova,putanja_projekt,putanja_pon,putanja_fakt, dat_kreiranje, dat_azuriranja, ";
            insertSQL += "racun_iznos,cijena_kat) ";
            insertSQL += "VALUES (";
            insertSQL += "@naziv, @arh_broj, @statusID, @vrstaID, @kat_opc, @kat_cest, @klijentID, @kreirao, @narucen_kat, @stigli_kat, @dat_ugov, @dat_predaja, ";
            insertSQL += "@dat_potvrde, @ugov_iznos, @dgu_klasa, @dgu_uru, @teren, @faktura, @pon_nar, @opis_placanja, @placeno, @lova, @putanja_projekt, @putanja_pon, @putanja_fakt, @dat_kreiranje, @dat_azuriranja, ";
            insertSQL += "@racun_iznos, @cijena_kat);SELECT SCOPE_IDENTITY();";

            string connectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);

            cmd.Parameters.AddWithValue("@naziv", txtNaziv.Text);
            cmd.Parameters.AddWithValue("@arh_broj", txtArhivski.Text);
            cmd.Parameters.AddWithValue("@statusID", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@vrstaID", ddlVrsta.SelectedValue);
            cmd.Parameters.AddWithValue("@kat_opc", txtKatOpc.Text);
            cmd.Parameters.AddWithValue("@kat_cest", txtCestica.Text);
            cmd.Parameters.AddWithValue("@klijentID", ddlKlijent.SelectedValue);
            cmd.Parameters.AddWithValue("@kreirao", kreirao);
            cmd.Parameters.AddWithValue("@narucen_kat", txtNarucen.Text);
            cmd.Parameters.AddWithValue("@stigli_kat", txtStigao.Text);
            cmd.Parameters.AddWithValue("@dat_ugov", txtDatUgov.Text);
            cmd.Parameters.AddWithValue("@dat_predaja", txtPredaja.Text);
            cmd.Parameters.AddWithValue("@dat_potvrde", txtPotvrda.Text);
            cmd.Parameters.AddWithValue("@ugov_iznos", Convert.ToDecimal(txtIznos.Text));
            cmd.Parameters.AddWithValue("@dgu_klasa", txtKlasa.Text);
            cmd.Parameters.AddWithValue("@dgu_uru", txtUrud.Text);
            cmd.Parameters.AddWithValue("@teren", txtTeren.Text);
            cmd.Parameters.AddWithValue("@faktura", txtFaktura.Text);
            cmd.Parameters.AddWithValue("@pon_nar", txtPonNar.Text);
            cmd.Parameters.AddWithValue("@opis_placanja", txtPlacanje.Text);
            cmd.Parameters.AddWithValue("@placeno", chkPlaceno.Checked);

            cmd.Parameters.AddWithValue("@lova", Convert.ToDecimal(txtLova.Text));
            cmd.Parameters.AddWithValue("@putanja_projekt", txtPutProj.Text);
            cmd.Parameters.AddWithValue("@putanja_pon", txtPutPon.Text);
            cmd.Parameters.AddWithValue("@putanja_fakt", txtPutFakt.Text);
            cmd.Parameters.AddWithValue("@dat_kreiranje", txtDatKreir.Text);
            cmd.Parameters.AddWithValue("@dat_azuriranja", txtDatAzu.Text);

            cmd.Parameters.AddWithValue("@racun_iznos", Convert.ToDecimal(txtIznFakt.Text));

            cmd.Parameters.AddWithValue("@cijena_kat", Convert.ToDecimal(txtKatCijena.Text));
            // Try to open the database and execute the update.

            try
            {
                con.Open();
                PredmetID = Convert.ToInt32(cmd.ExecuteScalar());
                // added = cmd.ExecuteNonQuery();
                lblStatus.Text = "Unesen je predmet sa šifrom " + PredmetID;
            }
            catch (Exception err)
            {

                lblStatus.Text += err.Message;
                PredmetID = -1;
            }
            finally
            {
                con.Close();
            }
            return (PredmetID);
        }


        public static void SetReadOnlyOnAllTextBox(Control parentControl, bool readOnly)
        {
            if (parentControl is TextBox)
                ((TextBox)parentControl).ReadOnly = readOnly;
            foreach (Control control in parentControl.Controls)
                SetReadOnlyOnAllTextBox(control, readOnly);


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int projID = Convert.ToInt32(Request.QueryString["ID"]);
            Response.Redirect("Uplatnica.aspx?ID=" + projID);
        }

       

    }
}


