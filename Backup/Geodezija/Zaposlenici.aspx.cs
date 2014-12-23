using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Geodezija
{
    public partial class Zaposlenici : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPregled_Click(object sender, EventArgs e)
        {
            string dat_od = Request.Form[txtDate.UniqueID];
            string dat_do = Request.Form[txtDateDo.UniqueID];
            string url = "Loko.aspx?od="+dat_od+"&do="+dat_do;
            Response.Redirect(url);
            
          
        }

        protected void btnTerenski_Click(object sender, EventArgs e)
        {
            string dat_od = Request.Form[txtOd.UniqueID];
            string dat_do = Request.Form[txtDo.UniqueID];
            string url = "Terenski.aspx?dod=" + dat_od + "&ddo=" + dat_do;
            Response.Redirect(url);
        }

        protected void gvRadnik_SelectedIndexChanged(object sender, EventArgs e)
        {
         
            Response.Redirect("ZaposlCRUD.aspx?ID=" + gvRadnik.SelectedValue);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Write("Valid!");
            //after validation, run server-side code here
        }

      
    }
}