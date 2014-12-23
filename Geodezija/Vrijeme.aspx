<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    SmartNavigation="true" CodeBehind="Vrijeme.aspx.cs" Inherits="Geodezija.Vrijeme"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.blockUI.js"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
    <script type="text/javascript" src="Scripts/jscrollable.js"></script>
    <script type="text/javascript" src="Scripts/scrollabletable.js"></script>
    <%-- <script type="text/javascript">
        $(document).ready(function () {
            jQuery('table').Scrollable(400, 800);
        });
    </script>--%>
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


            $("#<%= txtDate.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' }, $.datepick.regional['hr']);
            $("#<%= txtDateDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });

            $.datepick.setDefaults($.datepick.regional['hr']);

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
                    height: 190,
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
            $.datepick.setDefaults($.datepick.regional['hr']);

            $('.Picker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn', multiSelect: 999, monthsToShow: 3 });
        });
       
    </script>
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
        var GridId = "<%=GridView1.ClientID %>";
        var ScrollHeight = 700;
        window.onload = function () {
            var grid = document.getElementById(GridId);
            var gridWidth = grid.offsetWidth;
            var gridHeight = grid.offsetHeight;
            var headerCellWidths = new Array();
            for (var i = 0; i < grid.getElementsByTagName("TH").length; i++) {
                headerCellWidths[i] = grid.getElementsByTagName("TH")[i].offsetWidth;
            }
            grid.parentNode.appendChild(document.createElement("div"));
            var parentDiv = grid.parentNode;

            var table = document.createElement("table");
            for (i = 0; i < grid.attributes.length; i++) {
                if (grid.attributes[i].specified && grid.attributes[i].name != "id") {
                    table.setAttribute(grid.attributes[i].name, grid.attributes[i].value);
                }
            }
            table.style.cssText = grid.style.cssText;
            table.style.width = gridWidth + "px";
            table.appendChild(document.createElement("tbody"));
            table.getElementsByTagName("tbody")[0].appendChild(grid.getElementsByTagName("TR")[0]);
            var cells = table.getElementsByTagName("TH");

            var gridRow = grid.getElementsByTagName("TR")[0];
            for (var i = 0; i < cells.length; i++) {
                var width;
                if (headerCellWidths[i] > gridRow.getElementsByTagName("TD")[i].offsetWidth) {
                    width = headerCellWidths[i];
                }
                else {
                    width = gridRow.getElementsByTagName("TD")[i].offsetWidth;
                }
                cells[i].style.width = parseInt(width - 3) + "px";
                gridRow.getElementsByTagName("TD")[i].style.width = parseInt(width - 3) + "px";
            }
            parentDiv.removeChild(grid);

            var dummyHeader = document.createElement("div");
            dummyHeader.appendChild(table);
            parentDiv.appendChild(dummyHeader);
            var scrollableDiv = document.createElement("div");
            if (parseInt(gridHeight) > ScrollHeight) {
                gridWidth = parseInt(gridWidth) + 17;
            }
            scrollableDiv.style.cssText = "overflow:auto;height:" + ScrollHeight + "px;width:" + gridWidth + "px";
            scrollableDiv.appendChild(grid);
            parentDiv.appendChild(scrollableDiv);
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
        .style1
        {
            font-size: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="projectreport">
        <a name="content_start" id="content_start"></a>
        <br />
        <fieldset>
            <h2 class="none">
            </h2>
            <legend>PREGLED RADNOG VREMENA</legend>
            <p style="width: 808px">
                ODABERITE RAZDOBLJE ZA PREGLED:</p>
            <p style="width: 808px">
                &nbsp;</p>
            OD&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDate" runat="server" class="field"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;DO &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDateDo" runat="server"
                class="field"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnPregled" runat="server" OnClick="btnPregled_Click" Text="Filtriraj"
                Width="73px" CssClass="botuni" Visible="False" />
            <asp:Button ID="btnSvi" runat="server" OnClick="btnSvi_Click" Text="Prikaz svih"
                Width="73px" CssClass="botuni" Visible="False" />
            <br />
            &nbsp;&nbsp;<p style="height: 31px">
                <span class="style1">FILTRIRANJE PO DJELATNIKU:</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource3"
                    DataTextField="username" DataValueField="sifra" Height="23px" Width="138px" AppendDataBoundItems="True"
                    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem Text="Svi" Value="-1"></asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnTrazi" runat="server" OnClick="btnTrazi_Click" Text="Traži" Width="73px"
                    CssClass="botuni" />
            </p>
            &nbsp;&nbsp;
            <asp:Label ID="lblSifra" runat="server" Text="Label" Visible="False"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                SelectCommand="SELECT [username], [sifra] FROM [Radnik]"></asp:SqlDataSource>
            <%--<div id="scroll">--%>
            <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;"
                onscroll="Onscrollfnction();">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    DataKeyNames="sifra" EmptyDataText="There are no data records to display." OnRowCommand="GridView1_RowCommand"
                    CssClass="CustomView" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="GridView1_RowDataBound"
                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnSorting="GridView1_Sorting"
                    Height="89%" Width="98%">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataTemplate>
                        <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka" ImageUrl="~/Styles/images/icon-save.gif"
                            runat="server" />
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra" />
                        <asp:BoundField DataField="datum" HeaderText="Datum" SortExpression="datum" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="dolazak" HeaderText="Dolazak" SortExpression="dolazak" />
                        <asp:BoundField DataField="odlazak" HeaderText="Odlazak" SortExpression="odlazak" />
                        <asp:CheckBoxField DataField="blagdan" HeaderText="Blagdan" SortExpression="blagdan" />
                        <asp:CheckBoxField DataField="godisnji" HeaderText="Godišnji" SortExpression="godisnji" />
                        <asp:CheckBoxField DataField="bolovanje" HeaderText="Bolovanje" SortExpression="bolovanje" />
                        <asp:BoundField DataField="radnikID" HeaderText="Radnik ID" SortExpression="radnikID" />
                        <asp:BoundField DataField="sati" HeaderText="Sati" SortExpression="sati" ReadOnly="True" />
                        <%-- <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="AddButton" runat="server" ClientIDMode="Static" CommandName="Kopiraj"
                                    Visible="false" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Kopiraj" />
                            </ItemTemplate>
                            <ControlStyle CssClass="botuni" />
                        </asp:TemplateField>--%>
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
                    <RowStyle BackColor="#F7F6F3" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
            <%--  </div>--%>
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
                        <td colspan="2" style="width: 45%; text-align: left;">
                            <asp:Label ID="Label1" runat="server" Text="Odaberite datume"></asp:Label>
                        </td>
                    </tr>
                    <%--<tr>
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
                            <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Spremi" />
                            <input type="button" class="btnClose" value="Otkaži" />
                            <%--  <asp:Button ID="btnClear" runat="server" Text="Počisti datume" OnClick="btnClear_Click" />--%>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Evid_vrijeme] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID, @sati)"
                ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                UpdateCommand="UPDATE [Evid_vrijeme] SET [datum] = @datum, [dolazak] = @dolazak, [odlazak] = @odlazak, [blagdan] = @blagdan, [godisnji] = @godisnji, [bolovanje] = @bolovanje, [napomena] = @napomena, [radnikID] = @radnikID, [sati] = @sati WHERE [sifra] = @sifra"
                SelectCommand="SELECT [sifra], [datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati] FROM [Evid_vrijeme]   ORDER BY DATUM DESC">
                <%-- <SelectParameters>
                    <asp:ControlParameter Type="DateTime" ControlID="txtDate" Name="od" PropertyName="Text" />
                    <asp:ControlParameter Type="DateTime" ControlID="txtDateDo" Name="do" PropertyName="Text" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="odgovoran" PropertyName="SelectedItem.Value" 
                        Type="Int32"/>
                </SelectParameters>--%>
                <%--  FilterExpression="radnikID = {0} OR (datum BETWEEN {1} AND {2}"--%>
                <%-- <FilterParameters>
                    <asp:ControlParameter Name="radnikID" ControlID="DropDownList1" PropertyName="SelectedValue" />
                    <asp:ControlParameter Name="datum" ControlID="txtDate" PropertyName="Text" />
                    <asp:ControlParameter Name="datum2" ControlID="txtDateDo" PropertyName="Text" />
                </FilterParameters>--%>
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="dolazak" Type="Decimal" />
                    <asp:Parameter Name="odlazak" Type="Decimal" />
                    <asp:Parameter Name="blagdan" Type="Boolean" />
                    <asp:Parameter Name="godisnji" Type="Boolean" />
                    <asp:Parameter Name="bolovanje" Type="Boolean" />
                    <asp:Parameter Name="napomena" Type="String" />
                    <asp:Parameter Name="radnikID" Type="Int32" />
                    <asp:Parameter Name="sati" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="dolazak" Type="Decimal" />
                    <asp:Parameter Name="odlazak" Type="Decimal" />
                    <asp:Parameter Name="blagdan" Type="Boolean" />
                    <asp:Parameter Name="godisnji" Type="Boolean" />
                    <asp:Parameter Name="bolovanje" Type="Boolean" />
                    <asp:Parameter Name="napomena" Type="String" />
                    <asp:Parameter Name="radnikID" Type="Int32" />
                    <asp:Parameter Name="sati" Type="Decimal" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
            &nbsp;
            <asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
            &nbsp;
            <asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />
            &nbsp;&nbsp;
            <br />
            <br />
            <p style="width: 772px; height: 22px;" class="style1">
                UREĐIVANJE PODATAKA ZA ODABRANU EVIDENCIJU VREMENA
                <p style="width: 953px">
                    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="3"
                        DataKeyNames="sifra" DataSourceID="SqlDataSource2" GridLines="Horizontal" Height="159px"
                        Width="855px" OnItemCreated="DetailsView1_ItemCreated" OnItemDeleted="DetailsView1_ItemDeleted"
                        OnItemInserted="DetailsView1_ItemInserted" OnItemUpdated="DetailsView1_ItemUpdated"
                        OnItemUpdating="DetailsView1_ItemUpdating" OnItemInserting="DetailsView1_ItemInserting"
                        BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                        Font-Size="Medium">
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                        <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <EmptyDataTemplate>
                            <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                                Text="Dodaj evidenciju"></asp:LinkButton>
                        </EmptyDataTemplate>
                        <Fields>
                            <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                SortExpression="sifra" />
                            <asp:TemplateField HeaderText="Datum" SortExpression="datum" />
                            <asp:TemplateField HeaderText="Djelatnik" SortExpression="Djelatnik">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="odsOdg" DataTextField="UserName"
                                        DataValueField="sifra" AppendDataBoundItems="true" SelectedValue='<%#Bind("radnikID") %>'>
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
                                    <asp:Label ID="Label21" runat="server" Text='<%# Bind("radnikID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Datum" SortExpression="Datum">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="Picker" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("datum", "{0:dd/MM/yyyy}") %>'
                                        CssClass="Picker"></asp:TextBox>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dolazak" SortExpression="dolazak">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2"
                                        ErrorMessage="Unos mora biti u decimalnom obliku" SetFocusOnError="True" ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dolazak") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2"
                                        ErrorMessage="Unos mora biti decimalnog oblika" ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("dolazak") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Odlazak" SortExpression="odlazak">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox3"
                                        ErrorMessage="Unos mora biti decimalni broj" ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("odlazak") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox3"
                                        ErrorMessage="Unos mora biti decimalni broj" ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("odlazak") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sati" SortExpression="sati">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("sati") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" ReadOnly="True" Text='<%# Bind("sati") %>'></asp:Label>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox4" ReadOnly="True" runat="server" Text='<%# Bind("sati") %>'></asp:TextBox>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Blagdan" SortExpression="blagdan">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("blagdan") %>' ReadOnly="True"
                                        AutoPostBack="true" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("blagdan") %>' />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("blagdan") %>' AutoPostBack="true" />
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Godišnji" SortExpression="godisnji">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("godisnji") %>' ReadOnly="True"
                                        AutoPostBack="true" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("godisnji") %>' />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("godisnji") %>' AutoPostBack="true" />
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bolovanje" SortExpression="bolovanje">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox3" runat="server" ReadOnly="True" Checked='<%# Bind("bolovanje") %>'
                                        AutoPostBack="true" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("bolovanje") %>' />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("bolovanje") %>' AutoPostBack="true" />
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="napomena" HeaderText="Napomena" SortExpression="napomena">
                                <ControlStyle Width="300px" />
                                <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Update"
                                        ForeColor="Black" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                        Text="Update"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                        ForeColor="Black" Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" CommandName="Insert"
                                        OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                        ForeColor="Black" Text="Insert"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel"
                                        ForeColor="Black" Text="Cancel"></asp:LinkButton>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" CommandName="Edit"
                                        ForeColor="Black" Text="Edit"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="True" CommandName="New"
                                        ForeColor="Black" Text="New"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" CommandName="Delete"
                                        OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                                        ForeColor="Black" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="Black" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="Black" />
                    </asp:DetailsView>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" BackColor="White" ForeColor="Red"
                        Width="892px" Height="39px" Font-Size="Medium" />
                    <p style="width: 474px; height: 95px;">
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConflictDetection="CompareAllValues"
                            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" DeleteCommand="DELETE FROM [Evid_vrijeme] WHERE [sifra] = @original_sifra"
                            InsertCommand="INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID], [sati]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID, @sati)"
                            OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Evid_vrijeme] WHERE ([sifra] = @sifra)"
                            UpdateCommand="UPDATE [Evid_vrijeme] SET [datum] = @datum, [dolazak] = @dolazak, [odlazak] = @odlazak, [blagdan] = @blagdan, [godisnji] = @godisnji, [bolovanje] = @bolovanje, [napomena] = @napomena, [radnikID] = @radnikID, [sati] = @sati WHERE [sifra] = @original_sifra">
                            <DeleteParameters>
                                <asp:Parameter Name="original_sifra" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="datum" Type="DateTime" />
                                <asp:Parameter Name="dolazak" Type="Decimal" />
                                <asp:Parameter Name="odlazak" Type="Decimal" />
                                <asp:Parameter Name="blagdan" Type="Boolean" />
                                <asp:Parameter Name="godisnji" Type="Boolean" />
                                <asp:Parameter Name="bolovanje" Type="Boolean" />
                                <asp:Parameter Name="napomena" Type="String" />
                                <asp:ControlParameter Name="radnikID" Type="Int32" ControlID="DetailsView1$ddlOdg"
                                    PropertyName="SelectedItem.Value" />
                                <asp:Parameter Name="sati" Type="Decimal" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="sifra" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="datum" Type="DateTime" />
                                <asp:Parameter Name="dolazak" Type="Decimal" />
                                <asp:Parameter Name="odlazak" Type="Decimal" />
                                <asp:Parameter Name="blagdan" Type="Boolean" />
                                <asp:Parameter Name="godisnji" Type="Boolean" />
                                <asp:Parameter Name="bolovanje" Type="Boolean" />
                                <asp:Parameter Name="napomena" Type="String" />
                                <asp:ControlParameter Name="radnikID" Type="Int32" ControlID="DetailsView1$ddlOdg"
                                    PropertyName="SelectedItem.Value" />
                                <asp:Parameter Name="sati" Type="Decimal" />
                                <asp:Parameter Name="original_sifra" Type="Int32" />
                                <asp:Parameter Name="original_datum" Type="DateTime" />
                                <asp:Parameter Name="original_dolazak" Type="Decimal" />
                                <asp:Parameter Name="original_odlazak" Type="Decimal" />
                                <asp:Parameter Name="original_blagdan" Type="Boolean" />
                                <asp:Parameter Name="original_godisnji" Type="Boolean" />
                                <asp:Parameter Name="original_bolovanje" Type="Boolean" />
                                <asp:Parameter Name="original_napomena" Type="String" />
                                <asp:Parameter Name="original_radnikID" Type="Int32" />
                                <asp:Parameter Name="original_sati" Type="Decimal" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:Label ID="lbl" runat="server" Text="0.00" Visible="False"></asp:Label>
                        <asp:Label ID="lblStatus" runat="server" ForeColor="#CC0000"></asp:Label>
                        <br />
                        <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
        </fieldset>
    </div>
</asp:Content>
