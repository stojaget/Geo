<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="KlijentiCRUD.aspx.cs" Inherits="Geodezija.KlijentiCRUD" %>

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
    <script type="text/javascript">
        $(function () {
            $("[id*=gvKlijentProj] td").hover(function () {
                $("td", $(this).closest("tr")).addClass("hover_row");
            }, function () {
                $("td", $(this).closest("tr")).removeClass("hover_row");
            });
        });
    </script>
    <style type="text/css">
        div#scroll
        {
            border: 1px solid #C0C0C0;
            background-color: #F0F0F0;
            width: 98%;
            height: 60%;
            overflow: scroll;
            position: relative;
            left: 9px;
            top: 60%;
        }
        .CustomView
        {
        }
        .CustomGrid
        {
        }
    </style>
    <script language="javascript" type="text/javascript">
        function CreateGridHeader(DataDiv, gvKlijentProj, HeaderDiv) {
            var DataDivObj = document.getElementById(DataDiv);
            var DataGridObj = document.getElementById(gvKlijentProj);
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
        .FooterStyle
        {
            background-color: #FF4D4D;
            color: White;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="projectreport">
        <a name="content_start" id="content_start"></a>
        <br />
        <fieldset>
            <h2 class="none">
                <asp:ImageButton ID="btnExcel" runat="server" Height="45px" ImageUrl="~/Styles/images/excel_lrg.png"
                    OnClick="ExportToExcel" ToolTip="Izvoz u Excel" Width="49px" />
                &nbsp;
                <asp:ImageButton ID="btnSveStrane" runat="server" Height="45px" ImageUrl="~/Styles/images/print_vise.png"
                    OnClick="btnSveStrane_Click" ToolTip="Ispis svih stranica" Width="49px" />
                &nbsp;
                <asp:ImageButton ID="btnAktivnaStrana" runat="server" Height="45px" ImageUrl="~/Styles/images/print_jedan.png"
                    OnClick="btnAktivnaStrana_Click" ToolTip="Ispis aktivne stranice" Width="49px" />
                &nbsp;
            </h2>
            <legend>Uređivanje podataka za izabranog klijenta</legend>
            <table class="ui-accordion">
                <tr>
                    <td align="left">
                        <asp:Button ID="btnKontakti" runat="server" CssClass="botuni" Height="27px" Text="Kontakti"
                            Width="111px" OnClick="btnKontakti_Click" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnPonuda" runat="server" CssClass="botuni" Height="27px" Text="Kreiraj ponudu"
                            Width="111px" OnClick="btnPonuda_Click" />
                        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                    </td>
                    <td>
                        Šifra zadnje ponude:&nbsp;
                        <asp:TextBox ID="txtZadnjaPonuda" runat="server" Height="27px" ReadOnly="True" Width="120px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="3"
                DataKeyNames="sifra" DataSourceID="sdsKlijentiCRUD" GridLines="Both" Height="50px"
                Width="726px" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                OnItemDeleted="DetailsView1_ItemDeleted" OnItemInserted="DetailsView1_ItemInserted"
                OnItemUpdated="DetailsView1_ItemUpdated" OnDataBound="DetailsView1_DataBound"
                OnItemCommand="DetailsView1_ItemCommand" Font-Size="Medium">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <EmptyDataTemplate>
                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                        Text="Dodaj klijenta"></asp:LinkButton>
                </EmptyDataTemplate>
                <Fields>
                    <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra"
                        InsertVisible="False" />
                    <asp:TemplateField HeaderText="Naziv" SortExpression="naziv">
                        <ItemTemplate>
                            <asp:Label ID="Label1" Width="300px" runat="server" Text='<%# Bind("naziv") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" Width="300px" runat="server" Text='<%# Bind("naziv") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                Display="Dynamic" ErrorMessage="Naziv klijenta je obavezno polje" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" Width="300px" runat="server" Text='<%# Bind("naziv") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1"
                                Display="Dynamic" ErrorMessage="Naziv klijenta je obavezno polje">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="titula" HeaderText="Titula" SortExpression="titula" />
                    <asp:TemplateField HeaderText="Grad" SortExpression="grad">
                        <ItemTemplate>
                            <asp:Label ID="Label2" Width="300px" runat="server" Text='<%# Bind("grad") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" Width="300px" runat="server" Text='<%# Bind("grad") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox2"
                                Display="Dynamic" ErrorMessage="Grad je obavezno polje">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox2" Width="300px" runat="server" Text='<%# Bind("grad") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox2"
                                ErrorMessage="Grad je obavezno polje">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="adresa" HeaderText="Adresa" SortExpression="adresa" />
                    <asp:TemplateField HeaderText="Država" SortExpression="drzava">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("drzava") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("drzava") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("drzava") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="E-mail" SortExpression="email">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlMail" Width="300px" runat="server" Text='<%# Eval("email") %>'
                                NavigateUrl='<%# Eval("email", "mailto:{0}") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" Width="300px" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox3" Width="300px" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="E-mail 2" SortExpression="email2">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlMail2" Width="300px" runat="server" Text='<%# Eval("email2") %>'
                                NavigateUrl='<%# Eval("email2", "mailto:{0}") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox53" Width="300px" runat="server" Text='<%# Bind("email2") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox54" Width="300px" runat="server" Text='<%# Bind("email2") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="mob" HeaderText="Mob" SortExpression="mob" />
                    <asp:BoundField DataField="mob2" HeaderText="Mob 2" SortExpression="mob2" />
                    <asp:BoundField DataField="tel1" HeaderText="Tel 1" SortExpression="tel1" />
                    <asp:BoundField DataField="tel2" HeaderText="Tel 2" SortExpression="tel2" />
                    <asp:BoundField DataField="napomena" HeaderText="Napomena" SortExpression="napomena">
                        <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="oib" HeaderText="Oib" SortExpression="oib" />
                    <asp:BoundField DataField="tekuci" HeaderText="Tekući" SortExpression="tekuci" />
                    <asp:BoundField DataField="ziro" HeaderText="Žiro" SortExpression="ziro" />
                    <asp:CheckBoxField DataField="potencijalni" HeaderText="Potencijalni" SortExpression="potencijalni" />
                    <asp:CheckBoxField DataField="povezani" HeaderText="Nepovezani" SortExpression="povezani" />
                    <asp:CheckBoxField DataField="ind_prilog" HeaderText="Ind. prilog" SortExpression="ind_prilog" />
                    <asp:CheckBoxField DataField="ind_kontakt" HeaderText="Ind. kontakt" SortExpression="ind_kontakt" />
                    <asp:CheckBoxField DataField="ind_ponuda" HeaderText="Ind. ponuda" SortExpression="ind_ponuda" />
                    <asp:TemplateField HeaderText="Šifra ponude" SortExpression="pon_sifra">
                        <ItemTemplate>
                            <asp:Label ID="Label111" runat="server" Text='<%# Bind("pon_sifra") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox111" runat="server" Text='<%# Bind("pon_sifra") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox112" runat="server" Text='<%# Bind("pon_sifra") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="kreirao" HeaderText="Kreirao" InsertVisible="False" ReadOnly="True"
                        SortExpression="kreirao" />
                    <asp:BoundField DataField="dat_kreiranja" HeaderText="Dat. kreiranja" InsertVisible="False"
                        ReadOnly="True" DataFormatString="{0:d}" SortExpression="dat_kreiranja" />
                    <asp:BoundField DataField="dat_azu" HeaderText="Dat. promjene" InsertVisible="False"
                        ReadOnly="True" DataFormatString="{0:d}" SortExpression="dat_azu" />
                    <asp:BoundField DataField="napomena2" HeaderText="Napomena 2" SortExpression="napomena2">
                        <ControlStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" ForeColor="Black"
                                CommandName="Update" Text="Update" Font-Size="Large"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                ForeColor="Black" Text="Cancel" Font-Size="Large"></asp:LinkButton>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" ForeColor="Black"
                                CommandName="Insert" Text="Insert" Font-Size="Large"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel"
                                ForeColor="Black" Text="Cancel" Font-Size="Large"></asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="Edit"
                                ForeColor="Black" Text="Edit" Font-Size="Large"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="New"
                                ForeColor="Black" Text="New" Font-Size="Large"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Želite obrisati zapis?');"
                                ForeColor="Black" CommandName="Delete" Text="Delete" Font-Size="Large"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton8" runat="server" CausesValidation="False" CommandName="Prilozi"
                                ForeColor="Black" Text="Prilozi" Font-Size="Large"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="Black" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="Black" />
            </asp:DetailsView>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" Font-Size="Medium" />
            <br />
            <br />
            <asp:SqlDataSource ID="sdsKlijentiCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                DeleteCommand="DELETE FROM [Klijent] WHERE [sifra] = @sifra" InsertCommand="INSERT INTO [Klijent] ([naziv], [grad], [adresa], [email],[email2], [mob],[mob2], [titula], [povezani], [tel1], [tel2], [napomena], [oib], [tekuci], [ziro], [potencijalni], [kreirao], [dat_kreiranja], [dat_azu], [drzava],[napomena2],[vrsta], [ind_prilog],[ind_kontakt], [ind_ponuda], [pon_sifra]) VALUES (@naziv, @grad, @adresa, @email,@email2, @mob,@mob2, @titula, @povezani, @tel1, @tel2, @napomena, @oib, @tekuci, @ziro, @potencijalni, @kreirao, @dat_kreiranja, @dat_azu, @drzava, @napomena2, @vrsta, @ind_prilog, @ind_kontakt, @ind_ponuda, @pon_sifra)"
                SelectCommand="SELECT * FROM [Klijent] WHERE ([sifra] = @sifra)" UpdateCommand="UPDATE [Klijent] SET [naziv] = @naziv, [grad] = @grad, [adresa] = @adresa, [email] = @email,[email2]=@email2, [mob]=@mob,[mob2]=@mob2, [titula]=@titula, [povezani]=@povezani, [tel1] = @tel1, [tel2] = @tel2, [napomena] = @napomena, [oib] = @oib, [tekuci] = @tekuci, [ziro] = @ziro, [potencijalni] = @potencijalni, [kreirao] = @kreirao, [dat_kreiranja] = @dat_kreiranja, [dat_azu] = @dat_azu, [drzava] = @drzava, [napomena2]=@napomena2, [vrsta]=@vrsta, [ind_prilog]= @ind_prilog, [ind_kontakt]= @ind_kontakt, [ind_ponuda]= @ind_ponuda, [pon_sifra]= @pon_sifra WHERE [sifra] = @sifra"
                OnInserted="sdsKlijentiCRUD_Inserted" OnInserting="sdsKlijentiCRUD_Inserting"
                OnUpdated="sdsKlijentiCRUD_Updated" OnUpdating="sdsKlijentiCRUD_Updating">
                <DeleteParameters>
                    <asp:Parameter Name="sifra" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="naziv" Type="String" />
                    <asp:Parameter Name="grad" Type="String" />
                    <asp:Parameter Name="adresa" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="email2" Type="String" />
                    <asp:Parameter Name="mob" Type="String" />
                    <asp:Parameter Name="mob2" Type="String" />
                    <asp:Parameter Name="titula" Type="String" />
                    <asp:Parameter Name="povezani" Type="Boolean" />
                    <asp:Parameter Name="tel1" Type="String" />
                    <asp:Parameter Name="tel2" Type="String" />
                    <asp:Parameter Name="vrsta" Type="String" />
                    <asp:Parameter Name="napomena" Type="String" />
                    <asp:Parameter Name="napomena2" Type="String" />
                    <asp:Parameter Name="oib" Type="String" />
                    <asp:Parameter Name="tekuci" Type="String" />
                    <asp:Parameter Name="ziro" Type="String" />
                    <asp:Parameter Name="potencijalni" Type="Boolean" />
                    <asp:Parameter Name="ind_prilog" Type="Boolean" />
                    <asp:Parameter Name="ind_kontakt" Type="Boolean" />
                    <asp:Parameter Name="ind_ponuda" Type="Boolean" />
                    <asp:Parameter Name="pon_sifra" Type="String" />
                    <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
                    <asp:ControlParameter Name="dat_kreiranja" Type="DateTime" ControlID="Calendar1"
                        PropertyName="SelectedDate" />
                    <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                    <asp:Parameter Name="drzava" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="sifra" QueryStringField="ID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="naziv" Type="String" />
                    <asp:Parameter Name="grad" Type="String" />
                    <asp:Parameter Name="adresa" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="email2" Type="String" />
                    <asp:Parameter Name="mob" Type="String" />
                    <asp:Parameter Name="mob2" Type="String" />
                    <asp:Parameter Name="titula" Type="String" />
                    <asp:Parameter Name="povezani" Type="Boolean" />
                    <asp:Parameter Name="tel1" Type="String" />
                    <asp:Parameter Name="tel2" Type="String" />
                    <asp:Parameter Name="napomena" Type="String" />
                    <asp:Parameter Name="napomena2" Type="String" />
                    <asp:Parameter Name="oib" Type="String" />
                    <asp:Parameter Name="tekuci" Type="String" />
                    <asp:Parameter Name="ziro" Type="String" />
                    <asp:Parameter Name="potencijalni" Type="Boolean" />
                    <asp:Parameter Name="ind_prilog" Type="Boolean" />
                    <asp:Parameter Name="ind_kontakt" Type="Boolean" />
                    <asp:Parameter Name="ind_ponuda" Type="Boolean" />
                    <asp:Parameter Name="pon_sifra" Type="String" />
                    <asp:Parameter Name="vrsta" Type="String" />
                    <asp:Parameter Name="drzava" Type="String" />
                    <asp:ControlParameter Name="kreirao" Type="String" ControlID="lblUser" PropertyName="Text" />
                    <asp:Parameter Name="dat_kreiranja" Type="DateTime" />
                    <asp:ControlParameter Name="dat_azu" Type="DateTime" ControlID="Calendar1" PropertyName="SelectedDate" />
                    <asp:Parameter Name="sifra" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsPovezani" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                SelectCommand="SELECT Projekt.sifra, Projekt.arh_broj, Projekt.godina, Projekt.naziv, Projekt.ugov_iznos, Projekt.dat_kreiranje, Projekt.dat_predaja, Projekt.putanja_projekt FROM Projekt INNER JOIN Klijent ON Projekt.klijentID = Klijent.sifra WHERE (Klijent.sifra = @ID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ID" QueryStringField="ID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Calendar ID="Calendar1" runat="server" Visible="False" Height="23px"></asp:Calendar>
            <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
            <br />
            <h5>
                Pregled predmeta povezanih sa izabranim klijentom</h5>
            <%-- <div id="scroll">--%>
            <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 400px;"
                onscroll="Onscrollfnction();">
                <asp:GridView ID="gvKlijentProj" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="4" DataKeyNames="sifra" DataSourceID="sdsPovezani" ForeColor="#333333"
                    GridLines="None" OnSelectedIndexChanged="gvKlijentProj_SelectedIndexChanged"
                    Height="50%" Width="96%" CssClass="CustomView" ShowHeaderWhenEmpty="True" PageSize="3"
                    OnRowDataBound="gvKlijentProj_RowDataBound" OnRowCreated="gvKlijentProj_RowCreated"
                    ShowFooter="True">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataTemplate>
                        <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka" ImageUrl="~/Styles/images/icon-save.gif"
                            runat="server" />
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra"
                            InsertVisible="False" />
                        <asp:BoundField DataField="arh_broj" HeaderText="Arh. broj" ReadOnly="True" SortExpression="arh_broj"
                            InsertVisible="False" />
                        <asp:BoundField DataField="godina" HeaderText="Godina" ReadOnly="True" SortExpression="godina"
                            InsertVisible="False" />
                        <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
                        <asp:BoundField DataField="ugov_iznos" HeaderText="Ugov. iznos" SortExpression="ugov_iznos" />
                        <asp:BoundField DataField="dat_kreiranje" HeaderText="Dat.kreiranja" SortExpression="dat_kreiranje" />
                        <asp:BoundField DataField="dat_predaja" HeaderText="Dat.predaje" SortExpression="dat_predaja" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                   <FooterStyle CssClass="FooterStyle" />
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
</asp:Content>
