<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="Obavijesti.aspx.cs" Inherits="Geodezija.Obavijesti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
   <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
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
        <fieldset>
            <h2 class="none">
            </h2>
            <legend>PREGLED OBAVIJESTI</legend>
            <%--<div id="scroll">--%>
             <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
            <asp:GridView ID="GridView1" runat="server" 
                AllowSorting="True" GridLines="None"
                AutoGenerateColumns="False" DataKeyNames="sifra" 
                DataSourceID="SqlDataSource1" ShowHeaderWhenEmpty="True" 
                Height="89%" Width="98%" CellPadding="4" Font-Size="Medium" CssClass="CustomView"
                OnRowDataBound="GridView1_RowDataBound" 
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" PageSize="6">
                 <EmptyDataTemplate>
                    <asp:HyperLink ID="NewKontakt" Text="Trenutno nema podataka"
                        ImageUrl="~/Styles/images/icon-save.gif" runat="server" />
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="sifra"></asp:BoundField>
                    <asp:BoundField DataField="datum" HeaderText="datum" SortExpression="datum"></asp:BoundField>
                    <asp:BoundField DataField="korisnik" HeaderText="korisnik" SortExpression="korisnik">
                    </asp:BoundField>
                    <asp:BoundField DataField="opis" HeaderText="opis" SortExpression="opis"></asp:BoundField>
                    <asp:CheckBoxField DataField="izvrsen" HeaderText="izvršen" 
                        SortExpression="izvrsen" />
                </Columns>
            </asp:GridView>
          </div>
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                SelectCommand="SELECT * FROM [Poruke] WHERE korisnik = @UserName or korisnik = 'svi' ORDER BY [datum] DESC"
                CancelSelectOnNullParameter="false" OnSelecting="SqlDataSource1_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="UserName" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="90%" AutoGenerateRows="False" 
                BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" 
                BorderWidth="1px" GridLines="None"
                CellPadding="3" DataKeyNames="sifra" DataSourceID="SqlDataSource2" 
                Font-Size="Medium" onitemdeleted="DetailsView1_ItemDeleted" 
                onitemupdated="DetailsView1_ItemUpdated">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                
                <Fields>
                    <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="sifra" />
                    <asp:TemplateField HeaderText="datum" SortExpression="datum">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="Picker" 
                                Text='<%# Bind("datum") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("datum") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("datum") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="korisnik" HeaderText="korisnik" SortExpression="korisnik" />
                    <asp:BoundField DataField="opis" HeaderText="opis" SortExpression="opis" >
                     <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="izvrsen" HeaderText="izvršen" 
                        SortExpression="izvrsen" />
                    

                      <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                              ForeColor="Black"  CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                              ForeColor="Black"  Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                       
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" CommandName="Edit"
                              ForeColor="Black"  Text="Edit"></asp:LinkButton>
                            &nbsp;
                            &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                              ForeColor="Black"  CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="Black" />
            </asp:DetailsView>
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Poruke] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Poruke] ([datum], [korisnik], [opis], [izvrsen]) VALUES (@datum, @korisnik, @opis, @izvrsen)"
                SelectCommand="SELECT * FROM [Poruke] WHERE ([sifra] = @sifra) ORDER BY [datum] DESC"
                UpdateCommand="UPDATE [Poruke] SET [datum] = @datum, [korisnik] = @korisnik, [opis] = @opis, [izvrsen] = @izvrsen WHERE [sifra] = @sifra">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="datum" Type="DateTime" />
                    <asp:Parameter Name="korisnik" Type="String" />
                    <asp:Parameter Name="opis" Type="String" />
                    <asp:Parameter Name="izvrsen" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="sifra" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                 <asp:ControlParameter ControlID="DetailsView1$TextBox1" Name="datum" PropertyName="Text" 
                        Type="DateTime" />
                   <%-- <asp:Parameter Name="datum" Type="DateTime" />--%>
                    <asp:Parameter Name="korisnik" Type="String" />
                    <asp:Parameter Name="opis" Type="String" />
                    <asp:Parameter Name="izvrsen" Type="Boolean" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </fieldset>
    </div>
</asp:Content>
