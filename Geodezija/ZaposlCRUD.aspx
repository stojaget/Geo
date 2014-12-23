<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"
 CodeBehind="ZaposlCRUD.aspx.cs" Inherits="Geodezija.ZaposlCRUD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
 <script type="text/javascript">
         $(function () {

             $('.Picker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn'});
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
                &nbsp;</h2>
            <legend> PREGLED PODATAKA O DJELATNIKU</legend>
    <p style="width: 880px">
        </p>
    
        <asp:DetailsView ID="DetailsView1" runat="server" 
            AutoGenerateRows="False" CellPadding="3" DataKeyNames="sifra" 
            DataSourceID="SqlDataSource1" GridLines="Horizontal" 
            Height="50px" Width="878px" onitemdeleted="DetailsView1_ItemDeleted" 
            oniteminserted="DetailsView1_ItemInserted" BackColor="White" 
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                Font-Size="Medium">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
             <EmptyDataTemplate>
            <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" 
                            CommandName="New" Text="Dodaj zaposlenika"></asp:LinkButton>
        </EmptyDataTemplate>
            <Fields>
                <asp:BoundField DataField="sifra" HeaderText="sifra" 
                    SortExpression="sifra" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="ime" HeaderText="ime" SortExpression="ime" />
                <asp:BoundField DataField="prezime" HeaderText="prezime" 
                    SortExpression="prezime" />
                <asp:BoundField DataField="oib" HeaderText="oib" 
                    SortExpression="oib" />
                <asp:BoundField DataField="mob" HeaderText="mob" SortExpression="mob" />
                <asp:BoundField DataField="tel" HeaderText="tel" SortExpression="tel" />
                <asp:BoundField DataField="fax" HeaderText="fax" SortExpression="fax" />
                <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
                <asp:BoundField DataField="username" HeaderText="username" 
                    SortExpression="username" />
                <asp:BoundField DataField="adresa" HeaderText="adresa" 
                    SortExpression="adresa" />
                <asp:BoundField DataField="grad" HeaderText="grad" SortExpression="grad" />
                 <asp:TemplateField HeaderText="dat_zaposlenja" SortExpression="dat_zaposlenja">
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("dat_zaposlenja", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="Picker" Text='<%# Bind("dat_zaposlenja", "{0:d}") %>'></asp:TextBox>
                           
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox14" runat="server" CssClass="Picker" Text='<%# Bind("dat_zaposlenja", "{0:d}") %>'></asp:TextBox>
                           
                        </InsertItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="dat_prestanka" SortExpression="dat_prestanka">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("dat_prestanka", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="Picker" Text='<%# Bind("dat_prestanka", "{0:d}") %>'></asp:TextBox>
                           
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="Picker" Text='<%# Bind("dat_prestanka", "{0:d}") %>'></asp:TextBox>
                           
                        </InsertItemTemplate>
                    </asp:TemplateField>
                
                    <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True"  OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                            CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True"  OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                            CommandName="Insert" Text="Insert"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" 
                            CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" 
                            CommandName="New" Text="New"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                            CommandName="Delete" Text="Delete"></asp:LinkButton>
                             <asp:LinkButton ID="LinkButton8" runat="server" CausesValidation="False" 
                            CommandName="Prilozi" Text="Prilozi"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        </asp:DetailsView>
       
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            SelectCommand="SELECT * FROM [Radnik] WHERE ([sifra] = @sifra)" 
            DeleteCommand="DELETE FROM [Radnik] WHERE [sifra] = @sifra" 
            InsertCommand="INSERT INTO [Radnik] ([ime], [prezime], [oib], [dat_zaposlenja], [mob], [tel], [fax], [email], [username], [adresa], [grad], [dat_prestanka]) VALUES (@ime, @prezime, @oib, @dat_zaposlenja, @mob, @tel, @fax, @email, @username, @adresa, @grad, @dat_prestanka)" 
            
                UpdateCommand="UPDATE [Radnik] SET [ime] = @ime, [prezime] = @prezime, [oib] = @oib, [dat_zaposlenja] = @dat_zaposlenja, [mob] = @mob, [tel] = @tel, [fax] = @fax, [email] = @email, [username] = @username, [adresa] = @adresa, [grad] = @grad, [dat_prestanka] = @dat_prestanka WHERE [sifra] = @sifra">
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
                <asp:Parameter Name="adresa" Type="String" />
                <asp:Parameter Name="grad" Type="String" />
                <asp:Parameter Name="dat_prestanka" Type="DateTime" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="sifra" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
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
                <asp:Parameter Name="adresa" Type="String" />
                <asp:Parameter Name="grad" Type="String" />
                <asp:Parameter Name="dat_prestanka" Type="DateTime" />
                <asp:Parameter Name="sifra" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
            <h3 style="width: 845px">
        PREGLED POVEZANIH AKTIVNOSTI</h3>
    
    <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
        <asp:GridView ID="GridView1" runat="server" 
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
            DataKeyNames="sifra" DataSourceID="sdsAkt" ForeColor="#333333" GridLines="None" 
            onselectedindexchanged="GridView1_SelectedIndexChanged" Height="91%" Width="97%"
            CssClass="CustomView" ShowHeaderWhenEmpty="True">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
             <EmptyDataTemplate>
                        <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka, kliknite za dodavanje" 
                             ImageUrl="~/Styles/images/icon-save.gif" NavigateUrl="~/Aktivnosti.aspx"
                            runat="server" />
                    </EmptyDataTemplate>
            <Columns>
                <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" 
                    ReadOnly="True" SortExpression="sifra" />
                <asp:BoundField DataField="pocetak" HeaderText="Početak" 
                    SortExpression="pocetak" />
                <asp:BoundField DataField="kraj" HeaderText="Kraj" SortExpression="kraj" />
                <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
                <asp:BoundField DataField="odgovoran" HeaderText="Odgovoran" 
                    SortExpression="odgovoran" />
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
    
    <p>
        &nbsp;&nbsp;&nbsp;&nbsp;
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
        ToolTip="Ispis aktivne stranice" Width="49px" />
    </p>
    <p style="width: 823px">
        <asp:SqlDataSource ID="sdsAkt" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            SelectCommand="SELECT * FROM [Aktivnost] WHERE ([odgovoran] = @odgovoran)">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblUser" Name="odgovoran" PropertyName="Text" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    </p>
     </fieldset>
    </div>
</asp:Content>
