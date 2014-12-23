<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjektiCRUD.aspx.cs" Inherits="Geodezija.ProjektiCRUD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="botuni.css" />
     <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>    
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
 <script type="text/javascript">
     $(function () {
         $.datepick.setDefaults($.datepick.regional['hr']);

         $("#<%= txtNarucen.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
         $("#<%= txtStigao.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
         $("#<%= txtDatUgov.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
         $("#<%= txtPredaja.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
         $("#<%= txtPotvrda.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });


     });
    </script>
    <script type="text/javascript">

        String.Format = function () {
            var s = arguments[0];
            for (var i = 0; i < arguments.length - 1; i++) {
                var reg = new RegExp("\\{" + i + "\\}", "gm");
                s = s.replace(reg, arguments[i + 1]);
            }
            return s;
        }

        var dialogConfirmed = false;
        function ConfirmDialog(obj, title, dialogText) {
            if (!dialogConfirmed) {
                $('body').append(String.Format("<div id='dialog' title='{0}'><p>{1}</p></div>",
                    title, dialogText));

                $('#dialog').dialog
                ({
                    height: 140,
                    modal: true,
                    resizable: false,
                    draggable: false,
                    close: function (event, ui) { $('body').find('#dialog').remove(); },
                    buttons:
                    {
                        'Da': function () {
                            $(this).dialog('close');
                            dialogConfirmed = true;
                            if (obj) obj.click();
                        },
                        'Ne': function () {
                            $(this).dialog('close');
                        }
                    }
                });
            }

            return dialogConfirmed;
        }
    </script>
    <style type="text/css">
        .style1
        {
            width: 187px;
        }
        .style2
        {
            text-align: center;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="style2">
        detaljni pregled podataka o predmetu</h3>
    <table class="ui-accordion">
        <tr>
            <td class="style1">
                Šifra:</td>
            <td>
                <asp:TextBox ID="txtSifra" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Naziv projekta:</td>
            <td>
                <asp:TextBox ID="txtNaziv" runat="server" Width="281px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNaziv" runat="server" 
                    ControlToValidate="txtNaziv" ErrorMessage="Naziv je obavezno polje" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Arhivski broj:</td>
            <td>
                <asp:TextBox ID="txtArhivski" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Status:</td>
            <td>
                <asp:DropDownList ID="ddlStatus" runat="server" Height="16px" Width="170px" 
                    AppendDataBoundItems="True" AutoPostBack="True" >
                    
                <asp:ListItem Text="-- Odaberite vrijednost --" Value ="-1"></asp:ListItem>
                </asp:DropDownList>
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToValidate="ddlStatus" Display="Dynamic" 
                    ErrorMessage="Morate odabrati status predmeta" Operator="NotEqual" 
                    SetFocusOnError="True" ValueToCompare="-1">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Vrsta posla:</td>
            <td>
                <asp:DropDownList ID="ddlVrsta" runat="server" Height="17px" Width="171px" 
                    AppendDataBoundItems="True" AutoPostBack="True">
                <asp:ListItem Text="-- Odaberite vrijednost --" Value ="-1"></asp:ListItem>
                </asp:DropDownList>
                <asp:CompareValidator ID="CompareValidator2" runat="server" Display="Dynamic" 
                    ErrorMessage="Morate odabrati vrstu posla" Operator="NotEqual" 
                    ValueToCompare="-1" ControlToValidate="ddlVrsta">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Kat. općina:</td>
            <td>
                <asp:TextBox ID="txtKatOpc" runat="server" Width="281px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtKatOpc" Display="Dynamic" 
                    ErrorMessage="Kat. općina je obavezno polje">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Kat. čestica:</td>
            <td>
                <asp:TextBox ID="txtCestica" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Naručitelj:</td>
            <td>
                <asp:DropDownList ID="ddlKlijent" runat="server" Height="16px" Width="173px" 
                    AppendDataBoundItems="True" AutoPostBack="True">
                 <asp:ListItem Text="-- Odaberite vrijednost --" Value ="-1"></asp:ListItem>
                </asp:DropDownList>
                <asp:CompareValidator ID="CompareValidator3" runat="server" 
                    ControlToValidate="ddlKlijent" ErrorMessage="Morate odabrati naručitelja" 
                    Operator="NotEqual" ValueToCompare="-1">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Odgovorna osoba:</td>
            <td>
                <asp:TextBox ID="txtKreirao" runat="server" Width="281px" ReadOnly="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Naručen katastar:</td>
            <td>
                <asp:TextBox ID="txtNarucen" runat="server" class="field" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Stigli podaci:</td>
            <td>
                <asp:TextBox ID="txtStigao" runat="server" class="field" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Cijena katastar:</td>
            <td>
                <asp:TextBox ID="txtKatCijena" runat="server" Width="281px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="txtKatCijena" Display="Dynamic" 
                    ErrorMessage="Cijena mora imati decimalni oblik, npr. 12.345" 
                    ValidationExpression="^\d+(\.\d\d)">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Dat. ugovora:</td>
            <td>
                <asp:TextBox ID="txtDatUgov" runat="server" class="field" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Dat. predaje:</td>
            <td>
                <asp:TextBox ID="txtPredaja" runat="server" class="field" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Dat. potvrde:</td>
            <td>
                <asp:TextBox ID="txtPotvrda" runat="server" class="field" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Ugov. iznos:</td>
            <td>
                <asp:TextBox ID="txtIznos" runat="server" Width="281px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="txtIznos" ErrorMessage="Cijena mora imati decimalni oblik" 
                    ValidationExpression="^\d+(\.\d\d)">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Iznos fakture:</td>
            <td>
                <asp:TextBox ID="txtIznFakt" runat="server" Width="281px" 
                    ></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                    ControlToValidate="txtIznFakt" ErrorMessage="Cijena mora imati decimalni oblik" 
                    ValidationExpression="^\d+(\.\d\d)">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                DGU klasa:</td>
            <td>
                <asp:TextBox ID="txtKlasa" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                DGU urudžbeni:</td>
            <td>
                <asp:TextBox ID="txtUrud" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Teren:</td>
            <td>
                <asp:TextBox ID="txtTeren" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Faktura:</td>
            <td>
                <asp:TextBox ID="txtFaktura" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Ponuda/ nar.:</td>
            <td>
                <asp:TextBox ID="txtPonNar" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Opis plaćanja:</td>
            <td>
                <asp:TextBox ID="txtPlacanje" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Plaćeno:</td>
            <td>
                <asp:CheckBox ID="chkPlaceno" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="style1">
                Lova:</td>
            <td>
                <asp:TextBox ID="txtLova" runat="server" Width="281px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                    ControlToValidate="txtLova" ErrorMessage="Cijena mora imati decimalni oblik" 
                    ValidationExpression="^\d+(\.\d\d)">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Putanja projekt:</td>
            <td>
                <asp:TextBox ID="txtPutProj" runat="server" Width="281px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Putanja ponuda:</td>
            <td>
                <asp:TextBox ID="txtPutPon" runat="server" Width="281px"></asp:TextBox>
            &nbsp;
                <asp:Button ID="btnPonuda" runat="server" Height="21px" 
                    onclick="btnPonuda_Click" Text="Kreiraj ponudu" CssClass="botuni" 
                    Width="139px" />
            </td>
        </tr>
        <tr>
            <td class="style1">
                Putanja faktura:</td>
            <td>
                <asp:TextBox ID="txtPutFakt" runat="server" Width="281px"></asp:TextBox>
            &nbsp;
                <asp:Button ID="btnFaktura" runat="server" Height="21px" 
                    onclick="btnFaktura_Click" Text="Kreiraj fakturu" Width="140px" 
                    CssClass="botuni" />
            </td>
        </tr>
        <tr>
            <td class="style1">
                Dat. kreiranja:</td>
            <td>
                <asp:TextBox ID="txtDatKreir" runat="server" Width="281px" ReadOnly="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Dat. ažuriranja:</td>
            <td>
                <asp:TextBox ID="txtDatAzu" runat="server" Width="281px" ReadOnly="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
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
                &nbsp;</td>
            <td>
                <asp:Button ID="btnSpremi" runat="server" Text="Promijeni" Width="81px" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite spremiti zapis?');"
                    onclick="btnSpremi_Click" CssClass="botuni" />
&nbsp;
                <asp:Button ID="btnBrisi" runat="server" Text="Briši" width="81px" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                    onclick="btnBrisi_Click" CssClass="botuni" />
&nbsp;
                <asp:Button ID="btnNovi" runat="server" Text="Novi" width="81px" 
                    onclick="btnNovi_Click" CssClass="botuni" />
            &nbsp;
                <asp:Button ID="btnUnos" runat="server" Text="Unos" width="81px" 
                    onclick="btnUnos_Click" CssClass="botuni" />
            &nbsp;
                <asp:Button ID="btnPovratak" runat="server" Text="Povratak" width="81px" 
                    onclick="btnPovratak_Click" CssClass="botuni" />
            </td>
        </tr>
    </table>
    <p>
        <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    </p>
<h3>
        PREGLED BILJEŠKI ZA ODABRANI PREDMET</h3>
<p>
        <asp:GridView ID="gvBiljeskeProj" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
            DataSourceID="SqlDataSource1" DataKeyNames="sifra"
            EmptyDataText="There are no data records to display." ForeColor="#333333" 
            GridLines="None" Width="560px" 
            onselectedindexchanged="gvBiljeskeProj_SelectedIndexChanged" PageSize="5">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="sifra" HeaderText="sifra" ReadOnly="True" 
                    SortExpression="sifra" InsertVisible="False" />
                <asp:BoundField DataField="datum" HeaderText="datum" SortExpression="datum" DataFormatString="{0:d}" />
                <asp:BoundField DataField="opis" HeaderText="opis" SortExpression="opis" ItemStyle-Width="30%" />
                <asp:BoundField DataField="projektID" HeaderText="projektID" 
                    SortExpression="projektID" />
                <asp:BoundField DataField="unio" HeaderText="unio" SortExpression="unio" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
            
            SelectCommand="SELECT [sifra], [datum], [opis], [projektID], [unio] FROM [Biljeske] WHERE ([projektID] = @projektID) ORDER BY [datum] DESC">
            <SelectParameters>
                <asp:QueryStringParameter Name="projektID" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
<p>
        &nbsp;</p>
</asp:Content>
