<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Geodezija.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .failureNotification
        {}
        .submitButton
        {
            width: 554px;
        }
        .style1
        {
            text-align: justify;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="adminedit">
        <a name="content_start" id="content_start"></a>
         <br />
        <fieldset>
            <h2 class="none">
                &nbsp;</h2>
            <legend> ULAZ U APLIKACIJU</legend>
    <p style="width: 512px">
        
        <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="False" 
            Font-Bold="True" Font-Size="Larger">Registracija </asp:HyperLink> ako nemate korisnički račun
    </p>
    &nbsp;<asp:Login ID="LoginUser" runat="server" EnableViewState="False" 
        MembershipProvider="AspNetSqlMembershipProvider" BackColor="White" 
        BorderColor="Red" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" 
        DestinationPageUrl="~/Projekti.aspx" Font-Names="Verdana" Font-Size="1.0em" 
        ForeColor="#333333" Width="98px" onauthenticate="LoginUser_Authenticate" 
        Height="400px">
        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
        <LayoutTemplate>
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
           
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                 ValidationGroup="LoginUserValidationGroup" Height="24px" Width="613px"/>
                 <br />
                 <br />
            <div class="accountInfo">
                <fieldset class="login">
                    <legend>KORISNIČKI PODACI</legend>
                    <p style="width: 405px">
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                        <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                             CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p style="width: 70%; height: 28px;" class="style1">
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                        &nbsp;<asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                             CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p style="width: 404px">
                        <asp:CheckBox ID="RememberMe" runat="server"/>
                        <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline">Keep me logged in</asp:Label>
                    </p>
                </fieldset>
                <p class="submitButton">
                    &nbsp;<asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" 
                        ValidationGroup="LoginUserValidationGroup" onclick="LoginButton_Click" 
                        CssClass="botuni" />
                </p>
            </div>
        </LayoutTemplate>
        <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" 
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
        <TextBoxStyle Font-Size="0.8em" />
        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" 
            ForeColor="White" />
    </asp:Login>
     </fieldset>
    </div>
</asp:Content>

