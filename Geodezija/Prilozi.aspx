<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="Prilozi.aspx.cs" Inherits="Geodezija.Prilozi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
        <link href="Styles/jquery.jnotify.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.jnotify.js" type="text/javascript"></script>
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
    <style type="text/css">
        .CustomView
        {
        }
    </style>
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
            <legend>RAD SA PRILOZIMA</legend>
            <h3>
                <br />
                PREGLED PRILOGA ZA PREDMET
                <asp:Label ID="lblPredmet" runat="server" Font-Bold="True" ForeColor="#0066FF"></asp:Label>
            </h3>
            <p >
           <%-- <div id="scroll">--%>
              <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 700px;" onscroll="Onscrollfnction();">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    DataSourceID="SqlDataSource1" ForeColor="#333333" Width="97%" Height="92%"
                    GridLines="None" PageSize="5" CssClass="CustomView" ShowHeaderWhenEmpty="True"
                    AllowSorting="True" DataKeyNames="proj_id,rbr">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataTemplate>
                        <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka" ImageUrl="~/Styles/images/icon-save.gif"
                            runat="server" />
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="proj_id" HeaderText="ID Projekta" SortExpression="proj_id"
                            ReadOnly="True" />
                        <asp:BoundField DataField="rbr" HeaderText="Rbr" SortExpression="rbr" ReadOnly="True" />
                        <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
                        <asp:BoundField DataField="putanja" HeaderText="Putanja" SortExpression="putanja">
                        </asp:BoundField>
                        <asp:BoundField DataField="dt_ins" HeaderText="Dat. unosa" SortExpression="dt_ins" />
                        <asp:BoundField DataField="tip_sadrzaja" HeaderText="Tip sadržaja" SortExpression="tip_sadrzaja" />
                         <asp:HyperLinkField DataNavigateUrlFields="proj_id,rbr" DataNavigateUrlFormatString="~/DownloadFile.aspx?Id={0}&amp;Rbr={1}"
                            Target="_blank" HeaderText="Download" Text="Download" />
                        <asp:CommandField ShowEditButton="True" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Želite obrisati zapis?');"
                                    CommandName="Delete" Text="Delete"></asp:LinkButton>
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
            </p>
            <p >
                <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                    OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
                &nbsp;
                <asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                    OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
                &nbsp;
                <asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                    OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                    DeleteCommand="DELETE FROM [Prilozi] WHERE [proj_id] = @proj_id AND [rbr] = @rbr"
                    InsertCommand="INSERT INTO [Prilozi] ([proj_id], [rbr], [opis], [putanja], [dt_ins], [tip_sadrzaja]) VALUES (@proj_id, @rbr, @opis, @putanja, @dt_ins, @tip_sadrzaja)"
                    SelectCommand="SELECT * FROM [Prilozi] WHERE ([proj_id] = @proj_id) ORDER BY [rbr] DESC"
                    UpdateCommand="UPDATE [Prilozi] SET [opis] = @opis, [putanja] = @putanja, [dt_ins] = @dt_ins, [tip_sadrzaja] = @tip_sadrzaja WHERE [proj_id] = @proj_id AND [rbr] = @rbr">
                    <DeleteParameters>
                        <asp:Parameter Name="proj_id" Type="Int32" />
                        <asp:Parameter Name="rbr" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="proj_id" Type="Int32" />
                        <asp:Parameter Name="rbr" Type="Int32" />
                        <asp:Parameter Name="opis" Type="String" />
                        <asp:Parameter Name="putanja" Type="String" />
                        <asp:Parameter Name="dt_ins" Type="DateTime" />
                        <asp:Parameter Name="tip_sadrzaja" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter Name="proj_id" QueryStringField="ID" DefaultValue="" ConvertEmptyStringToNull="True"
                            Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="opis" Type="String" />
                        <asp:Parameter Name="putanja" Type="String" />
                        <asp:Parameter Name="dt_ins" Type="DateTime" />
                        <asp:Parameter Name="tip_sadrzaja" Type="String" />
                        <asp:Parameter Name="proj_id" Type="Int32" />
                        <asp:Parameter Name="rbr" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </p>
            <p>
                <asp:ObjectDataSource ID="odsPrilozi" runat="server" SelectMethod="DohvatiPriloge"
                    TypeName="Geodezija.Helper">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="proj_id" QueryStringField="ID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                &nbsp;</p>
            <h5>
                UNOS NOVOGA PRILOGA</h5>
            <p >
                <asp:Label ID="Label1" runat="server" Text="Naziv:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtNaziv" runat="server" Visible="False" Width="300px"></asp:TextBox>
            </p>
            <p >
                <asp:Label ID="Label2" runat="server" Text="Dokument:"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:FileUpload ID="UploadTest" runat="server" ToolTip="Pronađite dokument" 
                    Width="300px" />
            </p>
            <p >
                <asp:LinkButton ID="btnInsert" runat="server" OnClick="btnInsert_Click" 
                    Text="Dodaj" ForeColor="Black" Font-Size="Medium"></asp:LinkButton>&nbsp;</p>
            <p >
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Size="Small"></asp:Label>
            </p>
        </fieldset>
    </div>
</asp:Content>
