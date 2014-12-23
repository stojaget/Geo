<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"
CodeBehind="KlijentiCRUD.aspx.cs" Inherits="Geodezija.KlijentiCRUD" %>
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
    <h2>
        uređivanje podataka za izabranog klijenta</h2>
    <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" 
        AutoGenerateRows="False" CellPadding="4" DataKeyNames="sifra" 
        DataSourceID="sdsKlijentiCRUD" ForeColor="#333333" GridLines="None" 
        Height="50px" Width="602px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" 
                SortExpression="sifra" InsertVisible="False" />
            <asp:TemplateField HeaderText="Naziv" SortExpression="naziv">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("naziv") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("naziv") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox1" Display="Dynamic" 
                        ErrorMessage="Naziv klijenta je obavezno polje" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("naziv") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox1" Display="Dynamic" 
                        ErrorMessage="Naziv klijenta je obavezno polje">*</asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Grad" SortExpression="grad">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("grad") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("grad") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="TextBox2" Display="Dynamic" 
                        ErrorMessage="Grad je obavezno polje">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("grad") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="TextBox2" ErrorMessage="Grad je obavezno polje">*</asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="adresa" HeaderText="Adresa" 
                SortExpression="adresa" />
            <asp:BoundField DataField="email" HeaderText="E-mail" SortExpression="email" />
            <asp:BoundField DataField="mob" HeaderText="Mob" SortExpression="mob" />
            <asp:BoundField DataField="tel1" HeaderText="Tel 1" SortExpression="tel1" />
            <asp:BoundField DataField="tel2" HeaderText="Tel 2" SortExpression="tel2" />
            <asp:BoundField DataField="napomena" HeaderText="Napomena" 
                SortExpression="napomena" />
            <asp:BoundField DataField="oib" HeaderText="Oib" SortExpression="oib" />
            <asp:BoundField DataField="tekuci" HeaderText="Tekući" 
                SortExpression="tekuci" />
            <asp:BoundField DataField="ziro" HeaderText="Žiro" SortExpression="ziro" />
            <asp:CheckBoxField DataField="potencijalni" HeaderText="Potencijalni" 
                SortExpression="potencijalni" />
            <asp:BoundField DataField="kreirao" HeaderText="Kreirao" InsertVisible="False" ReadOnly="True" 
                SortExpression="kreirao" />
            <asp:BoundField DataField="dat_kreiranja" HeaderText="Dat. kreiranja" 
                InsertVisible="False" ReadOnly="True" DataFormatString="{0:d}"
                SortExpression="dat_kreiranja" />
            <asp:BoundField DataField="dat_azu" HeaderText="Dat. promjene" 
                InsertVisible="False" ReadOnly="True" DataFormatString="{0:d}"
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
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
    <br />
    <asp:SqlDataSource ID="sdsKlijentiCRUD" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        DeleteCommand="DELETE FROM [Klijent] WHERE [sifra] = @sifra" 
        InsertCommand="INSERT INTO [Klijent] ([sifra], [naziv], [grad], [adresa], [email], [mob], [tel1], [tel2], [napomena], [oib], [tekuci], [ziro], [potencijalni], [kreirao], [dat_kreiranja], [dat_azu]) VALUES (@sifra, @naziv, @grad, @adresa, @email, @mob, @tel1, @tel2, @napomena, @oib, @tekuci, @ziro, @potencijalni, @kreirao, @dat_kreiranja, @dat_azu)" 
        SelectCommand="SELECT * FROM [Klijent] WHERE ([sifra] = @sifra)" 
        
        UpdateCommand="UPDATE [Klijent] SET [naziv] = @naziv, [grad] = @grad, [adresa] = @adresa, [email] = @email, [mob] = @mob, [tel1] = @tel1, [tel2] = @tel2, [napomena] = @napomena, [oib] = @oib, [tekuci] = @tekuci, [ziro] = @ziro, [potencijalni] = @potencijalni, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu WHERE [sifra] = @sifra" 
       >
        <DeleteParameters>
            <asp:Parameter Name="sifra" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
           
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="grad" Type="String" />
            <asp:Parameter Name="adresa" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="mob" Type="String" />
            <asp:Parameter Name="tel1" Type="String" />
            <asp:Parameter Name="tel2" Type="String" />
            <asp:Parameter Name="napomena" Type="String" />
            <asp:Parameter Name="oib" Type="String" />
            <asp:Parameter Name="tekuci" Type="String" />
            <asp:Parameter Name="ziro" Type="String" />
            <asp:Parameter Name="potencijalni" Type="Boolean" />
             <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
          <asp:ControlParameter Name="dat_kreiranja" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
            <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
        
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="sifra" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="grad" Type="String" />
            <asp:Parameter Name="adresa" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="mob" Type="String" />
            <asp:Parameter Name="tel1" Type="String" />
            <asp:Parameter Name="tel2" Type="String" />
            <asp:Parameter Name="napomena" Type="String" />
            <asp:Parameter Name="oib" Type="String" />
            <asp:Parameter Name="tekuci" Type="String" />
            <asp:Parameter Name="ziro" Type="String" />
            <asp:Parameter Name="potencijalni" Type="Boolean" />
            
             <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
            <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
           <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
            <asp:Parameter Name="sifra" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Calendar ID="Calendar1" runat="server" 
        Visible="False"></asp:Calendar>
    <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    <br />
    <h2>
    Pregled predmeta povezanih sa izabranim klijentom</h2>
    <asp:GridView ID="gvKlijentProj" 
        runat="server" AllowSorting="True" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="sifra" DataSourceID="sdsPovezani" 
        ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="gvKlijentProj_SelectedIndexChanged" Width="605px" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" 
                SortExpression="sifra" InsertVisible="False" />
            <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
            <asp:BoundField DataField="ugov_iznos" HeaderText="Ugov. iznos" 
                SortExpression="ugov_iznos" />
            <asp:BoundField DataField="dat_ugov" HeaderText="Dat.ugovora" 
                SortExpression="dat_ugov" />
            <asp:BoundField DataField="dat_predaja" HeaderText="Dat.predaje" 
                SortExpression="dat_predaja" />
            <asp:BoundField DataField="putanja_projekt" HeaderText="Putanja" 
                SortExpression="putanja_projekt" />
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
    <br />
        <asp:ImageButton ID="btnPdf" runat="server" Height="45px" 
            ImageUrl="~/Styles/images/pdf_icon.gif" onclick="btnPdf_Click" 
            ToolTip="Izvoz u PDF" Width="52px" />
    <asp:ImageButton ID="btnExcel" runat="server" Height="45px" 
        ImageUrl="~/Styles/images/excel_lrg.png" onclick="ExportToExcel" 
        ToolTip="Izvoz u Excel" Width="49px" />
    <asp:SqlDataSource ID="sdsPovezani" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        
        SelectCommand="SELECT Projekt.sifra, Projekt.naziv, Projekt.ugov_iznos, Projekt.dat_ugov, Projekt.dat_predaja, Projekt.putanja_projekt FROM Projekt INNER JOIN Klijent ON Projekt.klijentID = Klijent.sifra WHERE (Klijent.sifra = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>
