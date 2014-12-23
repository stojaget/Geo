<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Vrijeme.aspx.cs" Inherits="Geodezija.Vrijeme" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.blockUI.js"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
     <script type="text/javascript">
         $(function () {
             $("[id*=GridView1] td").hover(function () {
                 $("td", $(this).closest("tr")).addClass("hover_row");
             }, function () {
                 $("td", $(this).closest("tr")).removeClass("hover_row");
             });
         });
    </script>
    <script type="text/javascript">
        function ShowPopup() {
            $('#mask').show();
            $('#<%=pnlpopup.ClientID %>').show();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#<%=pnlpopup.ClientID %>').hide();
        }
        $(".btnClose").live('click', function () {
            HidePopup();
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
                    height: 190,
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
    <script type="text/javascript">
        $(function () {
            $.datepick.setDefaults($.datepick.regional['hr']);

            $('.Picker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
        });
       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="projectreport">
        <a name="content_start" id="content_start"></a>
        <br />
        <fieldset>
            <h2 class="none">
               
            </h2>
            <legend>PREGLED RADNOG VREMENA</legend>
            <p style="width: 808px">
            </p>
           
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataKeyNames="sifra" DataSourceID="SqlDataSource1"
                        EmptyDataText="There are no data records to display." OnRowCommand="GridView1_RowCommand"
                        CssClass="CustomView" CellPadding="4" ForeColor="#333333" GridLines="None" Height="50%"
                        Width="80%">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <EmptyDataTemplate>
                            <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka" ImageUrl="~/Styles/images/icon-save.gif"
                                runat="server" />
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra" />
                            <asp:BoundField DataField="datum" HeaderText="Datum" SortExpression="datum" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="dolazak" HeaderText="Dolazak" SortExpression="dolazak" />
                            <asp:BoundField DataField="odlazak" HeaderText="Odlazak" SortExpression="odlazak" />
                            <asp:CheckBoxField DataField="blagdan" HeaderText="Blagdan" SortExpression="blagdan" />
                            <asp:CheckBoxField DataField="godisnji" HeaderText="Godišnji" SortExpression="godisnji" />
                            <asp:CheckBoxField DataField="bolovanje" HeaderText="Bolovanje" SortExpression="bolovanje" />
                            <asp:BoundField DataField="radnikID" HeaderText="Radnik ID" SortExpression="radnikID" />
                            <asp:BoundField DataField="sati" HeaderText="Sati" SortExpression="sati" ReadOnly="True" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Button ID="AddButton" runat="server" ClientIDMode="Static" CommandName="Kopiraj"
                                        OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Kopiraj" />
                                </ItemTemplate>
                                <ControlStyle CssClass="botuni" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkKopiraj" runat="server" CommandName="MKopiraj"  CommandArgument='<%#Eval("sifra") %>'
                                        Text="Kopiraj više" ForeColor="blue">
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
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
                    <asp:Panel ID="pnlpopup" runat="server" CssClass="modalPopup" Style="display: none">
                        <asp:Label Font-Bold="true" ID="Label4" runat="server" Text="Kopiranje više evidencija"></asp:Label>
                        <br />
                        <table align="center">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="Odaberite datume"></asp:Label>
                                </td>
                                <td>
                                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black"
                                        Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="250px" NextPrevFormat="ShortMonth"
                                        OnPreRender="Calendar1_PreRender" Width="330px" OnSelectionChanged="Calendar1_SelectionChanged"
                                        BorderStyle="Solid" CellSpacing="1">
                                        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                                        <DayStyle BackColor="#CCCCCC" />
                                        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="White" />
                                        <OtherMonthDayStyle ForeColor="#999999" />
                                        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                        <TitleStyle BackColor="#333399" Font-Bold="True" Font-Size="12pt" ForeColor="White"
                                            BorderStyle="Solid" Height="12pt" />
                                        <TodayDayStyle BackColor="#999999" ForeColor="White" />
                                    </asp:Calendar>
                                </td>
                                 <td>
                                    <asp:Label ID="lblPor" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <td>
                                <asp:Button ID="btnSave" runat="server" Text="Spremi" OnClick="VisestrukoKopiraj" />
                            </td>
                            <td>
                                <asp:Button ID="btnCancel" runat="server" Text="Otkaži" OnClientClick="return Hidepopup()" />
                            </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:LinkButton ID="lnkFake" runat="server"></asp:LinkButton>
                   
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Evid_vrijeme] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID, @sati)"
                ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                SelectCommand="SELECT [sifra], [datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati] FROM [Evid_vrijeme] ORDER BY DATUM DESC"
                UpdateCommand="UPDATE [Evid_vrijeme] SET [datum] = @datum, [dolazak] = @dolazak, [odlazak] = @odlazak, [blagdan] = @blagdan, [godisnji] = @godisnji, [bolovanje] = @bolovanje, [napomena] = @napomena, [radnikID] = @radnikID, [sati] = @sati WHERE [sifra] = @sifra">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="dolazak" Type="Decimal" />
                    <asp:Parameter Name="odlazak" Type="Decimal" />
                    <asp:Parameter Name="blagdan" Type="Boolean" />
                    <asp:Parameter Name="godisnji" Type="Boolean" />
                    <asp:Parameter Name="bolovanje" Type="Boolean" />
                    <asp:Parameter Name="napomena" Type="String" />
                    <asp:Parameter Name="radnikID" Type="Int32" />
                    <asp:Parameter Name="sati" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="dolazak" Type="Decimal" />
                    <asp:Parameter Name="odlazak" Type="Decimal" />
                    <asp:Parameter Name="blagdan" Type="Boolean" />
                    <asp:Parameter Name="godisnji" Type="Boolean" />
                    <asp:Parameter Name="bolovanje" Type="Boolean" />
                    <asp:Parameter Name="napomena" Type="String" />
                    <asp:Parameter Name="radnikID" Type="Int32" />
                    <asp:Parameter Name="sati" Type="Decimal" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
            &nbsp;
            <asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
            &nbsp;
            <asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />
            &nbsp;&nbsp;
            
            <br />
            <br />
            <p style="width: 772px; height: 9px;">
                UREĐIVANJE PODATAKA ZA ODABRANU EVIDENCIJU VREMENA
                <p style="width: 783px">
                    &nbsp;</p>
                <p style="width: 559px">
                    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="3"
                        DataKeyNames="sifra" DataSourceID="SqlDataSource2" GridLines="Horizontal" Height="159px"
                        Width="125px" OnItemCreated="DetailsView1_ItemCreated" OnItemDeleted="DetailsView1_ItemDeleted"
                        OnItemInserted="DetailsView1_ItemInserted" OnItemUpdated="DetailsView1_ItemUpdated"
                        OnItemUpdating="DetailsView1_ItemUpdating" OnItemInserting="DetailsView1_ItemInserting"
                        BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px">
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                        <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <EmptyDataTemplate>
                            <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                                Text="Dodaj evidenciju"></asp:LinkButton>
                        </EmptyDataTemplate>
                        <Fields>
                            <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                SortExpression="sifra" />
                            <asp:TemplateField HeaderText="Datum" SortExpression="datum" />
                            <asp:TemplateField HeaderText="Djelatnik" SortExpression="Djelatnik">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="odsOdg" DataTextField="UserName"
                                        DataValueField="sifra">
                                    </asp:DropDownList>
                                    <asp:ObjectDataSource ID="odsOdg" runat="server" SelectMethod="DohvatiUsername" TypeName="Geodezija.Helper">
                                    </asp:ObjectDataSource>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="ObjectDataSource2" DataTextField="UserName"
                                        DataValueField="sifra">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="DohvatiUsername"
                                        TypeName="Geodezija.Helper"></asp:ObjectDataSource>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label21" runat="server" Text='<%# Bind("radnikID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Datum" SortExpression="Datum">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="Picker" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'
                                        CssClass="Picker"></asp:TextBox>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dolazak" SortExpression="dolazak">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2"
                                        ErrorMessage="Unos mora biti u decimalnom obliku" SetFocusOnError="True" ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2"
                                        ErrorMessage="Unos mora biti decimalnog oblika" ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("dolazak") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Odlazak" SortExpression="odlazak">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox3"
                                        ErrorMessage="Unos mora biti decimalni broj" ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox3"
                                        ErrorMessage="Unos mora biti decimalni broj" ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("odlazak") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sati" SortExpression="sati">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("sati") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" ReadOnly="True" Text='<%# Bind("sati") %>'></asp:Label>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox4" ReadOnly="True" runat="server" Text='<%# Bind("sati") %>'></asp:TextBox>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Blagdan" SortExpression="blagdan">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("blagdan") %>' ReadOnly="True"
                                        AutoPostBack="true" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("blagdan") %>' />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("blagdan") %>' AutoPostBack="true" />
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Godišnji" SortExpression="godisnji">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("godisnji") %>' ReadOnly="True"
                                        AutoPostBack="true" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("godisnji") %>' />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("godisnji") %>' AutoPostBack="true" />
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bolovanje" SortExpression="bolovanje">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox3" runat="server" ReadOnly="True" Checked='<%# Bind("bolovanje") %>'
                                        AutoPostBack="true" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("bolovanje") %>' />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("bolovanje") %>' AutoPostBack="true" />
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="napomena" HeaderText="Napomena" SortExpression="napomena" />
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Update"
                                        OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                        Text="Update"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" CommandName="Insert"
                                        OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                        Text="Insert"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Cancel"></asp:LinkButton>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" CommandName="Edit"
                                        Text="Edit"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="True" CommandName="New"
                                        Text="New"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" CommandName="Delete"
                                        OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                                        Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    </asp:DetailsView>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" BackColor="White" ForeColor="Red"
                        Width="892px" Height="31px" />
                    <p style="width: 474px; height: 95px;">
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConflictDetection="CompareAllValues"
                            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" DeleteCommand="DELETE FROM [Evid_vrijeme] WHERE [sifra] = @original_sifra"
                            InsertCommand="INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID, @sati)"
                            OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Evid_vrijeme] WHERE ([sifra] = @sifra)"
                            UpdateCommand="UPDATE [Evid_vrijeme] SET [datum] = @datum, [dolazak] = @dolazak, [odlazak] = @odlazak, [blagdan] = @blagdan, [godisnji] = @godisnji, [bolovanje] = @bolovanje, [napomena] = @napomena, [radnikID] = @radnikID, [sati] = @sati WHERE [sifra] = @original_sifra">
                            <DeleteParameters>
                                <asp:Parameter Name="original_sifra" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="datum" Type="DateTime" />
                                <asp:Parameter Name="dolazak" Type="Decimal" />
                                <asp:Parameter Name="odlazak" Type="Decimal" />
                                <asp:Parameter Name="blagdan" Type="Boolean" />
                                <asp:Parameter Name="godisnji" Type="Boolean" />
                                <asp:Parameter Name="bolovanje" Type="Boolean" />
                                <asp:Parameter Name="napomena" Type="String" />
                                <asp:ControlParameter Name="radnikID" Type="Int32" ControlID="DetailsView1$ddlOdg"
                                    PropertyName="SelectedItem.Value" />
                                <asp:Parameter Name="sati" Type="Decimal" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="sifra" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="datum" Type="DateTime" />
                                <asp:Parameter Name="dolazak" Type="Decimal" />
                                <asp:Parameter Name="odlazak" Type="Decimal" />
                                <asp:Parameter Name="blagdan" Type="Boolean" />
                                <asp:Parameter Name="godisnji" Type="Boolean" />
                                <asp:Parameter Name="bolovanje" Type="Boolean" />
                                <asp:Parameter Name="napomena" Type="String" />
                                <asp:ControlParameter Name="radnikID" Type="Int32" ControlID="DetailsView1$ddlOdg"
                                    PropertyName="SelectedItem.Value" />
                                <asp:Parameter Name="sati" Type="Decimal" />
                                <asp:Parameter Name="original_sifra" Type="Int32" />
                                <asp:Parameter Name="original_datum" Type="DateTime" />
                                <asp:Parameter Name="original_dolazak" Type="Decimal" />
                                <asp:Parameter Name="original_odlazak" Type="Decimal" />
                                <asp:Parameter Name="original_blagdan" Type="Boolean" />
                                <asp:Parameter Name="original_godisnji" Type="Boolean" />
                                <asp:Parameter Name="original_bolovanje" Type="Boolean" />
                                <asp:Parameter Name="original_napomena" Type="String" />
                                <asp:Parameter Name="original_radnikID" Type="Int32" />
                                <asp:Parameter Name="original_sati" Type="Decimal" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:Label ID="lbl" runat="server" Text="0.00" Visible="False"></asp:Label>
                        <asp:Label ID="lblStatus" runat="server" ForeColor="#CC0000"></asp:Label>
                        <br />
                        <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
        </fieldset>
    </div>
</asp:Content>


