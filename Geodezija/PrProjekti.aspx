<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"
CodeBehind="PrProjekti.aspx.cs" Inherits="Geodezija.PrProjekti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
  <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("[id*=GridView1] td").hover(function () {
                $("td", $(this).closest("tr")).addClass("hover_row");
            }, function () {
                $("td", $(this).closest("tr")).removeClass("hover_row");
            });
        });
    </script>
      <script language="javascript" type="text/javascript">
          function CreateGridHeader(DataDiv, GridView1, HeaderDiv) {
              var DataDivObj = document.getElementById(DataDiv);
              var DataGridObj = document.getElementById(GridView1);
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
width: 93%; 
height: 90%; 
overflow: scroll; 
position: relative;
left: 9px;
top: 90%;
}
        .CustomView
        {}
        .CustomGrid
        {}
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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
        ToolTip="Ispis aktivne stranice" Width="49px" />  &nbsp;</h2>
            <legend> PREGLED PREDMETA</legend>
    <br />
    Traženje predmeta po nazivu:<br />
            <br />
            &nbsp;
    <asp:TextBox ID="txtTraziPredmet" runat="server" 
       ></asp:TextBox>
&nbsp;&nbsp;
    <asp:Button ID="btnTrazi" runat="server" Text="Traži" onclick="btnTrazi_Click" CssClass="botuni" 
         />
    <asp:SqlDataSource ID="sdsStatusi" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        SelectCommand="SELECT [sifra], [naziv] FROM [statusi] ORDER BY [naziv]">
    </asp:SqlDataSource>
    <br />
    <%--<div id = "scroll">--%>
     <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="sifra" DataSourceID="SqlDataSource1" CssClass="CustomView" 
    EmptyDataText="There are no data records to display." 
        AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" 
        Height="94%" Width="97%" onselectedindexchanged="GridView1_SelectedIndexChanged" 
        onrowdatabound="GridView1_RowDataBound" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <Columns>
        <asp:BoundField DataField="sifra" HeaderText="ID" SortExpression="sifra" 
            InsertVisible="False" ReadOnly="True" Visible="false" />
        <asp:BoundField DataField="arh_broj" HeaderText="Arh.br." 
                    SortExpression="arh_broj"  />
        <asp:BoundField DataField="naziv" HeaderText="Naziv" 
            SortExpression="naziv" />
        <asp:BoundField DataField="Klijent" HeaderText="Klijent" 
            SortExpression="Klijent" />
        <asp:BoundField DataField="Vrsta" HeaderText="Vrsta" SortExpression="Vrsta" />
        <asp:BoundField DataField="Status" HeaderText="Status" 
            SortExpression="Status" />
        <asp:BoundField DataField="kat_opc" HeaderText="Kat. opć." 
            SortExpression="kat_opc" />
        <asp:BoundField DataField="kat_cest" HeaderText="Kat. čest"
            SortExpression="kat_cest" />
        <asp:BoundField DataField="dat_kreiranje" DataFormatString="{0:d}" HeaderText="Dat. kreiranja" 
            SortExpression="dat_kreiranje" />
        <asp:CheckBoxField DataField="placeno" HeaderText="Plaćeno" 
            SortExpression="placeno" />
             <asp:TemplateField HeaderText="Putanja" 
            SortExpression="putanja_projekt">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("putanja_projekt") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
            <asp:Label ID="label1" runat="server" Text='<%# Eval("putanja_projekt") %>'></asp:Label>
           <%--      <asp:HyperLink Text='<%# Eval("putanja_projekt") %>'  id="Label1" runat="server" Target="_blank" NavigateUrl='<%# ""~/Dokumenti/Predmeti"" + Eval("putanja_projekt").ToString()) %>' ></asp:HyperLink>  --%>
            </ItemTemplate>
        </asp:TemplateField>
         <asp:BoundField DataField="dat_zavrs" DataFormatString="{0:d}" HeaderText="Dat.završetka" 
            SortExpression="dat_zavrs" />
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

<SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

<SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

<SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

<SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
</asp:GridView>
  </div>
  <br />
    <br />
        &nbsp;&nbsp;&nbsp;&nbsp;
  
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
                DeleteCommand="DELETE FROM [Projekt] WHERE [sifra] = @sifra" 
                InsertCommand="INSERT INTO [Projekt] ([naziv], [dat_ugov], [dat_predaja], [ugov_iznos], [statusID], [kreirao], [vrstaID], [teren], [narucen_kat], [cijena_kat], [stigli_kat], [dgu_klasa], [dgu_uru], [lova], [kat_opc], [kat_cest], [dat_kreiranje], [putanja_projekt], [dat_azuriranja], [klijentID], [arh_broj], [pon_nar], [faktura], [opis_placanja], [placeno], [dat_potvrde], [racun_iznos], [ponuda_ind], [faktura_ind], [ponuda_sifra], [faktura_sifra], [dat_zavrs]) VALUES (@naziv, @dat_ugov, @dat_predaja, @ugov_iznos, @statusID, @kreirao, @vrstaID, @teren, @narucen_kat, @cijena_kat, @stigli_kat, @dgu_klasa, @dgu_uru, @lova, @kat_opc, @kat_cest, @dat_kreiranje, @putanja_projekt, @dat_azuriranja, @klijentID, @arh_broj, @pon_nar, @faktura, @opis_placanja, @placeno, @dat_potvrde, @racun_iznos, @ponuda_ind, @faktura_ind, @ponuda_sifra, @faktura_sifra, @dat_zavrs)" 
                SelectCommand="SELECT * FROM [Projekt] ORDER BY dat_kreiranje DESC" 
                UpdateCommand="UPDATE [Projekt] SET [naziv] = @naziv, [dat_ugov] = @dat_ugov, [dat_predaja] = @dat_predaja, [ugov_iznos] = @ugov_iznos, [statusID] = @statusID, [kreirao] = @kreirao, [vrstaID] = @vrstaID, [teren] = @teren, [narucen_kat] = @narucen_kat, [cijena_kat] = @cijena_kat, [stigli_kat] = @stigli_kat, [dgu_klasa] = @dgu_klasa, [dgu_uru] = @dgu_uru, [lova] = @lova, [kat_opc] = @kat_opc, [kat_cest] = @kat_cest, [dat_kreiranje] = @dat_kreiranje, [putanja_projekt] = @putanja_projekt, [dat_azuriranja] = @dat_azuriranja, [klijentID] = @klijentID, [arh_broj] = @arh_broj, [pon_nar] = @pon_nar, [faktura] = @faktura, [opis_placanja] = @opis_placanja, [placeno] = @placeno, [dat_potvrde] = @dat_potvrde, [racun_iznos] = @racun_iznos, [ponuda_ind] = @ponuda_ind, [faktura_ind] = @faktura_ind, [ponuda_sifra] = @ponuda_sifra, [faktura_sifra] = @faktura_sifra, [dat_zavrs] = @dat_zavrs WHERE [sifra] = @sifra">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="naziv" Type="String" />
                    <asp:Parameter Name="dat_ugov" Type="DateTime" />
                    <asp:Parameter Name="dat_predaja" Type="DateTime" />
                    <asp:Parameter Name="ugov_iznos" Type="Decimal" />
                    <asp:Parameter Name="statusID" Type="Int32" />
                    <asp:Parameter Name="kreirao" Type="String" />
                    <asp:Parameter Name="vrstaID" Type="Int32" />
                    <asp:Parameter Name="teren" Type="String" />
                    <asp:Parameter Name="narucen_kat" Type="DateTime" />
                    <asp:Parameter Name="cijena_kat" Type="Decimal" />
                    <asp:Parameter Name="stigli_kat" Type="DateTime" />
                    <asp:Parameter Name="dgu_klasa" Type="String" />
                    <asp:Parameter Name="dgu_uru" Type="String" />
                    <asp:Parameter Name="lova" Type="Decimal" />
                    <asp:Parameter Name="kat_opc" Type="String" />
                    <asp:Parameter Name="kat_cest" Type="String" />
                    <asp:Parameter Name="dat_kreiranje" Type="DateTime" />
                    <asp:Parameter Name="putanja_projekt" Type="String" />
                    <asp:Parameter Name="dat_azuriranja" Type="DateTime" />
                    <asp:Parameter Name="klijentID" Type="Int32" />
                    <asp:Parameter Name="arh_broj" Type="Int32" />
                    <asp:Parameter Name="pon_nar" Type="String" />
                    <asp:Parameter Name="faktura" Type="String" />
                    <asp:Parameter Name="opis_placanja" Type="String" />
                    <asp:Parameter Name="placeno" Type="Boolean" />
                    <asp:Parameter Name="dat_potvrde" Type="DateTime" />
                    <asp:Parameter Name="racun_iznos" Type="Decimal" />
                    <asp:Parameter Name="ponuda_ind" Type="Boolean" />
                    <asp:Parameter Name="faktura_ind" Type="Boolean" />
                    <asp:Parameter Name="ponuda_sifra" Type="String" />
                    <asp:Parameter Name="faktura_sifra" Type="String" />
                    <asp:Parameter Name="dat_zavrs" Type="DateTime" />
                   
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="naziv" Type="String" />
                    <asp:Parameter Name="dat_ugov" Type="DateTime" />
                    <asp:Parameter Name="dat_predaja" Type="DateTime" />
                    <asp:Parameter Name="ugov_iznos" Type="Decimal" />
                    <asp:Parameter Name="statusID" Type="Int32" />
                    <asp:Parameter Name="kreirao" Type="String" />
                    <asp:Parameter Name="vrstaID" Type="Int32" />
                    <asp:Parameter Name="teren" Type="String" />
                    <asp:Parameter Name="narucen_kat" Type="DateTime" />
                    <asp:Parameter Name="cijena_kat" Type="Decimal" />
                    <asp:Parameter Name="stigli_kat" Type="DateTime" />
                    <asp:Parameter Name="dgu_klasa" Type="String" />
                    <asp:Parameter Name="dgu_uru" Type="String" />
                    <asp:Parameter Name="lova" Type="Decimal" />
                    <asp:Parameter Name="kat_opc" Type="String" />
                    <asp:Parameter Name="kat_cest" Type="String" />
                    <asp:Parameter Name="dat_kreiranje" Type="DateTime" />
                    <asp:Parameter Name="putanja_projekt" Type="String" />
                    <asp:Parameter Name="dat_azuriranja" Type="DateTime" />
                    <asp:Parameter Name="klijentID" Type="Int32" />
                    <asp:Parameter Name="arh_broj" Type="Int32" />
                    <asp:Parameter Name="pon_nar" Type="String" />
                    <asp:Parameter Name="faktura" Type="String" />
                    <asp:Parameter Name="opis_placanja" Type="String" />
                    <asp:Parameter Name="placeno" Type="Boolean" />
                    <asp:Parameter Name="dat_potvrde" Type="DateTime" />
                    <asp:Parameter Name="racun_iznos" Type="Decimal" />
                    <asp:Parameter Name="ponuda_ind" Type="Boolean" />
                    <asp:Parameter Name="faktura_ind" Type="Boolean" />
                    <asp:Parameter Name="ponuda_sifra" Type="String" />
                    <asp:Parameter Name="faktura_sifra" Type="String" />
                      <asp:Parameter Name="dat_zavrs" Type="DateTime" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <br />
            <br />
    <br />
&nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
    ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
    SelectCommand="SELECT Projekt.sifra, Projekt.arh_broj, Projekt.naziv, Projekt.ugov_iznos, Projekt.putanja_projekt,Projekt.kat_opc, Projekt.kat_cest, Projekt.dat_kreiranje, Projekt.dat_zavrs, Projekt.placeno, Projekt.racun_iznos, Klijent.naziv AS Klijent, statusi.naziv AS Status, vrsta_posla.naziv AS Vrsta FROM Projekt INNER JOIN Klijent ON Projekt.klijentID = Klijent.sifra INNER JOIN statusi ON Projekt.statusID = statusi.sifra INNER JOIN vrsta_posla ON Projekt.vrstaID = vrsta_posla.sifra ORDER BY Projekt.sifra DESC"
     FilterExpression="Projekt.naziv LIKE '%{0}%'">
      <FilterParameters>
        <asp:ControlParameter Name="naziv" ControlID="txtTraziPredmet" PropertyName="Text" />
    </FilterParameters>
</asp:SqlDataSource>
   
    </fieldset>
    </div>
</asp:Content>
