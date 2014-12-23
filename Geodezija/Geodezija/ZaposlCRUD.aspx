<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"
 CodeBehind="ZaposlCRUD.aspx.cs" Inherits="Geodezija.ZaposlCRUD" %>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        PREGLED PODATAKA O DJELATNIKU</p>
    <p>
        <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" 
            AutoGenerateRows="False" CellPadding="4" DataKeyNames="sifra" 
            DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" 
            Height="50px" Width="287px" onitemdeleted="DetailsView1_ItemDeleted" 
            oniteminserted="DetailsView1_ItemInserted">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="sifra" HeaderText="sifra" InsertVisible="False" 
                    ReadOnly="True" SortExpression="sifra" />
                <asp:BoundField DataField="ime" HeaderText="ime" SortExpression="ime" />
                <asp:BoundField DataField="prezime" HeaderText="prezime" 
                    SortExpression="prezime" />
                <asp:BoundField DataField="oib" HeaderText="oib" SortExpression="oib" />
                <asp:BoundField DataField="dat_zaposlenja" HeaderText="dat_zaposlenja" 
                    SortExpression="dat_zaposlenja" />
                <asp:BoundField DataField="mob" HeaderText="mob" SortExpression="mob" />
                <asp:BoundField DataField="tel" HeaderText="tel" SortExpression="tel" />
                <asp:BoundField DataField="fax" HeaderText="fax" SortExpression="fax" />
                <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
                <asp:BoundField DataField="username" HeaderText="username" 
                    SortExpression="username" />
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            SelectCommand="SELECT * FROM [Radnik] WHERE ([sifra] = @sifra)" 
            DeleteCommand="DELETE FROM [Radnik] WHERE [sifra] = @sifra" 
            InsertCommand="INSERT INTO [Radnik] ([ime], [prezime], [oib], [dat_zaposlenja], [mob], [tel], [fax], [email], [username]) VALUES (@ime, @prezime, @oib, @dat_zaposlenja, @mob, @tel, @fax, @email, @username)" 
            UpdateCommand="UPDATE [Radnik] SET [ime] = @ime, [prezime] = @prezime, [oib] = @oib, [dat_zaposlenja] = @dat_zaposlenja, [mob] = @mob, [tel] = @tel, [fax] = @fax, [email] = @email, [username] = @username WHERE [sifra] = @sifra">
            <DeleteParameters>
                <asp:Parameter Name="sifra" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ime" Type="String" />
                <asp:Parameter Name="prezime" Type="String" />
                <asp:Parameter Name="oib" Type="String" />
                <asp:Parameter Name="dat_zaposlenja" Type="DateTime" />
                <asp:Parameter Name="mob" Type="String" />
                <asp:Parameter Name="tel" Type="String" />
                <asp:Parameter Name="fax" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="username" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="sifra" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ime" Type="String" />
                <asp:Parameter Name="prezime" Type="String" />
                <asp:Parameter Name="oib" Type="String" />
                <asp:Parameter Name="dat_zaposlenja" Type="DateTime" />
                <asp:Parameter Name="mob" Type="String" />
                <asp:Parameter Name="tel" Type="String" />
                <asp:Parameter Name="fax" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="username" Type="String" />
                <asp:Parameter Name="sifra" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        PREGLED POVEZANIH AKTIVNOSTI</p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
            DataKeyNames="sifra" DataSourceID="sdsAkt" ForeColor="#333333" GridLines="None" 
            onselectedindexchanged="GridView1_SelectedIndexChanged" Width="674px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="sifra" HeaderText="sifra" InsertVisible="False" 
                    ReadOnly="True" SortExpression="sifra" />
                <asp:BoundField DataField="pocetak" HeaderText="pocetak" 
                    SortExpression="pocetak" />
                <asp:BoundField DataField="kraj" HeaderText="kraj" SortExpression="kraj" />
                <asp:BoundField DataField="opis" HeaderText="opis" SortExpression="opis" />
                <asp:BoundField DataField="odgovoran" HeaderText="odgovoran" 
                    SortExpression="odgovoran" />
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
        <asp:SqlDataSource ID="sdsAkt" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            SelectCommand="SELECT * FROM [Aktivnost] WHERE ([odgovoran] = @odgovoran)">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblUser" Name="odgovoran" PropertyName="Text" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    </p>
</asp:Content>
