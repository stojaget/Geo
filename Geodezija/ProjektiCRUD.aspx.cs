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
using System.Globalization;
using System.Data.SqlTypes;
using jQueryNotification.Helper;
using System.Drawing;
using System.Text;



namespace Geodezija
{
    public partial class ProjektiCRUD : System.Web.UI.Page
    {

        // Specify exactly how to interpret the string.
        IFormatProvider culture = new System.Globalization.CultureInfo("hr-HR", true);
        protected void Page_Load(object sender, EventArgs e)
        {
            txtSifra.ReadOnly = true;
           // txtArhZadnji.Text = Helper.MaxArhivski();
            txtArhZadnji.Text = Helper.MaxArhivskiTekucaGodina();
            //stavi textboxeve u read only
            txtKreirao.ReadOnly = true;
            txtDatKreir.ReadOnly = false;
            txtDatAzu.ReadOnly = true;
            //SetReadOnlyOnAllTextBox(this, true);
            //btnSpremi.Visible = false;

            lblUser.Text = User.Identity.Name;
            int projID = Convert.ToInt32(Request.QueryString["ID"]);

            if (User.IsInRole("Pripravnik"))
            {
                //sakri iznose
                txtIznFakt.Visible = false;
                txtIznos.Visible = false;
                txtLova.Visible = false;
            }
            if (!Page.IsPostBack)
            {

                FillKlijenti();

                lblStatus.Text = "";
                FillZavrsio();
                FillStatusi();
                FillVrsta();

                FillKat();
                DohvatiProjekt(projID);
                FillKlijentiInfo();
                // FillSviKlijenti();


                // postavlja sve textboxeve u read only  SetReadOnlyOnAllTextBox(this, true);
            }

            gvBiljeskeProj.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            if (gvBiljeskeProj.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CreateGridHeader", "<script>CreateGridHeader('DataDiv', 'gvBiljeskeProj', 'HeaderDiv');</script>");
            }
        }




