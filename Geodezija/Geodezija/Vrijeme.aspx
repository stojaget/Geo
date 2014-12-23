<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Vrijeme.aspx.cs" Inherits="Geodezija.Vrijeme" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
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
    <h3>
        <br />
        PREGLED RADNOG VREMENA<br />
    </h3>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" BorderWidth="1px"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1"
        EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None"
        OnRowCommand="GridView1_RowCommand">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="sifra" ReadOnly="True" SortExpression="sifra" />
            <asp:BoundField DataField="datum" HeaderText="datum" SortExpression="datum" DataFormatString="{0:d}" />
            <asp:BoundField DataField="dolazak" HeaderText="dolazak" SortExpression="dolazak" />
            <asp:BoundField DataField="odlazak" HeaderText="odlazak" SortExpression="odlazak" />
            <asp:CheckBoxField DataField="blagdan" HeaderText="blagdan" SortExpression="blagdan" />
            <asp:CheckBoxField DataField="godisnji" HeaderText="godisnji" SortExpression="godisnji" />
            <asp:CheckBoxField DataField="bolovanje" HeaderText="bolovanje" SortExpression="bolovanje" />
            <asp:BoundField DataField="napomena" HeaderText="napomena" SortExpression="napomena" />
            <asp:BoundField DataField="radnikID" HeaderText="radnikID" SortExpression="radnikID" />
            <asp:BoundField DataField="sati" HeaderText="sati" SortExpression="sati" ReadOnly="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="AddButton" runat="server" ClientIDMode="Static" CommandName="Kopiraj"
                        OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Kopiraj" />
                </ItemTemplate>
                <ControlStyle CssClass="botuni" />
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="Black" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
        DeleteCommand="DELETE FROM [Evid_vrijeme] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID, @sati)"
        ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
        SelectCommand="SELECT [sifra], [datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati] FROM [Evid_vrijeme]"
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
    <asp:ImageButton ID="btnPdf" runat="server" Height="45px" ImageUrl="~/Styles/images/pdf_icon.gif"
        OnClick="btnPdf_Click" ToolTip="Izvoz u PDF" Width="52px" />
    <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
        OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
    <br />
    <br />
    <p>
        UREĐIVANJE PODATAKA ZA ODABRANU EVIDENCIJU VREMENA</p>
    <p>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4"
            DataKeyNames="sifra" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None"
            Height="159px" Width="125px" AllowPaging="True" OnItemCreated="DetailsView1_ItemCreated"
            OnItemDeleted="DetailsView1_ItemDeleted" OnItemInserted="DetailsView1_ItemInserted"
            OnItemUpdated="DetailsView1_ItemUpdated" OnItemUpdating="DetailsView1_ItemUpdating"
            OnItemInserting="DetailsView1_ItemInserting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="sifra" HeaderText="sifra" InsertVisible="False" ReadOnly="True"
                    SortExpression="sifra" />
                <asp:TemplateField HeaderText="datum" SortExpression="datum">
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
                <asp:TemplateField HeaderText="dolazak" SortExpression="dolazak">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2"
                            ErrorMessage="Unos mora biti u decimalnom obliku" SetFocusOnError="True" 
                            ValidationExpression="/^\d+\.?\d*$/">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2"
                            ErrorMessage="Unos mora biti decimalnog oblika" 
                            ValidationExpression="/^\d+\.?\d*$/">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("dolazak") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="odlazak" SortExpression="odlazak">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox3"
                            ErrorMessage="Unos mora biti decimalni broj" 
                            ValidationExpression="/^\d+\.?\d*$/">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox3"
                            ErrorMessage="Unos mora biti decimalni broj" 
                            ValidationExpression="/^\d+\.?\d*$/">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("odlazak") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="blagdan" SortExpression="blagdan">
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
                <asp:TemplateField HeaderText="godisnji" SortExpression="godisnji">
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
                <asp:TemplateField HeaderText="bolovanje" SortExpression="bolovanje">
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
                <asp:BoundField DataField="napomena" HeaderText="napomena" SortExpression="napomena" />
                <asp:TemplateField HeaderText="radnikID" SortExpression="radnikID">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("radnikID") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" ReadOnly="true" runat="server" Text='<%# Bind("radnikID") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" ReadOnly="true" runat="server" Text='<%# Bind("radnikID") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="sati" SortExpression="sati">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" ReadOnly="True" Text='<%# Bind("sati") %>'></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" ReadOnly="True" Text='<%# Bind("sati") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("sati") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" CommandName="Edit"
                            Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="True" CommandName="New"
                            Text="New"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" CommandName="Delete"
                            OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                            Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
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
                </asp:TemplateField>
            </Fields>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DetailsView>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" BackColor="White" ForeColor="Red" />
        <p>
            <br />
            <p>
                <br />
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                    SelectCommand="SELECT * FROM [Evid_vrijeme] WHERE ([sifra] = @sifra)" DeleteCommand="DELETE FROM [Evid_vrijeme] WHERE [sifra] = @sifra"
                    InsertCommand="INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID, @sati)"
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
                        <asp:Parameter Name="radnikID" Type="Int32" />
                        <asp:Parameter Name="sifra" Type="Int32" />
                        <asp:Parameter Name="sati" Type="Decimal" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Label ID="lbl" runat="server" Text="0.00" Visible="False"></asp:Label>
                <asp:Label ID="lblStatus" runat="server" ForeColor="#CC0000"></asp:Label>
                <br />
                <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
                &nbsp;<br />
                <br />
</asp:Content>
