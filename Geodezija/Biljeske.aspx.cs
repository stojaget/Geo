using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Threading;

namespace Geodezija
{
    public partial class Biljeske : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["GeoistraConnectionString1"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = User.Identity.Name;
           // FillDDL();

          

        }

     
        
        protected void dvBiljeske_DataBound(object sender, EventArgs e)
        {
            DropDownList ddlDelegiraj = (DropDownList)sender;

            DetailsView dvBiljeske = (DetailsView)ddlDelegiraj.NamingContainer;

            if (dvBiljeske.DataItem != null)
            {

                string username = ((DataRowView)dvBiljeske.DataItem)["UserName"] as string;

                ListItem lm = ddlDelegiraj.Items.FindByValue(username);

                if (lm != null) lm.Selected = true;

            }
        }


        
 //Occurs whenever a new DetailsView item is created.
        /*
        protected void dvBiljeske_ItemCreated(object sender, EventArgs e)
        {
        
         
           if (dvBiljeske.FooterRow == null)

                return;
            if (dvBiljeske.CurrentMode == DetailsViewMode.ReadOnly)

                AddConfirmToDeleteButton();

            if (dvBiljeske.CurrentMode != DetailsViewMode.ReadOnly)

                AddConfirmToUpdateButton();

        }
         
         * */


        /*
protected void AddConfirmToDeleteButton()

 {

    int commandRowIndex = dvBiljeske.Rows.Count - 1;

    DetailsViewRow commandRow =

      dvBiljeske.Rows[commandRowIndex];

    DataControlFieldCell cell =

      (DataControlFieldCell)commandRow.Controls[0];

    foreach (Control ctl in cell.Controls)

    {

        LinkButton link = ctl as LinkButton;

        if (link != null)

        {

            if (link.CommandName == "Delete")

            {

                link.ToolTip = "Click here to delete";
              

              //  link.OnClientClick = "return confirm('Do you really want to save changes?');";
                link.OnClientClick = "return ConfirmDialog(this, 'Confirmation', 'Are you sure?');";
            }

            else if (link.CommandName == "New")

                link.ToolTip = "Click here to add a new record";

            else if (link.CommandName == "Edit")

                link.ToolTip = "Click here to edit the current record";

        }

    }

 }

 protected void AddConfirmToUpdateButton()

 {

    int commandRowIndex = dvBiljeske.Rows.Count - 1;

    DetailsViewRow commandRow =

      dvBiljeske.Rows[commandRowIndex];

    DataControlFieldCell cell =

      (DataControlFieldCell)commandRow.Controls[0];

    foreach (Control ctl in cell.Controls)

    {

        LinkButton link = ctl as LinkButton;

        if (link != null)

        {

            if (link.CommandName == "Update" || link.CommandName == "Insert")

            {

                link.ToolTip = "Click here to save changes";

                link.OnClientClick = "return ConfirmDialog(this, 'Confirmation', 'Are you sure?');";

            }

            else if (link.CommandName == "Cancel")

                link.ToolTip = "Click here to cancel editing";

        }

    }

 }

        */
   
        /*
        private void FillDDL()
        {
            if (!IsPostBack)
            {
                MembershipUserCollection members = Membership.GetAllUsers();

               ddlDelegiraj.DataSource = members.Cast<MembershipUser>()
                .ToDictionary(m => m.ProviderUserKey, m => m.UserName);
            ddlDelegiraj.DataValueField = "Key";
            ddlDelegiraj.DataTextField = "Value";
            ddlDelegiraj.DataBind();   
            }
        }

      */

        /*
        public void Delegiraj(string user)
        {
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);

            string insertSQL;

            //   insertSQL = "UPDATE [Biljeske] SET [datum] = @datum, [opis] = @opis, [projektID] = @projektID, [unio] = @unio, [kraj]= @kraj, [odgovoran]= @odgovoran WHERE [sifra] = @sifra";
            insertSQL = "UPDATE [Biljeske] SET  [odgovoran]= @odgovoran WHERE [sifra] = @sifra";

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.Parameters.AddWithValue("@sifra", sifra);
            //   cmd.Parameters.AddWithValue("@opis", opis);

            // cmd.Parameters.AddWithValue("@projektID", projektID);
            // cmd.Parameters.AddWithValue("@unio", unio);
            // cmd.Parameters.AddWithValue("@kraj", kraj);
            cmd.Parameters.AddWithValue("@odgovoran", user);


            int added = 0;
            try
            {
                con.Open();
                added = cmd.ExecuteNonQuery();
                lblStatus.Text = added.ToString() + " records inserted.";
            }
            catch (Exception err)
            {
                lblStatus.Text = "Error inserting record. ";
                lblStatus.Text += err.Message;
            }
            finally
            {
                con.Close();
            }
            // If the insert succeeded, refresh the author list.
            if (added > 0)
            {
                //FillAuthorList();
            }
        }
        */

    }
}