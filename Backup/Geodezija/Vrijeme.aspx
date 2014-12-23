<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vrijeme.aspx.cs" Inherits="Geodezija.Vrijeme" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
     <script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
        <br />
        PREGLED RADNOG VREMENA<br />
    </h3>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="sifra" DataSourceID="SqlDataSource1" 
        EmptyDataText="There are no data records to display." ForeColor="#333333" 
        GridLines="None" onrowcommand="GridView1_RowCommand">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowSelectButton="True" />
            <asp:BoundField DataField="sifra" HeaderText="sifra" ReadOnly="True" 
                SortExpression="sifra" />
            <asp:BoundField DataField="datum" HeaderText="datum" SortExpression="datum" DataFormatString="{0:d}" />
            <asp:BoundField DataField="dolazak" HeaderText="dolazak" 
                SortExpression="dolazak" />
            <asp:BoundField DataField="odlazak" HeaderText="odlazak" 
                SortExpression="odlazak" />
            <asp:CheckBoxField DataField="blagdan" HeaderText="blagdan" 
                SortExpression="blagdan" />
            <asp:CheckBoxField DataField="godisnji" HeaderText="godisnji" 
                SortExpression="godisnji" />
            <asp:CheckBoxField DataField="bolovanje" HeaderText="bolovanje" 
                SortExpression="bolovanje" />
            <asp:BoundField DataField="napomena" HeaderText="napomena" 
                SortExpression="napomena" />
            <asp:BoundField DataField="radnikID" HeaderText="radnikID" 
                SortExpression="radnikID" />
                 <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    
                        <asp:Button ID="AddButton" runat="server" 
      CommandName="Kopiraj"  OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Da li ste sigurni?');" 
      CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
      Text="Kopiraj"  />
                </ItemTemplate>
                <ControlStyle CssClass="botuni" />
            </asp:TemplateField>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>" 
        DeleteCommand="DELETE FROM [Evid_vrijeme] WHERE [sifra] = @sifra" 
        InsertCommand="INSERT INTO [Evid_vrijeme] ([datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID]) VALUES (@datum, @dolazak, @odlazak, @blagdan, @godisnji, @bolovanje, @napomena, @radnikID)" 
        ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>" 
        SelectCommand="SELECT [sifra], [datum], [dolazak], [odlazak], [blagdan], [godisnji], [bolovanje], [napomena], [radnikID] FROM [Evid_vrijeme]" 
        UpdateCommand="UPDATE [Evid_vrijeme] SET [datum] = @datum, [dolazak] = @dolazak, [odlazak] = @odlazak, [blagdan] = @blagdan, [godisnji] = @godisnji, [bolovanje] = @bolovanje, [napomena] = @napomena, [radnikID] = @radnikID WHERE [sifra] = @sifra">
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
            <asp:Parameter Name="sifra" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblStatus" runat="server" ForeColor="#CC0000"></asp:Label>
    <br />
    <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
    <br />
</asp:Content>
