<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="IzvjDGU.aspx.cs" Inherits="Geodezija.Reports.IzvjDGU" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="~/Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="~/Styles/style.css" />
    <script type="text/javascript" src="~/Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="~/Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="~/Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="~/Scripts/hajan.datevalidator.js"></script>
    <script type="text/javascript">
        $(function () {
            $.datepick.setDefaults($.datepick.regional['hr']);


            $("#<%= txtOd.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });


        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        IZVJEŠĆE ZA DGU</h1>
    <p>
        Odaberite razdoblje od:
        <asp:TextBox ID="txtOd" runat="server"></asp:TextBox>
        &nbsp;&nbsp; do
        <asp:TextBox ID="txtDo" runat="server"></asp:TextBox>
    </p>
    <p>
        <asp:DropDownList ID="ddlVrsta" runat="server" Height="20px" Width="176px">
            <asp:ListItem Value="0">Odaberite vrstu izvješća</asp:ListItem>
            <asp:ListItem Value="1">Br. predanih poslova</asp:ListItem>
            <asp:ListItem Value="2">Uk. ugovorenih poslova</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Pokreni" 
            onclick="Button1_Click1" />
    </p>
    <p>
        Ukupno ugovorenih poslova po djelatnostima</p>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
        PageZoomFactor="75" />
    <p>
        &nbsp;<p>
            Broj predanih poslova naručiteljima<p>
    &nbsp;</asp:Content>
