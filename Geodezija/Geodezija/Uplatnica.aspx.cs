using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;

namespace Geodezija
{
    public partial class Uplatnica : System.Web.UI.Page
    {
        private string modelPozivPrimatelj;


        protected void Page_Load(object sender, EventArgs e)
        { 
            int projID = Convert.ToInt32(Request.QueryString["ID"]);
            if (!Page.IsPostBack)
            { 
            DohvatiProjekt(projID);
            }


            int klijentID = Convert.ToInt32(txtNarSifra.Text);
            PostaviNarucitelja(klijentID);
        }

        public void PostaviNarucitelja(int klijentId)
        { 
         Narucitelj narucitelj = Helper.DohvatiKlijenta(klijentId);
         txtNarucitelj.Text = narucitelj.Naziv;
         txtAdresa.Text = narucitelj.Adresa;
         txtGrad.Text = narucitelj.Grad;
         txtTekuci.Text = narucitelj.Tekuci;
         txtZiro.Text = narucitelj.Ziro;

        
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
                        
                        txtNaziv.Text = (string)rdr["naziv"];
                       
                        txtNarSifra.Text = rdr["klijentID"].ToString();
                       
                       
                        txtIznos.Text = rdr["ugov_iznos"].ToString();
                       
                       
                       
                        chkPlaceno.Checked = Convert.ToBoolean(rdr["placeno"]);
                        txtLova.Text = rdr["lova"].ToString();
                       
                        
                       
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            
            string platitelj = txtNarucitelj.Text + "\n" + txtGrad.Text + "\n" + txtAdresa.Text;
            var pdfPath = Path.Combine(Server.MapPath("~/PDFs/HUB-3A_TEMP.pdf"));

            // Get the form fields for this PDF and fill them in!
            var formFieldMap = PDFHelper.GetFormFieldNames(pdfPath);
            
            formFieldMap["Primatelj"] = "Geoistra d.o.o.\nPula, Veronska 6 ";
            formFieldMap["IbanPrimatelja"] = "HR236435690878";
            formFieldMap["IbanPrimatelj2"] = "HR236435690878";
            if (string.IsNullOrEmpty(txtPozivPrimatelja.Text))
            {
                formFieldMap["PozivPrimatelja"] = "";
            }
            else
            {
                formFieldMap["PozivPrimatelja"] = txtPozivPrimatelja.Text;
            }


            if (string.IsNullOrEmpty(txtDatum.Text))
            {
                formFieldMap["ModelPrimatelja"] = "HR01";
            }
            else
            {
                formFieldMap["ModelPrimatelja"] = txtModelPrimatelja.Text;
            }
            modelPozivPrimatelj = txtModelPrimatelja.Text + " " + txtPozivPrimatelja.Text;
            formFieldMap["ModelPozivPrimatelja"] = modelPozivPrimatelj;
            formFieldMap["Platitelj"] = platitelj;
             
            if (string.IsNullOrEmpty(txtTekuci.Text))
            {
                formFieldMap["IbanPlatitelja"] = txtZiro.Text;
            }
            else
            {
                formFieldMap["IbanPlatitelja"] = txtTekuci.Text;
            }

            formFieldMap["Iznos"] = txtIznos.Text;
            if (string.IsNullOrEmpty(txtDatum.Text))
            {
                formFieldMap["Datum"] = DateTime.Now.ToShortDateString();
            }
            else
            {
                formFieldMap["Datum"] = txtDatum.Text;
            }
            
            formFieldMap["OpisPlacanja"] = txtOpisPlacanja.Text;
            formFieldMap["Valuta"] = "HRK";
            formFieldMap["OpisPlacanja2"] = txtOpisPlacanja.Text;
            formFieldMap["ValutaIznos"] = "HRK = " + txtIznos.Text;

            var pdfContents = PDFHelper.GeneratePDF(pdfPath, formFieldMap);

            PDFHelper.ReturnPDF(pdfContents, "Popunjen-HUB3A.pdf");
        }
    }
}