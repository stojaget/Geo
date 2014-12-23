<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"
 CodeBehind="Projekti.aspx.cs" Inherits="Geodezija.Projekti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    Traženje predmeta po nazivu:&nbsp;
    <asp:TextBox ID="txtTraziPredmet" runat="server" 
       ></asp:TextBox>
&nbsp;&nbsp;
    <asp:Button ID="btnTrazi" runat="server" Text="Traži" onclick="btnTrazi_Click" CssClass="botuni" 
         />
    <br />
    &nbsp;
    <asp:SqlDataSource ID="sdsStatusi" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        SelectCommand="SELECT [sifra], [naziv] FROM [statusi] ORDER BY [naziv]">
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
    EmptyDataText="There are no data records to display." AllowPaging="True" 
        AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" 
        Width="862px" onselectedindexchanged="GridView1_SelectedIndexChanged" 
        onrowdatabound="GridView1_RowDataBound">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <Columns>
        <asp:CommandField ShowSelectButton="True" />
        <asp:BoundField DataField="sifra" HeaderText="sifra" SortExpression="sifra" 
            InsertVisible="False" ReadOnly="True" />
        <asp:BoundField DataField="naziv" HeaderText="naziv" 
            SortExpression="naziv" />
        <asp:BoundField DataField="ugov_iznos" HeaderText="ugov_iznos" DataFormatString="{0:#.00}"
            SortExpression="ugov_iznos" />
        <asp:BoundField DataField="kat_opc" HeaderText="kat_opc" 
            SortExpression="kat_opc" />
        <asp:BoundField DataField="kat_cest" HeaderText="kat_cest" 
            SortExpression="kat_cest" />
        <asp:TemplateField HeaderText="putanja_projekt" 
            SortExpression="putanja_projekt">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("putanja_projekt") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("putanja_projekt") %>'></asp:TextBox>
           <%--      <asp:HyperLink Text='<%# Eval("putanja_projekt") %>'  id="Label1" runat="server" Target="_blank" NavigateUrl='<%# ""~/Dokumenti/Predmeti"" + Eval("putanja_projekt").ToString()) %>' ></asp:HyperLink>  --%>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="status" HeaderText="status" 
            SortExpression="status" />
        <asp:BoundField DataField="tip_posla" HeaderText="tip_posla" 
            SortExpression="tip_posla" />
        <asp:BoundField DataField="klijent" HeaderText="klijent" 
            SortExpression="klijent" />
        <asp:BoundField DataField="dat_ugov" HeaderText="dat_ugov" 
            SortExpression="dat_ugov" />
        <asp:BoundField DataField="dat_predaja" HeaderText="dat_predaja" 
            SortExpression="dat_predaja" />
        <asp:HyperLinkField DataNavigateUrlFields="sifra" 
            DataNavigateUrlFormatString="Prilozi.aspx?ID={0}" Text="Prilozi" />
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
    <br />
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
    DeleteCommand="DELETE FROM [Projekt] WHERE [sifra] = @sifra" 
    InsertCommand="INSERT INTO [Projekt] ([sifra], [naziv], [dat_ugov], [dat_potvrde], [dat_predaja], [ugov_iznos], [statusID], [kreirao], [vrstaID], [teren], [narucen_kat], [stigli_kat], [dgu_klasa], [dgu_uru], [lova], [kat_opc], [kat_cest], [dat_kreiranje], [putanja_projekt], [putanja_pon], [putanja_fakt], [dat_azuriranja],  [arh_broj], [pon_nar], [faktura], [opis_placanja], [placeno], [klijentID]) VALUES (@sifra, @naziv, @dat_ugov, @dat_potvrde,@dat_predaja , @ugov_iznos, @statusID, @kreirao, @vrstaID, @teren, @narucen_kat, @stigli_kat, @dgu_klasa, @dgu_uru, @lova, @kat_opc, @kat_cest, @dat_kreiranje, @putanja_projekt, @putanja_pon, @putanja_fakt, @dat_azuriranja, @ arh_broj, @pon_nar, @faktura, @opis_placanja,@placeno,  @klijentID)" 
    ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
    SelectCommand="SELECT Projekt.sifra, Projekt.naziv, Projekt.ugov_iznos, Projekt.statusID, Projekt.kreirao, Projekt.vrstaID, Projekt.teren, Projekt.narucen_kat, Projekt.stigli_kat, Projekt.dgu_klasa, Projekt.dgu_uru, Projekt.lova, Projekt.kat_opc, Projekt.kat_cest, Projekt.dat_kreiranje, Projekt.putanja_projekt, Projekt.putanja_pon, Projekt.putanja_fakt, Projekt.dat_azuriranja, Projekt.klijentID, statusi.naziv AS status, vrsta_posla.naziv AS tip_posla, Klijent.naziv AS klijent, Projekt.dat_ugov, Projekt.dat_predaja FROM Projekt INNER JOIN statusi ON Projekt.statusID = statusi.sifra INNER JOIN vrsta_posla ON Projekt.vrstaID = vrsta_posla.sifra INNER JOIN Klijent ON Projekt.klijentID = Klijent.sifra" 
    UpdateCommand="UPDATE Projekt SET  ugov_iznos = @ugov_iznos, statusID = @statusID, kreirao = @kreirao, vrstaID = @vrstaID, teren = @teren, narucen_kat = @narucen_kat, stigli_kat = @stigli_kat, dgu_klasa = @dgu_klasa, dgu_uru = @dgu_uru, lova = @lova, kat_opc = @kat_opc, kat_cest = @kat_cest, dat_kreiranje = @dat_kreiranje, putanja_projekt = @putanja_projekt, putanja_pon = @putanja_pon, putanja_fakt = @putanja_fakt, dat_azuriranja = @dat_azuriranja, klijentID = @klijentID, dat_ugov =@dat_ugov, naziv =@naziv, dat_predaja =@dat_predaja, arh_broj =@arh_broj, pon_nar =@pon_nar, faktura =@faktura, opis_placanja =@opis_placanja, placeno =@placeno, dat_potvrde =@dat_potvrde WHERE (sifra = @sifra)"
     FilterExpression="naziv LIKE '%{0}%'">
      <FilterParameters>
        <asp:ControlParameter Name="naziv" ControlID="txtTraziPredmet" PropertyName="Text" />
    </FilterParameters>
    <DeleteParameters>
        <asp:Parameter Name="sifra" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="sifra" Type="Int32" />
        <asp:Parameter Name="naziv" Type="String" />
        <asp:Parameter Name="dat_ugov" />
        <asp:Parameter Name="dat_potvrde" />
        <asp:Parameter Name="dat_predaja" />
        <asp:Parameter Name="ugov_iznos" Type="Decimal" />
        <asp:Parameter Name="statusID" Type="Int32" />
        <asp:Parameter Name="kreirao" Type="String" />
        <asp:Parameter Name="vrstaID" Type="Int32" />
        <asp:Parameter Name="teren" Type="String" />
        <asp:Parameter Name="narucen_kat" Type="DateTime" />
        <asp:Parameter Name="stigli_kat" Type="DateTime" />
        <asp:Parameter Name="dgu_klasa" Type="String" />
        <asp:Parameter Name="dgu_uru" Type="String" />
        <asp:Parameter Name="lova" Type="Decimal" />
        <asp:Parameter Name="kat_opc" Type="String" />
        <asp:Parameter Name="kat_cest" Type="String" />
        <asp:Parameter Name="dat_kreiranje" Type="DateTime" />
        <asp:Parameter Name="putanja_projekt" Type="String" />
        <asp:Parameter Name="putanja_pon" Type="String" />
        <asp:Parameter Name="putanja_fakt" Type="String" />
        <asp:Parameter Name="dat_azuriranja" Type="DateTime" />
        <asp:Parameter />
        <asp:Parameter Name="pon_nar" />
        <asp:Parameter Name="faktura" />
        <asp:Parameter Name="opis_placanja" />
        <asp:Parameter Name="placeno" />
        <asp:Parameter Name="klijentID" Type="Int32" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ugov_iznos" Type="Decimal" />
        <asp:Parameter Name="statusID" Type="Int32" />
        <asp:Parameter Name="kreirao" Type="String" />
        <asp:Parameter Name="vrstaID" Type="Int32" />
        <asp:Parameter Name="teren" Type="String" />
        <asp:Parameter Name="narucen_kat" Type="DateTime" />
        <asp:Parameter Name="stigli_kat" Type="DateTime" />
        <asp:Parameter Name="dgu_klasa" Type="String" />
        <asp:Parameter Name="dgu_uru" Type="String" />
        <asp:Parameter Name="lova" Type="Decimal" />
        <asp:Parameter Name="kat_opc" Type="String" />
        <asp:Parameter Name="kat_cest" Type="String" />
        <asp:Parameter Name="dat_kreiranje" Type="DateTime" />
        <asp:Parameter Name="putanja_projekt" Type="String" />
        <asp:Parameter Name="putanja_pon" Type="String" />
        <asp:Parameter Name="putanja_fakt" Type="String" />
        <asp:Parameter Name="dat_azuriranja" Type="DateTime" />
        <asp:Parameter Name="klijentID" Type="Int32" />
        <asp:Parameter Name="dat_ugov" />
        <asp:Parameter Name="naziv" Type="String" />
        <asp:Parameter Name="dat_predaja" />
        <asp:Parameter Name="arh_broj" />
<asp:Parameter Name="pon_nar"></asp:Parameter>
<asp:Parameter Name="faktura"></asp:Parameter>
<asp:Parameter Name="opis_placanja"></asp:Parameter>
<asp:Parameter Name="placeno"></asp:Parameter>
<asp:Parameter Name="dat_potvrde"></asp:Parameter>
        <asp:Parameter Name="sifra" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
    <h2>
    <br />
    <br />
    </h2>
</asp:Content>
