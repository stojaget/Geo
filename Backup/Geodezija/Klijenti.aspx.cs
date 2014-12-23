using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Geodezija
{
    public partial class Klijenti : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //kada user odabere klijneta odvede ga na stranicu za uređivanje
            Response.Redirect("KlijentiCRUD.aspx?ID=" + GridView1.SelectedValue);
        }

        protected void btnTrazi_Click(object sender, EventArgs e)
        {
           
            }

        }

      
    }
