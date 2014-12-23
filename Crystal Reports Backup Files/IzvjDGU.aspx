<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IzvjDGU.aspx.cs" Inherits="Geodezija.Reports.IzvjDGU" %>
<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
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
        &nbsp;</p>
<p>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" 
            AutoDataBind="true" />
        
    </p>
<p>
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        </CR:CrystalReportSource>
    </p>
    </asp:Content>
