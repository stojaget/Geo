<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IzvjDjelatnika.aspx.cs" Inherits="Geodezija.Reports.IzvjDjelatnika" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="../Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="../Styles/style.css" />
    <script type="text/javascript" src="/Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="/Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="/Scripts/hajan.datevalidator.js"></script>
    <script type="text/javascript">
        $(function () {
            $.datepick.setDefaults($.datepick.regional['hr']);


            $("#<%= txtOd.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });


        });
    </script>
    <style type="text/css">
        .style1
        {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
 <p>
        <asp:DropDownList ID="ddlVrsta" runat="server" Height="20px" Width="176px" 
            onselectedindexchanged="ddlVrsta_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem Value="0">Odaberite vrstu izvješća</asp:ListItem>
            <asp:ListItem Value="1">Loko vožnje po razdoblju</asp:ListItem>
            <asp:ListItem Value="2">Terenski dodaci po razdoblju</asp:ListItem>
<asp:ListItem Value="3">Evidencija vremena po razdoblju</asp:ListItem>
            <asp:ListItem Value="4">Loko vožnje po radniku</asp:ListItem>
            <asp:ListItem Value="5">Terenski dodaci po radniku</asp:ListItem>
            
            <asp:ListItem Value="6">Evidencija vremena po radniku</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Pokreni" 
            onclick="Button1_Click1" CssClass="botuni" />
    </p>
 <p>
        &nbsp;<asp:Label ID="lblRaz" runat="server" Text="Odaberite razdoblje od:"></asp:Label>
&nbsp;&nbsp;
        <asp:TextBox ID="txtOd" runat="server"></asp:TextBox>
        &nbsp;&nbsp; do
        <asp:TextBox ID="txtDo" runat="server"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="lblRadnik" runat="server" Text="Odaberite radnika:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
        <asp:DropDownList ID="ddlRadnik" runat="server" Height="16px" Width="167px" 
            AppendDataBoundItems="True" 
            onselectedindexchanged="ddlRadnik_SelectedIndexChanged">
         <asp:ListItem Text="-- Odaberite vrijednost --" Value ="-1"></asp:ListItem>
                </asp:DropDownList>
        </asp:DropDownList>
    </p>

   
<p>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    </p>
<rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="#6699FF" 
    Width="911px">
</rsweb:ReportViewer>
</asp:Content>
