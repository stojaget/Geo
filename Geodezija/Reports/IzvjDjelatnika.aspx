﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="IzvjDjelatnika.aspx.cs" Inherits="Geodezija.Reports.IzvjDjelatnika" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="../Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="../Styles/style.css" />
    <script src="/Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="/Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="/Scripts/hajan.datevalidator.js"></script>
    <script type="text/javascript">
        $(function () {



            $("#<%= txtOd.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $.datepick.setDefaults($.datepick.regional['hr']);

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="projectreport">
        <a name="content_start" id="content_start"></a>
        <br />
        <fieldset>
            <h2 class="none">
                &nbsp;</h2>
            <legend>IZVJEŠĆA O RADU DJELATNIKA </legend>
            <br />
            <p>
                <asp:DropDownList ID="ddlVrsta" runat="server" Height="20px" Width="176px" OnSelectedIndexChanged="ddlVrsta_SelectedIndexChanged"
                    AutoPostBack="True">
                    <asp:ListItem Value="0">Odaberite vrstu izvješća</asp:ListItem>
                    <asp:ListItem Value="1">Loko vožnje po razdoblju</asp:ListItem>
                    <asp:ListItem Value="2">Terenski dodaci po razdoblju</asp:ListItem>
                    <asp:ListItem Value="3">Evidencija vremena po razdoblju</asp:ListItem>
                    <asp:ListItem Value="4">Loko vožnje po radniku</asp:ListItem>
                    <asp:ListItem Value="5">Terenski dodaci po radniku</asp:ListItem>
                    <asp:ListItem Value="6">Evidencija vremena po radniku</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Text="Pokreni" OnClick="Button1_Click1" CssClass="botuni" />
            </p>
            <p>
                &nbsp;<asp:Label ID="lblRaz" runat="server" Text="Odaberite razdoblje od:"></asp:Label>
                &nbsp;&nbsp;
                <asp:TextBox ID="txtOd" runat="server"></asp:TextBox>
                &nbsp;&nbsp; do
                <asp:TextBox ID="txtDo" runat="server"></asp:TextBox>
            </p>
            <p>
                &nbsp;</p>
            <p>
                <asp:Label ID="lblRadnik" runat="server" Text="Odaberite radnika:"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                <asp:DropDownList ID="ddlRadnik" runat="server" Height="16px" Width="167px" AppendDataBoundItems="True"
                    OnSelectedIndexChanged="ddlRadnik_SelectedIndexChanged">
                    <asp:ListItem Text="-- Odaberite vrijednost --" Value="-1"></asp:ListItem>
                </asp:DropDownList>
                </asp:DropDownList>
            </p>
            <p>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </p>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="#6699FF" Width="98%">
            </rsweb:ReportViewer>
        </fieldset>
    </div>
</asp:Content>
