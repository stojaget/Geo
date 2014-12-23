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
    public partial class IzvjDGUSva : System.Web.UI.Page
    {
        DateTime odd, dod;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

               

            }

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
                case 1: PokaziReport(odd, dod, "spGodisnjeDgu", Server.MapPath(@"~\Reports\DGUUkupno.rdlc"));
                    break;
                case 2: PokaziReport(odd, dod, "spGodisnjeDguPredani", Server.MapPath(@"~\Reports\DGUPredani.rdlc"));
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


            ReportViewer1.LocalReport.DataSources.Add(repDs);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}