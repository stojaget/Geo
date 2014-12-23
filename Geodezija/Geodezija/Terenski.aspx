<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation ="false"
CodeBehind="Terenski.aspx.cs" Inherits="Geodezija.Terenski" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
     <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>    
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
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

            $('.Picker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
        });
       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <br />
        PREGLED TERENSKIH TROŠKOVA ZA IZABRANO RAZDOBLJE</p>
    <p>
        <asp:GridView ID="gvTerenski" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
            DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
            EmptyDataText="There are no data records to display." ForeColor="#333333" 
            GridLines="None" onrowcommand="gvTerenski_RowCommand">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" 
                    SortExpression="sifra" />
                <asp:BoundField DataField="datum" HeaderText="Datum" SortExpression="datum" 
                    DataFormatString="{0:d}" />
                <asp:BoundField DataField="iznos" HeaderText="Iznos" SortExpression="iznos" 
                    DataFormatString="{0:#.00}" />
                <asp:BoundField DataField="odlazak" HeaderText="Odlazak" 
                    SortExpression="odlazak" />
                <asp:BoundField DataField="dolazak" HeaderText="Dolazak" 
                    SortExpression="dolazak" />
                <asp:BoundField DataField="sati" HeaderText="Sati" SortExpression="sati" />
                <asp:BoundField DataField="radnikID" HeaderText="Radnik ID" 
                    SortExpression="radnikID" />
                <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
                <asp:BoundField DataField="vrsta" HeaderText="Vrsta" SortExpression="vrsta" />
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
    </p>
    <p>
        <asp:ImageButton ID="btnPdf" runat="server" Height="45px" 
            ImageUrl="~/Styles/images/pdf_icon.gif" onclick="btnPdf_Click" 
            ToolTip="Izvoz u PDF" Width="52px" />
    <asp:ImageButton ID="btnExcel" runat="server" Height="45px" 
        ImageUrl="~/Styles/images/excel_lrg.png" onclick="ExportToExcel" 
        ToolTip="Izvoz u Excel" Width="49px" />
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            DeleteCommand="DELETE FROM [Terenski] WHERE [sifra] = @sifra" 
            InsertCommand="INSERT INTO [Terenski] ([datum], [iznos], [odlazak], [dolazak], [sati], [napomena], [kreirao], [dat_kreiranja], [dat_azu], [radnikID], [opis], [vrsta]) VALUES (@datum, @iznos, @odlazak, @dolazak, @sati, @napomena, @kreirao, @dat_kreiranja, @dat_azu, @radnikID, @opis, @vrsta)" 
            ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
            SelectCommand="SELECT sifra, datum, iznos, odlazak, dolazak, sati, napomena, kreirao, dat_kreiranja, dat_azu, radnikID, opis, vrsta FROM Terenski WHERE (datum BETWEEN @dod AND @ddo)" 
            UpdateCommand="UPDATE [Terenski] SET [datum] = @datum, [iznos] = @iznos, [odlazak] = @odlazak, [dolazak] = @dolazak, [sati] = @sati, [napomena] = @napomena, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [radnikID] = @radnikID, [opis] = @opis, [vrsta] = @vrsta WHERE [sifra] = @sifra">
            <DeleteParameters>
                <asp:Parameter Name="sifra" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="datum" Type="DateTime" />
                <asp:Parameter Name="iznos" Type="Decimal" />
                <asp:Parameter Name="odlazak" Type="Decimal" />
                <asp:Parameter Name="dolazak" Type="Decimal" />
                <asp:Parameter Name="sati" Type="Decimal" />
                <asp:Parameter Name="napomena" Type="String" />
                <asp:Parameter Name="kreirao" Type="String" />
                <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                <asp:Parameter Name="dat_azu" Type="DateTime" />
                <asp:Parameter Name="radnikID" Type="Int32" />
                <asp:Parameter Name="opis" Type="String" />
                <asp:Parameter Name="vrsta" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter DbType="DateTime" Name="dod" QueryStringField="dod" />
                <asp:QueryStringParameter DbType="DateTime" Name="ddo" QueryStringField="ddo" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="datum" Type="DateTime" />
                <asp:Parameter Name="iznos" Type="Decimal" />
                <asp:Parameter Name="odlazak" Type="Decimal" />
                <asp:Parameter Name="dolazak" Type="Decimal" />
                <asp:Parameter Name="sati" Type="Decimal" />
                <asp:Parameter Name="napomena" Type="String" />
                <asp:Parameter Name="kreirao" Type="String" />
                <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                <asp:Parameter Name="dat_azu" Type="DateTime" />
                <asp:Parameter Name="radnikID" Type="Int32" />
                <asp:Parameter Name="opis" Type="String" />
                <asp:Parameter Name="vrsta" Type="String" />
                <asp:Parameter Name="sifra" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:Label ID="lblStatus" runat="server"></asp:Label>
    </p>
    <p>
        UREĐIVANJE PODATAKA ZA ODABRANE TERENSKE TROŠKOVE</p>
    <p>
        <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" 
            AutoGenerateRows="False" CellPadding="4" DataKeyNames="sifra" 
            DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" 
            Height="50px" Width="125px" onitemdeleted="DetailsView1_ItemDeleted" 
            oniteminserted="DetailsView1_ItemInserted" 
            onitemupdated="DetailsView1_ItemUpdated" 
            onitemupdating="DetailsView1_ItemUpdating">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" 
                    ReadOnly="True" SortExpression="sifra" />
                <asp:TemplateField HeaderText="Radnik ID" InsertVisible="False" 
                    SortExpression="radnikID">
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("radnikID") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("radnikID") %>'></asp:Label>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Datum"  SortExpression="datum">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" 
                            Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>' CssClass="Picker"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ErrorMessage="Datum je obavezno polje" ControlToValidate="TextBox1">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" 
                            Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>' CssClass="Picker"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ErrorMessage="Datum je obavezno polje" ControlToValidate="TextBox1">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Odlazak" SortExpression="odlazak">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("odlazak") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                            ErrorMessage="Odlazak je obavezno polje" ControlToValidate="TextBox2">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                            ErrorMessage="Odlazak je obavezno polje" ControlToValidate="TextBox2">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Dolazak" SortExpression="dolazak">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("dolazak") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                            ErrorMessage="Dolazak je obavezno polje" ControlToValidate="TextBox3">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("dolazak") %>' 
                            Height="23px" Width="100px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                            ErrorMessage="Dolazak je obavezno polje" ControlToValidate="TextBox3">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="sati" SortExpression="sati" InsertVisible="False">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("sati") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("sati") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("sati") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Iznos" SortExpression="iznos">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("iznos", "{0:#.00}") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("iznos") %>'></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" 
                            ControlToValidate="TextBox4" 
                            ErrorMessage="Iznos mora biti veći ili jednak nuli, bez oznake valute" 
                            Operator="GreaterThanEqual" Type="Currency" ValueToCompare="0">*</asp:CompareValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" 
                            Text='<%# Bind("iznos", "{0:#.00}") %>'></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" 
                            ControlToValidate="TextBox4" 
                            ErrorMessage="Iznos mora biti veći ili jednak nuli, bez oznake valute" 
                            Operator="GreaterThanEqual" Type="Currency" ValueToCompare="0">*</asp:CompareValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="opis" HeaderText="Opis"
                    SortExpression="opis" />
                <asp:BoundField DataField="vrsta" HeaderText="Vrsta" SortExpression="vrsta" />
                <asp:BoundField DataField="napomena" HeaderText="Napomena" 
                    SortExpression="napomena" />
                <asp:BoundField DataField="kreirao" HeaderText="Kreirao" InsertVisible="False"  ReadOnly="True" 
                    
                    SortExpression="kreirao" />
                <asp:BoundField DataField="dat_kreiranja" HeaderText="Dat. kreiranja" 
                    InsertVisible="False" ReadOnly="True" 
                    SortExpression="dat_kreiranja" />
                <asp:BoundField DataField="dat_azu" HeaderText="Dat. promjene" 
                    InsertVisible="False" ReadOnly="True" 
                    SortExpression="dat_azu" />
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
                        <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" 
                            CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="True" 
                            CommandName="New" Text="New"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                            CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DetailsView>
        <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
    <p>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            DeleteCommand="DELETE FROM [Terenski] WHERE [sifra] = @sifra" 
            InsertCommand="INSERT INTO [Terenski] ([datum], [iznos], [odlazak], [dolazak], [sati], [napomena], [kreirao], [dat_kreiranja], [dat_azu], [radnikID], [opis], [vrsta]) VALUES (@datum, @iznos, @odlazak, @dolazak, @sati, @napomena, @kreirao, @dat_kreiranja, @dat_azu, @radnikID, @opis, @vrsta)" 
            SelectCommand="SELECT * FROM [Terenski] WHERE ([sifra] = @sifra)" 
            UpdateCommand="UPDATE [Terenski] SET [datum] = @datum, [iznos] = @iznos, [odlazak] = @odlazak, [dolazak] = @dolazak, [sati] = @sati, [napomena] = @napomena, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [radnikID] = @radnikID, [opis] = @opis, [vrsta] = @vrsta WHERE [sifra] = @sifra">
            <DeleteParameters>
                <asp:Parameter Name="sifra" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="datum" Type="DateTime" />
                <asp:Parameter Name="iznos" Type="Decimal" />
                <asp:Parameter Name="odlazak" Type="Decimal" />
                <asp:Parameter Name="dolazak" Type="Decimal" />
                <asp:Parameter Name="sati" Type="Decimal" />
                <asp:Parameter Name="napomena" Type="String" />
               <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
               <asp:ControlParameter Name="dat_kreiranja" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                 <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                <asp:Parameter Name="radnikID" Type="Int32" />
                <asp:Parameter Name="opis" Type="String" />
                <asp:Parameter Name="vrsta" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="gvTerenski" Name="sifra" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="datum" Type="DateTime" />
                <asp:Parameter Name="iznos" Type="Decimal" />
                <asp:Parameter Name="odlazak" Type="Decimal" />
                <asp:Parameter Name="dolazak" Type="Decimal" />
                <asp:Parameter Name="sati" Type="Decimal" />
                <asp:Parameter Name="napomena" Type="String" />
                <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
               <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                 <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                <asp:Parameter Name="radnikID" Type="Int32" />
                <asp:Parameter Name="opis" Type="String" />
                <asp:Parameter Name="vrsta" Type="String" />
                <asp:Parameter Name="sifra" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <br />
    <asp:Calendar ID="Calendar1" runat="server" FirstDayOfWeek="Monday" 
        Visible="False"></asp:Calendar>
</asp:Content>