        protected void gvBiljeskeProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvBiljeskeProj.Rows)
            {
                if (row.RowIndex == gvBiljeskeProj.SelectedIndex)
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
                        if (rdr["zavrsio"] != DBNull.Value)
                        {

                            ddlZavrsio.SelectedItem.Text = rdr["zavrsio"].ToString();
                        }
                        else
                        {
                            ddlZavrsio.SelectedIndex = -1;

                        }

                        if (rdr["kat"] != DBNull.Value)
                        {
                            ddlKat.SelectedValue = rdr["kat"].ToString();

                        }
                        else
                        {
                            ddlKat.SelectedIndex = 0;

                        }
                        if (rdr["kat_opc"] != DBNull.Value)
                        {
                            txtKat2.Text = rdr["kat_opc"].ToString();
                            //  ddlKat.SelectedValue = rdr["kat_opc"].ToString();

                        }
                        else
                        {
                            txtKat2.Text = "";
                            // ddlKat.SelectedIndex = 0;

                        }

                        if (rdr["kat_cest"] != DBNull.Value)
                        {

                            txtCestica.Text = (string)rdr["kat_cest"];
                        }
                        else
                        {
                            txtCestica.Text = "";
                        }

                        ddlKlijent.SelectedValue = rdr["klijentID"].ToString();
                        if (rdr["kreirao"] != DBNull.Value)
                        {
                            txtKreirao.Text = rdr["kreirao"].ToString();
                        }
                        else
                        {
                            txtKreirao.Text = "";
                        }

                        DateTime datpreddgu, predaja, potvrda, zavrsen;
                        if (rdr["narucen_kat"] == DBNull.Value)
                        {
                            txtNarucen.Text = "";
                        }
                        else
                        {

                            txtNarucen.Text = rdr["narucen_kat"].ToString();
                        }
                        if (rdr["stigli_kat"] == DBNull.Value)
                        {
                            txtStigao.Text = "";
                        }
                        else
                        {

                            txtStigao.Text = rdr["stigli_kat"].ToString();
                        }
                        if (rdr["dat_predajedgu"].ToString() == "")
                        {
                            txtDatPredajeDgu.Text = "";
                        }
                        else
                        {
                            datpreddgu = Convert.ToDateTime(rdr["dat_predajedgu"]);
                            txtDatPredajeDgu.Text = datpreddgu.ToShortDateString();
                        }
                        if (rdr["dat_predaja"].ToString() == "")
                        {
                            txtPredaja.Text = "";

                        }
                        else
                        {
                            predaja = Convert.ToDateTime(rdr["dat_predaja"]);
                            txtPredaja.Text = predaja.ToShortDateString();
                        }
                        if (rdr["dat_potvrde"].ToString() == "")
                        {
                            txtPotvrda.Text = "";
                        }
                        else
                        {
                            potvrda = Convert.ToDateTime(rdr["dat_potvrde"]);
                            txtPotvrda.Text = potvrda.ToShortDateString();
                        }
                        if (rdr["dat_zavrs"].ToString() == "")
                        {
                            txtZavrs.Text = "";
                        }
                        else
                        {
                            zavrsen = Convert.ToDateTime(rdr["dat_zavrs"]);
                            txtZavrs.Text = zavrsen.ToShortDateString();
                        }

                        // //Skidanje datuma ako je vrijednost DateTime.MinValue
                        //DateTime datum;DateTime.TryParse(gvr.Cells[7].Text, out datum);if (datum == DateTime.MinValue) {gvr.Cells[7].Text = "";}
                        //dateTime.ToString("dd'/'MM'/'yyyy");
                        //txtNarucen.Text = Convert.ToDateTime(rdr["narucen_kat"]).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                        //txtStigao.Text = Convert.ToDateTime(rdr["stigli_kat"]).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                        //txtDatUgov.Text = Convert.ToDateTime(rdr["dat_ugov"]).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                        //txtPredaja.Text = Convert.ToDateTime(rdr["dat_predaja"]).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                        //txtPotvrda.Text = Convert.ToDateTime(rdr["dat_potvrde"]).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);


                        if (!String.IsNullOrEmpty(rdr["ugov_iznos"].ToString()))
                        {
                            // object value = rdr.GetValue(rdr.GetOrdinal("ugov_iznos"));
                            // txtIznos.Text =  value.ToString();
                            txtIznos.Text = rdr["ugov_iznos"].ToString();

                        }
                        else
                        {
                            txtIznos.Text = "";
                        }


                        if (rdr["dgu_klasa"] != DBNull.Value)
                        {
                            txtKlasa.Text = (string)rdr["dgu_klasa"];
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtKlasa.Text = "";
                        }

                        if (rdr["dgu_uru"] != DBNull.Value)
                        {
                            txtUrud.Text = (string)rdr["dgu_uru"];
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtUrud.Text = "";
                        }

                        if (rdr["teren"] != DBNull.Value)
                        {
                            txtTeren.Text = (string)rdr["teren"];
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtTeren.Text = "";
                        }



                        if (rdr["pon_nar"] != DBNull.Value)
                        {
                            txtPonNar.Text = (string)rdr["pon_nar"];
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtPonNar.Text = "";
                        }

                        if (rdr["godina"] != DBNull.Value)
                        {
                            txtGodina.Text = rdr["godina"].ToString();
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtGodina.Text = "";
                        }

                        if (rdr["placeno"] is DBNull)
                        {
                            chkPlaceno.Checked = false;
                        }
                        else
                        {
                            chkPlaceno.Checked = Convert.ToBoolean(rdr["placeno"]);
                        }

                        if (!String.IsNullOrEmpty(rdr["lova"].ToString()))
                        {

                            txtLova.Text = rdr["lova"].ToString();
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtLova.Text = "";
                        }

                        if (rdr["putanja_projekt"] != DBNull.Value)
                        {
                            txtPutProj.Text = (string)rdr["putanja_projekt"];
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtPutProj.Text = "";
                        }


                        //if (rdr["ponuda_ind"] is DBNull)
                        //{
                        //    chkPonudaPoslana.Checked = false;
                        //}
                        //else
                        //{
                        //    chkPonudaPoslana.Checked = Convert.ToBoolean(rdr["ponuda_ind"]);
                        //}
                        if (rdr["faktura_ind"] is DBNull)
                        {
                            chkFakturaPoslana.Checked = false;
                        }
                        else
                        {
                            chkFakturaPoslana.Checked = Convert.ToBoolean(rdr["faktura_ind"]);
                        }


                        //if (rdr["ponuda_sifra"] != DBNull.Value)
                        //{
                        //    txtPonSifra.Text = (string)rdr["ponuda_sifra"];
                        //    // selVrijeme.Dolazak = 0.00m; ;
                        //}
                        //else
                        //{
                        //    txtPonSifra.Text = "";
                        //}

                        if (rdr["faktura_sifra"] != DBNull.Value)
                        {
                            txtFaktSifra.Text = (string)rdr["faktura_sifra"];
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtFaktSifra.Text = "";
                        }

                        if (rdr["dat_kreiranje"] != DBNull.Value)
                        {
                            txtDatKreir.Text = rdr["dat_kreiranje"].ToString();
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtDatKreir.Text = "";
                        }

                        if (rdr["dat_azuriranja"] != DBNull.Value)
                        {
                            txtDatAzu.Text = rdr["dat_azuriranja"].ToString();
                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtDatAzu.Text = "";
                        }
                        if (!String.IsNullOrEmpty(rdr["racun_iznos"].ToString()))
                        {

                            txtIznFakt.Text = rdr["racun_iznos"].ToString();

                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtIznFakt.Text = "";
                        }

                        if (!String.IsNullOrEmpty(rdr["cijena_kat"].ToString()))
                        {

                            txtKatCijena.Text = rdr["cijena_kat"].ToString();

                            // selVrijeme.Dolazak = 0.00m; ;
                        }
                        else
                        {
                            txtKatCijena.Text = "";
                        }

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
            //SetReadOnlyOnAllTextBox(this, false);
            txtSifra.Text = "";
            txtSifra.Visible = false;
            txtKat2.Text = "";
            txtNaziv.Text = "";
            txtArhivski.Text = "";
            ddlStatus.SelectedIndex = 0;
            ddlVrsta.SelectedIndex = 0;
            //txtKatOpc.Text = "";
            txtCestica.Text = "";
            ddlKlijent.SelectedIndex = 0;
            ddlZavrsio.SelectedIndex = 0;
            txtKreirao.Text = "";
            txtNarucen.Text = "";
            txtStigao.Text = "";
            txtDatPredajeDgu.Text = "";
            txtPredaja.Text = "";
            txtPotvrda.Text = "";
            txtZavrs.Text = "";
            txtIznos.Text = "";
            txtKlasa.Text = "";
            txtUrud.Text = "";
            txtTeren.Text = "";

            txtPonNar.Text = "";
            txtGodina.Text = "2014";
            chkPlaceno.Checked = false;
            txtLova.Text = "";
            txtPutProj.Text = "";
            //chkPonudaPoslana.Checked = false;
            chkFakturaPoslana.Checked = false;
            //txtPonSifra.Text = "";
            txtFaktSifra.Text = "";
            txtDatKreir.Text = DateTime.Now.ToString();
            txtDatAzu.Text = DateTime.Now.ToString();
            txtIznFakt.Text = "";
            txtKatCijena.Text = "";
            lblStatus.Text = "Odaberite Unos za spremanje podataka o predmetu";
            //miče read only sa svih textboxeva SetReadOnlyOnAllTextBox(this, false);
            //btnSpremi.Visible = false;

            btnUnos.Visible = true;
            btnPovratak.Visible = true;

        }

