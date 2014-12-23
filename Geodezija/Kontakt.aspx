<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation = "false"
    CodeBehind="Kontakt.aspx.cs" Inherits="Geodezija.Kontakt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
     <script type="text/javascript" src="Scripts/jquery.blockUI.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
     <script type="text/javascript" src="Scripts/jscrollable.js"></script>
    <script type="text/javascript" src="Scripts/scrollabletable.js"></script>
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
            $("[id*=GridView1] td").hover(function () {
                $("td", $(this).closest("tr")).addClass("hover_row");
            }, function () {
                $("td", $(this).closest("tr")).removeClass("hover_row");
            });
        });
    </script>
  <%--   <script language="javascript" type="text/javascript">
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
    
    </script>--%>
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
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="server">
    <div id="projectreport">
        <a name="content_start" id="content_start"></a>
        <br />
        <fieldset style="font-size: large">
            <h2 class="none">
            &nbsp;&nbsp;
            <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
            &nbsp;<asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
            &nbsp;<asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />  &nbsp;<asp:LinkButton ID="lnkDummy" runat="server" Visible ="false"></asp:LinkButton>
            </h2>
            <legend>RAD SA KONTAKTIMA</legend>
            <p>
                &nbsp;&nbsp;&nbsp;&nbsp;
                Traženje kontakta po uzorku prezimena:
            </p>
            &nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtTraziKlijenta" runat="server"></asp:TextBox>
            &nbsp;&nbsp;
            <asp:Button ID="btnTrazi" runat="server" Text="Traži" CssClass="botuni" Height="25px"
                Width="53px" />
            <%-- <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;">--%>
            <asp:GridView ID="GridView1" runat="server" 
                AllowSorting="True" CellPadding="4" GridLines="None"
                AutoGenerateColumns="False" CssClass="CustomView" DataKeyNames="kontaktID" DataSourceID="SqlDataSource1"
                PageSize="5" Height="80%" Width="98%" ShowHeaderWhenEmpty="True" 
                onrowdatabound="GridView1_RowDataBound" 
                onselectedindexchanged="GridView1_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <EmptyDataTemplate>
                    <asp:HyperLink ID="NewKontakt" Text="Trenutno nema podataka, kliknite za dodavanje"
                        ImageUrl="~/Styles/images/icon-save.gif" runat="server" />
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="naziv" HeaderText="Klijent" 
                        SortExpression="klijent" />
                    <asp:BoundField DataField="kontaktID" HeaderText="Kontakt ID" ReadOnly="True" 
                        SortExpression="kontaktID" />
                    <asp:BoundField DataField="ime" HeaderText="Ime" SortExpression="ime" />
                    <asp:BoundField DataField="prezime" HeaderText="Prezime" 
                        SortExpression="prezime" />
                    <asp:BoundField DataField="titula" HeaderText="Titula" 
                        SortExpression="titula" />
                    <asp:BoundField DataField="tel1" HeaderText="Tel1" SortExpression="tel1" />
                    <asp:BoundField DataField="mob1" HeaderText="Mob1" SortExpression="mob1" />
                     <asp:TemplateField HeaderText="E-mail" SortExpression="email">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("email") %>' NavigateUrl='<%# Eval("email", "mailto:{0}") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
              <div id="mask">
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Kontakt] WHERE [kontaktID] = @kontaktID" InsertCommand="INSERT INTO [Kontakt] ([klijentID], [kontaktID], [ime], [prezime], [titula], [tel1], [tel2], [mob1], [mob2], [email], [biljeska]) VALUES (@klijentID, @kontaktID, @ime, @prezime, @titula, @tel1, @tel2, @mob1, @mob2, @email, @biljeska)"
                SelectCommand="SELECT Kontakt.klijentID, Kontakt.kontaktID, Kontakt.ime, Kontakt.prezime, Kontakt.titula, Kontakt.tel1, Kontakt.tel2, Kontakt.mob1, Kontakt.mob2, Kontakt.email, Kontakt.biljeska, Klijent.naziv FROM Kontakt INNER JOIN Klijent ON Kontakt.klijentID = Klijent.sifra WHERE (Kontakt.klijentID = @klijentID OR @klijentID IS NULL) ORDER BY Kontakt.kontaktID DESC" CancelSelectOnNullParameter="false"
                UpdateCommand="UPDATE [Kontakt] SET [klijentID] = @klijentID, [ime] = @ime, [prezime] = @prezime, [titula] = @titula, [tel1] = @tel1, [tel2] = @tel2, [mob1] = @mob1, [mob2] = @mob2, [email] = @email, [biljeska] = @biljeska WHERE [kontaktID] = @kontaktID"
                FilterExpression="prezime LIKE '{0}%'">
                <FilterParameters>
                    <asp:ControlParameter Name="prezime" ControlID="txtTraziKlijenta" PropertyName="Text" />
                </FilterParameters>
                <DeleteParameters>
                    <asp:Parameter Name="kontaktID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="klijentID" Type="Int32" />
                    <asp:Parameter Name="kontaktID" Type="Int32" />
                    <asp:Parameter Name="ime" Type="String" />
                    <asp:Parameter Name="prezime" Type="String" />
                    <asp:Parameter Name="titula" Type="String" />
                    <asp:Parameter Name="tel1" Type="String" />
                    <asp:Parameter Name="tel2" Type="String" />
                    <asp:Parameter Name="mob1" Type="String" />
                    <asp:Parameter Name="mob2" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="biljeska" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="klijentID" QueryStringField="ID" Type="Int32"
                    DefaultValue="" ConvertEmptyStringToNull="True" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="klijentID" Type="Int32" />
                    <asp:Parameter Name="ime" Type="String" />
                    <asp:Parameter Name="prezime" Type="String" />
                    <asp:Parameter Name="titula" Type="String" />
                    <asp:Parameter Name="tel1" Type="String" />
                    <asp:Parameter Name="tel2" Type="String" />
                    <asp:Parameter Name="mob1" Type="String" />
                    <asp:Parameter Name="mob2" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="biljeska" Type="String" />
                    <asp:Parameter Name="kontaktID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            UREĐIVANJE PODATAKA O IZABRANOM KONTAKTU<br />
            <br />
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="kontaktID"
                DataSourceID="SqlDataSource2" Height="50px" Width="997px" 
                BackColor="White" BorderColor="#E7E7FF"
                BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                GridLines="Horizontal" Font-Size="Medium" 
                oniteminserting="DetailsView1_ItemInserting">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <EmptyDataTemplate>
                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New">Dodaj kontakt</asp:LinkButton>
                </EmptyDataTemplate>
                <Fields>
                    <asp:TemplateField HeaderText="Klijent " SortExpression="klijentID">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlKlijent" runat="server" SelectedValue='<%# Bind("klijentID") %>'
                                DataSourceID="ObjectDataSource1" DataTextField="Naziv" DataValueField="Sifra" 
                                Width="175px">
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                                SelectMethod="DohvatiKlijente" TypeName="Geodezija.Helper">
                            </asp:ObjectDataSource>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="ddlKlijent" runat="server" SelectedValue='<%# Bind("klijentID") %>'
                                DataSourceID="ObjectDataSource2" DataTextField="Naziv" DataValueField="Sifra" 
                                Height="19px" Width="260px">
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                                SelectMethod="DohvatiKlijente" TypeName="Geodezija.Helper">
                            </asp:ObjectDataSource>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("klijentID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="kontaktID" HeaderText="Kontakt ID" ReadOnly="True" InsertVisible="false"
                        SortExpression="kontaktID" />
                    <asp:BoundField DataField="ime" HeaderText="Ime" SortExpression="ime" />
                    <asp:BoundField DataField="prezime" HeaderText="Prezime" 
                        SortExpression="prezime" />
                    <asp:BoundField DataField="titula" HeaderText="Titula" 
                        SortExpression="titula" />
                    <asp:BoundField DataField="tel1" HeaderText="Tel1" SortExpression="tel1" />
                    <asp:BoundField DataField="tel2" HeaderText="Tel2" SortExpression="tel2" />
                    <asp:BoundField DataField="mob1" HeaderText="Mob1" SortExpression="mob1" />
                    <asp:BoundField DataField="mob2" HeaderText="Mob2" SortExpression="mob2" />
                    <asp:BoundField DataField="email" HeaderText="E-mail" SortExpression="email" />
                    <asp:BoundField DataField="biljeska" HeaderText="Bilješka" 
                        SortExpression="biljeska" >
                         <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                          ForeColor="Black"  Font-Size="Large"    CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Font-Size="Large"
                              ForeColor="Black"  Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                           ForeColor="Black"  Font-Size="Large"   CommandName="Insert" Text="Insert"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel" Font-Size="Large"
                              ForeColor="Black"  Text="Cancel"></asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="Edit" Font-Size="Large"
                               ForeColor="Black" Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                              ForeColor="Black"  Text="New" Font-Size="Large"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Želite obrisati zapis?');"
                              ForeColor="Black"  CommandName="Delete" Text="Delete" Font-Size="Large"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="Black" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="Black" />
            </asp:DetailsView>
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Kontakt] WHERE [kontaktID] = @kontaktID"
                 InsertCommand="INSERT INTO [Kontakt] ([klijentID], [ime], [prezime], [titula], [tel1], [tel2], [mob1], [mob2], [email], [biljeska]) VALUES (@klijentID, @ime, @prezime, @titula, @tel1, @tel2, @mob1, @mob2, @email, @biljeska)"
                SelectCommand="SELECT * FROM [Kontakt] WHERE ([kontaktID] = @kontaktID)" 
                UpdateCommand="UPDATE [Kontakt] SET [klijentID] = @klijentID, [ime] = @ime, [prezime] = @prezime, [titula] = @titula, [tel1] = @tel1, [tel2] = @tel2, [mob1] = @mob1, [mob2] = @mob2, [email] = @email, [biljeska] = @biljeska WHERE [kontaktID] = @kontaktID" 
                ondeleted="SqlDataSource2_Deleted" oninserted="SqlDataSource2_Inserted" 
                onupdated="SqlDataSource2_Updated">
                <DeleteParameters>
                    <asp:Parameter Name="kontaktID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                      <asp:ControlParameter Name="klijentID" Type="Int32" ControlID="DetailsView1$ddlKlijent" PropertyName="SelectedItem.Value" />
                    <asp:Parameter Name="ime" Type="String" />
                    <asp:Parameter Name="prezime" Type="String" />
                    <asp:Parameter Name="titula" Type="String" />
                    <asp:Parameter Name="tel1" Type="String" />
                    <asp:Parameter Name="tel2" Type="String" />
                    <asp:Parameter Name="mob1" Type="String" />
                    <asp:Parameter Name="mob2" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="biljeska" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="kontaktID" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                 <asp:ControlParameter Name="klijentID" Type="Int32" ControlID="DetailsView1$ddlKlijent" PropertyName="SelectedItem.Value" />
                   <%-- <asp:Parameter Name="klijentID" Type="Int32" />--%>
                    <asp:Parameter Name="ime" Type="String" />
                    <asp:Parameter Name="prezime" Type="String" />
                    <asp:Parameter Name="titula" Type="String" />
                    <asp:Parameter Name="tel1" Type="String" />
                    <asp:Parameter Name="tel2" Type="String" />
                    <asp:Parameter Name="mob1" Type="String" />
                    <asp:Parameter Name="mob2" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="biljeska" Type="String" />
                    <asp:Parameter Name="kontaktID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </fieldset>
    </div>
</asp:Content>
