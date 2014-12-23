<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Zaposlenici.aspx.cs" Inherits="Geodezija.Zaposlenici" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <script type="text/javascript">
        $(function () {


            $("#<%= txtDate.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' }, $.datepick.regional['hr']);
            $("#<%= txtDateDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtOd.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $.datepick.setDefaults($.datepick.regional['hr']);

        });
    </script>
     <script type="text/javascript">
         $(function () {
             $("[id*=gvRadnik] td").hover(function () {
                 $("td", $(this).closest("tr")).addClass("hover_row");
             }, function () {
                 $("td", $(this).closest("tr")).removeClass("hover_row");
             });
         });
    </script>
      <script language="javascript" type="text/javascript">
          function CreateGridHeader(DataDiv, gvRadnik, HeaderDiv) {
              var DataDivObj = document.getElementById(DataDiv);
              var DataGridObj = document.getElementById(gvRadnik);
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
        <fieldset style="height: 1190px">
            <h2 class="none">
                <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                    OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
                &nbsp;
                <asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                    OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
                &nbsp;
                <asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                    OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" /> &nbsp;</h2>
            <legend>PREGLED PODATAKA O ZAPOSLENIMA</legend>
            <p style="width: 778px">
            </p>
            <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
            <asp:GridView ID="gvRadnik" runat="server" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1"
                EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None"
                OnSelectedIndexChanged="gvRadnik_SelectedIndexChanged" Height="91%" Width="98%"
                CssClass="CustomView" ShowHeaderWhenEmpty="True" 
                onrowdatabound="gvRadnik_RowDataBound">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="sifra" HeaderText="ID" SortExpression="sifra" InsertVisible="False"
                        ReadOnly="True" />
                    <asp:BoundField DataField="ime" HeaderText="Ime" SortExpression="ime" />
                    <asp:BoundField DataField="prezime" HeaderText="Prezime" SortExpression="prezime" />
                    <asp:BoundField DataField="oib" HeaderText="Oib" SortExpression="oib" />
                    <asp:BoundField DataField="mob" HeaderText="Mob" SortExpression="mob">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="tel" HeaderText="Tel." SortExpression="tel">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fax" HeaderText="Fax" SortExpression="fax">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Email" SortExpression="email">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("email") %>' NavigateUrl='<%# Eval("email", "mailto:{0}") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" />
                     <asp:HyperLinkField DataNavigateUrlFields="sifra" 
            DataNavigateUrlFormatString="RadnikPriloz.aspx?ID={0}" Text="Prilozi" />
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
            </div>
            
            <p style="width: 606px">
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
            <p style="width: 606px">
                &nbsp;</p>
            <p style="width: 606px">
                ODABERITE RAZDOBLJE ZA PREGLED LOKO VOŽNJI</p>
            <p style="width: 607px">
                OD&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDate" runat="server" class="field"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;DO &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDateDo" runat="server"
                    class="field"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnPregled" runat="server" OnClick="btnPregled_Click" Text="Pregled"
                    Width="73px" CssClass="botuni" />
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnLokoNovi" runat="server" OnClick="btnLokoNovi_Click" Text="Novi unos"
                    Width="74px" CssClass="botuni" />
                &nbsp;
                <asp:Button ID="btnValidate" runat="server" OnClientClick="return validate(this,'txtDate','txtDateDo');"
                    class="btn" Text="TEST" OnClick="Button1_Click" Visible="False" />
                <br />
                <br />
                <span id="messages" class="msg" style="background-color: #bb1100; color: White;">&nbsp;</span>
            </p>
            <p style="width: 625px">
                ODABERITE RAZDOBLJE ZA PREGLED TERENSKIH TROŠKOVA</p>
            <p style="width: 626px">
                OD&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtOd" runat="server" class="field"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;DO &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDo" runat="server"
                    class="field"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnTerenski" runat="server" OnClick="btnTerenski_Click" Text="Pregled"
                    Width="73px" CssClass="botuni" />
            &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnNoviTeren" runat="server" OnClick="btnNoviTeren_Click" Text="Novi unos"
                    Width="81px" CssClass="botuni" />
            </p>
        </fieldset>
    </div>
</asp:Content>
