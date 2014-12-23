using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Microsoft.Reporting.WebForms;

namespace Geodezija.Reports
{
    public partial class IzvjPoslovanje : System.Web.UI.Page
    {
        DateTime odd, dod;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (txtOd.Text == string.Empty)
            { odd = DateTime.Now.AddYears(-1); }
            else
            {
                odd = Convert.ToDateTime(txtOd.Text);
            }
            if (txtDo.Text == string.Empty)
            {
                dod = DateTime.Now.AddYears(1);
            }
            else
            {
                dod = Convert.ToDateTime(txtDo.Text);
            }
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            switch (ddlVrsta.SelectedIndex)
            {
                case 1: PokaziReport(odd, dod, "PopisKlijenataPoRazdoblju", Server.MapPath(@"~\Reports\KlijentiPoRazdoblju.rdlc"));
                    break;
                case 2: PokaziReport(odd, dod, "PredaniNeplaceniProjekti", Server.MapPath(@"~\Reports\PredaniNeplaceniProjekti.rdlc"));
                    break;
                case 3: PokaziReport(odd, dod, "PredaniPlaceniProjekti", Server.MapPath(@"~\Reports\PredaniPlaceniProjekti.rdlc"));
                    break;
                case 4: PokaziReport(odd, dod, "UgovoreniNeplaceniProjekti", Server.MapPath(@"~\Reports\UgovoreniNeplaceni.rdlc"));
                    break;
                case 5: PokaziReport(odd, dod, "UgovoreniPlaceniProjekti", Server.MapPath(@"~\Reports\UgovoreniPlaceni.rdlc"));
                    break;
                
                default:
                    break;
            }

        }

        private void PokaziReport(DateTime odd, DateTime dod, string proc, string putanja)
        {


            ReportViewer1.LocalReport.DataSources.Clear();
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlCommand cmd = new SqlCommand("dbo." + proc, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@OD", odd);
            cmd.Parameters.AddWithValue("@DO", dod);
            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataSet dataSet = new DataSet();

            adpt.Fill(dataSet, "Djelatnici");
            ReportDataSource repDs = new ReportDataSource("DataSet1", dataSet.Tables[0]);


            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            ReportViewer1.LocalReport.ReportPath = putanja;

            // set param values, not really doing anything except showing up in the report,
            //ovo će trebati za prikaz reporta da se vide datumi razdublja, još treba na rep. vieweru ShowParameterPrompts="true"
            string paraOd = odd.ToShortDateString();
            string paraDo = dod.ToShortDateString();
            ReportParameter[] param = new ReportParameter[2];
            param[0] = new ReportParameter("paraOd", paraOd, false);
            param[1] = new ReportParameter("paraDo", paraDo, false);
            this.ReportViewer1.LocalReport.SetParameters(param);

            ReportViewer1.LocalReport.DataSources.Add(repDs);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}