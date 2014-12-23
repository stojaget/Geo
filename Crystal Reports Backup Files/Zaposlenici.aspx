<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Zaposlenici.aspx.cs" Inherits="Geodezija.Zaposlenici" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
    <script type="text/javascript">
        $(function () {
            $.datepick.setDefaults($.datepick.regional['hr']);

            $("#<%= txtDate.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' }, $.datepick.regional['hr']);
            $("#<%= txtDateDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtOd.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });


        });
    </script>
    <style type="text/css">
        .style1
        {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p class="style1">
        PREGLED PODATAKA O ZAPOSLENIMA</p>
    <p>
        <asp:GridView ID="gvRadnik" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1"
            EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None"
            OnSelectedIndexChanged="gvRadnik_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="sifra" HeaderText="sifra" SortExpression="sifra" InsertVisible="False"
                    ReadOnly="True" />
                <asp:BoundField DataField="ime" HeaderText="ime" SortExpression="ime" />
                <asp:BoundField DataField="prezime" HeaderText="prezime" SortExpression="prezime" />
                <asp:BoundField DataField="oib" HeaderText="oib" SortExpression="oib" />
                <asp:BoundField DataField="dat_zaposlenja" HeaderText="dat_zaposlenja" DataFormatString="{0:d}"
                    SortExpression="dat_zaposlenja" />
                <asp:BoundField DataField="mob" HeaderText="mob" SortExpression="mob" />
                <asp:BoundField DataField="tel" HeaderText="tel" SortExpression="tel" />
                <asp:BoundField DataField="fax" HeaderText="fax" SortExpression="fax" />
                <asp:TemplateField HeaderText="email" SortExpression="email">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("email") %>' NavigateUrl='<%# Eval("email", "mailto:{0}") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="username" HeaderText="username" SortExpression="username" />
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
            DeleteCommand="DELETE FROM [Radnik] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Radnik] ([ime], [prezime], [oib], [dat_zaposlenja], [mob], [tel], [fax], [email], [username]) VALUES (@ime, @prezime, @oib, @dat_zaposlenja, @mob, @tel, @fax, @email, @username)"
            ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
            SelectCommand="SELECT [ime], [prezime], [oib], [dat_zaposlenja], [sifra], [mob], [tel], [fax], [email], [username] FROM [Radnik]"
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
        ODABERITE RAZDOBLJE ZA PREGLED LOKO VOŽNJI</p>
    <p>
        OD&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDate" runat="server" class="field"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;DO &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDateDo" runat="server"
            class="field"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnPregled" runat="server" OnClick="btnPregled_Click" Text="Pregled"
            Width="73px" CssClass="botuni" />
        &nbsp;
        <asp:Button ID="btnValidate" runat="server" OnClientClick="return validate(this,'txtDate','txtDateDo');"
            class="btn" Text="TEST" OnClick="Button1_Click" />
        <br />
        <br />
        <span id="messages" class="msg" style="background-color: #bb1100; color: White;">&nbsp;</span>
    </p>
    <p>
        ODABERITE RAZDOBLJE ZA PREGLED TERENSKIH TROŠKOVA</p>
    <p>
        OD&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtOd" runat="server" class="field"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;DO &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDo" runat="server"
            class="field"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnTerenski" runat="server" OnClick="btnTerenski_Click" Text="Pregled"
            Width="73px" CssClass="botuni" />
    </p>
</asp:Content>
