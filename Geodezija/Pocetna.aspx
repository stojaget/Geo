<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeBehind="Pocetna.aspx.cs" Inherits="Geodezija._Default" %>

<%@ Register assembly="DayPilot" namespace="DayPilot.Web.Ui" tagprefix="DayPilot" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
 <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
   <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
   <script type="text/javascript">
       $(function () {
           $("[id*=gvProjekti] td").hover(function () {
               $("td", $(this).closest("tr")).addClass("hover_row");
           }, function () {
               $("td", $(this).closest("tr")).removeClass("hover_row");
           });
       });
    </script>
     <script language="javascript" type="text/javascript">
         function CreateGridHeader(DataDiv, gvProjekti, HeaderDiv) {
             var DataDivObj = document.getElementById(DataDiv);
             var DataGridObj = document.getElementById(gvProjekti);
             var HeaderDivObj = document.getElementById(HeaderDiv);

             //********* Creating new table which contains the header row ***********
             var HeadertableObj = HeaderDivObj.appendChild(document.createElement('table'));

             DataDivObj.style.paddingTop = '0px';
             var DataDivWidth = DataDivObj.clientWidth;
             DataDivObj.style.width = '1000px';

             //********** Setting the style of Header Div as per the Data Div ************
             HeaderDivObj.className = DataDivObj.className;
             HeaderDivObj.style.cssText = DataDivObj.style.cssText;
             //**** Making the Header Div scrollable. *****
             HeaderDivObj.style.overflow = 'auto';
             //*** Hiding the horizontal scroll bar of Header Div ****
             HeaderDivObj.style.overflowX = 'hidden';
             //**** Hiding the vertical scroll bar of Header Div **** 
             HeaderDivObj.style.overflowY = 'hidden';
             HeaderDivObj.style.height = DataGridObj.rows[0].clientHeight + 'px';
             //**** Removing any border between Header Div and Data Div ****
             HeaderDivObj.style.borderBottomWidth = '0px';

             //********** Setting the style of Header Table as per the GridView ************
             HeadertableObj.className = DataGridObj.className;
             //**** Setting the Headertable css text as per the GridView css text 
             HeadertableObj.style.cssText = DataGridObj.style.cssText;
             HeadertableObj.border = '1px';
             HeadertableObj.rules = 'all';
             HeadertableObj.cellPadding = DataGridObj.cellPadding;
             HeadertableObj.cellSpacing = DataGridObj.cellSpacing;

             //********** Creating the new header row **********
             var Row = HeadertableObj.insertRow(0);
             Row.className = DataGridObj.rows[0].className;
             Row.style.cssText = DataGridObj.rows[0].style.cssText;
             Row.style.fontWeight = 'bold';

             //******** This loop will create each header cell *********
             for (var iCntr = 0; iCntr < DataGridObj.rows[0].cells.length; iCntr++) {
                 var spanTag = Row.appendChild(document.createElement('td'));
                 spanTag.innerHTML = DataGridObj.rows[0].cells[iCntr].innerHTML;
                 var width = 0;
                 //****** Setting the width of Header Cell **********
                 if (spanTag.clientWidth > DataGridObj.rows[1].cells[iCntr].clientWidth) {
                     width = spanTag.clientWidth;
                 }
                 else {
                     width = DataGridObj.rows[1].cells[iCntr].clientWidth;
                 }
                 if (iCntr <= DataGridObj.rows[0].cells.length - 2) {
                     spanTag.style.width = width + 'px';
                 }
                 else {
                     spanTag.style.width = width + 20 + 'px';
                 }
                 DataGridObj.rows[1].cells[iCntr].style.width = width + 'px';
             }
             var tableWidth = DataGridObj.clientWidth;
             //********* Hidding the original header of GridView *******
             DataGridObj.rows[0].style.display = 'none';
             //********* Setting the same width of all the componets **********
             HeaderDivObj.style.width = DataDivWidth + 'px';
             DataDivObj.style.width = DataDivWidth + 'px';
             DataGridObj.style.width = tableWidth + 'px';
             HeadertableObj.style.width = tableWidth + 20 + 'px';
             return false;
         }

         function Onscrollfnction() {
             var div = document.getElementById('DataDiv');
             var div2 = document.getElementById('HeaderDiv');
             //****** Scrolling HeaderDiv along with DataDiv ******
             div2.scrollLeft = div.scrollLeft;
             return false;
         }
    
    </script>
     <style type="text/css">
        div#scroll
        {
            border: 1px solid #C0C0C0;
            background-color: #F0F0F0;
            width: 99%;
            height: 90%;
            overflow: scroll;
            position: relative;
            left: 9px;
            top: 80%;
        }
       
    </style>
    <style type="text/css">
        
        .GridViewStyle
        {    
            font-family:Verdana;
            font-size:11px;
            background-color: White; 
        }
        
        .GridViewHeaderStyle
        {
            font-family:Verdana;
            font-size:18px;
	        color:White;
	        background: black url(Image/header3.jpg) repeat-x;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
     <div id="projectreport">
        <a name="content_start" id="content_start"></a>
         <br />
        <fieldset>
            <h2 class="none">
              <asp:ImageButton ID="btnExcel" runat="server" Height="45px" 
        ImageUrl="~/Styles/images/excel_lrg.png" onclick="ExportToExcel" 
        ToolTip="Izvoz u Excel" Width="49px" />
    &nbsp;
    <asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" 
        ImageUrl="~/Styles/images/print_vise.png" onclick="btnSveStrane_Click" 
        ToolTip="Ispis svih stranica" Width="49px" />
    &nbsp;
    <asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" 
        ImageUrl="~/Styles/images/print_jedan.png" onclick="btnAktivnaStrana_Click" 
        ToolTip="Ispis aktivne stranice" Width="49px" />   &nbsp;</h2>
            <legend> PREGLED AKTIVNIH PREDMETA </legend>
  
  <p style="width: 516px"> 
  </p>
   <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
<%-- <div id="scroll">--%>
        <asp:GridView ID="gvProjekti" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
            EmptyDataText="There are no data records to display." 
            AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" 
                 Height="95%" Width= "97%" onselectedindexchanged="gvProjekti_SelectedIndexChanged" 
                onrowdatabound="gvProjekti_RowDataBound" CssClass="CustomView" 
                ShowHeaderWhenEmpty="True">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="sifra" HeaderText="ID" 
                    SortExpression="sifra" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="naziv1" HeaderText="Naziv" 
                    SortExpression="naziv1" />
                <asp:BoundField DataField="naziv" HeaderText="Status" SortExpression="naziv" />
                <asp:BoundField DataField="vrsta_posla" HeaderText="Vrsta posla" 
                    SortExpression="vrsta_posla" />
                <asp:BoundField DataField="klijent" HeaderText="Klijent" 
                    SortExpression="klijent" />
                <asp:BoundField DataField="dat_kreiranje" HeaderText="Dat.kreiranja" ConvertEmptyStringToNull="True"
                    SortExpression="dat_kreiranje" />
                <asp:BoundField DataField="ugov_iznos" HeaderText="Ugov.iznos" ConvertEmptyStringToNull="True"
                    SortExpression="ugov_iznos" />
                <asp:BoundField DataField="dat_predaja" HeaderText="Dat.predaja" ConvertEmptyStringToNull="True"
                    SortExpression="dat_predaja" />
               <%-- <asp:TemplateField HeaderText="Plaćeno" SortExpression="placeno" ConvertEmptyStringToNull="True" >
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" NullDisplayText="Nepoznato"  Checked='<%# Bind("placeno") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# (Boolean.Parse(Eval("placeno").ToString())) ? "Da" : "Ne"%>
                     
                    </ItemTemplate>
                </asp:TemplateField>--%>
                  <asp:CheckBoxField DataField="placeno" HeaderText="Plaćeno" 
            SortExpression="placeno" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="Black" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
  </div>
   <br />
 
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            DeleteCommand="DELETE FROM [Projekt] WHERE [sifra] = @sifra" 
            InsertCommand="INSERT INTO [Projekt] ([sifra], [naziv], [dat_pocetka], [plan_kraj], [ugov_iznos], [statusID], [kreirao], [vrstaID], [teren], [narucen_kat], [stigli_kat], [dgu_klasa], [dgu_uru], [lova], [kat_opc], [kat_cest], [dat_kreiranje], [putanja_projekt], [putanja_pon], [putanja_fakt], [dat_azuriranja], [klijentID]) VALUES (@sifra, @naziv, @dat_pocetka, @plan_kraj, @ugov_iznos, @statusID, @kreirao, @vrstaID, @teren, @narucen_kat, @stigli_kat, @dgu_klasa, @dgu_uru, @lova, @kat_opc, @kat_cest, @dat_kreiranje, @putanja_projekt, @putanja_pon, @putanja_fakt, @dat_azuriranja, @klijentID)" 
            ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
            SelectCommand="SELECT statusi.naziv, vrsta_posla.naziv AS vrsta_posla, Klijent.naziv AS klijent, Projekt.sifra, Projekt.naziv AS naziv, Projekt.dat_kreiranje, Projekt.ugov_iznos, Projekt.dat_predaja, Projekt.placeno, Projekt.dat_potvrde FROM Projekt INNER JOIN statusi ON Projekt.statusID = statusi.sifra INNER JOIN vrsta_posla ON Projekt.vrstaID = vrsta_posla.sifra INNER JOIN Klijent ON Projekt.klijentID = Klijent.sifra" 
            
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
    <p style="width: 606px">
        PREGLED MOJIH AKTIVNOSTI</p>
           <%-- <div id="scroll">--%>
           <div id="Div1" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
                <asp:GridView ID="GridView1" runat="server" CssClass="CustomView" GridLines="None" 
                    DataSourceID="sdsAkt" Height="474px" PageSize="6" ShowHeaderWhenEmpty="True" 
                    Width= "97%" AllowSorting="True" 
                AutoGenerateColumns="False" DataKeyNames="sifra" >
                    <Columns>
                        <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" 
                            ReadOnly="True" SortExpression="sifra" />
                        <asp:BoundField DataField="pocetak" HeaderText="Početak" 
                            SortExpression="pocetak" />
                        <asp:BoundField DataField="od" HeaderText="Od" SortExpression="od" />
                        <asp:BoundField DataField="kraj" HeaderText="Kraj" SortExpression="kraj" />
                        <asp:BoundField DataField="do" HeaderText="Do" SortExpression="do" />
                        <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
                        <asp:BoundField DataField="odgovoran" HeaderText="Odgovoran" 
                            SortExpression="odgovoran" />
                    </Columns>
                </asp:GridView>
           </div>
            </p>
    <p style="width: 595px">
        <asp:SqlDataSource ID="sdsAkt" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            
            SelectCommand="SELECT * FROM [Aktivnost] WHERE ([odgovoran] = @odgovoran) ORDER BY [sifra] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblUser" Name="odgovoran" PropertyName="Text" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    </p>
    <p style="width: 510px">
        &nbsp;</p>
         </fieldset>
    </div>
</asp:Content>
