<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pomoc.aspx.cs" Inherits="Geodezija.Pomoc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
        PREGLED STATUSA</h3>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
        EmptyDataText="There are no data records to display." ForeColor="#333333" 
        GridLines="None" Height="218px" Width="270px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="sifra" ReadOnly="True" 
                SortExpression="sifra" />
            <asp:BoundField DataField="naziv" HeaderText="naziv" SortExpression="naziv" />
            <asp:BoundField DataField="boja" HeaderText="boja" SortExpression="boja" />
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
        DeleteCommand="DELETE FROM [statusi] WHERE [sifra] = @sifra" 
        InsertCommand="INSERT INTO [statusi] ([naziv], [boja]) VALUES (@naziv, @boja)" 
        ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
        SelectCommand="SELECT [sifra], [naziv], [boja] FROM [statusi]" 
        UpdateCommand="UPDATE [statusi] SET [naziv] = @naziv, [boja] = @boja WHERE [sifra] = @sifra">
        <DeleteParameters>
            <asp:Parameter Name="sifra" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="boja" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="boja" Type="String" />
            <asp:Parameter Name="sifra" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <h3>
        PREGLED VRSTE POSLOVA</h3>
    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="sifra" DataSourceID="SqlDataSource2" 
        EmptyDataText="There are no data records to display." ForeColor="#333333" 
        GridLines="None" Width="267px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="sifra" ReadOnly="True" 
                SortExpression="sifra" />
            <asp:BoundField DataField="naziv" HeaderText="naziv" SortExpression="naziv" />
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
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        DeleteCommand="DELETE FROM [vrsta_posla] WHERE [sifra] = @sifra" 
        InsertCommand="INSERT INTO [vrsta_posla] ([naziv]) VALUES (@naziv)" 
        ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
        SelectCommand="SELECT [sifra], [naziv] FROM [vrsta_posla]" 
        UpdateCommand="UPDATE [vrsta_posla] SET [naziv] = @naziv WHERE [sifra] = @sifra">
        <DeleteParameters>
            <asp:Parameter Name="sifra" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="naziv" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="sifra" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
