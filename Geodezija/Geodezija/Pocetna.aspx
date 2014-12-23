<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeBehind="Pocetna.aspx.cs" Inherits="Geodezija._Default" %>

<%@ Register assembly="DayPilot" namespace="DayPilot.Web.Ui" tagprefix="DayPilot" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Aktivni projekti</h2>
<p>
        Pregled aktivnih projekata</p>
    <p>
        <asp:GridView ID="gvProjekti" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
            EmptyDataText="There are no data records to display." AllowPaging="True" 
            AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="sifra" HeaderText="sifra" 
                    SortExpression="sifra" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="naziv1" HeaderText="naziv" 
                    SortExpression="naziv1" />
                <asp:BoundField DataField="naziv" HeaderText="status" SortExpression="naziv" />
                <asp:BoundField DataField="vrsta_posla" HeaderText="vrsta_posla" 
                    SortExpression="vrsta_posla" />
                <asp:BoundField DataField="klijent" HeaderText="klijent" 
                    SortExpression="klijent" />
                <asp:BoundField DataField="dat_ugov" HeaderText="dat_ugov" 
                    SortExpression="dat_ugov" />
                <asp:BoundField DataField="ugov_iznos" HeaderText="ugov_iznos" 
                    SortExpression="ugov_iznos" />
                <asp:BoundField DataField="dat_predaja" HeaderText="dat_predaja" 
                    SortExpression="dat_predaja" />
                <asp:TemplateField HeaderText="placeno" SortExpression="placeno">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("placeno") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# (Boolean.Parse(Eval("placeno").ToString())) ? "Da" : "Ne"%>
                     
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="dat_potvrde" HeaderText="dat_potvrde" 
                    SortExpression="dat_potvrde" />
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            DeleteCommand="DELETE FROM [Projekt] WHERE [sifra] = @sifra" 
            InsertCommand="INSERT INTO [Projekt] ([sifra], [naziv], [dat_pocetka], [plan_kraj], [ugov_iznos], [statusID], [kreirao], [vrstaID], [teren], [narucen_kat], [stigli_kat], [dgu_klasa], [dgu_uru], [lova], [kat_opc], [kat_cest], [dat_kreiranje], [putanja_projekt], [putanja_pon], [putanja_fakt], [dat_azuriranja], [klijentID]) VALUES (@sifra, @naziv, @dat_pocetka, @plan_kraj, @ugov_iznos, @statusID, @kreirao, @vrstaID, @teren, @narucen_kat, @stigli_kat, @dgu_klasa, @dgu_uru, @lova, @kat_opc, @kat_cest, @dat_kreiranje, @putanja_projekt, @putanja_pon, @putanja_fakt, @dat_azuriranja, @klijentID)" 
            ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
            SelectCommand="SELECT statusi.naziv, vrsta_posla.naziv AS vrsta_posla, Klijent.naziv AS klijent, Projekt.sifra, Projekt.naziv AS naziv, Projekt.dat_ugov, Projekt.ugov_iznos, Projekt.dat_predaja, Projekt.placeno, Projekt.dat_potvrde FROM Projekt INNER JOIN statusi ON Projekt.statusID = statusi.sifra INNER JOIN vrsta_posla ON Projekt.vrstaID = vrsta_posla.sifra INNER JOIN Klijent ON Projekt.klijentID = Klijent.sifra" 
            
            UpdateCommand="UPDATE [Projekt] SET [naziv] = @naziv, [dat_pocetka] = @dat_pocetka, [plan_kraj] = @plan_kraj, [ugov_iznos] = @ugov_iznos, [statusID] = @statusID, [kreirao] = @kreirao, [vrstaID] = @vrstaID, [teren] = @teren, [narucen_kat] = @narucen_kat, [stigli_kat] = @stigli_kat, [dgu_klasa] = @dgu_klasa, [dgu_uru] = @dgu_uru, [lova] = @lova, [kat_opc] = @kat_opc, [kat_cest] = @kat_cest, [dat_kreiranje] = @dat_kreiranje, [putanja_projekt] = @putanja_projekt, [putanja_pon] = @putanja_pon, [putanja_fakt] = @putanja_fakt, [dat_azuriranja] = @dat_azuriranja, [klijentID] = @klijentID WHERE [sifra] = @sifra">
            <DeleteParameters>
                <asp:Parameter Name="sifra" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="sifra" Type="Int32" />
                <asp:Parameter Name="naziv" Type="String" />
                <asp:Parameter Name="dat_pocetka" Type="DateTime" />
                <asp:Parameter Name="plan_kraj" Type="DateTime" />
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
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="naziv" Type="String" />
                <asp:Parameter Name="dat_pocetka" Type="DateTime" />
                <asp:Parameter Name="plan_kraj" Type="DateTime" />
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
                <asp:Parameter Name="sifra" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        PREGLED MOJIH AKTIVNOSTI</p>
    <p>
        <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
            BackColor="#FFFFD5" BorderColor="Black" BusinessBeginsHour="8" 
            BusinessEndsHour="16" DayFontFamily="Tahoma" DayFontSize="10pt" Days="7" 
            DurationBarColor="Blue" EventBackColor="White" EventBorderColor="Black" 
            EventClickHandling="Disabled" EventFontFamily="Tahoma" EventFontSize="8pt" 
            EventHoverColor="Gainsboro" HourBorderColor="#EAD098" HourFontFamily="Tahoma" 
            HourFontSize="16pt" HourHalfBorderColor="#F3E4B1" HourNameBackColor="#ECE9D8" 
            HourNameBorderColor="#ACA899" HoverColor="#FFED95" 
            NonBusinessBackColor="#FFF4BC" StartDate="2013-08-12" TimeFormat="Clock24Hours" 
            Width="69px" DataEndField="kraj" DataSourceID="sdsAkt" 
            DataStartField="pocetak" DataTextField="opis" DataValueField="sifra" 
            ShowHours="False" />
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
    <p>
        &nbsp;</p>
</asp:Content>
