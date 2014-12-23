﻿
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;

namespace Geodezija
{
    public partial class User_Create : System.Web.UI.Page
    {
       
      

  void Page_Load(object sender, EventArgs e) {
    // disable the UI for annonymous user when the config switch is disable
    if (!Page.User.Identity.IsAuthenticated && String.Compare(ConfigurationManager.AppSettings["AllowUserCreationForAnonymousUsers"], "0") == 0) {
      noAccessMsg.Visible = true;
      CreateUserWizard1.Visible = false;
    }

    if (!Page.IsPostBack) {
      if (Page.User.IsInRole("Administrator")) {
        CreateUserWizard1.LoginCreatedUser = false;
        GroupName.SelectedValue = GetDefaultRoleForNewUser();
      }
    }
  }

  protected void AddUserToRole(string newUserName, string roleInformation) {
    switch (roleInformation) {
      case ("0"):
        Roles.AddUserToRole(newUserName, "Administrator");
        Roles.AddUserToRole(newUserName, "Manager");
        Roles.AddUserToRole(newUserName, "Pripravnik");
        break;

      case ("1"):
        Roles.AddUserToRole(newUserName, "Manager");
        Roles.AddUserToRole(CreateUserWizard1.UserName, "Pripravnik");
        break;

      default:
        Roles.AddUserToRole(CreateUserWizard1.UserName, "Pripravnik");
        break;
    }

  }

  protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e) {
    if (!Page.User.IsInRole("Administrator")) {
      AddUserToRole(CreateUserWizard1.UserName, GetDefaultRoleForNewUser());
      CreateUserWizard1.ActiveStepIndex = CreateUserWizard1.WizardSteps.IndexOf(CreateUserWizard1.CompleteStep);
    }

  }

  protected void Wizard_FinishButton_Click(object sender, WizardNavigationEventArgs e) {
    if (Page.User.IsInRole("Administrator")) {
      AddUserToRole(CreateUserWizard1.UserName, GroupName.SelectedValue);
    }
  }

  private string GetDefaultRoleForNewUser() {
    if (ConfigurationManager.AppSettings["DefaultRoleForNewUser"] == null) {
      throw (new Exception("DefaultRoleForNewUser was not been defined in the appsettings section of config"));

    }
    else {
      string defaultRole = ConfigurationManager.AppSettings["DefaultRoleForNewUser"];
      if (string.IsNullOrEmpty(defaultRole)) {
        throw (new Exception("DefaultRoleForNewUser does not contain a default value"));
      }
      else {
        if (string.Compare(defaultRole, "3") < 0 && string.Compare(defaultRole, "0") >= 0) {
          return (ConfigurationManager.AppSettings["DefaultRoleForNewUser"]);
        }
        else {
          throw (new ArgumentException("DefaultRoleForNewUser defined in the appsettings has to be between 0 and 2"));
        }
      }
    }
  }
    }
}