        protected void btnBrisi_Click(object sender, EventArgs e)
        {
            //btnUnos.Visible = false;
            //btnSpremi.Visible = false;
            btnPovratak.Visible = true;
            // Define ADO.NET objects.
            string deleteSQL;
            deleteSQL = "DELETE FROM Projekt WHERE sifra=@sifra";
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
                lblStatus.Text = "Uspješno je obrisan predmet";
                Response.Redirect("Projekti.aspx");
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

        //protected void btnSpremi_Click(object sender, EventArgs e)
        //{

        //    gvBiljeskeProj.Visible = false;
        //    ProvjeriFormu();
        //    string connectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
        //    string updateSQL = "UPDATE Projekt SET ";
        //    updateSQL += "naziv=@naziv, arh_broj=@arh_broj, statusID = @statusID, vrstaID = @vrstaID, kat_opc = @kat_opc, kat_cest= @kat_cest, klijentID = @klijentID, kreirao = @kreirao, narucen_kat = @narucen_kat, ";
        //    updateSQL += "stigli_kat=@stigli_kat, dat_ugov=@dat_ugov, dat_predaja=@dat_predaja, dat_potvrde=@dat_potvrde, ugov_iznos=@ugov_iznos, dgu_klasa=@dgu_klasa, dgu_uru=@dgu_uru, teren=@teren, faktura= @faktura,  ";
        //    updateSQL += "pon_nar=@pon_nar, opis_placanja=@opis_placanja, placeno = @placeno, lova = @lova, putanja_projekt= @putanja_projekt, ponuda_ind=@ponuda_ind,faktura_ind=@faktura_ind, ponuda_sifra=@ponuda_sifra, faktura_sifra=@faktura_sifra,  ";
        //    updateSQL += "dat_kreiranje=@dat_kreiranje, dat_azuriranja=@dat_azuriranja, racun_iznos = @racun_iznos, cijena_kat = @cijena_kat ";
        //    updateSQL += "WHERE sifra=@sifra";
        //    SqlConnection con = new SqlConnection(connectionString);
        //    SqlCommand cmd = new SqlCommand(updateSQL, con);
        //    // Add the parameters.
        //    string kreirao = lblUser.Text;
        //    string datum = DateTime.Now.ToShortDateString();
        //    cmd.Parameters.AddWithValue("@naziv", txtNaziv.Text);
        //    cmd.Parameters.AddWithValue("@arh_broj", txtArhivski.Text);
        //    cmd.Parameters.AddWithValue("@statusID", ddlStatus.SelectedValue);
        //    cmd.Parameters.AddWithValue("@vrstaID", ddlVrsta.SelectedValue);
        //    cmd.Parameters.AddWithValue("@kat_opc", txtKatOpc.Text);
        //    cmd.Parameters.AddWithValue("@kat_cest", txtCestica.Text);
        //    cmd.Parameters.AddWithValue("@klijentID", ddlKlijent.SelectedValue);
        //    cmd.Parameters.AddWithValue("@kreirao", kreirao);
        //    cmd.Parameters.AddWithValue("@narucen_kat", txtNarucen.Text);
        //    cmd.Parameters.AddWithValue("@stigli_kat", txtStigao.Text);
        //    cmd.Parameters.AddWithValue("@dat_ugov", txtDatUgov.Text);
        //    cmd.Parameters.AddWithValue("@dat_predaja", txtPredaja.Text);
        //    cmd.Parameters.AddWithValue("@dat_potvrde", txtPotvrda.Text);
        //    cmd.Parameters.AddWithValue("@ugov_iznos", Convert.ToDecimal(txtIznos.Text));
        //    cmd.Parameters.AddWithValue("@dgu_klasa", txtKlasa.Text);
        //    cmd.Parameters.AddWithValue("@dgu_uru", txtUrud.Text);
        //    cmd.Parameters.AddWithValue("@teren", txtTeren.Text);
        //    cmd.Parameters.AddWithValue("@faktura", txtFaktura.Text);
        //    cmd.Parameters.AddWithValue("@pon_nar", txtPonNar.Text);
        //    cmd.Parameters.AddWithValue("@opis_placanja", txtPlacanje.Text);
        //    cmd.Parameters.AddWithValue("@placeno", chkPlaceno.Checked);
        //    cmd.Parameters.AddWithValue("@lova", Convert.ToDecimal(txtLova.Text));
        //    cmd.Parameters.AddWithValue("@putanja_projekt", txtPutProj.Text);
        //    cmd.Parameters.AddWithValue("@ponuda_ind", chkPonudaPoslana.Checked);
        //    cmd.Parameters.AddWithValue("@faktura_ind", chkFakturaPoslana.Checked);
        //    cmd.Parameters.AddWithValue("@ponuda_sifra", txtPonSifra.Text);
        //    cmd.Parameters.AddWithValue("@faktura_sifra", txtFaktSifra.Text);
        //    cmd.Parameters.AddWithValue("@dat_kreiranje", txtDatKreir.Text);
        //    cmd.Parameters.AddWithValue("@dat_azuriranja", datum);
        //    cmd.Parameters.AddWithValue("@racun_iznos", Convert.ToDecimal(txtIznFakt.Text));
        //    cmd.Parameters.AddWithValue("@cijena_kat", Convert.ToDecimal(txtKatCijena.Text));
        //    cmd.Parameters.AddWithValue("@sifra", txtSifra.Text);
        //    // Try to open database and execute the update.
        //    int updated = 0;
        //    try
        //    {
        //        con.Open();
        //        updated = cmd.ExecuteNonQuery();
        //        lblStatus.Text = updated.ToString() + " zapis je promijenjen.";
        //    }
        //    catch (Exception err)
        //    {
        //        lblStatus.Text = "Dogodila se greška prilikom spremanja podataka";
        //        lblStatus.Text += err.Message;
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }
        //    // If the update succeeded, refresh the author list.
        //    if (updated > 0)
        //    {
        //        //  FillAuthorList();
        //        lblStatus.Text = "Uspješno su promijenjeni podaci";
        //    }
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

        void PopupKat(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> ShowPopup2(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowPopup2", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> HidePopup2(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "HidePopup2", builder.ToString());
            }
        }
        protected void btnUnos_Click(object sender, EventArgs e)
        {
            // SetReadOnlyOnAllTextBox(this, false);
            txtSifra.Visible = true;
            btnUnos.Visible = true;
            //btnSpremi.Visible = false; ;
            btnNovi.Visible = true;
            ProvjeriFormu();
            //provjeri sve validatore
            if (Page.IsValid)
            {

                if ((txtSifra.Text != "") || (txtSifra.Text != string.Empty))
                {
                    int uspjeh = AzurirajPredmet();
                    if (uspjeh == 99)
                    {
                        lblStatus.Text = "Greška prilikom ažuriranja predmeta. ";
                        this.ShowErrorNotification("Greška prilikom ažuriranja predmeta.", 3000);
                        
                    }
                    else
                    {
                        lblStatus.Text = "Uspješno je ažuriran predmet sa šifrom " + txtSifra.Text;
                        string poruka = "Uspješno je ažuriran predmet sa arh. br. " + txtArhivski.Text + " naziva " + txtNaziv.Text;
                        this.ShowSuccessfulNotification(poruka, 3000);
                    }
                }
                else
                {

                    int PredmetID = SpremiPredmet();
                    if (PredmetID == -1)
                    {
                        lblStatus.Text = "Greška prilikom unosa novoga predmeta. ";
                        this.ShowErrorNotification("Greška prilikom unosa novoga predmeta.");
                    }
                    else
                    {
                        //kreiramo obavijest
                        string poruka = "Unesen je predmet sa arh. br. " + txtArhivski.Text + "naziva " + txtNaziv.Text;
                        bool uspjeh = Helper.UnesiObavijest(DateTime.Now, "svi", poruka, false);
                        if (uspjeh)
                        {

                            this.ShowSuccessfulNotification(poruka, 3000);
                        }
                        else
                        {
                            this.ShowErrorNotification("Nije uspjelo kreiranje obavijesti");
                        }
                        // show the result
                        lblStatus.Text = "Uspješno je spremljen predmet sa šifrom " + PredmetID;

                        // disable the submit button
                        //btnUnos.Enabled = false;
                        //kreira se novi folder sa šifrom predmeta
                        var folder = Server.MapPath("~/Dokumenti/Predmeti/" + PredmetID);
                        if (!Directory.Exists(folder))
                        {
                            Directory.CreateDirectory(folder);
                        }

                    }
                }
            }


        }
        //return this.DateTimeValue.ToString( "yyyy-MM-dd" );
        //protected void btnPonuda_Click(object sender, EventArgs e)
        //{
        //    //za word 2007 docx
        //    string content = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        //    int klijentID = Convert.ToInt32(ddlKlijent.SelectedValue);
        //    int rbrKlijent = Convert.ToInt32(Helper.MaxKlijent(klijentID)) + 1;
        //    int projID = Convert.ToInt32(Request.QueryString["ID"]);
        //    int rbr = Convert.ToInt32(Helper.MaxPredmet(projID)) + 1;
        //    string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/Ponuda.docx");
        //    string izradio = lblUser.Text;
        //    string datum = DateTime.Now.Day.ToString();
        //    // Otvori dokument (Nalazi se u web siteu, u folderu Predlosci)
        //    try
        //    {
        //        // string putanjaWord = System.Web.HttpContext.Current.Server.MapPath("~/Popunjeni/Ponuda1.docx");
        //        string dok = "Ponuda" + datum + ".docx";
        //        string putanjaWord = System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID + "/" + dok);
        //        bool zaht = Helper.UnesiPrilog(projID, rbr, "Ponuda", putanjaWord, content, DateTime.Now);
        //        //  bool kl_ponuda = Helper.UnesiKlijentPrilog(klijentID, rbrKlijent, "Ponuda", "/Dokumenti/Klijenti/", content, DateTime.Now);
        //        DataTable predmet = Helper.DohvatiPredmet(projID, izradio, txtPonSifra.Text, txtFaktSifra.Text);
        //        Document doc = new Document(putanjaOriginal);

