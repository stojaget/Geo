<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"
CodeBehind="Prilozi.aspx.cs" Inherits="Geodezija.Prilozi1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
        <br />
        PREGLED PRILOGA ZA PREDMET
        <asp:Label ID="lblPredmet" runat="server" Font-Bold="True" ForeColor="#0066FF"></asp:Label>
    </h3>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="odsPrilozi" ForeColor="#333333" 
            GridLines="None" AllowPaging="True" PageSize="5">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Proj_id" HeaderText="Proj. ID" 
                    SortExpression="Proj_id" />
                <asp:BoundField DataField="Rbr" HeaderText="Rbr" SortExpression="Rbr" />
                <asp:BoundField DataField="Opis" HeaderText="Opis" SortExpression="Opis" />
                <asp:BoundField DataField="Putanja" HeaderText="Putanja" 
                    SortExpression="Putanja" />
                <asp:BoundField DataField="Dt_ins" HeaderText="Dat. unosa" 
                    SortExpression="Dt_ins" />
                <asp:BoundField DataField="Tip_sadrzaja" HeaderText="Tip sadržaja" 
                    SortExpression="Tip_sadrzaja" />
                     
                             <asp:HyperLinkField DataNavigateUrlFields="Proj_id,Rbr" 
                                DataNavigateUrlFormatString="~/DownloadFile.aspx?Id={0}&amp;Rbr={1}" Target="_blank"
                                HeaderText="Download" Text="Download" />
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
        <asp:ObjectDataSource ID="odsPrilozi" runat="server" 
            SelectMethod="DohvatiPriloge" TypeName="Geodezija.Helper">
            <SelectParameters>
                <asp:QueryStringParameter Name="proj_id" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </p>
    <h3>
        UNOS NOVOGA PRILOGA</h3>
    <p>
        <asp:Label ID="Label1" runat="server" Text="Naziv:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtNaziv" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txtNaziv" ErrorMessage="Naziv je obavezno polje">*</asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:Label ID="Label2" runat="server" Text="Dokument:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:FileUpload ID="UploadTest" runat="server" ToolTip="Pronađite dokument" />
    </p>
    <p>
         <asp:LinkButton ID="btnInsert" runat="server" OnClick="btnInsert_Click" 
                        Text="Dodaj"></asp:LinkButton>&nbsp;</p>
    <p>
         <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>
