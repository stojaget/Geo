<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="404Greska.aspx.cs" Inherits="Geodezija._404Greska" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="server">
<br />
<h3 style="width: 1046px">
Ups...dogodila se greška u aplikaciji.
    Kliknite na sliku da se vratite na početnu stranicu :)
</h3>
    <h3>
        <br />
        <a href="Pocetna.aspx">
        <asp:Image ID="Image2" runat="server" Height="549px" 
            ImageUrl="~/Styles/images/404eror.jpg" Width="816px" />
            </a>
    </h3>
    <p>
    </p>
</asp:Content>
