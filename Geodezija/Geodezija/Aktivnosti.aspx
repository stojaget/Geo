<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"
CodeBehind="Aktivnosti.aspx.cs" Inherits="Geodezija.Aktivnosti" %>
<%@ Register assembly="DayPilot" namespace="DayPilot.Web.Ui" tagprefix="DayPilot" %>
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

         $('.DateTimePicker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
       

     });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    PREGLED AKTIVNOSTI
<br />
<br />
Filtriraj po djelatniku:
<asp:DropDownList ID="DropDownList1" runat="server" 
    DataSourceID="ObjectDataSource1" DataTextField="UserName" 
    DataValueField="UserName" AutoPostBack="True">
</asp:DropDownList>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
    SelectMethod="CustomGetAllUsers" TypeName="Geodezija.Helper">
</asp:ObjectDataSource>
<br />
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
    DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
    EmptyDataText="There are no data records to display." ForeColor="#333333" 
    GridLines="None" EnableModelValidation="False" Width="617px">
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <Columns>
        <asp:CommandField ShowSelectButton="True" />
        <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" 
            SortExpression="sifra" InsertVisible="False" />
        <asp:BoundField DataField="pocetak" HeaderText="Početak" DataFormatString="{0:d}"
            SortExpression="pocetak" />
        <asp:BoundField DataField="kraj" HeaderText="Kraj" SortExpression="kraj" 
            DataFormatString="{0:d}" />
        <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
        <asp:BoundField DataField="odgovoran" HeaderText="Odgovoran" 
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
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
    DeleteCommand="DELETE FROM [Aktivnost] WHERE [sifra] = @sifra" 
    InsertCommand="INSERT INTO [Aktivnost] ([pocetak], [kraj], [opis], [odgovoran]) VALUES (@pocetak, @kraj, @opis, @odgovoran)" 
    ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
    SelectCommand="SELECT [sifra], [pocetak], [kraj], [opis], [odgovoran] FROM [Aktivnost] WHERE ([odgovoran] = @odgovoran)" 
    
        UpdateCommand="UPDATE [Aktivnost] SET [pocetak] = @pocetak, [kraj] = @kraj, [opis] = @opis, [odgovoran] = @odgovoran WHERE [sifra] = @sifra">
    <DeleteParameters>
        <asp:Parameter Name="sifra" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="pocetak" Type="DateTime" />
        <asp:Parameter Name="kraj" Type="DateTime" />
        <asp:Parameter Name="opis" Type="String" />
        <asp:Parameter Name="odgovoran" Type="String" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownList1" Name="odgovoran" 
            PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="pocetak" Type="DateTime" />
        <asp:Parameter Name="kraj" Type="DateTime" />
        <asp:Parameter Name="opis" Type="String" />
        <asp:Parameter Name="odgovoran" Type="String" />
        <asp:Parameter Name="sifra" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
        <asp:ImageButton ID="btnPdf" runat="server" Height="45px" 
            ImageUrl="~/Styles/images/pdf_icon.gif" onclick="btnPdf_Click" 
            ToolTip="Izvoz u PDF" Width="52px" />
&nbsp;
    <asp:ImageButton ID="btnExcel" runat="server" Height="45px" 
        ImageUrl="~/Styles/images/excel_lrg.png" onclick="ExportToExcel" 
        ToolTip="Izvoz u Excel" Width="49px" />
<br />
UREĐIVANJE PODATAKA O IZABRANOJ AKTIVNOSTI<br />
<br />
<asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" 
    AutoGenerateRows="False" CellPadding="4" DataKeyNames="sifra" 
    DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" 
    Height="50px" Width="617px">
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
    <EditRowStyle BackColor="#999999" />
    <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
    <Fields>
        <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" 
            ReadOnly="True" SortExpression="sifra" />
        <asp:TemplateField HeaderText="Početak" SortExpression="pocetak" >
            <ItemTemplate>
                <asp:Label ID="Label2"  runat="server" Text='<%# Bind("pocetak", "{0:dd/MM/yyyy}") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="DateTimePicker" 
                    Text='<%# Bind("pocetak") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="TextBox1" ErrorMessage="Početak je obavezno polje">*</asp:RequiredFieldValidator>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="DateTimePicker" 
                    Text='<%# Bind("pocetak") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="TextBox1" ErrorMessage="Početak je obavezno polje">*</asp:RequiredFieldValidator>
            </InsertItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Kraj" SortExpression="kraj" >
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("kraj", "{0:dd/MM/yyyy}") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="DateTimePicker" 
                    Text='<%# Bind("kraj") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="TextBox2" ErrorMessage=" Kraj je obavezno polje">*</asp:RequiredFieldValidator>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="DateTimePicker" 
                    Text='<%# Bind("kraj") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="TextBox2" ErrorMessage=" Kraj je obavezno polje">*</asp:RequiredFieldValidator>
            </InsertItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="opis" HeaderText="Opis" 
            SortExpression="opis" />
        <asp:TemplateField HeaderText="Odgovoran" SortExpression="odgovoran">
            <EditItemTemplate>
                <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="odsOdg" 
                    DataTextField="UserName" DataValueField="UserName">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsOdg" runat="server" SelectMethod="DohvatiUsername" 
                    TypeName="Geodezija.Helper"></asp:ObjectDataSource>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="ObjectDataSource2" 
                    DataTextField="UserName" DataValueField="UserName">
                </asp:DropDownList>
                <br />
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                    SelectMethod="DohvatiUsername" TypeName="Geodezija.Helper">
                </asp:ObjectDataSource>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("odgovoran") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
            ShowInsertButton="True" />
    </Fields>
    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
</asp:DetailsView>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
    <br />
<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
    DeleteCommand="DELETE FROM [Aktivnost] WHERE [sifra] = @sifra" 
    InsertCommand="INSERT INTO [Aktivnost] ([pocetak], [kraj], [opis], [odgovoran]) VALUES (@pocetak, @kraj, @opis, @odgovoran)" 
    SelectCommand="SELECT * FROM [Aktivnost] WHERE ([sifra] = @sifra)" 
    UpdateCommand="UPDATE [Aktivnost] SET [pocetak] = @pocetak, [kraj] = @kraj, [opis] = @opis, [odgovoran] = @odgovoran WHERE [sifra] = @sifra">
    <DeleteParameters>
        <asp:Parameter Name="sifra" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="pocetak" Type="DateTime" />
        <asp:Parameter Name="kraj" Type="DateTime" />
        <asp:Parameter Name="opis" Type="String" />
        
        <asp:ControlParameter Name="odgovoran" Type="String" ControlID="DetailsView1$ddlOdg" PropertyName="SelectedValue" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="GridView1" Name="sifra" 
            PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="pocetak" Type="DateTime" />
        <asp:Parameter Name="kraj" Type="DateTime" />
        <asp:Parameter Name="opis" Type="String" />
        <asp:ControlParameter Name="odgovoran" Type="String" ControlID="DetailsView1$ddlOdg" PropertyName="SelectedValue" />
 
        <asp:Parameter Name="sifra" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
    <br />
<br />
</asp:Content>
