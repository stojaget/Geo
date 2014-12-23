using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Geodezija
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //ako je anonimni user onda se ne prikazuje glavni menu
           // NavigationMenu.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
        }
    }
}
