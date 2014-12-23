<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="Klijenti.aspx.cs" Inherits="Geodezija.Klijenti" %>

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
    <%-- <div id="HeaderDiv">
            </div>--%>
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
            color: #272626;
            width: 98%;
            height: 746px;
            overflow: hide;
            position: relative;
            left: 2px;
            top: 80%;
        }
    </style>
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
                <asp:ImageButton ID="ImageButton1" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                    OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
                &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                    OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
                &nbsp;<asp:ImageButton ID="ImageButton3" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                    OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />
                &nbsp;</h2>
            <legend>RAD SA KLIJENTIMA</legend>
            <h4 style="width: 1086px">
            </h4>
            <asp:Button ID="Button1" runat="server" CssClass="botuni" Height="25px" OnClick="Button1_Click"
                Text="Novi unos" ToolTip="Unos novoga klijenta" Width="100px" />
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnKontakt" runat="server" CssClass="botuni" Height="25px" OnClick="btnKontakt_Click"
                Text="Novi kontakt" ToolTip="Unos novoga klijenta" Width="100px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Naziv:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNaziv" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Font-Size="10pt" Text="Vrsta klijenta:"></asp:Label>
            &nbsp;<asp:DropDownList ID="ddlVrsta" runat="server" Height="19px"
                Width="158px" AppendDataBoundItems="True">
                <asp:ListItem Selected="True" Value="">Svi</asp:ListItem>
                <asp:ListItem>Potencijalni</asp:ListItem>
                <asp:ListItem>Nepovezani</asp:ListItem>
                <asp:ListItem>Standardni</asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp; Šifra klijenta:&nbsp;
            <asp:TextBox ID="txtSifra" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnTrazi" runat="server" Text="Traži" CssClass="botuni" Height="25px"
                Width="49px" OnClick="btnTrazi_Click" />
            <%--Wrapper Div which will scroll the GridView--%><%-- <HeaderStyle Wrap="False" />--%><%-- <HeaderStyle Wrap="False" />--%><%-- <HeaderStyle Wrap="False" />--%>
            <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;"
                onscroll="Onscrollfnction();">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="false" AutoGenerateColumns="False"
                    CellPadding="4" DataKeyNames="sifra" EmptyDataText="There are no data records to display." Font-Size="Medium"
                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CssClass="CustomView" GridLines="Both"
                    ShowHeaderWhenEmpty="True" Height="89%" Width="98%" OnRowDataBound="GridView1_RowDataBound"
                 OnRowCommand="GridView1_RowCommand" AlternatingRowStyle-CssClass="even">
                    
                    <EmptyDataTemplate>
                        <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka, kliknite za dodavanje"
                            ImageUrl="~/Styles/images/icon-save.gif" NavigateUrl="~/KlijentiCRUD.aspx?ID=999"
                            runat="server" />
                    </EmptyDataTemplate>
                    <Columns>
                      
                        <%-- <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra" 
                            InsertVisible="False" >
                     
                        </asp:BoundField>--%>
                        <%--<asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv">
                           <%-- <ItemStyle  Wrap="False" />--%>
                        <asp:TemplateField HeaderText="Naziv" SortExpression="naziv">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnNaziv" runat="server" CommandName="Sort" CommandArgument="naziv">Naziv</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderNaziv" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("naziv") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("naziv") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Grad" SortExpression="grad">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnGrad" runat="server" CommandName="Sort" CommandArgument="grad">Grad</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderGrad" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label17" runat="server" Text='<%# Bind("grad") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("grad") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%--  <asp:BoundField DataField="grad" HeaderText="Grad" SortExpression="grad">
                          <%--  <ItemStyle Wrap="False" />--%>
                        <asp:BoundField DataField="adresa" HeaderText="Adresa" >
                            <%-- <ControlStyle Width="14%" />--%>
                            <%--<ItemStyle Wrap="False" />--%>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="E-mail" >
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("email") %>' NavigateUrl='<%# Eval("email", "mailto:{0}") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="mob" HeaderText="Mob" >
                            <%--<ControlStyle Width="14%" />
                            <HeaderStyle Wrap="True" />--%>
                            <%--<ItemStyle Wrap="False" />--%>
                        </asp:BoundField>
                        <asp:BoundField DataField="tel1" HeaderText="Tel 1" >
                            <%--   <ControlStyle Width="14%" />--%>
                            <%--<ItemStyle Wrap="False" />--%>
                        </asp:BoundField>
                        <asp:BoundField DataField="oib" HeaderText="OIB" />
                        <asp:BoundField DataField="ziro" HeaderText="Žiro"  Visible="false" />
                        <asp:CheckBoxField DataField="potencijalni" HeaderText="Potencijalni" />
                        <asp:CheckBoxField DataField="povezani" HeaderText="Nepovezani"  />
                        <asp:BoundField DataField="titula" HeaderText="Titula"  />
                        <asp:BoundField DataField="napomena" HeaderText="Napomena"  />
                        <asp:TemplateField HeaderText="ind_prilog" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblInd" runat="server" Text='<%# Bind("ind_prilog") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ind_kontakt" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblIndKon" runat="server" Text='<%# Bind("ind_kontakt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField HeaderText="ID" SortExpression="sifra">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lnkbtnSifra" runat="server" CommandName="Sort" CommandArgument="sifra">ID</asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderSifra" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label27" runat="server" Text='<%# Bind("sifra") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox27" runat="server" Text='<%# Bind("sifra") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- <asp:HyperLinkField DataNavigateUrlFields="sifra" DataNavigateUrlFormatString="KlijentiPriloz.aspx?ID={0}"
                            Text="Prilozi" />--%>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="hlPrilozi" runat="server" CssClass="stil" NavigateUrl='<%# Eval("sifra", "KlijentiPriloz.aspx?ID={0}") %>'
                                    Text="Prilozi"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink9" runat="server" CssClass="stil" NavigateUrl='<%# Eval("sifra", "Kontakt.aspx?ID={0}") %>'
                                    Text="Kontakti"></asp:HyperLink>
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
            <%-- <ItemStyle  Wrap="False" />--%>
            <asp:LinkButton ID="lnkDummy" runat="server" Visible="false"></asp:LinkButton>
            <%--  <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
              
                ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                SelectCommand="SELECT sifra, naziv, grad, adresa, email, mob, tel1, tel2, napomena, oib, tekuci, ziro, potencijalni, kreirao, dat_kreiranja, dat_azu, pbr, titula, povezani, vrsta, ind_prilog, ind_kontakt FROM Klijent ORDER BY naziv ASC"
               
                FilterExpression="naziv LIKE '{0}%' OR vrsta='{1}'">
                <FilterParameters>
                    <asp:ControlParameter Name="naziv" ControlID="txtTraziKlijenta" PropertyName="Text"  ConvertEmptyStringToNull="true"/>
                   <asp:ControlParameter Name="vrsta" ControlID="DropDownList1" PropertyName="SelectedValue" ConvertEmptyStringToNull="true"  />
                </FilterParameters>
                
            </asp:SqlDataSource>--%>
           
            <br />
            <br />
        </fieldset>
    </div>
</asp:Content>
           
