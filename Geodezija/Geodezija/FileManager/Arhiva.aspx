<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Arhiva.aspx.cs" Inherits="Geodezija.FileManager.Arhiva" %>

<%@ Register src="FileGrid.ascx" tagname="FileGrid" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        ARHIVA</h1>
    <uc2:FileGrid ID="FileGrid1" HomeFolder="~/Dokumenti" PageSize="10" runat="server"  />
    <h1>
        <br />
    </h1>
    </asp:Content>
