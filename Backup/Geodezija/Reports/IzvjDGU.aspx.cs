using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Reporting;
using CrystalDecisions;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Geodezija.Reports
{
    public partial class IzvjDGU : System.Web.UI.Page
    {
        ReportDocument doc;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void ShowReport(String fileName, String strProcedureName)
        {
            DateTime odd, dod;
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

            TableLogOnInfo crTableLogOnInfo = new TableLogOnInfo();
            ConnectionInfo crConnectionInfo = new ConnectionInfo();
            CrystalDecisions.CrystalReports.Engine.Database crDatabase;
            CrystalDecisions.CrystalReports.Engine.Tables crTables;
            doc = new ReportDocument();
            doc.Load(fileName);

            crDatabase = doc.Database;
            crTables = crDatabase.Tables;
            string connectionString = ConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("dbo." + strProcedureName, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@OD", odd);
            cmd.Parameters.AddWithValue("@DO", dod);
            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataSet dataSet = new DataSet();

            adpt.Fill(dataSet, "DGUUkupno");
            foreach (CrystalDecisions.CrystalReports.Engine.Table crTable in crTables)
            {
                crTableLogOnInfo = crTable.LogOnInfo;
                crTableLogOnInfo.ConnectionInfo = crConnectionInfo;

            }
           
            /*
doc.SetParameterValue("@OD", txtOd.Text);
CrystalReportViewer1.ParameterFieldInfo.Clear();
CrystalReportViewer1.ReportSource = doc;
             * 
             * 
             */
            doc.SetDataSource(dataSet.Tables[0]);
            CrystalReportViewer1.ReportSource = doc;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            doc.SetParameterValue("@OD", txtOd.Text);
            CrystalReportViewer1.ParameterFieldInfo.Clear();
            CrystalReportViewer1.ReportSource = doc;
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            ShowReport(Server.MapPath(@"~\Reports\DGU_UK.rpt"), "spGodisnjeDgu");
        }

       
        
    }


}
