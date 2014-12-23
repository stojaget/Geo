<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Loko.aspx.cs" EnableEventValidation="false" Inherits="Geodezija.Loko" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
    <script src="Scripts/ScrollableGrid.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %>').Scrollable();
        }
)
    </script>
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
        $(function () {
            $("[id*=GridView1] td").hover(function () {
                $("td", $(this).closest("tr")).addClass("hover_row");
            }, function () {
                $("td", $(this).closest("tr")).removeClass("hover_row");
            });
        });
    </script>
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
        .GridViewStyle
        {
            font-family: Verdana;
            font-size: 11px;
            background-color: White;
        }
        
        .GridViewHeaderStyle
        {
            font-family: Verdana;
            font-size: 18px;
            color: White;
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
            &nbsp;<asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
            &nbsp;<asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />
            &nbsp;
            <asp:Button ID="btnTerenski" runat="server" OnClick="btnTerenski_Click" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li želite obračunati terensku vožnju?');"
                Text="Terenski" ToolTip="Pregled terenskih troškova u odabranom razdoblju" CssClass="botuni" />  &nbsp;</h2>
            <br />
             <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display."
                ForeColor="#333333" GridLines="None" OnRowCommand="GridView1_RowCommand" CssClass="CustomView"
                ShowHeaderWhenEmpty="True" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                OnDataBound="GridView1_DataBound" Height="89%" Width="98%">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <EmptyDataTemplate>
                    <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka" ImageUrl="~/Styles/images/icon-save.gif"
                        runat="server"></asp:HyperLink>
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="sifra" HeaderText="ID" SortExpression="sifra" >
                        <%--<HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="datum" DataFormatString="{0:d}" HeaderText="Datum" SortExpression="datum">
                       <%-- <HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="pocetna" HeaderText="Početna" SortExpression="pocetna">
                        <%--<HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="dolazna" HeaderText="Dolazna" SortExpression="dolazna">
                        <%--<HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="km" HeaderText="Km" SortExpression="km" >
                        <%--<HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="relacija" HeaderText="Relacija" SortExpression="relacija">
                        <%--<HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="200px" Wrap="True"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="iznos" HeaderText="Iznos" SortExpression="iznos" DataFormatString="{0:#.00}">
                        <%--<HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="kreirao" HeaderText="Kreirao" SortExpression="kreirao">
                       <%-- <HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="izvjesce" HeaderText="Izvješće" SortExpression="izvjesce">
                       <%-- <HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="200px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="odlazak" HeaderText="Odlazak" SortExpression="odlazak">
                        <%--<HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="dolazak" HeaderText="Dolazak" SortExpression="dolazak">
                       <%-- <HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:BoundField DataField="sati" HeaderText="Sati" SortExpression="sati" >
                        <%--<HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Width="100px"></ItemStyle>--%>
                    </asp:BoundField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="AddButton" runat="server" CommandName="Kopiraj" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                Visible="false" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Kopiraj" />
                        </ItemTemplate>
                        <ControlStyle CssClass="botuni" />
                        <ControlStyle CssClass="botuni"></ControlStyle>
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
                <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>
                <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>
                <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>
                <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
            </asp:GridView>
           </div>
            <br />
            <br />
            &nbsp;<div id="mask">
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
                        <td colspan="2" style="width: 45%; text-align: left;">
                            <asp:Label ID="Label1" runat="server" Text="Odaberite datume"></asp:Label>
                        </td>
                    </tr>
                    <%-- <tr>
                        <td style="width: 85%; height: 60%;">
                            <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="Black" 
                                Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="250px" NextPrevFormat="ShortMonth"
                                OnPreRender="Calendar2_PreRender" Width="330px" OnSelectionChanged="Calendar2_SelectionChanged"
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
                        <td>
                            <asp:TextBox ID="TextBox123" runat="server" CssClass="Picker"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPor" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td align="left">
                            <asp:Button ID="btnSave" runat="server" Text="Spremi" OnClick="btnSave_Click" />
                            <input type="button" class="btnClose" value="Otkaži" />
                            <%-- <asp:Button ID="btnClear" runat="server" Text="Počisti datume" OnClick="btnClear_Click" />--%>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Loko] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Loko] ([datum], [pocetna], [dolazna], [km], [relacija], [auto], [vozac], [iznos], [dat_kreiranja], [dat_azu], [kreirao], [radnikID], [izvjesce], [vrijeme], [registracija], [odlazak], [dolazak], [sati]) VALUES (@datum, @pocetna, @dolazna, @km, @relacija, @auto, @vozac, @iznos, @dat_kreiranja, @dat_azu, @kreirao, @radnikID, @izvjesce, @vrijeme, @registracija, @odlazak, @dolazak, @sati)"
                ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                SelectCommand="SELECT sifra, datum, pocetna, dolazna, km, relacija, auto, vozac, iznos, dat_kreiranja, dat_azu, kreirao, radnikID, izvjesce, vrijeme, registracija, odlazak, dolazak, sati FROM Loko WHERE (datum BETWEEN @od AND @do) ORDER BY DATUM DESC"
                UpdateCommand="UPDATE [Loko] SET [datum] = @datum, [pocetna] = @pocetna, [dolazna] = @dolazna, [km] = @km, [relacija] = @relacija, [auto] = @auto, [vozac] = @vozac, [iznos] = @iznos, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [kreirao] = @kreirao, [radnikID] = @radnikID, [izvjesce] = @izvjesce, [vrijeme] = @vrijeme, [registracija] = @registracija, [odlazak] =@odlazak, [dolazak] =@dolazak, [sati]= @sati WHERE [sifra] = @sifra">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="pocetna" Type="Decimal" />
                    <asp:Parameter Name="dolazna" Type="Decimal" />
                    <asp:Parameter Name="km" Type="Int32" />
                    <asp:Parameter Name="relacija" Type="String" />
                    <asp:Parameter Name="auto" Type="String" />
                    <asp:Parameter Name="vozac" Type="String" />
                    <asp:Parameter Name="iznos" Type="Decimal" />
                    <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                    <asp:Parameter Name="dat_azu" Type="DateTime" />
                    <asp:Parameter Name="kreirao" Type="String" />
                    <asp:Parameter Name="radnikID" Type="Int32" />
                    <asp:Parameter Name="izvjesce" Type="String" />
                    <asp:Parameter Name="vrijeme" Type="String" />
                    <asp:Parameter Name="dolazak" Type="Decimal" />
                    <asp:Parameter Name="odlazak" Type="Decimal" />
                    <asp:Parameter Name="sati" Type="Decimal" />
                    <asp:Parameter Name="registracija" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter DbType="DateTime" Name="od" QueryStringField="od" />
                    <asp:QueryStringParameter DbType="DateTime" Name="do" QueryStringField="do" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="pocetna" Type="Decimal" />
                    <asp:Parameter Name="dolazna" Type="Decimal" />
                    <asp:Parameter Name="km" Type="Int32" />
                    <asp:Parameter Name="relacija" Type="String" />
                    <asp:Parameter Name="auto" Type="String" />
                    <asp:Parameter Name="vozac" Type="String" />
                    <asp:Parameter Name="iznos" Type="Decimal" />
                    <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                    <asp:Parameter Name="dat_azu" Type="DateTime" />
                    <asp:Parameter Name="kreirao" Type="String" />
                    <asp:Parameter Name="radnikID" Type="Int32" />
                    <asp:Parameter Name="izvjesce" Type="String" />
                    <asp:Parameter Name="vrijeme" Type="String" />
                    <asp:Parameter Name="dolazak" Type="Decimal" />
                    <asp:Parameter Name="odlazak" Type="Decimal" />
                    <asp:Parameter Name="sati" Type="Decimal" />
                    <asp:Parameter Name="registracija" Type="String" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            &nbsp; &nbsp; &nbsp;
            <br />
            <asp:Label ID="lblStatus" runat="server" ForeColor="#CC0000"></asp:Label>
            <br />
            <h3>
            UREĐIVANJE ODABRANE LOKO VOŽNJE</h3>
            <br />
            
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="3"
                DataKeyNames="sifra" DataSourceID="SqlDataSource2" GridLines="Horizontal" Height="70px"
                Width="804px" 
                OnItemUpdating="DetailsView1_ItemUpdating" BackColor="White"
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" OnItemInserting="DetailsView1_ItemInserting"
                OnItemDeleted="DetailsView1_ItemDeleted" OnItemInserted="DetailsView1_ItemInserted"
                OnItemUpdated="DetailsView1_ItemUpdated" 
                EmptyDataText="Trenutno nema podataka" Font-Size="Medium">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <EmptyDataTemplate>
                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New">Dodaj loko vožnju</asp:LinkButton>
                </EmptyDataTemplate>
                <Fields>
                    <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="sifra" />
                    <asp:TemplateField HeaderText="Djelatnik" SortExpression="Djelatnik">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="odsOdg" DataTextField="UserName"
                                DataValueField="sifra">
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="odsOdg" runat="server" SelectMethod="DohvatiUsername" TypeName="Geodezija.Helper">
                            </asp:ObjectDataSource>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="ObjectDataSource2" DataTextField="UserName"
                                DataValueField="sifra">
                            </asp:DropDownList>
                            <br />
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="DohvatiUsername"
                                TypeName="Geodezija.Helper"></asp:ObjectDataSource>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("radnikID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Auto" SortExpression="auto">
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("auto") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlAuto" runat="server" AutoPostBack="True" Height="19px" Width="103px"
                                DataSourceID="ObjectDataSource3" DataTextField="Marka" OnSelectedIndexChanged="ddlAuto_SelectedIndexChanged"
                                DataValueField="Sifra" AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="DohvatiAute"
                                TypeName="Geodezija.Helper"></asp:ObjectDataSource>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="ddlAuto" runat="server" AutoPostBack="True" Height="16px" OnSelectedIndexChanged="ddlAuto_SelectedIndexChanged"
                                Width="106px" DataSourceID="ObjectDataSource4" DataTextField="Marka" DataValueField="Sifra"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="DohvatiAute"
                                TypeName="Geodezija.Helper"></asp:ObjectDataSource>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Registracija" SortExpression="registracija">
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("registracija") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("registracija") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("registracija") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Vozač" SortExpression="vozac">
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("vozac") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("vozac") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("vozac") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Datum" SortExpression="datum">
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("datum", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="Picker" Text='<%# Bind("datum", "{0:d}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1"
                                Display="Dynamic" ErrorMessage="Datum je obavezno polje">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox14" runat="server" CssClass="Picker" Text='<%# Bind("datum", "{0:d}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox14"
                                ErrorMessage="Datum je obavezno polje">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Početna" SortExpression="pocetna">
                        <ItemTemplate>
                            <asp:Label ID="Label12" runat="server" Text='<%# Bind("pocetna") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("pocetna") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEditPocetna" runat="server" ControlToValidate="TextBox2"
                                ErrorMessage="Početna kilometraža je obavezno polje">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="TextBox2"
                                ErrorMessage="Početna kilom. mora biti veća od 1" Operator="GreaterThan" Type="Currency"
                                ValueToCompare="1">*</asp:CompareValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("pocetna") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsertPocetna" runat="server" ControlToValidate="TextBox1"
                                ErrorMessage="Početna kilometraža je obavezno polje, format unosa [25,00]">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="TextBox1"
                                ErrorMessage="Početna kilom. mora biti veća od 1" Operator="GreaterThanEqual"
                                Type="Currency" ValueToCompare="1">*</asp:CompareValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dolazna" SortExpression="dolazna">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("dolazna") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("dolazna") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEditDol" runat="server" ControlToValidate="TextBox3"
                                ErrorMessage="Dolazna kilometraža je obavezno polje">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dolazna") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsDol" runat="server" ControlToValidate="TextBox2"
                                ErrorMessage="Dolazna kilometraža je obavezno polje">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="relacija" HeaderText="Relacija" SortExpression="relacija" >
                     <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Iznos" SortExpression="iznos">
                        <ItemTemplate>
                            <asp:Label ID="Label15" runat="server" ReadOnly="True" Text='<%# Bind("iznos", "{0:#.00}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" ReadOnly="True" Text='<%# Bind("iznos") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" ReadOnly="True" Text='<%# Bind("iznos", "{0:#.00}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="izvjesce" HeaderText="Izvješće" SortExpression="izvjesce" >
                     <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Km" InsertVisible="False" SortExpression="km">
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("km") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="Label12" runat="server" Text='<%# Eval("km") %>'></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox7" runat="server" ReadOnly="True" Text='<%# Bind("km") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dolazak" SortExpression="dolazak">
                        <ItemTemplate>
                            <asp:Label ID="Label13" runat="server" Text='<%# Bind("dolazak") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox33" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Dolazak je obavezno polje"
                                ControlToValidate="TextBox33">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox33" runat="server" Text='<%# Bind("dolazak") %>' Height="23px"
                                Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Dolazak je obavezno polje"
                                ControlToValidate="TextBox33">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Odlazak" SortExpression="odlazak">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("odlazak") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox22" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Odlazak je obavezno polje"
                                ControlToValidate="TextBox22">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox22" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Odlazak je obavezno polje"
                                ControlToValidate="TextBox22">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sati" SortExpression="sati" InsertVisible="False">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("sati") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox55" runat="server" Visible="false" Text='<%# Bind("sati") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox55" runat="server" Visible="false" Text='<%# Bind("sati") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Vrijeme" SortExpression="vrijeme">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("vrijeme") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("vrijeme") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEditVrijeme" runat="server" ControlToValidate="TextBox4"
                                ErrorMessage="Vrijeme je obavezno polje">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("vrijeme") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsVrijeme" runat="server" ControlToValidate="TextBox13"
                                ErrorMessage="Vrijeme je obavezno polje">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="dat_kreiranja" HeaderText="Dat. kreiranja" InsertVisible="False"
                        ReadOnly="True" SortExpression="dat_kreiranja" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="dat_azu" HeaderText="Dat. promjene" ReadOnly="True" InsertVisible="False"
                        DataFormatString="{0:d}" SortExpression="dat_azu" />
                    <asp:BoundField DataField="kreirao" HeaderText="Kreirao" ReadOnly="True" InsertVisible="False"
                        SortExpression="kreirao" />
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                              ForeColor="Black"  CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                              ForeColor="Black"  Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                              ForeColor="Black"  CommandName="Insert" Text="Insert"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel"
                               ForeColor="Black" Text="Cancel"></asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="Edit"
                              ForeColor="Black"  Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                             ForeColor="Black"   Text="New"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                             ForeColor="Black"   CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="Black" />
            </asp:DetailsView>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" ForeColor="Red" Font-Size="Medium" />
            <br />
            <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Loko] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Loko] ([datum], [pocetna], [dolazna], [km], [relacija], [auto], [vozac], [iznos], [dat_kreiranja], [dat_azu], [kreirao], [radnikID], [izvjesce], [vrijeme], [registracija], [odlazak], [dolazak], [sati]) VALUES (@datum, @pocetna, @dolazna, @km, @relacija, @auto, @vozac, @iznos, @dat_kreiranja, @dat_azu, @kreirao, @radnikID, @izvjesce, @vrijeme, @registracija,@odlazak, @dolazak, @sati)"
                SelectCommand="SELECT * FROM [Loko] WHERE ([sifra] = @sifra)" UpdateCommand="UPDATE [Loko] SET [datum] = @datum, [pocetna] = @pocetna, [dolazna] = @dolazna, [km] = @km, [relacija] = @relacija, [auto] = @auto, [vozac] = @vozac, [iznos] = @iznos, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [kreirao] = @kreirao, [radnikID] = @radnikID, [izvjesce] = @izvjesce, [vrijeme] = @vrijeme, [registracija] = @registracija, [odlazak] =@odlazak, [dolazak] =@dolazak, [sati]= @sati WHERE [sifra] = @sifra">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="pocetna" Type="Decimal" />
                    <asp:Parameter Name="dolazna" Type="Decimal" />
                    <asp:Parameter Name="km" Type="Int32" />
                    <asp:Parameter Name="relacija" Type="String" />
                    <%--<asp:Parameter Name="auto" Type="String" />--%>
                    <asp:ControlParameter Name="auto" Type="String" ControlID="DetailsView1$ddlAuto"
                        PropertyName="SelectedItem.Text" />
                    <asp:Parameter Name="vozac" Type="String" />
                    <asp:Parameter Name="iznos" Type="Decimal" />
                    <asp:ControlParameter Name="dat_kreiranja" Type="DateTime" ControlID="Calendar1"
                        PropertyName="SelectedDate" />
                    <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                    <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
                    <%--<asp:Parameter Name="radnikID" Type="Int32" />--%>
                    <asp:ControlParameter Name="radnikID" Type="Int32" ControlID="DetailsView1$ddlOdg"
                        PropertyName="SelectedItem.Value" />
                    <asp:Parameter Name="izvjesce" Type="String" />
                    <asp:Parameter Name="vrijeme" Type="String" />
                    <asp:Parameter Name="registracija" Type="String" />
                    <asp:Parameter Name="dolazak" Type="Decimal" />
                    <asp:Parameter Name="odlazak" Type="Decimal" />
                    <asp:Parameter Name="sati" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="sifra" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="pocetna" Type="Decimal" />
                    <asp:Parameter Name="dolazna" Type="Decimal" />
                    <asp:Parameter Name="km" Type="Int32" />
                    <asp:Parameter Name="relacija" Type="String" />
                    <%--<asp:Parameter Name="auto" Type="String" />--%>
                    <asp:ControlParameter Name="auto" Type="String" ControlID="DetailsView1$ddlAuto"
                        PropertyName="SelectedItem.Text" />
                    <asp:Parameter Name="vozac" Type="String" />
                    <asp:Parameter Name="iznos" Type="Decimal" />
                    <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                    <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                    <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
                    <%--<asp:Parameter Name="radnikID" Type="Int32" />--%>
                    <asp:ControlParameter Name="radnikID" Type="Int32" ControlID="DetailsView1$ddlOdg"
                        PropertyName="SelectedItem.Value" />
                    <asp:Parameter Name="izvjesce" Type="String" />
                    <asp:Parameter Name="vrijeme" Type="String" />
                    <asp:Parameter Name="registracija" Type="String" />
                    <asp:Parameter Name="dolazak" Type="Decimal" />
                    <asp:Parameter Name="odlazak" Type="Decimal" />
                    <asp:Parameter Name="sati" Type="Decimal" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Calendar ID="Calendar1" runat="server" FirstDayOfWeek="Monday" 
                Visible="False" Height="16px">
            </asp:Calendar>
            <br />
           
        </fieldset>
    </div>
</asp:Content>
