<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="Terenski.aspx.cs" Inherits="Geodezija.Terenski" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <style type="text/css">
        #mask
        {
            position: fixed;
            left: 0px;
            top: 0px;
            z-index: 4;
            opacity: 0.4;
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=40)"; /* first!*/
            filter: alpha(opacity=40); /* second!*/
            background-color: gray;
            display: none;
            width: 100%;
            height: 100%;
        }
    </style>
    <script type="text/javascript">
        function ShowPopup() {
            $('#mask').show();
            $('#<%=pnlpopup.ClientID %>').show();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#<%=pnlpopup.ClientID %>').hide();
        }
        $(".btnClose").live('click', function () {
            HidePopup();
        });
    </script>
    <script type="text/javascript">

        String.Format = function () {
            var s = arguments[0];
            for (var i = 0; i < arguments.length - 1; i++) {
                var reg = new RegExp("\\{" + i + "\\}", "gm");
                s = s.replace(reg, arguments[i + 1]);
            }
            return s;
        }

        var dialogConfirmed = false;
        function ConfirmDialog(obj, title, dialogText) {
            if (!dialogConfirmed) {
                $('body').append(String.Format("<div id='dialog' title='{0}'><p>{1}</p></div>",
                    title, dialogText));

                $('#dialog').dialog
                ({
                    height: 140,
                    modal: true,
                    resizable: false,
                    draggable: false,
                    close: function (event, ui) { $('body').find('#dialog').remove(); },
                    buttons:
                    {
                        'Da': function () {
                            $(this).dialog('close');
                            dialogConfirmed = true;
                            if (obj) obj.click();
                        },
                        'Ne': function () {
                            $(this).dialog('close');
                        }
                    }
                });
            }

            return dialogConfirmed;
        }
    </script>
    <script type="text/javascript">
        $(function () {

            $('.Picker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn', multiSelect: 999, monthsToShow: 3 });
            $.datepick.setDefaults($.datepick.regional['hr']);
        });
       
    </script>
    <script type="text/javascript">
        $(function () {
            $("[id*=gvTerenski] td").hover(function () {
                $("td", $(this).closest("tr")).addClass("hover_row");
            }, function () {
                $("td", $(this).closest("tr")).removeClass("hover_row");
            });
        });
    </script>
     <script language="javascript" type="text/javascript">
         function CreateGridHeader(DataDiv, gvTerenski, HeaderDiv) {
             var DataDivObj = document.getElementById(DataDiv);
             var DataGridObj = document.getElementById(gvTerenski);
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
        <fieldset>
            <h2 class="none">
               <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                    OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
                &nbsp;
                <asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                    OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
                &nbsp;
                <asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                    OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />  &nbsp;</h2>
            <legend>PREGLED TERENSKIH TROŠKOVA ZA IZABRANO RAZDOBLJE</legend>
            <p>
            </p>
            <%--<div id="scroll">--%>
            <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
                <asp:GridView ID="gvTerenski" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display."
                    ForeColor="#333333" GridLines="None" OnRowCommand="gvTerenski_RowCommand" CssClass="CustomView"
                    Width="97%" Height="91%" ShowHeaderWhenEmpty="True" OnRowDataBound="gvTerenski_RowDataBound"
                    OnSelectedIndexChanged="gvTerenski_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataTemplate>
                        <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka" ImageUrl="~/Styles/images/icon-save.gif"
                            runat="server" />
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra" />
                        <asp:BoundField DataField="datum" HeaderText="Datum" SortExpression="datum" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="iznos" HeaderText="Iznos" SortExpression="iznos" DataFormatString="{0:#.00}" />
                        <asp:BoundField DataField="odlazak" HeaderText="Odlazak" SortExpression="odlazak" />
                        <asp:BoundField DataField="dolazak" HeaderText="Dolazak" SortExpression="dolazak" />
                        <asp:BoundField DataField="sati" HeaderText="Sati" SortExpression="sati" />
                        <asp:BoundField DataField="radnikID" HeaderText="Radnik ID" SortExpression="radnikID" />
                        <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
                        <asp:BoundField DataField="vrsta" HeaderText="Vrsta" SortExpression="vrsta" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="AddButton" runat="server" CommandName="Kopiraj" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                    Visible="false" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Kopiraj" />
                            </ItemTemplate>
                            <ControlStyle CssClass="botuni" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkKopiraj" runat="server" CommandName="MKopiraj" CommandArgument='<%#Eval("sifra") %>'
                                    Text="Kopiraj više" ForeColor="blue">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
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
            <div id="mask">
            </div>
            <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Height="575px" CssClass="modalPopup"
                Width="700px" Style="z-index: 111; background-color: White; position: absolute;
                left: 35%; top: 12%; border: outset 2px gray; padding: 5px; display: none">
                <table width="100%" style="width: 100%; height: 100%;" cellpadding="0" cellspacing="5">
                    <tr style="background-color: #0924BC">
                        <td colspan="2" style="color: White; font-weight: bold; font-size: 1.2em; padding: 3px"
                            align="center">
                            Višestruko kopiranje <a id="A1" style="color: white; float: right; text-decoration: none"
                                class="btnClose" href="#">X</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 15%; text-align: left;">
                            <asp:Label ID="Label1" runat="server" Text="Odaberite datume"></asp:Label>
                        </td>
                    </tr>
                    <%-- <tr>
                        <td style="width: 85%; height: 60%;">
                            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" 
                                Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="250px" NextPrevFormat="ShortMonth"
                                OnPreRender="Calendar1_PreRender" Width="330px" OnSelectionChanged="Calendar1_SelectionChanged"
                                BorderStyle="Solid" CellSpacing="1">
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                                <DayStyle BackColor="#CCCCCC" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="White" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                <TitleStyle BackColor="#333399" Font-Bold="True" Font-Size="12pt" ForeColor="White"
                                    BorderStyle="Solid" Height="12pt" />
                                <TodayDayStyle BackColor="#999999" ForeColor="White" />
                            </asp:Calendar>
                        </td>
                    </tr>--%>
                    <tr>
                        <td >
                    <asp:TextBox ID="TextBox123" runat="server" CssClass="Picker"></asp:TextBox>
                    </td> </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPor" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        
                        <td align="left">
                            <asp:Button ID="btnSave" runat="server" Text="Spremi" OnClick="btnSave_Click" />
                            <input type="button" class="btnClose" value="Otkaži" />
                            <%--<asp:Button ID="btnClear" runat="server" Text="Počisti datume" OnClick="btnClear_Click" />--%>
                        </td>
                    </tr>
                  
                </table>
            </asp:Panel>
           
            <p>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                    DeleteCommand="DELETE FROM [Terenski] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Terenski] ([datum], [iznos], [odlazak], [dolazak], [sati], [napomena], [kreirao], [dat_kreiranja], [dat_azu], [radnikID], [opis], [vrsta]) VALUES (@datum, @iznos, @odlazak, @dolazak, @sati, @napomena, @kreirao, @dat_kreiranja, @dat_azu, @radnikID, @opis, @vrsta)"
                    ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                    SelectCommand="SELECT sifra, datum, iznos, odlazak, dolazak, sati, napomena, kreirao, dat_kreiranja, dat_azu, radnikID, opis, vrsta FROM Terenski WHERE (datum BETWEEN @dod AND @ddo) ORDER BY DATUM DESC"
                    UpdateCommand="UPDATE [Terenski] SET [datum] = @datum, [iznos] = @iznos, [odlazak] = @odlazak, [dolazak] = @dolazak, [sati] = @sati, [napomena] = @napomena, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [radnikID] = @radnikID, [opis] = @opis, [vrsta] = @vrsta WHERE [sifra] = @sifra">
                    <DeleteParameters>
                        <asp:Parameter Name="sifra" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="datum" Type="DateTime" />
                        <asp:Parameter Name="iznos" Type="Decimal" />
                        <asp:Parameter Name="odlazak" Type="Decimal" />
                        <asp:Parameter Name="dolazak" Type="Decimal" />
                        <asp:Parameter Name="sati" Type="Decimal" />
                        <asp:Parameter Name="napomena" Type="String" />
                        <asp:Parameter Name="kreirao" Type="String" />
                        <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                        <asp:Parameter Name="dat_azu" Type="DateTime" />
                        <asp:Parameter Name="radnikID" Type="Int32" />
                        <asp:Parameter Name="opis" Type="String" />
                        <asp:Parameter Name="vrsta" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter DbType="DateTime" Name="dod" QueryStringField="dod" />
                        <asp:QueryStringParameter DbType="DateTime" Name="ddo" QueryStringField="ddo" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="datum" Type="DateTime" />
                        <asp:Parameter Name="iznos" Type="Decimal" />
                        <asp:Parameter Name="odlazak" Type="Decimal" />
                        <asp:Parameter Name="dolazak" Type="Decimal" />
                        <asp:Parameter Name="sati" Type="Decimal" />
                        <asp:Parameter Name="napomena" Type="String" />
                        <asp:Parameter Name="kreirao" Type="String" />
                        <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                        <asp:Parameter Name="dat_azu" Type="DateTime" />
                        <asp:Parameter Name="radnikID" Type="Int32" />
                        <asp:Parameter Name="opis" Type="String" />
                        <asp:Parameter Name="vrsta" Type="String" />
                        <asp:Parameter Name="sifra" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </p>
            <p>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </p>
            <h3>
                UREĐIVANJE PODATAKA ZA ODABRANE TERENSKE TROŠKOVE</h3>
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="3"
                DataKeyNames="sifra" DataSourceID="SqlDataSource2" GridLines="Horizontal" Height="50px"
                Width="638px" OnItemDeleted="DetailsView1_ItemDeleted" OnItemInserted="DetailsView1_ItemInserted"
                OnItemUpdated="DetailsView1_ItemUpdated" OnItemUpdating="DetailsView1_ItemUpdating"
                BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                OnItemInserting="DetailsView1_ItemInserting" 
                OnDataBound="DetailsView1_DataBound" Font-Size="Medium">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <EmptyDataTemplate>
                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                        Text="Dodaj terenske"></asp:LinkButton>
                </EmptyDataTemplate>
                <Fields>
                    <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="sifra" />
                    <asp:TemplateField HeaderText="Za radnika" SortExpression="radnikID">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox16" runat="server" ReadOnly="True" Text='<%# Bind("radnikID") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox16" runat="server" ReadOnly="True" Text='<%# Bind("radnikID") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label17" runat="server" Text='<%# Bind("radnikID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Datum" SortExpression="datum">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'
                                CssClass="Picker"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Datum je obavezno polje"
                                ControlToValidate="TextBox1">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'
                                CssClass="Picker"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Datum je obavezno polje"
                                ControlToValidate="TextBox1">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dolazak" SortExpression="dolazak">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("dolazak") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Dolazak je obavezno polje"
                                ControlToValidate="TextBox3">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("dolazak") %>' Height="23px"
                                Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Dolazak je obavezno polje"
                                ControlToValidate="TextBox3">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Odlazak" SortExpression="odlazak">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("odlazak") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Odlazak je obavezno polje"
                                ControlToValidate="TextBox2">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Odlazak je obavezno polje"
                                ControlToValidate="TextBox2">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sati" SortExpression="sati" InsertVisible="False">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("sati") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Visible="false" Text='<%# Bind("sati") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Visible="false" Text='<%# Bind("sati") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Iznos" SortExpression="iznos">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("iznos", "{0:#.00}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("iznos") %>'></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="TextBox4"
                                ErrorMessage="Iznos mora biti veći ili jednak nuli, bez oznake valute" Operator="GreaterThanEqual"
                                Type="Currency" ValueToCompare="0">*</asp:CompareValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("iznos", "{0:#.00}") %>'></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="TextBox4"
                                ErrorMessage="Iznos mora biti veći ili jednak nuli, bez oznake valute" Operator="GreaterThanEqual"
                                Type="Currency" ValueToCompare="0">*</asp:CompareValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" >
                     <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="vrsta" HeaderText="Vrsta" SortExpression="vrsta" />
                    <asp:BoundField DataField="napomena" HeaderText="Napomena" SortExpression="napomena" >
                     <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="kreirao" HeaderText="Kreirao" InsertVisible="False" ReadOnly="True"
                        SortExpression="kreirao" />
                    <asp:BoundField DataField="dat_kreiranja" HeaderText="Dat. kreiranja" InsertVisible="False"
                        ReadOnly="True" SortExpression="dat_kreiranja" />
                    <asp:BoundField DataField="dat_azu" HeaderText="Dat. promjene" InsertVisible="False"
                        ReadOnly="True" SortExpression="dat_azu" />
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                CommandName="Update" Text="Update" ForeColor="Black"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                               ForeColor="Black" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                               ForeColor="Black" CommandName="Insert" Text="Insert"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel"
                               ForeColor="Black" Text="Cancel"></asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" CommandName="Edit"
                               ForeColor="Black" Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="True" CommandName="New"
                               ForeColor="Black" Text="New"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                               ForeColor="Black" CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="Black" />
            </asp:DetailsView>
            <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
                Font-Size="Medium" />
            <p>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                    DeleteCommand="DELETE FROM [Terenski] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Terenski] ([datum], [iznos], [odlazak], [dolazak], [sati], [napomena], [kreirao], [dat_kreiranja], [dat_azu], [radnikID], [opis], [vrsta]) VALUES (@datum, @iznos, @odlazak, @dolazak, @sati, @napomena, @kreirao, @dat_kreiranja, @dat_azu, @radnikID, @opis, @vrsta)"
                    SelectCommand="SELECT * FROM [Terenski] WHERE ([sifra] = @sifra)" UpdateCommand="UPDATE [Terenski] SET [datum] = @datum, [iznos] = @iznos, [odlazak] = @odlazak, [dolazak] = @dolazak, [sati] = @sati, [napomena] = @napomena, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [radnikID] = @radnikID, [opis] = @opis, [vrsta] = @vrsta WHERE [sifra] = @sifra">
                    <DeleteParameters>
                        <asp:Parameter Name="sifra" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="datum" Type="DateTime" />
                        <asp:Parameter Name="iznos" Type="Decimal" />
                        <asp:Parameter Name="odlazak" Type="Decimal" />
                        <asp:Parameter Name="dolazak" Type="Decimal" />
                        <asp:Parameter Name="sati" Type="Decimal" />
                        <asp:Parameter Name="napomena" Type="String" />
                        <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
                        <asp:ControlParameter Name="dat_kreiranja" Type="DateTime" ControlID="Calendar1"
                            PropertyName="SelectedDate" />
                        <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                        <asp:Parameter Name="radnikID" Type="Int32" />
                        <asp:Parameter Name="opis" Type="String" />
                        <asp:Parameter Name="vrsta" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvTerenski" Name="sifra" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="datum" Type="DateTime" />
                        <asp:Parameter Name="iznos" Type="Decimal" />
                        <asp:Parameter Name="odlazak" Type="Decimal" />
                        <asp:Parameter Name="dolazak" Type="Decimal" />
                        <asp:Parameter Name="sati" Type="Decimal" />
                        <asp:Parameter Name="napomena" Type="String" />
                        <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
                        <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                        <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                        <asp:Parameter Name="radnikID" Type="Int32" />
                        <asp:Parameter Name="opis" Type="String" />
                        <asp:Parameter Name="vrsta" Type="String" />
                        <asp:Parameter Name="sifra" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </p>
            <br />
            <asp:Calendar ID="Calendar2" runat="server" FirstDayOfWeek="Monday" Visible="False">
            </asp:Calendar>
        </fieldset>
    </div>
</asp:Content>
