<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Arhiva.aspx.cs" Inherits="Geodezija.FileManager.Arhiva" %>
<%@ Register src="..\FileManager\FileGridCS.ascx" tagname="FileGridCS" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        ARHIVA<br />
    </h1>
    <uc1:FileGridCS ID="FileGridCS1" HomeFolder="~/Content" runat="server" PageSize="10" />
</asp:Content>
