<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="IzvjDGUSva.aspx.cs" Inherits="Geodezija.Reports.IzvjDGUSva" %>

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
            <legend>IZVJEŠĆE ZA DGU</legend>
            <p>
                Odaberite razdoblje od:&nbsp;&nbsp;
                <asp:TextBox ID="txtOd" runat="server"></asp:TextBox>
                &nbsp;&nbsp; do
                <asp:TextBox ID="txtDo" runat="server"></asp:TextBox>
            </p>
            <p>
                &nbsp;</p>
            <p>
                <asp:DropDownList ID="ddlVrsta" runat="server" Height="20px" Width="176px">
                    <asp:ListItem Value="0">Odaberite vrstu izvješća</asp:ListItem>
                    <asp:ListItem Value="1">Br. ugovorenih poslova</asp:ListItem>
                    <asp:ListItem Value="3">Br. obavljenih poslova</asp:ListItem>
                    <asp:ListItem Value="2">Upisnik obavljanja djelatnosti</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Text="Pokreni" OnClick="Button1_Click1" CssClass="botuni" />
            </p>
            <p>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </p>
            <p>
                &nbsp;</p>
            <p>
            </p>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="#6699FF" Width="98%">
            </rsweb:ReportViewer>
        </fieldset>
    </div>
</asp:Content>
