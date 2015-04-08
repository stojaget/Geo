<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"
CodeBehind="PrProjekti.aspx.cs" Inherits="Geodezija.PrProjekti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <script src="/Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <link rel="Stylesheet" type="text/css" href="../Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="../Styles/style.css" />
    <script type="text/javascript" src="/Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="/Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="/Scripts/hajan.datevalidator.js"></script>
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
        $(function () {


            $("#<%= txtZavrsOd.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtZavrsDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
          <%--  $("#<%= txtDguPodnesenOd.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtDguPodnesenDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtDguPotvrdenOd.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $("#<%= txtDguPotvrdenDo.ClientID %>").datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });--%>
            $.datepick.setDefaults($.datepick.regional['hr']);
        });
    </script>
    <%--  <script type="text/javascript">
        $(document).ready(function () {
            jQuery('table').Scrollable(400, 800);
        });
    </script>--%>
    <%--  <script type="text/javascript">
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
    </script>--%>
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
        table {
        }

        td {
        }

        th {
        }
    </style>
    <style type="text/css">
        div#scroll {
            border: 1px solid #C0C0C0;
            background-color: #F0F0F0;
            width: 99%;
            height: 90%;
            <%-- overflow: scroll;
            --%> position: relative;
            left: 9px;
            top: 80%;
        }

        .CustomView {
        }

        .CustomGrid {
        }
    </style>
    <style type="text/css">
        .even {
            background: #58FAAC;
        }

        .GridViewStyle {
            font-family: Verdana;
            font-size: 11px;
            background-color: White;
        }

        .GridViewHeaderStyle {
            font-family: Verdana;
            font-size: 15px;
            color: White;
            background: black url(Image/header3.jpg) repeat-x;
        }
    </style>
    <style>
        a.linkbutton, a.linkbutton:visited, a.linkbutton img {
            border: none;
            outline: none;
            color: Black;
        }
        .auto-style1 {
            width: 24%;
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
                    OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />
                &nbsp;
                <asp:Button ID="Button1" runat="server" CssClass="botuni" Height="24px" OnClick="Button1_Click"
                    Text="Unesi novi" Width="97px" />

            </h2>
            <legend>PREGLED PREDMETA</legend>
            <asp:SqlDataSource ID="sdsStatusi" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                SelectCommand="SELECT [sifra], [naziv] FROM [statusi] ORDER BY [naziv]"></asp:SqlDataSource>
            <br />
            <%--<div id="scroll">--%>
            <table style="width: 98%; height: 30px;" border="0" cellpadding="0" cellspacing="1"
                class="GridviewTable">
                <tr>
                    <td align="left" class="auto-style1">Klijent:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlKlij" runat="server" Width="130px" Font-Size="11px" AppendDataBoundItems="True">
                            <asp:ListItem Text="Svi" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20%;">Završio:
                        <asp:DropDownList ID="ddlZavrsio" runat="server" Width="130px" Font-Size="11px" AppendDataBoundItems="True">
                            <asp:ListItem Text="Svi" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20%;" align="left">Dat. zavrs. od:
                        <asp:TextBox ID="txtZavrsOd" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 20%;" align="left">Dat. zavrs. do:&nbsp;&nbsp;
                        <asp:TextBox ID="txtZavrsDo" runat="server"></asp:TextBox>
                    </td>
                    <td>
                         <asp:Button ID="btnKatPred" runat="server" Text="Kat. predmeti" CssClass="botuni" OnClick="btnKatPred_Click" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="auto-style1">Vrsta posla:
                        <asp:DropDownList ID="ddlVrsta" DataSourceID="dsVrsta" DataValueField="Sifra" runat="server"
                            Width="130px" Font-Size="11px" AppendDataBoundItems="True" DataTextField="Naziv">
                            <asp:ListItem Text="Svi" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20%;">Status:&nbsp;
                        <asp:DropDownList ID="ddlStatus" DataSourceID="dsStatus" DataValueField="Sifra" runat="server"
                            Width="130px" Font-Size="11px" AppendDataBoundItems="True" DataTextField="Naziv">
                            <asp:ListItem Text="Svi" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <%-- <td style="width: 150px;">
        Naziv
    </td>--%>
                    <td style="width: 15%;" align="left">Kat. opc.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlKat" DataSourceID="dsKat" DataValueField="Sifra" runat="server"
                            Width="130px" Font-Size="11px" AppendDataBoundItems="True" DataTextField="Naziv">
                            <asp:ListItem Text="Svi" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 15%" align="left">Naziv predmeta:
                        <asp:TextBox ID="txtTraziPredmet" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 10%" align="left">
                        <asp:Button ID="btnTrazi" runat="server" Text="Traži" CssClass="botuni" OnClick="btnTrazi_Click" />
                    </td>
                </tr>
               <%-- <tr>
                    <td style="width: 50%;" align="left">DGU datum podnošenja zahtjeva za pregled i ovjeru OD:
                        <asp:TextBox ID="txtDguPodnesenOd" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 50%;" align="left">DGU datum podnošenja zahtjeva za pregled i ovjeru DO:
                        <asp:TextBox ID="txtDguPodnesenDo" runat="server"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td align="left" class="auto-style1">DGU datum potvrde elaborata OD:&nbsp;&nbsp;
                        <asp:TextBox ID="txtDguPotvrdenOd" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 50%;" align="left">DGU datum potvrde elaborata DO:&nbsp;&nbsp;
                        <asp:TextBox ID="txtDguPotvrdenDo" runat="server"></asp:TextBox>
                    </td>
                </tr>--%>
            </table>
            <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;"
                onscroll="Onscrollfnction();">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="sifra"
                    EmptyDataText="There are no data records to display." CellPadding="4" GridLines="Both"
                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView1_RowDataBound"
                    OnPreRender="GridView1_PreRender" OnLoad="GridView1_Load" OnRowCommand="GridView1_RowCommand"
                    AlternatingRowStyle-BackColor="AliceBlue" Height="95%" Width="98%"
                    ShowFooter="True">
                    <Columns>
                        <%--   <asp:TemplateField HeaderText="Putanja" 
            SortExpression="putanja_projekt">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("putanja_projekt") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
            <asp:Label ID="label1" runat="server" Text='<%# Eval("putanja_projekt") %>'></asp:Label>
               <asp:HyperLink Text='<%# Eval("putanja_projekt") %>'  id="Label1" runat="server" Target="_blank" NavigateUrl='<%# ""~/Dokumenti/Predmeti"" + Eval("putanja_projekt").ToString()) %>' ></asp:HyperLink>  
            </ItemTemplate>
        </asp:TemplateField>
      <asp:BoundField DataField="dat_zavrs" DataFormatString="{0:d}" HeaderText="Dat.završetka" 
            SortExpression="dat_zavrs" />--%>
                        <asp:BoundField DataField="sifra" HeaderText="ID" SortExpression="sifra" InsertVisible="False"
                            Visible="false" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Arh. br." SortExpression="arh_broj">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnArh" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="arh_broj">Arh. br.</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderArh" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("arh_broj") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("arh_broj") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblUkPredmeta" runat="server" Text="Uk. predmeta:" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Poslovna godina" SortExpression="godina">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnGodina" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="godina">Poslovna godina</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderGodina" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("godina") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("godina") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dat.kreiranja" SortExpression="dat_kreiranje">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnDatkreiranja" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="dat_predajedgu">Dat.kreiranja</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderDatkreiranja" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("dat_kreiranje", "{0:d}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("dat_kreiranje") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dat.zatv." SortExpression="dat_predaja">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnDatzatv" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="dat_zavrs">Dat.zatv.</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderDatzatv" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("dat_zavrs", "{0:d}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("dat_zavrs") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Klijent" SortExpression="Klijent">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnKlijent" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="Klijent">Klijent</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderKlijent" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("Klijent") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Klijent") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="oib" HeaderText="OIB" SortExpression="oib" Visible="False" />
                        <asp:BoundField DataField="Vrsta" HeaderText="Vrsta" SortExpression="Vrsta" Visible="false" />
                        <asp:TemplateField HeaderText="Status" SortExpression="Status" Visible="false">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnStatus" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="Status">Status</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderStatus" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Naziv" SortExpression="naziv">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnNaziv" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="Naziv">Naziv</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderNaziv" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("naziv") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("naziv") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Kat. opć." SortExpression="kat_opc">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnKat_opc" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="kat_opc">Kat. opć.</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderKat_opc" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label8" runat="server" Text='<%# Bind("kat_opc") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("kat_opc") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- <asp:BoundField DataField="kat_cest" HeaderText="Kat. čest" SortExpression="kat_cest" />--%>
                        <asp:TemplateField HeaderText="Kat.čest." SortExpression="kat_cest">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnKat_cest" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="kat_cest">Kat.čest.</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderKat_cest" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label11" runat="server" Text='<%# Bind("kat_cest") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("kat_cest") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- <asp:BoundField DataField="narucen_kat" HeaderText="Kat. naručen" DataFormatString="{0:d}"
                            SortExpression="narucen_kat" />--%>
                        <asp:TemplateField HeaderText="Naručen kat." SortExpression="narucen_kat">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnNar_kat" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="narucen_kat">Naručen kat.</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderNar_kat" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label12" runat="server" Text='<%# Bind("narucen_kat") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("narucen_kat") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- <asp:BoundField DataField="stigli_kat" HeaderText="Kat. stigao" SortExpression="stigli_kat" />--%>
                        <asp:TemplateField HeaderText="Kat. stigao" SortExpression="stigli_kat">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnStigli_kat" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="stigli_kat">Kat. stigao</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderStigli_kat" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label13" runat="server" Text='<%# Bind("stigli_kat") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("stigli_kat") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="ugov_iznos" HeaderText="Ugov. iznos" DataFormatString="{0:C2}"
                            HtmlEncode="False" SortExpression="ugov_iznos" />--%>
                        <asp:TemplateField HeaderText="Ugov. iznos" SortExpression="ugov_iznos" Visible="false">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnUgov_iznos" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="ugov_iznos">Ugov. iznos</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderUgov_iznos" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label14" runat="server" Text='<%# Bind("ugov_iznos") %>' DataFormatString="{0:C2}"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("ugov_iznos") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblUkIznos" runat="server" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Završio" SortExpression="zavrsio">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnZavrsio" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="zavrsio">Završio</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderZavrsio" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("zavrsio") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("zavrsio") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Planirani završetak" SortExpression="teren">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnTeren" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="teren">Planirani završetak</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderTeren" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("teren") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("teren") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="pon_nar" HeaderText="Ponuda/nar." SortExpression="pon_nar" />--%>
                        <asp:TemplateField HeaderText="Pon/ nar." SortExpression="pon_nar">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnPon_nar" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="pon_nar">Pon/ nar.</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderPon_nar" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label15" runat="server" Text='<%# Bind("pon_nar") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("pon_nar") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- <asp:BoundField DataField="faktura_sifra" HeaderText="Broj računa" SortExpression="faktura_sifra" />--%>
                        <asp:TemplateField HeaderText="Br. računa" SortExpression="faktura_sifra">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnFakt_sif" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="faktura_sifra">Br. računa</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderFakt_sif" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label16" runat="server" Text='<%# Bind("faktura_sifra") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox16" runat="server" Text='<%# Bind("faktura_sifra") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%--  <asp:TemplateField HeaderText="Plaćeno" SortExpression="placeno">
                     <HeaderTemplate>
                            <asp:LinkButton ID="lnkbtnPlaceno" runat="server" CommandName="Sort" CommandArgument="placeno">Plaćeno</asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderPlaceno" runat="server"></asp:PlaceHolder>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("placeno") %>' Enabled="false" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("placeno") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>--%>
                        <%--<asp:BoundField DataField="lova" HeaderText="Lova" SortExpression="lova" DataFormatString="{0:C2}"
                            HtmlEncode="False" />--%>
                        <asp:TemplateField HeaderText="Lova" SortExpression="lova" Visible="false">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnLova" ForeColor="Black" runat="server" CommandName="Sort"
                                    CommandArgument="lova">Lova</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderLova" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label18" runat="server" Text='<%# Bind("lova") %>' DataFormatString="{0:C2}"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox18" runat="server" Text='<%# Bind("lova") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblUkLova" runat="server" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:BoundField />
                        <asp:TemplateField HeaderText="ind_prilog" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblInd" runat="server" Text='<%# Bind("ind_prilog") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("sifra", "Prilozi.aspx?ID={0}") %>'
                                    Text="Prilozi"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#B9C9FE" Font-Bold="True" ForeColor="Black" Font-Size="Larger" />
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
            <%--</div>--%>
            <%-- </div>
                            <div id="DivFooterRow" style="overflow: hidden">
                            </div>
                       </div>--%>
            <%--  </td>
                </tr>--%>
            <%--  </div>--%>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;
            <asp:ObjectDataSource ID="dsStatus" runat="server" SelectMethod="DohvatiStatuse"
                TypeName="Geodezija.Helper"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsVrsta" runat="server" SelectMethod="DohvatiPosao" TypeName="Geodezija.Helper"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsKat" runat="server" SelectMethod="DohvatiKat" TypeName="Geodezija.Helper"></asp:ObjectDataSource>
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Projekt] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Projekt] ([naziv], [dat_predajedgu], [dat_predaja], [ugov_iznos], [statusID], [kreirao], [vrstaID], [teren], [narucen_kat], [cijena_kat], [stigli_kat], [dgu_klasa], [dgu_uru], [lova], [kat_opc], [kat_cest], [dat_kreiranje], [putanja_projekt], [dat_azuriranja], [klijentID], [arh_broj], [pon_nar], [faktura], [opis_placanja], [placeno], [dat_potvrde], [racun_iznos], [ponuda_ind], [faktura_ind], [ponuda_sifra], [faktura_sifra], [dat_zavrs]) VALUES (@naziv, @dat_predajedgu, @dat_predaja, @ugov_iznos, @statusID, @kreirao, @vrstaID, @teren, @narucen_kat, @cijena_kat, @stigli_kat, @dgu_klasa, @dgu_uru, @lova, @kat_opc, @kat_cest, @dat_kreiranje, @putanja_projekt, @dat_azuriranja, @klijentID, @arh_broj, @pon_nar, @godina, @placeno, @dat_potvrde, @racun_iznos, @ponuda_ind, @faktura_ind, @ponuda_sifra, @faktura_sifra, @dat_zavrs)"
                SelectCommand="SELECT * FROM [Projekt] ORDER BY dat_kreiranje DESC" UpdateCommand="UPDATE [Projekt] SET [naziv] = @naziv, [dat_predajedgu] = @dat_predajedgu, [dat_predaja] = @dat_predaja, [ugov_iznos] = @ugov_iznos, [statusID] = @statusID, [kreirao] = @kreirao, [vrstaID] = @vrstaID, [teren] = @teren, [narucen_kat] = @narucen_kat, [cijena_kat] = @cijena_kat, [stigli_kat] = @stigli_kat, [dgu_klasa] = @dgu_klasa, [dgu_uru] = @dgu_uru, [lova] = @lova, [kat_opc] = @kat_opc, [kat_cest] = @kat_cest, [dat_kreiranje] = @dat_kreiranje, [putanja_projekt] = @putanja_projekt, [dat_azuriranja] = @dat_azuriranja, [klijentID] = @klijentID, [arh_broj] = @arh_broj, [pon_nar] = @pon_nar, [godina] = @godina, [placeno] = @placeno, [dat_potvrde] = @dat_potvrde, [racun_iznos] = @racun_iznos, [ponuda_ind] = @ponuda_ind, [faktura_ind] = @faktura_ind, [ponuda_sifra] = @ponuda_sifra, [faktura_sifra] = @faktura_sifra, [dat_zavrs] = @dat_zavrs WHERE [sifra] = @sifra">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="naziv" Type="String" />
                    <asp:Parameter Name="dat_predajedgu" Type="DateTime" />
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
                    <asp:Parameter Name="kat_opc" Type="Int32" />
                    <asp:Parameter Name="kat_cest" Type="String" />
                    <asp:Parameter Name="dat_kreiranje" Type="DateTime" />
                    <asp:Parameter Name="putanja_projekt" Type="String" />
                    <asp:Parameter Name="dat_azuriranja" Type="DateTime" />
                    <asp:Parameter Name="klijentID" Type="Int32" />
                    <asp:Parameter Name="arh_broj" Type="Int32" />
                    <asp:Parameter Name="pon_nar" Type="String" />
                    <asp:Parameter Name="godina" Type="Int32" />
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
                    <asp:Parameter Name="dat_predajedgu" Type="DateTime" />
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
                    <asp:Parameter Name="kat_opc" Type="Int32" />
                    <asp:Parameter Name="kat_cest" Type="String" />
                    <asp:Parameter Name="dat_kreiranje" Type="DateTime" />
                    <asp:Parameter Name="putanja_projekt" Type="String" />
                    <asp:Parameter Name="dat_azuriranja" Type="DateTime" />
                    <asp:Parameter Name="klijentID" Type="Int32" />
                    <asp:Parameter Name="arh_broj" Type="Int32" />
                    <asp:Parameter Name="pon_nar" Type="String" />
                    <asp:Parameter Name="godina" Type="Int32" />
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
            &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                SelectCommand="SELECT Projekt.sifra, Projekt.arh_broj, Projekt.dat_predajedgu,Projekt.dat_predaja, Projekt.naziv, Projekt.ugov_iznos, Projekt.kat_opc,Projekt.kat_cest,Projekt.narucen_kat,Projekt.stigli_kat,Projekt.opis_placanja,Projekt.kreirao, Projekt.teren,Projekt.pon_nar,Projekt.faktura, Projekt.placeno, Projekt.lova, Klijent.naziv AS Klijent,Klijent.oib, statusi.naziv AS Status, vrsta_posla.naziv AS Vrsta FROM Projekt INNER JOIN Klijent ON Projekt.klijentID = Klijent.sifra INNER JOIN statusi ON Projekt.statusID = statusi.sifra INNER JOIN vrsta_posla ON Projekt.vrstaID = vrsta_posla.sifra ORDER BY Projekt.sifra DESC"
                FilterExpression="naziv LIKE '%{0}%' AND statusID='{1}' AND vrstaID='{2}' AND kat_opc LIKE '%{3}%'">
                <FilterParameters>
                    <asp:ControlParameter Name="naziv" ControlID="txtTraziPredmet" PropertyName="Text"
                        DefaultValue="" />
                    <asp:ControlParameter Name="statusID" ControlID="ddlStatus" PropertyName="SelectedValue"
                        DefaultValue="-1" />
                    <asp:ControlParameter Name="vrstaID" ControlID="ddlVrsta" PropertyName="SelectedValue"
                        DefaultValue="-1" />
                    <asp:ControlParameter Name="kat_opc" ControlID="ddlKat" PropertyName="SelectedValue"
                        DefaultValue="-1" />
                </FilterParameters>
            </asp:SqlDataSource>
        </fieldset>
    </div>
</asp:Content>
