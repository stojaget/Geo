<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Uplatnica.aspx.cs" Inherits="Geodezija.Uplatnica" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
    <script type="text/javascript">
        $(function () {

            $("#<%= txtDatum.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $.datepick.setDefaults($.datepick.regional['hr']); 
        });
    </script>
    <style type="text/css">
        *
        {
            margin: 0;
        }
        
        .style1
        {
            width: 187px;
        }
        
        input.field
        {
            width: 110px;
            border: 1px solid black;
            padding: 1px;
            background-color: #fff;
        }
        
        .style3
        {
            width: 187px;
            height: 20px;
        }
        .style4
        {
            height: 20px;
        }
        .style5
        {
            width: 187px;
            height: 17px;
        }
        .style6
        {
            height: 17px;
        }
        .style7
        {
            width: 187px;
            height: 26px;
        }
        .style8
        {
            height: 26px;
        }
        .style9
        {
            color: #FF0000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="projectreport">
        <a name="content_start" id="content_start"></a>
        <br />
        <fieldset>
            <h2 class="none">
                &nbsp;</h2>
            <legend>PREGLED PODATAKA ZA KREIRANJE UPLATNICE </legend>
            <p>
            </p>
            <table class="ui-accordion">
                <tr>
                    <td class="style5">
                        Naziv projekta:
                    </td>
                    <td class="style6">
                        <asp:TextBox ID="txtNaziv" runat="server" Width="279px" ReadOnly="True" CssClass="textbox"
                            Height="28px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style7">
                        Arhivski broj:
                    </td>
                    <td class="style8">
                        <asp:TextBox ID="txtArhivski" runat="server" Width="281px" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Ugov. iznos:
                    </td>
                    <td>
                        <asp:TextBox ID="txtIznos" runat="server" Width="281px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style7">
                        Iznos fakture:
                    </td>
                    <td class="style8">
                        <asp:TextBox ID="txtIznFakt" runat="server" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Plaćeno:
                    </td>
                    <td>
                        <asp:CheckBox ID="chkPlaceno" runat="server" Enabled="False" />
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Cijena katastar:
                    </td>
                    <td>
                        <asp:TextBox ID="txtKatCijena" runat="server" Width="281px" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Lova:
                    </td>
                    <td>
                        <asp:TextBox ID="txtLova" runat="server" Width="281px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Naručitelj:
                    </td>
                    <td>
                        <asp:TextBox ID="txtNarucitelj" runat="server" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="txtNarSifra" runat="server" Visible="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Nar. grad:
                    </td>
                    <td>
                        <asp:TextBox ID="txtGrad" runat="server" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Nar. adresa:
                    </td>
                    <td>
                        <asp:TextBox ID="txtAdresa" runat="server" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Nar. tekući:
                    </td>
                    <td>
                        <asp:TextBox ID="txtTekuci" runat="server" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Nar. žiro račun/IBAN:
                    </td>
                    <td>
                        <asp:TextBox ID="txtZiro" runat="server" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Opis plaćanja:
                    </td>
                    <td>
                        <asp:TextBox ID="txtOpisPlacanja" runat="server" Width="281px" Height="60px" TextMode="MultiLine"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Datum:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDatum" runat="server" class="field" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        Primatelj- model
                    </td>
                    <td class="style4">
                        <asp:TextBox ID="txtModelPrimatelja" runat="server" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        Primatelj- poziv na broj&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtPozivPrimatelja" runat="server" Width="281px"></asp:TextBox>
                        &nbsp;<span class="style9">***</span>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                        <asp:Button ID="Button1" runat="server" CssClass="botuni" Height="26px" OnClick="Button1_Click"
                            Text="Kreiraj" Width="93px" />
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        &nbsp;
                    </td>
                    <td>
                        <asp:ValidationSummary ID="vsProjekt" runat="server" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                    </td>
                    <td class="style4">
                        <asp:Label ID="lblStatus" runat="server" ForeColor="#990000"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
</asp:Content>
