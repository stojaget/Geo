<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="Pomoc.aspx.cs" Inherits="Geodezija.Pomoc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/GridView.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/GridStyle.css" />
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
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
            $("[id*=GridView2] td").hover(function () {
                $("td", $(this).closest("tr")).addClass("hover_row");
            }, function () {
                $("td", $(this).closest("tr")).removeClass("hover_row");
            });
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $("[id*=GridView3] td").hover(function () {
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

            $('.Picker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            $.datepick.setDefaults($.datepick.regional['hr']);
        });
       
    </script>
      <script type="text/javascript">
          var GridId = "<%=GridView1.ClientID %>";
          var ScrollHeight = 400;
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
     <script type="text/javascript">
         var GridId = "<%=GridView2.ClientID %>";
         var ScrollHeight = 400;
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
     <script type="text/javascript">
         var GridId = "<%=GridView3.ClientID %>";
         var ScrollHeight = 400;
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
      <script type="text/javascript">
          var GridId = "<%=GridView4.ClientID %>";
          var ScrollHeight = 400;
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
        .style1
        {
            width: 54%;
            height: 60%;
        }
        .style2
        {
            width: 54%;
            height: 337px;
        }
        .style3
        {
            width: 44%;
            height: 337px;
        }
        .style4
        {
            height: 337px;
            width: 50%;
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
            <legend>RAD SA ŠIFARNICIMA </legend>
            <br />
            <table cellpadding="5" cellspacing="5" width="98%">
                <tr valign="top">
                    <td class="style2">
                        <h5>
                            PREGLED STATUSA</h5>
                             
                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True"
                            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="sifra" DataSourceID="SqlDataSource1"
                            EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None"
                            Height="57%" Width="98%" CssClass="CustomView" PageSize="6" ShowHeaderWhenEmpty="True"
                            OnRowDataBound="GridView1_RowDataBound" 
                            OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" CssClass="GridViewAlternatingRowStyle" />
                            <Columns>
                                <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra" />
                                <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
                                <asp:BoundField DataField="boja" HeaderText="Boja" SortExpression="boja" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="Black" CssClass="GridViewHeaderStyle" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" CssClass="GridViewPagerStyle" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" CssClass="GridViewRowStyle" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" CssClass="GridViewSelectedRowStyle" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                        
                        <br />
                    </td>
                    <td valign="top" align="center" class="style3">
                        <p>
                            <br />
                            <br />
                            <asp:DetailsView ID="DetailsView1" runat="server" Height="146px" Width="249px" CellPadding="3"
                                AutoGenerateRows="False" DataKeyNames="sifra" DataSourceID="SqlDataSource3" BackColor="White"
                                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" GridLines="Horizontal">
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <EmptyDataTemplate>
                                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                                        Text="Dodaj"></asp:LinkButton>
                                </EmptyDataTemplate>
                                <Fields>
                                    <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="sifra" />
                                    <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
                                    <asp:BoundField DataField="boja" HeaderText="Boja" SortExpression="boja" />
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                                CommandName="Update" ForeColor="Black" Text="Update"></asp:LinkButton>
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
                        </p>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                            DeleteCommand="DELETE FROM [statusi] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [statusi] ([naziv], [boja]) VALUES (@naziv, @boja)"
                            ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                            SelectCommand="SELECT [sifra], [naziv], [boja] FROM [statusi]" UpdateCommand="UPDATE [statusi] SET [naziv] = @naziv, [boja] = @boja WHERE [sifra] = @sifra">
                            <DeleteParameters>
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                                <asp:Parameter Name="boja" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                                <asp:Parameter Name="boja" Type="String" />
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                            DeleteCommand="DELETE FROM [statusi] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [statusi] ([naziv], [boja]) VALUES (@naziv, @boja)"
                            SelectCommand="SELECT * FROM [statusi] WHERE ([sifra] = @sifra)" UpdateCommand="UPDATE [statusi] SET [naziv] = @naziv, [boja] = @boja WHERE [sifra] = @sifra">
                            <DeleteParameters>
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                                <asp:Parameter Name="boja" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="sifra" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                                <asp:Parameter Name="boja" Type="String" />
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                            DeleteCommand="DELETE FROM [kat_opc] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [kat_opc] ([sifra], [naziv]) VALUES (@sifra, @naziv)"
                            SelectCommand="SELECT * FROM [kat_opc] ORDER BY [naziv]" UpdateCommand="UPDATE [kat_opc] SET [naziv] = @naziv WHERE [sifra] = @sifra">
                            <DeleteParameters>
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="sifra" Type="Int32" />
                                <asp:Parameter Name="naziv" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr valign="top">
                    <td class="style1">
                        <h5>
                            PREGLED VRSTE POSLOVA</h5>
                        <asp:GridView ID="GridView2" runat="server" AllowSorting="True"
                            AutoGenerateColumns="False"  DataKeyNames="sifra" DataSourceID="SqlDataSource2"
                            EmptyDataText="There are no data records to display." ForeColor="#333333" 
                            Width="729px" CssClass="CustomView" PageSize="5" 
                            OnRowDataBound="GridView2_RowDataBound" 
                            OnSelectedIndexChanged="GridView2_SelectedIndexChanged" AllowPaging="True">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra">
                                    <HeaderStyle Width="20%" />
                                    <ItemStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv">
                                    <HeaderStyle Width="80%" />
                                    <ItemStyle Width="80%" />
                                </asp:BoundField>
                            </Columns>
                           
                        </asp:GridView>
                    </td>
                    <%--<td valign = "middle"  width = "50%" align="center">--%>
                    <td valign="top" align="middle" class="style3">
                        <p>
                            &nbsp;</p>
                        <p>
                            &nbsp;</p>
                        <p>
                            <asp:DetailsView ID="DetailsView2" runat="server" Height="146px" Width="249px" CellPadding="3"
                                AutoGenerateRows="False" DataKeyNames="sifra" DataSourceID="SqlDataSource4" BackColor="White"
                                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" GridLines="Horizontal">
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <EmptyDataTemplate>
                                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                                        Text="Dodaj"></asp:LinkButton>
                                </EmptyDataTemplate>
                                <Fields>
                                    <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="sifra" />
                                    <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                                ForeColor="Black" CommandName="Update" Text="Update"></asp:LinkButton>
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
                        </p>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                            DeleteCommand="DELETE FROM [vrsta_posla] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [vrsta_posla] ([naziv]) VALUES (@naziv)"
                            ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                            SelectCommand="SELECT [sifra], [naziv] FROM [vrsta_posla]" UpdateCommand="UPDATE [vrsta_posla] SET [naziv] = @naziv WHERE [sifra] = @sifra">
                            <DeleteParameters>
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                            DeleteCommand="DELETE FROM [vrsta_posla] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [vrsta_posla] ([naziv]) VALUES (@naziv)"
                            SelectCommand="SELECT * FROM [vrsta_posla] WHERE ([sifra] = @sifra)" UpdateCommand="UPDATE [vrsta_posla] SET [naziv] = @naziv WHERE [sifra] = @sifra">
                            <DeleteParameters>
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView2" Name="sifra" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td valign="top" align="middle" class="style4">
                        &nbsp;
                    </td>
                </tr>
                <tr valign="top">
                    <td class="style1">
                        <h5>
                            PREGLED ŠIFARNIKA AUTOMOBILA</h5>
                        <asp:GridView ID="GridView3" runat="server" AllowSorting="True"
                            AutoGenerateColumns="False" CellPadding="4" EmptyDataText="There are no data records to display."
                            ForeColor="#333333" GridLines="None"  Height="50%" Width="92%" CssClass="CustomView"
                            DataKeyNames="sifra" DataSourceID="SqlDataSource6" PageSize="4" OnRowDataBound="GridView3_RowDataBound"
                            OnSelectedIndexChanged="GridView3_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="sifra" />
                                <asp:BoundField DataField="vlasnik" HeaderText="Vlasnik" SortExpression="vlasnik" />
                                <asp:BoundField DataField="marka" HeaderText="Marka" SortExpression="marka" />
                                <asp:BoundField DataField="rega" HeaderText="Reg." SortExpression="rega" />
                            </Columns>
                        </asp:GridView>
                        <br />
                    </td>
                    <%--<td valign = "middle"  width = "50%" align="center">--%>
                    <td valign="top" align="middle" class="style3">
                        <p>
                            &nbsp;</p>
                        <p>
                            &nbsp;</p>
                        <p>
                            <asp:DetailsView ID="DetailsView3" runat="server" AutoGenerateRows="False" BackColor="White"
                                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="sifra"
                                DataSourceID="SqlDataSource5" GridLines="Horizontal" Height="109px" Width="231px">
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <EmptyDataTemplate>
                                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                                        Text="Dodaj"></asp:LinkButton>
                                </EmptyDataTemplate>
                                <Fields>
                                    <asp:BoundField DataField="sifra" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="sifra" />
                                    <asp:BoundField DataField="vlasnik" HeaderText="Vlasnik" SortExpression="vlasnik" />
                                    <asp:BoundField DataField="marka" HeaderText="Marka" SortExpression="marka" />
                                    <asp:BoundField DataField="rega" HeaderText="Registracija" SortExpression="rega" />
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');"
                                                ForeColor="Black" CommandName="Update" Text="Update"></asp:LinkButton>
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
                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                                SelectCommand="SELECT * FROM [Auto]"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                                DeleteCommand="DELETE FROM [Auto] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Auto] ([vlasnik], [marka], [rega]) VALUES (@vlasnik, @marka, @rega)"
                                SelectCommand="SELECT * FROM [Auto] WHERE ([sifra] = @sifra)" UpdateCommand="UPDATE [Auto] SET [vlasnik] = @vlasnik, [marka] = @marka, [rega] = @rega WHERE [sifra] = @sifra">
                                <DeleteParameters>
                                    <asp:Parameter Name="sifra" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="vlasnik" Type="String" />
                                    <asp:Parameter Name="marka" Type="String" />
                                    <asp:Parameter Name="rega" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="GridView3" Name="sifra" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="vlasnik" Type="String" />
                                    <asp:Parameter Name="marka" Type="String" />
                                    <asp:Parameter Name="rega" Type="String" />
                                    <asp:Parameter Name="sifra" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        <h5>
                            PREGLED ŠIFARNIKA KAT. OPĆINA</h5>
                        <asp:GridView ID="GridView4" runat="server" CssClass="CustomView" AutoGenerateColumns="False"
                            DataKeyNames="sifra" DataSourceID="SqlDataSource7" OnRowDataBound="GridView4_RowDataBound"
                            OnSelectedIndexChanged="GridView4_SelectedIndexChanged" Width="729px"
                            AllowSorting="True" PageSize="5">
                            <Columns>
                                <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra">
                                    <HeaderStyle Width="30%" />
                                    <ItemStyle Width="30%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv">
                                    <HeaderStyle Width="70%" />
                                    <ItemStyle Width="70%" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                    <td valign="top" align="middle" class="style3">
                        <p>
                            &nbsp;</p>
                        <p>
                            &nbsp;</p>
                        <asp:DetailsView ID="DetailsView4" runat="server" BackColor="White" BorderColor="#E7E7FF"
                            BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource8"
                            GridLines="Horizontal" Height="109px" Width="231px" AutoGenerateRows="False"
                            DataKeyNames="sifra">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <EmptyDataTemplate>
                                <asp:LinkButton ID="LinkButton16" runat="server" CausesValidation="False" CommandName="New"
                                    ForeColor="Black" Text="Dodaj"></asp:LinkButton>
                            </EmptyDataTemplate>
                            <Fields>
                                <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra" />
                                <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                            </Fields>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="Black" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                            SelectCommand="SELECT * FROM [kat_opc] WHERE ([sifra] = @sifra)" DeleteCommand="DELETE FROM [kat_opc] WHERE [sifra] = @sifra"
                            InsertCommand="INSERT INTO [kat_opc] ([sifra], [naziv]) VALUES (@sifra, @naziv)"
                            UpdateCommand="UPDATE [kat_opc] SET [naziv] = @naziv WHERE [sifra] = @sifra">
                            <DeleteParameters>
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="sifra" Type="Int32" />
                                <asp:Parameter Name="naziv" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView4" Name="sifra" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="naziv" Type="String" />
                                <asp:Parameter Name="sifra" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <br />
            </table>
            <br />
        </fieldset>
    </div>
</asp:Content>
