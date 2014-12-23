using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;


namespace Geodezija.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            RegisterHyperLink.NavigateUrl = "~/User_Create.aspx";   
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(LoginUser.UserName, LoginUser.Password))
            {
                if (Request.QueryString["ReturnUrl"] != null)
                {
                    FormsAuthentication.RedirectFromLoginPage(LoginUser.UserName, false);
                }
                else
                {
                    FormsAuthentication.SetAuthCookie(LoginUser.UserName, false);
                }
            }
            else
            {
                Response.Write("Invalid UserID and Password");
            }
        }

        protected void LoginUser_Authenticate(object sender, AuthenticateEventArgs e)
        {
            if (Membership.ValidateUser(LoginUser.UserName, LoginUser.Password))
            {
                e.Authenticated = true;
            }
            else
            {
                e.Authenticated = false;
            }
        }


    }
}