        //        doc.MailMerge.Execute(predmet);
        //        if (!Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID)))
        //        {
        //            Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID));
        //        }
        //        doc.Save(putanjaWord);
        //        Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        //        Response.AddHeader("Content-Disposition", "attachment; filename=Ponuda1.docx");
        //        Response.WriteFile(putanjaWord);
        //        Response.End();
        //    }
        //    catch (Exception err)
        //    {
        //        lblStatus.Text = "Dogodila se greška prilikom kreiranja obrasca";
        //        lblStatus.Text += err.Message;
        //    }
        //}

        protected void btnFaktura_Click(object sender, EventArgs e)
        {
            string content = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            string datum = DateTime.Now.Day.ToString();
            string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/Racuni.docx");
            int projID = Convert.ToInt32(Request.QueryString["ID"]);
            int rbr = Convert.ToInt32(Helper.MaxPredmet(projID)) + 1;
            string izradio = lblUser.Text;
            // Otvori dokument (Nalazi se u web siteu, u folderu Predlosci)
            try
            {



                string dok = "Faktura" + datum + ".docx";
                string putanjaWord = System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID + "/" + dok);

                bool zaht = Helper.UnesiPrilog(projID, rbr, "Faktura", putanjaWord, content, DateTime.Now);
                DataTable predmet = Helper.DohvatiPredmet(projID, izradio, "", txtFaktSifra.Text);

                Document doc = new Document(putanjaOriginal);
                doc.MailMerge.Execute(predmet);
                if (!Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID)))
                {
                    Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID));
                }
                doc.Save(putanjaWord);
                Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                Response.AddHeader("Content-Disposition", "attachment; filename=Ponuda1.docx");
                Response.WriteFile(putanjaWord);
                Response.End();
            }
            catch (Exception err)
            {

                lblStatus.Text = "Dogodila se greška prilikom kreiranja obrasca";
                lblStatus.Text += err.Message;
            }

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

        public void FillKat()
        {

            // create the connection
            ddlKat.DataSource = Helper.DohvatiKat();

            ddlKat.DataTextField = "naziv";
            ddlKat.DataValueField = "sifra";
            ddlKat.DataBind();
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
            ddlKlijent.DataSource = Helper.DohvatiKlijente();
            ddlKlijent.DataTextField = "naziv";
            ddlKlijent.DataValueField = "sifra";
            ddlKlijent.DataBind();
            // ddlKlijent.Items.Insert(0, new ListItem("- Select Status -", ""));
        }


        public void FillSviKlijenti()
        {
            ddlKlijent.DataSource = Helper.DohvatiSveKlijente();
            ddlKlijent.DataTextField = "naziv";
            ddlKlijent.DataValueField = "sifra";
            ddlKlijent.DataBind();
            // ddlKlijent.Items.Insert(0, new ListItem("- Select Status -", ""));
        }
        public void FillKlijentiInfo()
        {
           
            int sifra = Convert.ToInt32(ddlKlijent.SelectedValue);
            if (sifra == -1)
            {
                Narucitelj nar = new Narucitelj();
                TextBox51.Text = nar.Naziv;
                TextBox52.Text = nar.Titula;
                TextBox53.Text = nar.Grad;
                TextBox54.Text = nar.Adresa;
                TextBox55.Text = nar.Email;
                TextBox56.Text = nar.Mob;
                TextBox57.Text = nar.Tel1;
                TextBox58.Text = nar.Tel2;
                TextBox59.Text = nar.Oib;
                TextBox60.Text = nar.Tekuci;
                chkPoten.Checked = nar.Potenc;
                chkNepovez.Checked = nar.Nepovezani;
            }
            else
            {
                Narucitelj nar = Helper.DohvatiKlijenta(sifra);
                TextBox51.Text = nar.Naziv;
                TextBox52.Text = nar.Titula;
                TextBox53.Text = nar.Grad;
                TextBox54.Text = nar.Adresa;
                TextBox55.Text = nar.Email;
                TextBox56.Text = nar.Mob;
                TextBox57.Text = nar.Tel1;
                TextBox58.Text = nar.Tel2;
                TextBox59.Text = nar.Oib;
                TextBox60.Text = nar.Tekuci;
                chkPoten.Checked = nar.Potenc;
                chkNepovez.Checked = nar.Nepovezani;
            }
        }


        public void ProvjeriFormu()
        {

            if (txtLova.Text == string.Empty)
            {
                txtLova.Text = "0,00";
            }

            if (txtIznFakt.Text == string.Empty)
            {
                txtIznFakt.Text = "0,00";
            }
            if (txtKatCijena.Text == string.Empty)
            {
                txtKatCijena.Text = "0,00";
            }
            if (txtIznos.Text == string.Empty)
            {
                txtIznos.Text = "0,00";
            }


        }

        protected void btnPovratak_Click(object sender, EventArgs e)
        {


            Response.Redirect("Projekti.aspx", true);

        }

        private int SpremiPredmet()
        {
            int PredmetID = 0;
            string kreirao = lblUser.Text;
            string insertSQL;
            insertSQL = "INSERT INTO Projekt (";
            insertSQL += "naziv, arh_broj, statusID, vrstaID, kat_opc,kat, kat_cest, klijentID, kreirao, narucen_kat, stigli_kat, dat_predajedgu, dat_predaja, ";
            insertSQL += "dat_potvrde,ugov_iznos,dgu_klasa, dgu_uru, teren,pon_nar, godina, placeno,lova,putanja_projekt,dat_kreiranje, dat_azuriranja, ";
            insertSQL += "racun_iznos,cijena_kat, faktura_ind, faktura_sifra, dat_zavrs, zavrsio) ";
            insertSQL += "VALUES (";
            insertSQL += "@naziv, @arh_broj, @statusID, @vrstaID, @kat_opc,@kat, @kat_cest, @klijentID, @kreirao, @narucen_kat, @stigli_kat, @dat_predajedgu, @dat_predaja, ";
            insertSQL += "@dat_potvrde, @ugov_iznos, @dgu_klasa, @dgu_uru, @teren, @pon_nar, @godina, @placeno, @lova, @putanja_projekt,  @dat_kreiranje, @dat_azuriranja, @racun_iznos, @cijena_kat, @faktura_ind, @faktura_sifra, @dat_zavrs, @zavrsio";
            insertSQL += ");SELECT SCOPE_IDENTITY();";

            string connectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            // DateTime.Now.ToString("yyyy-MM-dd");
            DateTime datum = DateTime.Now;


            cmd.Parameters.AddWithValue("@naziv", txtNaziv.Text);
            cmd.Parameters.AddWithValue("@arh_broj", txtArhivski.Text);
            cmd.Parameters.AddWithValue("@statusID", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@vrstaID", ddlVrsta.SelectedValue);
            cmd.Parameters.AddWithValue("@kat_opc", txtKat2.Text);
            cmd.Parameters.AddWithValue("@kat", ddlKat.SelectedValue);
            cmd.Parameters.AddWithValue("@kat_cest", txtCestica.Text);
            cmd.Parameters.AddWithValue("@klijentID", ddlKlijent.SelectedValue);
            cmd.Parameters.AddWithValue("@kreirao", kreirao);
            cmd.Parameters.AddWithValue("@zavrsio", ddlZavrsio.SelectedItem.Text);
            DateTime datpreddgu, predaja, potvrda, zavrsen, kreirano;

            cmd.Parameters.AddWithValue("@narucen_kat", txtNarucen.Text);

            cmd.Parameters.AddWithValue("@stigli_kat", txtStigao.Text);

            //po defaultu ćemo dat.ugovora staviti na datum kreiranja

            DateTime.TryParse(txtDatPredajeDgu.Text, out datpreddgu);
            string ugov = datpreddgu.ToShortDateString();
            cmd.Parameters.AddWithValue("@dat_predajedgu", Convert.ToDateTime(ugov) == DateTime.MinValue ? DBNull.Value : (object)ugov);
           
            DateTime.TryParse(txtPredaja.Text, out predaja);
            string pred = predaja.ToShortDateString();

            cmd.Parameters.AddWithValue("@dat_predaja", Convert.ToDateTime(pred) == DateTime.MinValue ? DBNull.Value : (object)pred);
          
            DateTime.TryParse(txtPotvrda.Text, out potvrda);
            string potvrd = potvrda.ToShortDateString();
            cmd.Parameters.AddWithValue("@dat_potvrde", Convert.ToDateTime(potvrd) == DateTime.MinValue ? DBNull.Value : (object)potvrd);

            DateTime.TryParse(txtZavrs.Text, out zavrsen);
            string zavr = zavrsen.ToShortDateString();
            cmd.Parameters.AddWithValue("@dat_zavrs", Convert.ToDateTime(zavr) == DateTime.MinValue ? DBNull.Value : (object)zavr);


            DateTime.TryParse(txtDatKreir.Text, out kreirano);
            string kreir = kreirano.ToShortDateString();
         //   cmd.Parameters.AddWithValue("@dat_kreiranje", Convert.ToDateTime(kreir) == DateTime.MinValue ? DBNull.Value : (object)kreir);
            cmd.Parameters.AddWithValue("@dat_kreiranje", datum);
            //string ugov = DatumHelper(txtDatPredajeDgu.Text);
            // cmd.Parameters.AddWithValue("@dat_predajedgu", Convert.ToDateTime(ugov) == DateTime.MinValue ? datum : (object)ugov);

            //string pred = DatumHelper(txtPredaja.Text);
            //cmd.Parameters.AddWithValue("@dat_predaja", Convert.ToDateTime(pred) == DateTime.MinValue ? DBNull.Value : (object)pred);

            //string potvrd = DatumHelper(txtPotvrda.Text);
            //cmd.Parameters.AddWithValue("@dat_potvrde", Convert.ToDateTime(potvrd) == DateTime.MinValue ? DBNull.Value : (object)potvrd);

            //string zavr = DatumHelper(txtZavrs.Text);
            //cmd.Parameters.AddWithValue("@dat_zavrs", Convert.ToDateTime(zavr) == DateTime.MinValue ? DBNull.Value : (object)zavr);

            cmd.Parameters.AddWithValue("@ugov_iznos", Convert.ToDecimal(txtIznos.Text));
            cmd.Parameters.AddWithValue("@dgu_klasa", txtKlasa.Text.Trim());
            cmd.Parameters.AddWithValue("@dgu_uru", txtUrud.Text.Trim());
            cmd.Parameters.AddWithValue("@teren", txtTeren.Text);

            cmd.Parameters.AddWithValue("@pon_nar", txtPonNar.Text);
            cmd.Parameters.AddWithValue("@godina", txtGodina.Text);
            cmd.Parameters.AddWithValue("@placeno", chkPlaceno.Checked);

            cmd.Parameters.AddWithValue("@lova", Convert.ToDecimal(txtLova.Text));
            //putanju koristim za spremanje druge napomene
            cmd.Parameters.AddWithValue("@putanja_projekt", txtPutProj.Text);
            //cmd.Parameters.AddWithValue("@ponuda_ind", false);
            cmd.Parameters.AddWithValue("@faktura_ind", chkFakturaPoslana.Checked);
            //cmd.Parameters.AddWithValue("@ponuda_sifra", "");
            cmd.Parameters.AddWithValue("@faktura_sifra", txtFaktSifra.Text);

            //  cmd.Parameters.AddWithValue("@dat_kreiranje", txtDatKreir.Text);
            // cmd.Parameters.AddWithValue("@dat_azuriranja", txtDatAzu.Text);
            // cmd.Parameters.AddWithValue("@dat_kreiranje", datum);
            cmd.Parameters.AddWithValue("@dat_azuriranja", datum);

            cmd.Parameters.AddWithValue("@racun_iznos", Convert.ToDecimal(txtIznFakt.Text));

            cmd.Parameters.AddWithValue("@cijena_kat", Convert.ToDecimal(txtKatCijena.Text));
            // Try to open the database and execute the update.

            try
            {
                con.Open();
                PredmetID = Convert.ToInt32(cmd.ExecuteScalar());
                // added = cmd.ExecuteNonQuery();
                lblStatus.Text = "Unesen je predmet sa šifrom " + PredmetID;
                txtSifra.Text = PredmetID.ToString();
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

        private int AzurirajPredmet()
        {
            gvBiljeskeProj.Visible = false;
            ProvjeriFormu();
            string connectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            //string updateSQL = "UPDATE Projekt SET ";
            //updateSQL += "naziv=@naziv, arh_broj=@arh_broj, statusID = @statusID, vrstaID = @vrstaID, kat_opc = @kat_opc, kat_cest= @kat_cest, klijentID = @klijentID, kreirao = @kreirao, narucen_kat = @narucen_kat, ";
            //updateSQL += "stigli_kat=@stigli_kat, dat_ugov=@dat_ugov, dat_predaja=@dat_predaja, dat_potvrde=@dat_potvrde, ugov_iznos=@ugov_iznos, dgu_klasa=@dgu_klasa, dgu_uru=@dgu_uru, teren=@teren, faktura= @faktura,  ";
            //updateSQL += "pon_nar=@pon_nar, opis_placanja=@opis_placanja, placeno = @placeno, lova = @lova, putanja_projekt= @putanja_projekt, ponuda_ind=@ponuda_ind,faktura_ind=@faktura_ind, ponuda_sifra=@ponuda_sifra, faktura_sifra=@faktura_sifra,  ";
            //updateSQL += "dat_kreiranje=@dat_kreiranje, dat_azuriranja=@dat_azuriranja, racun_iznos = @racun_iznos, cijena_kat = @cijena_kat ";
            //updateSQL += "WHERE sifra=@sifra";
            string updateSQL = "UPDATE [Projekt] SET [naziv] = @naziv, [dat_predajedgu] = @dat_predajedgu, [dat_predaja] = @dat_predaja, [ugov_iznos] = @ugov_iznos, [statusID] = @statusID, [kreirao] = @kreirao, [vrstaID] = @vrstaID, [teren] = @teren, [narucen_kat] = @narucen_kat, [cijena_kat] = @cijena_kat, [stigli_kat] = @stigli_kat, [dgu_klasa] = @dgu_klasa, [dgu_uru] = @dgu_uru, [lova] = @lova, [kat_opc] = @kat_opc,[kat]=@kat, [kat_cest] = @kat_cest, [dat_kreiranje] = @dat_kreiranje, [putanja_projekt] = @putanja_projekt, [dat_azuriranja] = @dat_azuriranja, [klijentID] = @klijentID, [arh_broj] = @arh_broj, [pon_nar] = @pon_nar, [godina] = @godina, [placeno] = @placeno, [dat_potvrde] = @dat_potvrde, [racun_iznos] = @racun_iznos,  [faktura_ind] = @faktura_ind,[faktura_sifra] = @faktura_sifra, [dat_zavrs]= @dat_zavrs, [zavrsio]= @zavrsio WHERE [sifra] = @sifra";
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(updateSQL, con);
            // Add the parameters.
            string kreirao = lblUser.Text;
            DateTime datum = DateTime.Now;
            cmd.Parameters.AddWithValue("@naziv", txtNaziv.Text);
            cmd.Parameters.AddWithValue("@arh_broj", txtArhivski.Text);
            cmd.Parameters.AddWithValue("@statusID", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@vrstaID", ddlVrsta.SelectedValue);
            cmd.Parameters.AddWithValue("@kat_opc", txtKat2.Text);
            cmd.Parameters.AddWithValue("@kat", ddlKat.SelectedValue);
            cmd.Parameters.AddWithValue("@kat_cest", txtCestica.Text);
            cmd.Parameters.AddWithValue("@klijentID", ddlKlijent.SelectedValue);
            cmd.Parameters.AddWithValue("@kreirao", kreirao);
            cmd.Parameters.AddWithValue("@zavrsio", ddlZavrsio.SelectedItem.Text);

            // DateTime datugov, predaja, potvrda, zavrsen;

            DateTime datpreddgu, predaja, potvrda, zavrsen, kreirano;
            //narucen=  DateTime.ParseExact(txtNarucen.Text, CultureInfo.InvariantCulture);
            //string nar = narucen.ToShortDateString();
            // string usa_nar = PretvoriDatum(nar);

            //cmd.Parameters.AddWithValue("@narucen_kat", Convert.ToDateTime(usa_nar) == DateTime.MinValue ? SqlDateTime.Null : (object)usa_nar);

            cmd.Parameters.AddWithValue("@narucen_kat", txtNarucen.Text);

            cmd.Parameters.AddWithValue("@stigli_kat", txtStigao.Text);


            //if (txtPotvrda.Text == string.Empty)
            //{
            //    potvrda = (DateTime)System.Data.SqlTypes.SqlDateTime.Null;
            //    cmd.Parameters.AddWithValue("@dat_potvrde", potvrda);
            //}
            //else
            //{
            //    cmd.Parameters.AddWithValue("@dat_potvrde", DateTime.ParseExact(txtPotvrda.Text, "dd.MM.yyyy", CultureInfo.InvariantCulture));
            //}
          
            DateTime.TryParse(txtDatPredajeDgu.Text, out datpreddgu);
            string ugov = DatumHelper(txtDatPredajeDgu.Text);
            //ako nije upisao dat ugovora stavimo datum kreiranja onda

            cmd.Parameters.AddWithValue("@dat_predajedgu", Convert.ToDateTime(ugov) == DateTime.MinValue ? DBNull.Value : (object)ugov);

            DateTime.TryParse(txtPredaja.Text, out predaja);
            string pred = DatumHelper(txtPredaja.Text);

            cmd.Parameters.AddWithValue("@dat_predaja", Convert.ToDateTime(pred) == DateTime.MinValue ? DBNull.Value : (object)pred);


            DateTime.TryParse(txtPotvrda.Text, out potvrda);
            string potvrd = DatumHelper(txtPotvrda.Text);

            cmd.Parameters.AddWithValue("@dat_potvrde", Convert.ToDateTime(potvrd) == DateTime.MinValue ? DBNull.Value : (object)potvrd);

            DateTime.TryParse(txtZavrs.Text, out zavrsen);
            string zavr = DatumHelper(txtZavrs.Text);

            cmd.Parameters.AddWithValue("@dat_zavrs", Convert.ToDateTime(zavr) == DateTime.MinValue ? DBNull.Value : (object)zavr);
            string ugovoren = PretvoriDecimalni(txtIznos.Text);

            DateTime.TryParse(txtDatKreir.Text, out kreirano);
            string kreir = DatumHelper(txtDatKreir.Text);
          //  string kreir = kreirano.ToShortDateString();
            cmd.Parameters.AddWithValue("@dat_kreiranje", Convert.ToDateTime(kreir) == DateTime.MinValue ? DBNull.Value : (object)kreir);

            cmd.Parameters.AddWithValue("@ugov_iznos", Convert.ToDecimal(txtIznos.Text));
            cmd.Parameters.AddWithValue("@dgu_klasa", txtKlasa.Text.Trim());
            cmd.Parameters.AddWithValue("@dgu_uru", txtUrud.Text.Trim());
            cmd.Parameters.AddWithValue("@teren", txtTeren.Text);

            cmd.Parameters.AddWithValue("@pon_nar", txtPonNar.Text);
            cmd.Parameters.AddWithValue("@godina", txtGodina.Text);
            cmd.Parameters.AddWithValue("@placeno", chkPlaceno.Checked);
            string lovica = PretvoriDecimalni(txtLova.Text);
            cmd.Parameters.AddWithValue("@lova", Convert.ToDecimal(txtLova.Text));
            // cmd.Parameters.AddWithValue("@lova", Convert.ToDecimal(txtLova.Text));
            cmd.Parameters.AddWithValue("@putanja_projekt", txtPutProj.Text);
            //cmd.Parameters.AddWithValue("@ponuda_ind", chkPonudaPoslana.Checked);
            cmd.Parameters.AddWithValue("@faktura_ind", chkFakturaPoslana.Checked);
            //cmd.Parameters.AddWithValue("@ponuda_sifra", txtPonSifra.Text);
            cmd.Parameters.AddWithValue("@faktura_sifra", txtFaktSifra.Text);
            //  cmd.Parameters.AddWithValue("@dat_kreiranje", Convert.ToDateTime(txtDatKreir.Text));
            cmd.Parameters.AddWithValue("@dat_azuriranja", datum);
            string iznosrac = PretvoriDecimalni(txtIznFakt.Text);
            cmd.Parameters.AddWithValue("@racun_iznos", Convert.ToDecimal(txtIznFakt.Text));
            string cijkat = PretvoriDecimalni(txtKatCijena.Text);
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

                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            // If the update succeeded, refresh the author list.
            if (updated > 0)
            {
                return updated;
            }
            else
            {
                return 99;
            }

        }

        private string PretvoriDecimalni(string broj)
        {
            string pomocni = "";
            if (broj.Contains("."))
            {
                pomocni = broj;
            }
            else
            {
                pomocni = broj.Replace(",", ".");
            }

            return pomocni;
        }


        /// <summary>
        /// pretvara datum u hr obliku u yyyy-mm-dd
        /// </summary>
        /// <param name="datum"></param>
        /// <returns></returns>
        private string PretvoriDatum(string datum)
        {
            string[] dat = datum.Split('.');
            string dan, mjesec, godina, usa;
            dan = dat[0];
            if (dan.Length == 1)
            { dan = "0" + dan; }

            mjesec = dat[1];
            if (mjesec.Length == 1)
            {
                mjesec = "0" + mjesec;
            }
            godina = dat[2];
            //ISO  usa = godina + "-" + mjesec + "-" + dan + " 00:00:00";
            usa = mjesec + "." + dan + "." + godina;
            return usa;

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

        protected void btnKatastar_Click(object sender, EventArgs e)
        {
            string datum = DateTime.Now.Day.ToString();
            string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/kat_pula.docx");
            Int32 projID = Convert.ToInt32(Request.QueryString["ID"]);
            string izradio = lblUser.Text;
            // Otvori dokument (Nalazi se u web siteu, u folderu Predlosci)
            try
            {
                DataTable predmet = Helper.DohvatiPredmet(projID, izradio, "", txtFaktSifra.Text);
                if (predmet.Rows[0]["KATOPC"].ToString().Contains("324914"))
                {
                    putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/kat_rovinj.docx");
                }

                Document doc = new Document(putanjaOriginal);

                doc.MailMerge.Execute(predmet);
                string dok = "Katastar" + datum + ".docx";
                string putanjaWord = System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID + "/" + dok);

                if (!Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID)))
                {
                    Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID));
                }

                doc.Save(putanjaWord);
                Response.ContentType = "application/ms-word";
                Response.AddHeader("Content-Disposition", "attachment; filename=Katastar.docx");
                Response.WriteFile(putanjaWord);
                Response.End();
            }
            catch (Exception err)
            {

                lblStatus.Text = "Dogodila se greška prilikom kreiranja obrasca";
                lblStatus.Text += err.Message;
            }

        }

        //protected void chkPonudaPoslana_CheckedChanged(object sender, EventArgs e)
        //{
        //    string oznaka;
        //    int sifra;
        //    if (chkPonudaPoslana.Checked == true)
        //    {
        //        if (txtPonStart.Text == "")
        //        {
        //            oznaka = Helper.MaxPonudaSifra();
        //            sifra = Convert.ToInt32(oznaka.Substring(2, 3)) + 1;
        //        }
        //        else
        //        {
        //            oznaka = txtPonStart.Text;
        //            sifra = Convert.ToInt32(oznaka) + 1;
        //        }


        //        //string dat = DateTime.Now.Year.ToString();
        //        //string danasnji = dat.Substring(2, 2);
        //        //int poz = oznaka.LastIndexOf("/");
        //        //string godina = oznaka.Substring(poz);
        //        string dat = DateTime.Now.Year.ToString();
        //        string danasnji = dat.Substring(2, 2);

        //        string godina = txtDatAzu.Text.Substring(8, 2);
        //        string ponuda = string.Empty;
        //        if (danasnji.Equals(godina, StringComparison.Ordinal))
        //        {
        //            ponuda = "P-" + sifra + "/" + godina;
        //        }
        //        //else
        //        //{
        //        //    ponuda = "P-" + "001" + "/" + godina;
        //        //}

        //        txtPonSifra.Text = ponuda;
        //    }
        //}

        protected void chkFakturaPoslana_CheckedChanged(object sender, EventArgs e)
        {
            string oznaka;
            int sifra;
            if (chkFakturaPoslana.Checked == true)
            {
                if (txtFaktStart.Text == "")
                {
                    oznaka = Helper.MaxFakturaSifra();
                    sifra = Convert.ToInt32(oznaka.Substring(0, 3)) + 1;
                }
                else
                {
                    oznaka = txtFaktStart.Text;
                    sifra = Convert.ToInt32(oznaka) + 1;
                }


                string dat = DateTime.Now.Year.ToString();
                string danasnji = dat.Substring(2, 2);

                string godina = txtDatAzu.Text.Substring(8, 2);

                string ponuda = string.Empty;

                string user = lblUser.Text;
                int operater = Helper.NadjiOperatera(user);
                if (danasnji.Equals(godina, StringComparison.Ordinal))
                {
                    ponuda = sifra + "-" + "U-" + operater;
                }
                //else
                //{
                //    ponuda = "001" + "-" + "U-" + operater;
                //}

                txtFaktSifra.Text = ponuda;
            }
        }

        protected void gvBiljeskeProj_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvBiljeskeProj, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Popup(true);
        }

        //protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        //{
        //    if (e.AffectedRows ==0) //Here AffectedRows gives you the count of returned rows.
        //    {
        //        gvBiljeskeProj.ShowHeaderWhenEmpty = true;

        //    }
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            bool uspjeh = Helper.UnesiKlijenta(txtKlNaziv.Text, txtKlGrad.Text, txtKlAdresa.Text, txtKlEmail.Text, txtKlMob.Text, txtKlTel.Text, txtKlOib.Text, txtKlZiro.Text, lblUser.Text);
            if (uspjeh)
            {
                string poruka = "Unesen je klijent " + txtKlNaziv.Text + " sa OIB-om " + txtKlOib.Text;
                bool usp = Helper.UnesiObavijest(DateTime.Now, "svi", poruka, true);
                if (usp)
                {
                    //  this.ShowSuccessfulNotification(poruka, 3000);
                    FillKlijenti();
                }

            }
        }

        protected void btnPrilozi_Click(object sender, EventArgs e)
        {
            Response.Redirect("Prilozi.aspx?ID=" + txtSifra.Text);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            PopupKat(true);
        }
        protected void btnKat_Click(object sender, EventArgs e)
        {
            int sif = Convert.ToInt32(TextBox42.Text);
            bool uspjeh = Helper.UnesiKat(sif, TextBox32.Text);
            if (uspjeh)
            {
                string poruka = "Unesena je kat. općina " + TextBox32.Text + " sa šifrom " + TextBox42.Text;
                bool usp = Helper.UnesiObavijest(DateTime.Now, "svi", poruka, true);
                if (usp)
                {
                    //AspNetNotify1.AddMessage(poruka);
                    FillKat();
                }

            }
        }

        protected void btnInfo_Click(object sender, EventArgs e)
        {

            PopupInfo(true);
        }

        void PopupInfo(bool isDisplay)
        {


            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> ShowPopup3(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowPopup3", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> HidePopup3(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "HidePopup3", builder.ToString());
            }
        }

        protected void btnSud_Click(object sender, EventArgs e)
        {
            string datum = DateTime.Now.Day.ToString();
            string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/zahtjev_sud.docx");
            Int32 projID = Convert.ToInt32(Request.QueryString["ID"]);
            string izradio = lblUser.Text;
            // Otvori dokument (Nalazi se u web siteu, u folderu Predlosci)
            try
            {
                DataTable predmet = Helper.DohvatiPredmet(projID, izradio, "", txtFaktSifra.Text);
                if (predmet.Rows[0]["KATOPC"].ToString().Contains("324914"))
                {
                    putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath("~/Predlosci/zahtjev_sud.docx");
                }

                Document doc = new Document(putanjaOriginal);

                doc.MailMerge.Execute(predmet);
                string dok = "ZahtjevSud" + datum + ".docx";
                string putanjaWord = System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID + "/" + dok);

                if (!Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID)))
                {
                    Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("~/Dokumenti/Predmeti/" + projID));
                }

                doc.Save(putanjaWord);
                Response.ContentType = "application/ms-word";
                Response.AddHeader("Content-Disposition", "attachment; filename=ZahtjevSud.docx");
                Response.WriteFile(putanjaWord);
                Response.End();
            }
            catch (Exception err)
            {

                lblStatus.Text = "Dogodila se greška prilikom kreiranja obrasca";
                lblStatus.Text += err.Message;
            }
        }

        public static string DatumHelper(string datum)
        {
            if (datum.Length == 0)
            {
                return DateTime.MinValue.ToString();
            }
            string[] dat;
            if (datum.Contains('/'))
            {
                dat = datum.Split('/');
            }
            else
            {
                dat = datum.Split('.');
            }

            string dan, mjesec, godina, usa;
            dan = dat[0];
            if (dan.Length == 1)
            { dan = "0" + dan; }

            mjesec = dat[1];
            if (mjesec.Length == 1)
            {
                mjesec = "0" + mjesec;
            }
            godina = dat[2];
            usa = godina + "-" + mjesec + "-" + dan;
            // usa = dan + "." + mjesec + "." + godina;
            return usa;

        }

        protected void ddlKlijent_SelectedIndexChanged(object sender, EventArgs e)
        {
            int sifra = Convert.ToInt32(ddlKlijent.SelectedValue);
            Narucitelj klijent = Helper.DohvatiKlijenta(sifra);
            TextBox51.Text = klijent.Naziv;
            TextBox59.Text = klijent.Oib;
            TextBox52.Text = klijent.Titula;
            TextBox53.Text = klijent.Grad;
            TextBox54.Text = klijent.Adresa;
            TextBox55.Text = klijent.Email;
            TextBox56.Text = klijent.Mob;
            TextBox57.Text = klijent.Tel1;
            TextBox58.Text = klijent.Tel2;
            TextBox60.Text = klijent.Tekuci;
            chkPoten.Checked = klijent.Potenc;
            chkNepovez.Checked = klijent.Povezani;

        }
    }
}


