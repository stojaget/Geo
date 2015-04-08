<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User_List.aspx.cs" Inherits="Geodezija.User_List1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
     <link href="Styles/jquery.jnotify.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.jnotify.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Confirm()
        {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Želite obrisati korisnika?")) {
                confirm_value.value = "DA";
            }
            else {
                confirm_value.value = "NE";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    <div id="adminedit">
        <a name="content_start" id="content_start"></a>
        <fieldset>
            <!-- add H2 here and hide it with css since you can not put h2 inside a legend tag -->
            <h2 class="none">
                </h2>
            <legend>Popis korisnika</legend>

                        <asp:ObjectDataSource ID="UserData" runat="server" TypeName="System.Web.Security.Membership"
                            SelectMethod="GetAllUsers" />
                            <div id="scroll">
                        <asp:GridView ID="GridView1" DataSourceID="UserData" 
                DataKeyNames="UserName" AutoGenerateColumns="False"
                            AllowSorting="True" BorderWidth="0px" 
                runat="server" BorderStyle="None"
                            Height="80%" Width="97%" CellPadding="2" PageSize="7" 
                CssClass="CustomView" onrowcommand="GridView1_RowCommand" >
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="UserName" HeaderText="Korisničko ime" />
                                <asp:BoundField DataField="LastPasswordChangedDate" HeaderText="Zadnja promjena lozinke" />
                                 <asp:BoundField DataField="LastLoginDate" HeaderText="Zadnji login" />
                            </Columns>
                            <RowStyle HorizontalAlign="Left" CssClass="row1" />
                            <HeaderStyle CssClass="grid-header" HorizontalAlign="Left" />
                        </asp:GridView>
                      </div>
                        <br />
                        <asp:Button ID="CreateUser" runat="server" Text="Novi korisnik" CssClass="botuni"
                            OnClick="Button_Click" />
                        <br />
            <br />
                        <asp:Panel ID="Panel1" runat="server" Height="235px">
                     <br />
                            &nbsp;UREĐIVANJE KORISNIČKIH 
                            PODATAKA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                     <br />
                     <table class="ui-accordion">
                         <tr>
                             <td class="style1">
                                 <asp:Label ID="Label4" runat="server" Text="Nova lozinka:"></asp:Label>
                             </td>
                             <td>
                                 <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox>
                                 &nbsp;&nbsp;&nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                                     runat="server" ControlToValidate="txtPass" 
                                     ErrorMessage="Lozinka mora biti između 8 i 15 znakova" ForeColor="Red" 
                                     ToolTip="Lozinka mora biti između 8 i 15 znakova" 
                                     ValidationExpression="^([a-zA-Z0-9@*#]{8,15})$">Lozinka mora biti između 8 i 15 znakova</asp:RegularExpressionValidator>
                                 &nbsp;&nbsp;
                             </td>
                             <td>
                                 &nbsp;</td>
                         </tr>
                         <tr>
                             <td class="style1">
                                 <asp:Label ID="Label5" runat="server" Text="Rola:"></asp:Label>
                             </td>
                             <td>
                                 <asp:DropDownList ID="ddlRola" runat="server" Height="22px" Width="129px" AppendDataBoundItems="True">
                                  <asp:ListItem Value="0" Text="Administrator"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Manager"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Pripravnik"></asp:ListItem>
                                 </asp:DropDownList>
                             </td>
                             <td>
                                 &nbsp;</td>
                         </tr>
                         <tr>
                             <td class="style1">
                                 <asp:Label ID="Label6" runat="server" Text="Korisničko ime:"></asp:Label>
                             </td>
                             <td>
                                 <asp:TextBox ID="txtUser" runat="server" ReadOnly="True"></asp:TextBox>
                             </td>
                             <td>
                                 &nbsp;</td>
                         </tr>
                         <tr>
                             <td class="style1">
                                 Zaključan:</td>
                             <td>
                                 <asp:CheckBox ID="chkZakljucan" runat="server" />
                             </td>
                             <td>
                                 &nbsp;</td>
                         </tr>
                         <tr>
                             <td class="style1">
                                 &nbsp;</td>
                             <td>
                                 &nbsp;</td>
                             <td>
                                 &nbsp;</td>
                         </tr>
                         <tr>
                             <td class="style1">
                                 <asp:Button ID="btnPromjena" runat="server" CssClass="botuni" 
                                     OnClick="btnPromjena_Click" Text="Spremi" />
                             </td>
                             <td>
                                 <asp:Button ID="btnOtkljucaj" runat="server" CssClass="botuni" OnClick="btnOtkljucaj_Click" Text="Otključaj" />
                                 &nbsp;&nbsp;
                                 <asp:Button ID="btnObrisi" runat="server" CssClass="botuni" OnClick="btnObrisi_Click" OnClientClick="Confirm()" Text="Izbriši" />
                             </td>
                             
                             <td>
                                 &nbsp;</td>
                         </tr>
                     </table>
                 </asp:Panel><br />
        </fieldset>
    </div>
</asp:Content>
