<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Loko.aspx.cs"  EnableEventValidation="false" Inherits="Geodezija.Loko" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
     <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>    
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
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
     <script type="text/javascript">
         $(function () {
             $.datepick.setDefaults($.datepick.regional['hr']);

             $('.DateTimePicker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
         });
       
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h3>
        PREGLED LOKO VOŽNJI U IZABRANOM RAZDOBLJU</h3>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
        EmptyDataText="There are no data records to display." ForeColor="#333333" 
        GridLines="None" 
        onrowcommand="GridView1_RowCommand" 
        >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="sifra"
                SortExpression="sifra" />
            <asp:BoundField DataField="datum" DataFormatString="{0:d}" HeaderText="datum" SortExpression="datum" />
            <asp:BoundField DataField="pocetna" HeaderText="pocetna" 
                SortExpression="pocetna" />
            <asp:BoundField DataField="dolazna" HeaderText="dolazna" 
                SortExpression="dolazna" />
            <asp:BoundField DataField="km" HeaderText="km" SortExpression="km" />
            <asp:BoundField DataField="relacija" HeaderText="relacija" 
                SortExpression="relacija" />
            <asp:BoundField DataField="iznos" HeaderText="iznos" SortExpression="iznos" DataFormatString="{0:#.00}"  />
            <asp:BoundField DataField="kreirao" HeaderText="kreirao"  
                SortExpression="kreirao" />
            <asp:BoundField DataField="izvjesce" HeaderText="izvjesce" 
                SortExpression="izvjesce" />
            <asp:BoundField DataField="vrijeme" HeaderText="vrijeme" 
                SortExpression="vrijeme" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    
                        <asp:Button ID="AddButton" runat="server" 
      CommandName="Kopiraj"  OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');" 
      CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
      Text="Kopiraj"  />
                </ItemTemplate>
                <ControlStyle CssClass="botuni" />
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        DeleteCommand="DELETE FROM [Loko] WHERE [sifra] = @sifra" 
        InsertCommand="INSERT INTO [Loko] ([datum], [pocetna], [dolazna], [km], [relacija], [auto], [vozac], [iznos], [dat_kreiranja], [dat_azu], [kreirao], [radnikID], [izvjesce], [vrijeme], [registracija]) VALUES (@datum, @pocetna, @dolazna, @km, @relacija, @auto, @vozac, @iznos, @dat_kreiranja, @dat_azu, @kreirao, @radnikID, @izvjesce, @vrijeme, @registracija)" 
        ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
        SelectCommand="SELECT sifra, datum, pocetna, dolazna, km, relacija, auto, vozac, iznos, dat_kreiranja, dat_azu, kreirao, radnikID, izvjesce, vrijeme, registracija FROM Loko WHERE (datum BETWEEN @od AND @do)" 
        UpdateCommand="UPDATE [Loko] SET [datum] = @datum, [pocetna] = @pocetna, [dolazna] = @dolazna, [km] = @km, [relacija] = @relacija, [auto] = @auto, [vozac] = @vozac, [iznos] = @iznos, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [kreirao] = @kreirao, [radnikID] = @radnikID, [izvjesce] = @izvjesce, [vrijeme] = @vrijeme, [registracija] = @registracija WHERE [sifra] = @sifra">
        <DeleteParameters>
            <asp:Parameter Name="sifra" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="datum" Type="DateTime" />
            <asp:Parameter Name="pocetna" Type="Decimal" />
            <asp:Parameter Name="dolazna" Type="Decimal" />
            <asp:Parameter Name="km" Type="Int32" />
            <asp:Parameter Name="relacija" Type="String" />
            <asp:Parameter Name="auto" Type="String" />
            <asp:Parameter Name="vozac" Type="String" />
            <asp:Parameter Name="iznos" Type="Decimal" />
            <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
            <asp:Parameter Name="dat_azu" Type="DateTime" />
            <asp:Parameter Name="kreirao" Type="String" />
            <asp:Parameter Name="radnikID" Type="Int32" />
            <asp:Parameter Name="izvjesce" Type="String" />
            <asp:Parameter Name="vrijeme" Type="String" />
            <asp:Parameter Name="registracija" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter DbType="DateTime" Name="od" QueryStringField="od" />
            <asp:QueryStringParameter DbType="DateTime" Name="do" QueryStringField="do" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="datum" Type="DateTime" />
            <asp:Parameter Name="pocetna" Type="Decimal" />
            <asp:Parameter Name="dolazna" Type="Decimal" />
            <asp:Parameter Name="km" Type="Int32" />
            <asp:Parameter Name="relacija" Type="String" />
            <asp:Parameter Name="auto" Type="String" />
            <asp:Parameter Name="vozac" Type="String" />
            <asp:Parameter Name="iznos" Type="Decimal" />
            <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
            <asp:Parameter Name="dat_azu" Type="DateTime" />
            <asp:Parameter Name="kreirao" Type="String" />
            <asp:Parameter Name="radnikID" Type="Int32" />
            <asp:Parameter Name="izvjesce" Type="String" />
            <asp:Parameter Name="vrijeme" Type="String" />
            <asp:Parameter Name="registracija" Type="String" />
            <asp:Parameter Name="sifra" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    &nbsp;
    <asp:Button ID="btnSveStranice" runat="server" onclick="btnSveStranice_Click" 
        Text="Ispis svih stranica" CssClass="botuni" />
&nbsp;
    <asp:Button ID="btnStranica" runat="server" onclick="btnStranica_Click" 
        Text=" Ispis aktivne stranice" CssClass="botuni" />
    &nbsp;
    <asp:Button ID="btnTerenski" runat="server" onclick="btnTerenski_Click" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li želite obračunati terensku vožnju?');"
        Text="Terenski" ToolTip="Pregled terenskih troškova u odabranom razdoblju" 
        CssClass="botuni" />
    &nbsp;
    
    <br />
    
    <asp:Label ID="lblStatus" runat="server" ForeColor="#CC0000"></asp:Label>
    <br />
    UREĐIVANJE ODABRANE LOKO VOŽNJE<br />
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
        CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource2" 
        ForeColor="#333333" GridLines="None" Height="50px" Width="125px" 
        AllowPaging="True" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="sifra" HeaderText="sifra" InsertVisible="False" 
                ReadOnly="True" SortExpression="sifra" />
            <asp:TemplateField HeaderText="datum" SortExpression="datum">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("datum", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="DateTimePicker" 
                        Text='<%# Bind("datum") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox1" Display="Dynamic" 
                        ErrorMessage="Datum je obavezno polje">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" CssClass="DateTimePicker" 
                        Text='<%# Bind("datum", "{0:d}") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox4" ErrorMessage="Datum je obavezno polje">*</asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="pocetna" SortExpression="pocetna">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("pocetna") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("pocetna") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEditPocetna" runat="server" 
                        ControlToValidate="TextBox2" 
                        ErrorMessage="Početna kilometraža je obavezno polje">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToValidate="TextBox2" ErrorMessage="Početna kilom. mora biti veća od 1" 
                        Operator="GreaterThan" Type="Currency" ValueToCompare="1">*</asp:CompareValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("pocetna") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInsertPocetna" runat="server" 
                        ControlToValidate="TextBox1" 
                        ErrorMessage="Početna kilometraža je obavezno polje">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" 
                        ControlToValidate="TextBox1" ErrorMessage="Početna kilom. mora biti veća od 1" 
                        Operator="GreaterThanEqual" Type="Currency" ValueToCompare="1">*</asp:CompareValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="dolazna" SortExpression="dolazna">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("dolazna") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("dolazna") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEditDol" runat="server" 
                        ControlToValidate="TextBox3" 
                        ErrorMessage="Dolazna kilometraža je obavezno polje">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dolazna") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInsDol" runat="server" 
                        ControlToValidate="TextBox2" 
                        ErrorMessage="Dolazna kilometraža je obavezno polje">*</asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="relacija" HeaderText="relacija" 
                SortExpression="relacija" />
            <asp:BoundField DataField="auto" HeaderText="auto" SortExpression="auto" />
            <asp:BoundField DataField="vozac" HeaderText="vozac" SortExpression="vozac" />
            <asp:TemplateField HeaderText="iznos" SortExpression="iznos">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("iznos", "{0:#.00}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("iznos") %>'></asp:TextBox>
                    <asp:CompareValidator ID="CompareValidator3" runat="server" 
                        ControlToValidate="TextBox5" 
                        ErrorMessage="Iznos mora biti veći ili jednak nuli, bez oznake valute" 
                        Operator="GreaterThanEqual" Type="Currency" ValueToCompare="0">*</asp:CompareValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" 
                        Text='<%# Bind("iznos", "{0:#.00}") %>'></asp:TextBox>
                    <asp:CompareValidator ID="CompareValidator4" runat="server" 
                        ControlToValidate="TextBox5" Display="Dynamic" 
                        ErrorMessage="Iznos mora biti veći ili jednak nuli, bez oznake valute" 
                        Operator="GreaterThanEqual" Type="Currency" ValueToCompare="0">*</asp:CompareValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="izvjesce" HeaderText="izvjesce" 
                SortExpression="izvjesce" />
            <asp:BoundField DataField="registracija" HeaderText="registracija" 
                SortExpression="registracija" />
            
            <asp:BoundField DataField="km" HeaderText="km" InsertVisible="False" 
                ReadOnly="True" SortExpression="km" />
            <asp:TemplateField HeaderText="vrijeme" SortExpression="vrijeme">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" 
                        CommandName="Edit" Text="Edit"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" 
                        CommandName="New" Text="New"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" 
                        CommandName="Delete" 
                        OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');" 
                        Text="Delete"></asp:LinkButton>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("vrijeme") %>'></asp:Label>
                
                </ItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("vrijeme") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("vrijeme") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEditVrijeme" runat="server" 
                        ControlToValidate="TextBox4" ErrorMessage="Vrijeme je obavezno polje">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("vrijeme") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInsVrijeme" runat="server" 
                        ControlToValidate="TextBox3" ErrorMessage="Vrijeme je obavezno polje">*</asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="dat_kreiranja" HeaderText="dat_kreiranja" ReadOnly="True" InsertVisible="False" DataFormatString="{0:d}"
                SortExpression="dat_kreiranja" />
            <asp:BoundField DataField="dat_azu" HeaderText="dat_azu" ReadOnly="True" InsertVisible="False" DataFormatString="{0:d}"
                SortExpression="dat_azu" />
            <asp:BoundField DataField="kreirao" HeaderText="kreirao" ReadOnly="True" InsertVisible="False" 
                SortExpression="kreirao" />
            <asp:BoundField DataField="radnikID" HeaderText="radnikID" 
                SortExpression="radnikID" />
            <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True"  OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                            CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True"  OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                            CommandName="Insert" Text="Insert"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" 
                            CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" 
                            CommandName="New" Text="New"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                            CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
        </Fields>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:DetailsView>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ForeColor="Red" />
    <br />
    <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        DeleteCommand="DELETE FROM [Loko] WHERE [sifra] = @sifra" 
        InsertCommand="INSERT INTO [Loko] ([datum], [pocetna], [dolazna], [km], [relacija], [auto], [vozac], [iznos], [dat_kreiranja], [dat_azu], [kreirao], [radnikID], [izvjesce], [vrijeme], [registracija]) VALUES (@datum, @pocetna, @dolazna, @km, @relacija, @auto, @vozac, @iznos, @dat_kreiranja, @dat_azu, @kreirao, @radnikID, @izvjesce, @vrijeme, @registracija)" 
        SelectCommand="SELECT * FROM [Loko] WHERE ([sifra] = @sifra)" 
        UpdateCommand="UPDATE [Loko] SET [datum] = @datum, [pocetna] = @pocetna, [dolazna] = @dolazna, [km] = @km, [relacija] = @relacija, [auto] = @auto, [vozac] = @vozac, [iznos] = @iznos, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [kreirao] = @kreirao, [radnikID] = @radnikID, [izvjesce] = @izvjesce, [vrijeme] = @vrijeme, [registracija] = @registracija WHERE [sifra] = @sifra">
        <DeleteParameters>
            <asp:Parameter Name="sifra" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="datum" Type="DateTime" />
            <asp:Parameter Name="pocetna" Type="Decimal" />
            <asp:Parameter Name="dolazna" Type="Decimal" />
            <asp:Parameter Name="km" Type="Int32" />
            <asp:Parameter Name="relacija" Type="String" />
            <asp:Parameter Name="auto" Type="String" />
            <asp:Parameter Name="vozac" Type="String" />
            <asp:Parameter Name="iznos" Type="Decimal" />
            <asp:ControlParameter Name="dat_kreiranja" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
            <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
          
            <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
            <asp:Parameter Name="radnikID" Type="Int32" />
            <asp:Parameter Name="izvjesce" Type="String" />
            <asp:Parameter Name="vrijeme" Type="String" />
            <asp:Parameter Name="registracija" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="sifra" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="datum" Type="DateTime" />
            <asp:Parameter Name="pocetna" Type="Decimal" />
            <asp:Parameter Name="dolazna" Type="Decimal" />
            <asp:Parameter Name="km" Type="Int32" />
            <asp:Parameter Name="relacija" Type="String" />
            <asp:Parameter Name="auto" Type="String" />
            <asp:Parameter Name="vozac" Type="String" />
            <asp:Parameter Name="iznos" Type="Decimal" />
            <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
            
            <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
             <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
            <asp:Parameter Name="radnikID" Type="Int32" />
            <asp:Parameter Name="izvjesce" Type="String" />
            <asp:Parameter Name="vrijeme" Type="String" />
            <asp:Parameter Name="registracija" Type="String" />
            <asp:Parameter Name="sifra" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Calendar ID="Calendar1" runat="server" FirstDayOfWeek="Monday" 
        Visible="False"></asp:Calendar>
</asp:Content>
