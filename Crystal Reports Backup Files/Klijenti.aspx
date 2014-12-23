<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Klijenti.aspx.cs" Inherits="Geodezija.Klijenti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    Traženje klijenta po nazivu:
    <asp:TextBox ID="txtTraziKlijenta" runat="server"></asp:TextBox>
    &nbsp;&nbsp;
    <asp:Button ID="btnTrazi" runat="server" Text="Traži" OnClick="btnTrazi_Click" CssClass="botuni"
        Height="25px" Width="53px" />
    <br />
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1"
        EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None"
        OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="sifra" ReadOnly="True" SortExpression="sifra" />
            <asp:BoundField DataField="naziv" HeaderText="naziv" SortExpression="naziv" />
            <asp:BoundField DataField="oib" HeaderText="oib" SortExpression="oib" />
            <asp:TemplateField HeaderText="email" SortExpression="email">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("email") %>' NavigateUrl='<%# Eval("email", "mailto:{0}") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="mob" HeaderText="mob" SortExpression="mob" />
            <asp:BoundField DataField="tel1" HeaderText="tel1" SortExpression="tel1" />
            <asp:BoundField DataField="tekuci" HeaderText="tekuci" SortExpression="tekuci" />
            <asp:BoundField DataField="ziro" HeaderText="ziro" SortExpression="ziro" />
            <asp:CheckBoxField DataField="potencijalni" HeaderText="potencijalni" SortExpression="potencijalni" />
            <asp:BoundField DataField="napomena" HeaderText="napomena" SortExpression="napomena" />
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
        DeleteCommand="DELETE FROM [Klijent] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Klijent] ([sifra], [naziv], [grad], [adresa], [email], [mob], [tel1], [tel2], [napomena], [oib], [tekuci], [ziro], [potencijalni], [kreirao], [dat_kreiranja], [dat_azu]) VALUES (@sifra, @naziv, @grad, @adresa, @email, @mob, @tel1, @tel2, @napomena, @oib, @tekuci, @ziro, @potencijalni, @kreirao, @dat_kreiranja, @dat_azu)"
        ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
        SelectCommand="SELECT [sifra], [naziv], [grad], [adresa], [email], [mob], [tel1], [tel2], [napomena], [oib], [tekuci], [ziro], [potencijalni], [kreirao], [dat_kreiranja], [dat_azu] FROM [Klijent]"
        UpdateCommand="UPDATE [Klijent] SET [naziv] = @naziv, [grad] = @grad, [adresa] = @adresa, [email] = @email, [mob] = @mob, [tel1] = @tel1, [tel2] = @tel2, [napomena] = @napomena, [oib] = @oib, [tekuci] = @tekuci, [ziro] = @ziro, [potencijalni] = @potencijalni, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu WHERE [sifra] = @sifra"
        FilterExpression="naziv LIKE '{0}%'">
        <FilterParameters>
            <asp:ControlParameter Name="naziv" ControlID="txtTraziKlijenta" PropertyName="Text" />
        </FilterParameters>
        <DeleteParameters>
            <asp:Parameter Name="sifra" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="sifra" Type="Int32" />
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
            <asp:Parameter Name="kreirao" Type="String" />
            <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
            <asp:Parameter Name="dat_azu" Type="DateTime" />
        </InsertParameters>
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
            <asp:Parameter Name="kreirao" Type="String" />
            <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
            <asp:Parameter Name="dat_azu" Type="DateTime" />
            <asp:Parameter Name="sifra" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>
