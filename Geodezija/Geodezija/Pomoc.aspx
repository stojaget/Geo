<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pomoc.aspx.cs" Inherits="Geodezija.Pomoc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/GridView.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/GridStyle.css" />
    <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.datepick.js"></script>
    <script type="text/javascript" src="Scripts/hajan.datevalidator.js"></script>
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

            $('.Picker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
        });
       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<table cellpadding="5" cellspacing="5">
<tr valign= "top" >
<td width = "50%">
    <h3>
        PREGLED STATUSA</h3>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
        EmptyDataText="There are no data records to display." ForeColor="#333333" 
        GridLines="None" Height="218px" Width="248px" CssClass="CustomView">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" 
            CssClass="GridViewAlternatingRowStyle" />
        <Columns>
            <asp:CommandField 
                ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="sifra" ReadOnly="True" 
                SortExpression="sifra" />
            <asp:BoundField DataField="naziv" HeaderText="naziv" SortExpression="naziv" />
            <asp:BoundField DataField="boja" HeaderText="boja" SortExpression="boja" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" 
            CssClass="GridViewHeaderStyle" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" 
            CssClass="GridViewPagerStyle" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" CssClass="GridViewRowStyle" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" 
            CssClass="GridViewSelectedRowStyle" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        DeleteCommand="DELETE FROM [statusi] WHERE [sifra] = @sifra" 
        InsertCommand="INSERT INTO [statusi] ([naziv], [boja]) VALUES (@naziv, @boja)" 
        ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
        SelectCommand="SELECT [sifra], [naziv], [boja] FROM [statusi]" 
        UpdateCommand="UPDATE [statusi] SET [naziv] = @naziv, [boja] = @boja WHERE [sifra] = @sifra">
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
    <br />
    <br />
    </td>
    <td valign= "top"  width = "50%" align="center">
    
    <p>
    <br />
    <br />
        <asp:DetailsView ID="DetailsView1" runat="server" Height="146px" Width="249px" 
            CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True" 
            AutoGenerateRows="False" DataKeyNames="sifra" DataSourceID="SqlDataSource3">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="sifra" HeaderText="sifra" InsertVisible="False" 
                    ReadOnly="True" SortExpression="sifra" />
                <asp:BoundField DataField="naziv" HeaderText="naziv" SortExpression="naziv" />
                <asp:BoundField DataField="boja" HeaderText="boja" SortExpression="boja" />
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
                        <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" 
                            CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="True" 
                            CommandName="New" Text="New"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                            CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DetailsView>
    </p>
    
    
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            DeleteCommand="DELETE FROM [statusi] WHERE [sifra] = @sifra" 
            InsertCommand="INSERT INTO [statusi] ([naziv], [boja]) VALUES (@naziv, @boja)" 
            SelectCommand="SELECT * FROM [statusi] WHERE ([sifra] = @sifra)" 
            UpdateCommand="UPDATE [statusi] SET [naziv] = @naziv, [boja] = @boja WHERE [sifra] = @sifra">
            <DeleteParameters>
                <asp:Parameter Name="sifra" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="naziv" Type="String" />
                <asp:Parameter Name="boja" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="sifra" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="naziv" Type="String" />
                <asp:Parameter Name="boja" Type="String" />
                <asp:Parameter Name="sifra" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    
    
    </td>
    </tr>

    <tr>
    <td width="50%">
    <h3>
        PREGLED VRSTE POSLOVA</h3>
    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="sifra" DataSourceID="SqlDataSource2" 
        EmptyDataText="There are no data records to display." ForeColor="#333333" 
        GridLines="None" Width="346px" CssClass="CustomView">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField 
                ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="sifra" ReadOnly="True" 
                SortExpression="sifra" />
            <asp:BoundField DataField="naziv" HeaderText="naziv" SortExpression="naziv" />
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
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        DeleteCommand="DELETE FROM [vrsta_posla] WHERE [sifra] = @sifra" 
        InsertCommand="INSERT INTO [vrsta_posla] ([naziv]) VALUES (@naziv)" 
        ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
        SelectCommand="SELECT [sifra], [naziv] FROM [vrsta_posla]" 
        UpdateCommand="UPDATE [vrsta_posla] SET [naziv] = @naziv WHERE [sifra] = @sifra">
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
    </td>
    <td width="40%" align="center">
     <p>
      <asp:DetailsView ID="DetailsView2" runat="server" Height="146px" Width="249px" 
            CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True" 
            AutoGenerateRows="False" DataKeyNames="sifra" DataSourceID="SqlDataSource4">
          <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
          <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
          <EditRowStyle BackColor="#999999" />
          <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
          <Fields>
              <asp:BoundField DataField="sifra" HeaderText="sifra" InsertVisible="False" 
                  ReadOnly="True" SortExpression="sifra" />
              <asp:BoundField DataField="naziv" HeaderText="naziv" SortExpression="naziv" />
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
                        <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" 
                            CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="True" 
                            CommandName="New" Text="New"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="True" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni da želite obrisati zapis?');"
                            CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
          </Fields>
          <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
          <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
          <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
          <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DetailsView>
    </p>
    
    
    
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
            DeleteCommand="DELETE FROM [vrsta_posla] WHERE [sifra] = @sifra" 
            InsertCommand="INSERT INTO [vrsta_posla] ([naziv]) VALUES (@naziv)" 
            SelectCommand="SELECT * FROM [vrsta_posla] WHERE ([sifra] = @sifra)" 
            UpdateCommand="UPDATE [vrsta_posla] SET [naziv] = @naziv WHERE [sifra] = @sifra">
            <DeleteParameters>
                <asp:Parameter Name="sifra" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="naziv" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView2" Name="sifra" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="naziv" Type="String" />
                <asp:Parameter Name="sifra" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    
    
    
    </td>
    </tr>
    </table>
</asp:Content>
