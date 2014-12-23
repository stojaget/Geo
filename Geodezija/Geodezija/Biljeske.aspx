<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Biljeske.aspx.cs" Inherits="Geodezija.Biljeske" %>

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

             $('.DateTimePicker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
         });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        RAD SA PODACIMA BILJEŠKE</p>
    <p>
        <asp:DetailsView ID="dvBiljeske" runat="server" AllowPaging="True" AutoGenerateRows="False"
            CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1" ForeColor="#333333"
            GridLines="None" Height="50px" Width="429px" >
          
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" Width="500px" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                    SortExpression="sifra" />
                <asp:TemplateField HeaderText="Datum" SortExpression="datum">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("datum", "{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("datum") %>' 
                            CssClass="DateTimePicker"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="TextBox1" Display="Dynamic" 
                            ErrorMessage="Datum je obavezno polje">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("datum", "{0:d}") %>' 
                            CssClass="DateTimePicker"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ControlToValidate="TextBox1" Display="Dynamic" 
                            ErrorMessage="Datum je obavezno polje">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Opis" SortExpression="opis">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("opis") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("opis") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                            ControlToValidate="TextBox2" Display="Dynamic" 
                            ErrorMessage="Opis je obavezno polje">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("opis") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                            ControlToValidate="TextBox2" Display="Dynamic" 
                            ErrorMessage="Opis je obavezno polje">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="projektID" HeaderText="Projekt ID" 
                    SortExpression="projektID" />
                <asp:BoundField DataField="unio" HeaderText="Unio" SortExpression="unio" ReadOnly="true" />
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
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
    <p>
        <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
            DeleteCommand="DELETE FROM [Biljeske] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Biljeske] ([datum], [opis], [projektID], [unio]) VALUES (@datum, @opis, @projektID, @unio)"
            SelectCommand="SELECT * FROM [Biljeske] WHERE ([sifra] = @sifra)" UpdateCommand="UPDATE [Biljeske] SET [datum] = @datum, [opis] = @opis, [projektID] = @projektID, [unio] = @unio WHERE [sifra] = @sifra">
            <DeleteParameters>
                <asp:Parameter Name="sifra" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="datum" Type="DateTime" />
                <asp:Parameter Name="opis" Type="String" />
                <asp:Parameter Name="projektID" Type="Int32" />
                <asp:ControlParameter Name="unio" Type="String" ControlID="lblUser" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="sifra" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="datum" Type="DateTime" />
                <asp:Parameter Name="opis" Type="String" />
                <asp:Parameter Name="projektID" Type="Int32" />
                <asp:ControlParameter Name="unio" Type="String" ControlID="lblUser" PropertyName="Text" />
                <asp:Parameter Name="sifra" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
