<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Aktivnosti.aspx.cs" Inherits="Geodezija.Aktivnosti" EnableEventValidation="false" %>

<%@ Register TagPrefix="cc1" Namespace="AspNetNotifyControl" Assembly="AspNetNotifyControl" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <link href="Styles/jquery.jnotify.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.10.4.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-timepicker-addon.js"></script>
    <script type="text/javascript" src="/Scripts/jquery.ui.datepicker-hr.js"></script>
    <script src="Scripts/jquery.jnotify.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-timepicker-hr.js" type="text/javascript"></script>
    <%-- <script type="text/javascript">
        $(function () {
           
            $('.DateTimePicker').datepicker();
          $.datepicker.regional['hr']
        });
    </script>--%>
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
        jQuery(function ($) {
            $('.Pokupi').datetimepicker();
            $.datepicker.regional['hr']
            $.timepicker.regional['hr']
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
        <div>
            <cc1:AspNetNotify ID="AspNetNotify1" runat="server" Sticky="true" />
        </div>
        <br />
        <fieldset>
            <h2 class="none">
                &nbsp;</h2>
            <legend>PREGLED AKTIVNOSTI</legend>
            <br />
            &nbsp;&nbsp;&nbsp; Filtriraj po djelatniku:&nbsp;
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                DataTextField="UserName" DataValueField="UserName" AutoPostBack="True" Height="23px"
                Width="152px">
            </asp:DropDownList>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="CustomGetAllUsers"
                TypeName="Geodezija.Helper"></asp:ObjectDataSource>
            <%-- <div id="scroll">--%>
            <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;"
                onscroll="Onscrollfnction();">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1" ForeColor="#333333"
                    GridLines="None" EnableModelValidation="False" Height="80%" Width="90%" CssClass="CustomView"
                    ShowHeaderWhenEmpty="True" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataTemplate>
                        <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka, kliknite za dodavanje"
                            ImageUrl="~/Styles/images/icon-save.gif" runat="server" />
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra"
                            InsertVisible="False" />
                        <asp:BoundField DataField="pocetak" HeaderText="Početak" SortExpression="pocetak" />
                        <asp:BoundField DataField="kraj" HeaderText="Kraj" SortExpression="kraj" />
                        <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
                        <asp:BoundField DataField="odgovoran" HeaderText="Odgovoran" SortExpression="odgovoran" />
                        <asp:CheckBoxField DataField="izvrsena" HeaderText="izvrsena" SortExpression="izvrsena" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Aktivnost] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Aktivnost] ([pocetak], [kraj], [opis], [odgovoran]) VALUES (@pocetak, @kraj, @opis, @odgovoran)"
                ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                SelectCommand="SELECT [sifra], [pocetak], [kraj], [opis], [odgovoran], [izvrsena] FROM [Aktivnost] WHERE ([odgovoran] = @odgovoran) OR [odgovoran] IS NULL"
                UpdateCommand="UPDATE [Aktivnost] SET [pocetak] = @pocetak, [kraj] = @kraj, [opis] = @opis, [odgovoran] = @odgovoran, [izvrsena] = @izvrsena WHERE [sifra] = @sifra">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="pocetak" Type="DateTime" />
                    <asp:Parameter Name="kraj" Type="DateTime" />
                    <asp:Parameter Name="opis" Type="String" />
                    <asp:Parameter Name="odgovoran" Type="String" />
                    <asp:Parameter Name="izvrsena" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="odgovoran" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="pocetak" Type="DateTime" />
                    <asp:Parameter Name="kraj" Type="DateTime" />
                    <asp:Parameter Name="opis" Type="String" />
                    <asp:Parameter Name="odgovoran" Type="String" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                    <asp:Parameter Name="izvrsena" Type="Boolean" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            &nbsp; &nbsp;
            <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
            &nbsp;<asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
            &nbsp;<asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />
            &nbsp;&nbsp;&nbsp;
            <br />
            UREĐIVANJE PODATAKA O IZABRANOJ AKTIVNOSTI<br />
            <br />
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="3"
                DataKeyNames="sifra" DataSourceID="SqlDataSource2" GridLines="Horizontal" Height="50px"
                Width="617px" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                OnItemDeleted="DetailsView1_ItemDeleted" OnItemInserted="DetailsView1_ItemInserted"
                OnItemUpdated="DetailsView1_ItemUpdated" OnItemInserting="DetailsView1_ItemInserting"
                OnItemUpdating="DetailsView1_ItemUpdating" Font-Size="Medium" 
                ForeColor="Black">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <EmptyDataTemplate>
                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                        Text="Dodaj aktivnost"></asp:LinkButton>
                </EmptyDataTemplate>
                <Fields>
                    <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="sifra" />
                    <asp:TemplateField HeaderText="Početak" SortExpression="pocetak">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("pocetak") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="Pokupi" Text='<%# Bind("pocetak") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                ErrorMessage="Početak je obavezno polje">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="Pokupi" Text='<%# Bind("pocetak") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1"
                                ErrorMessage="Početak je obavezno polje">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Kraj" SortExpression="kraj">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("kraj") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="Pokupi" Text='<%# Bind("kraj") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox2"
                                ErrorMessage=" Kraj je obavezno polje">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="Pokupi" Text='<%# Bind("kraj") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox2"
                                ErrorMessage=" Kraj je obavezno polje">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis">
                        <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Odgovoran" SortExpression="odgovoran">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="odsOdg" DataTextField="UserName"
                                DataValueField="UserName" AppendDataBoundItems="true" SelectedValue='<%#Bind("odgovoran") %>'>
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="odsOdg" runat="server" SelectMethod="DohvatiUsername" TypeName="Geodezija.Helper">
                            </asp:ObjectDataSource>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="ddlOdg" runat="server" DataSourceID="ObjectDataSource2" DataTextField="UserName"
                                DataValueField="UserName">
                            </asp:DropDownList>
                            <br />
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="DohvatiUsername"
                                TypeName="Geodezija.Helper"></asp:ObjectDataSource>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("odgovoran") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="izvrsena" HeaderText="Izvršena" SortExpression="izvrsena" />
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                             ForeColor="Black"   CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" ForeColor="Black"
                                Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                            ForeColor="Black"    CommandName="Insert" Text="Insert"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel" ForeColor="Black"
                                Text="Cancel"></asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="Edit" ForeColor="Black"
                                Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New" ForeColor="Black"
                                Text="New"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton7" ForeColor="Black" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                                CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="Black" />
            </asp:DetailsView>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Aktivnost] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Aktivnost] ([pocetak], [kraj], [opis], [odgovoran],[izvrsena] ) VALUES (@pocetak, @kraj, @opis, @odgovoran, @izvrsena)"
                SelectCommand="SELECT * FROM [Aktivnost] WHERE ([sifra] = @sifra)" UpdateCommand="UPDATE [Aktivnost] SET [pocetak] = @pocetak, [kraj] = @kraj, [opis] = @opis, [odgovoran] = @odgovoran, [izvrsena]= @izvrsena WHERE [sifra] = @sifra"
                OnInserted="SqlDataSource2_Inserted" OnUpdated="SqlDataSource2_Updated" OnInserting="SqlDataSource2_Inserting"
                OnUpdating="SqlDataSource2_Updating">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="pocetak" Type="DateTime" />
                    <asp:Parameter Name="kraj" Type="DateTime" />
                    <asp:Parameter Name="opis" Type="String" />
                    <asp:ControlParameter Name="odgovoran" Type="String" ControlID="DetailsView1$ddlOdg"
                        PropertyName="SelectedValue" />
                    <asp:Parameter Name="izvrsena" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="sifra" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="pocetak" Type="DateTime" />
                    <asp:Parameter Name="kraj" Type="DateTime" />
                    <asp:Parameter Name="opis" Type="String" />
                    <asp:ControlParameter Name="odgovoran" Type="String" ControlID="DetailsView1$ddlOdg"
                        PropertyName="SelectedValue" />
                    <asp:Parameter Name="izvrsena" Type="Boolean" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
        </fieldset>
    </div>
</asp:Content>
