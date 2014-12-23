using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Geodezija
{
    public partial class Projekti : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //kada user odabere klijneta odvede ga na stranicu za uređivanje
            Response.Redirect("ProjektiCRUD.aspx?ID=" + GridView1.SelectedValue);
        }

        protected void btnTrazi_Click(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
         
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = e.Row.Cells[7].Text;
                /*
                if (status == "Početak")
                {
                    e.Row.ForeColor = System.Drawing.Color.Black;
                   
                }
                */
                switch (status)
                {
                    case "Početak":
                        e.Row.ForeColor = System.Drawing.Color.Black;
                        break;
                    case "Odrađen teren":
                        e.Row.ForeColor = System.Drawing.Color.Green;
                        break;
                        
                         case "Na čekanju (papiri)":
                        e.Row.ForeColor = System.Drawing.Color.Orange;
                        break;

                         case "Otvoren- storniran":
                        e.Row.ForeColor = System.Drawing.Color.LightPink;
                        break;

                         case "Gotovo":
                        e.Row.ForeColor = System.Drawing.Color.Red;
                        break;


                    default:
                        e.Row.ForeColor = System.Drawing.Color.Black;
                        break;
                }

            }




        }
    }
}