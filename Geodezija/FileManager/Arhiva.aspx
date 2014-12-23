<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Arhiva.aspx.cs" Inherits="Geodezija.FileManager.Arhiva" %>

<%@ Register src="FileGrid.ascx" tagname="FileGrid" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div id="projectreport">
        <a name="content_start" id="content_start"></a>
         <br />
        <fieldset>
            
            <legend>ARHIVA DOKUMENATA</legend>
 <p>
 
 </p>
    <uc2:FileGrid ID="FileGrid1" HomeFolder="~/Dokumenti" PageSize="10" runat="server"  />
    <h1>
        <br />
    </h1>
     </fieldset>
    </div>
    </asp:Content>
