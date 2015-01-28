using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Web.Security;
using jQueryNotification.Helper;
namespace Geodezija
{
    public partial class User_List1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            chkZakljucan.Enabled = false;
            btnOtkljucaj.Enabled = false;
        }

        protected void Button_Click(object sender, EventArgs e)
        {
            Response.Redirect("User_Create.aspx");
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowIndex == GridView1.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                    row.ToolTip = string.Empty;
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                    row.ToolTip = "Click to select this row.";
                }

            }
            int index = GridView1.SelectedIndex;
            txtUser.Text = (GridView1.DataKeys[index].Value).ToString();

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
                //int index = GridView1.SelectedIndex;

                //txtUser.Text = (GridView1.DataKeys[index].Value).ToString();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "Select")
            {
                int row = int.Parse(e.CommandArgument.ToString());
                txtUser.Text = GridView1.Rows[row].Cells[1].Text.ToString();
                // Get information about this user
                MembershipUser usr = Membership.GetUser(txtUser.Text);
                ddlRola.SelectedValue = (VratiSifruRole(txtUser.Text)).ToString();
                chkZakljucan.Checked = usr.IsLockedOut;
                if (chkZakljucan.Checked == true)
                {
                    btnOtkljucaj.Enabled = true;
                }
                else
                {
                    btnOtkljucaj.Enabled = false;
                }
            }
        }

        static bool IsNullOrEmpty(string[] myStringArray)
        {
            return myStringArray == null || myStringArray.Length < 1;
        }

        private int VratiSifruRole(string user)
        {
            string[] role = null;
            role = Roles.GetRolesForUser(user);
            if (IsNullOrEmpty(role))
            {
                return -1;
            }
            string rola = role[0].ToString();
            int sifra = 2;
            switch (rola)
            {
                case "Administrator":
                    sifra = 0;
                    return sifra;

                case "Pripravnik":
                    sifra = 2;
                    return sifra;

                case "Manager":
                    sifra = 1;
                    return sifra;
                default:

                    break;
            }
            return sifra;

        }

        protected void btnPromjena_Click(object sender, EventArgs e)
        {
            string poruka;
            if (chkZakljucan.Checked)
            {
                poruka = "Korisnik je zaključan.Prvo ga otključajte";
                this.ShowErrorNotification(poruka);
            }
            else
            {
                poruka = "Uspješno je obavljena promjena korisničkih podataka za korisnika " + txtUser.Text;
                //ako nije upiso novi pass
                if (txtPass.Text.Trim() == "")
                {
                    string[] role = null;
                    role = Roles.GetRolesForUser(txtUser.Text);
                    string rola;
                    if (IsNullOrEmpty(role))
                    {
                        rola = string.Empty;
                      //  this.ShowErrorNotification("Odabrani korisnik nema rolu u sustavu.Nije moguće napraviti promjenu");
                        return;
                    }
                    else
                    {
                        rola = role[0].ToString();
                        Roles.RemoveUserFromRole(txtUser.Text, rola);
                        Roles.AddUserToRole(txtUser.Text, ddlRola.SelectedItem.Text);
this.ShowSuccessfulNotification(poruka, 3000);
                    }


                    
                }
                else
                {

                    MembershipUser mu = Membership.GetUser(txtUser.Text);
                    mu.ChangePassword(mu.ResetPassword(), txtPass.Text);
                    string[] role = Roles.GetRolesForUser(txtUser.Text);
                    string rola = role[0].ToString();
                    Roles.RemoveUserFromRole(txtUser.Text, rola);
                    Roles.AddUserToRole(txtUser.Text, ddlRola.SelectedItem.Text);
                    this.ShowSuccessfulNotification(poruka, 3000);
                }
            }
        }
        protected void btnOtkljucaj_Click(object sender, EventArgs e)
        {
            if (chkZakljucan.Checked == true)
            {
                MembershipUser mu = Membership.GetUser(txtUser.Text);
                mu.UnlockUser();
                btnOtkljucaj.Enabled = false;
                string poruka = "Uspješno je obavljeno otključavanje za korisnika " + txtUser.Text;
                this.ShowSuccessfulNotification(poruka, 3000);
            }
        }



    }


}