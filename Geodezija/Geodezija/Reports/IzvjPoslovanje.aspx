<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IzvjPoslovanje.aspx.cs" Inherits="Geodezija.Reports.IzvjPoslovanje" %>
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
 <h1 class="style1">
        IZVJEŠĆA O POSLOVANJU</h1>
    <p class="style1">
        &nbsp;</p>
    <p>
        Odaberite razdoblje od:
        <asp:TextBox ID="txtOd" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp; do
        <asp:TextBox ID="txtDo" runat="server"></asp:TextBox>
    </p>
    <p>
        <asp:DropDownList ID="ddlVrsta" runat="server" Height="20px" Width="176px">
            <asp:ListItem Value="0">Odaberite vrstu izvješća</asp:ListItem>
            <asp:ListItem Value="1">Popis klijenata po razdoblju</asp:ListItem>
            <asp:ListItem Value="2">Predani neplaćeni predmeti</asp:ListItem>
            <asp:ListItem Value="3">Predani plaćeni predmeti</asp:ListItem>
            <asp:ListItem Value="4">Ugovoreni neplaćeni predmeti</asp:ListItem>
            <asp:ListItem Value="5">Ugovoreni plaćeni predmeti</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Pokreni" 
            onclick="Button1_Click1" CssClass="botuni" />
    </p>
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="#6699FF" 
        Width="906px">
    </rsweb:ReportViewer>
    <p>
        &nbsp;</p>
</asp:Content>
