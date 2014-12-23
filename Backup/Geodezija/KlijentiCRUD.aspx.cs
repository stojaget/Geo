using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Geodezija
{
    public partial class KlijentiCRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = User.Identity.Name;
            Calendar1.SelectedDate = DateTime.Now;
        }

        protected void gvKlijentProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            //kada user odabere klijneta odvede ga na stranicu za uređivanje
            Response.Redirect("ProjektiCRUD.aspx?ID=" + gvKlijentProj.SelectedValue);
        }

        /*
        protected void sdsKlijentiCRUD_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {

            sdsKlijentiCRUD.InsertParameters["@dat_kreiranja"].DefaultValue = Convert.ToString(DateTime.Now); 
            sdsKlijentiCRUD.Insert();
        }
         * */
    }
}