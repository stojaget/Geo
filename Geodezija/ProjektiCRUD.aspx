<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="ProjektiCRUD.aspx.cs" Inherits="Geodezija.ProjektiCRUD" %>

<%--<%@ Register TagPrefix="cc1" Namespace="AspNetNotifyControl" Assembly="AspNetNotifyControl" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
    <link href="/Styles/Site.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
<%--<link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />--%>
    <script src="Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.10.4.custom.min.js"></script>
<%--  <script src="Scripts/jquery.ui.datepicker.js" type="text/javascript"></script>
     <script type="text/javascript" src="/Scripts/jquery.ui.datepicker-hr.js"></script>--%>
    <link rel="Stylesheet" type="text/css" href="botuni.css" />
    <link href="Styles/jquery.jnotify.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.jnotify.js" type="text/javascript"></script>
<%--<script src="Scripts/jquery.jnotify.min.js" type="text/javascript"></script>--%>
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

        $(function () {
            $("[id*=gvBiljeskeProj] td").hover(function () {
                $("td", $(this).closest("tr")).addClass("hover_row");
            }, function () {
                $("td", $(this).closest("tr")).removeClass("hover_row");
            });
        });

      
    </script>
    <script type="text/javascript">
        function ShowPopup() {
            $('#mask').show();
            $('#<%=pnlpopup.ClientID %>').show();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#<%=pnlpopup.ClientID %>').hide();
        }
        $(document).on('click', '.btnClose', function () {
            HidePopup();
        });
        function ShowPopup2() {
            $('#mask').show();
            $('#<%=pnlpopup2.ClientID %>').show();
        }
        function HidePopup2() {
            $('#mask').hide();
            $('#<%=pnlpopup2.ClientID %>').hide();
        }
        function ShowPopup3() {
            $('#mask').show();
            $('#<%=pnlpopup3.ClientID %>').show();
        }
        function HidePopup3() {
            $('#mask').hide();
            $('#<%=pnlpopup3.ClientID %>').hide();
        }
          $(document).on('click','.btnZatvori',function(){
       // $(".btnZatvori").on('click', function () {
            HidePopup2();
        });
         $(document).on('click','.btnMakni',function(){  
                 HidePopup3();
             });
    </script>
    <script language="javascript" type="text/javascript">
        function CreateGridHeader(DataDiv, gvBiljeskeProj, HeaderDiv) {
            var DataDivObj = document.getElementById(DataDiv);
            var DataGridObj = document.getElementById(gvBiljeskeProj);
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
        .style3
        {
            width: 131px;
            height: 16px;
        }
        </style>
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
        .style11
        {
            width: 296px; height: 49px;
        }
        .style13
        {
            height: 48px;
            width: 296px;
        }
        .style15
        {
            height: 16px;
            width: 296px;
        }
        .style16
        {
            width: 381px;  padding-left:180px;
        }
        .style19
        {
            height: 38px;
            width: 381px;
             padding-left:360px;
        }
        .style20
        {
            width: 381px;
            text-align: right;
        }
        .style21
        {
            width: 15%;height: 49px;
        }
        .style27
        {
            width: 131px;
            height: 38px;
        }
        .style28
        {
            height: 38px;
            width: 296px;
        }
        .style39
        {
            height: 59px;
            width: 296px;
            text-align: left;
        }
        .style42
    {
        height: 1811px;
        width: 98%;
    }
    .style43
    {
        width: 15%;
        height: 30px;
    }
    .style44
    {
        width: 296px;
        height: 30px;
    }
    .style49
    {
        width: 15%;
        height: 33px;
    }
    .style50
    {
        width: 296px;
        height: 33px;
    }
    .style51
    {
        width: 15%;
        height: 31px;
    }
    .style52
    {
        width: 296px;
        height: 31px;
    }
    .style53
    {
        height: 16px;
    }
    .style54
    {
        width: 381px;
        height: 16px;
    }
    .style55
    {
        width: 15%;
        height: 29px;
    }
    .style56
    {
        width: 296px;
        height: 29px;
    }
    .style59
    {
        width: 131px;
        height: 32px;
    }
    .style60
    {
        height: 32px;
        width: 296px;
    }
    .style62
    {
        width: 15%;
        height: 62px;
    }
    .style63
    {
        width: 296px;
        height: 62px;
    }
    .style64
    {
        width: 15%;
        height: 28px;
    }
    .style65
    {
        width: 296px;
        height: 28px;
    }
    .style66
    {
        width: 15%;
        height: 48px;
    }
    .style88
    {
        width: 131px;
        height: 29px;
    }
    .style90
    {
        height: 29px;
        width: 381px;
    }
    .style99
    {
        height: 49px;
        width: 381px;
    }
        .style108
        {
            width: 381px;
            height: 30px;
        }
        .style112
        {
            height: 59px;
        }
        .style118
        {
            width: 131px;
            height: 30px;
        }
        .style119
        {
            height: 14px;
        }
        .style120
        {
            width: 15%;
            height: 44px;
        }
        .style127
        {
            height: 51px;
        }
        .style128
        {
            width: 296px;
            height: 51px;
        }
        .style129
        {
            width: 15%;
            height: 59px;
        }
        .style131
        {
            height: 21px;
        }
        .style132
        {
            width: 296px;
            height: 21px;
        }
        .style133
        {
            width: 296px;
            height: 44px;
        }
    </style>
    <script type="text/javascript">
        //      
        jQuery(function ($) {

            $(".Pokupi").datepicker({ dateFormat: "dd/mm/yy" });
        });
        
    </script>
<%--  <script language="javascript" type="text/javascript">
        $(".Tab").on("keypress", function (e) {
            if (e.keyCode == 13) {
                var index = $(this).index();
                var next = $(".Tab", $(this).closest(".controls")).eq(index + 1);
                if (next.length > 0) {
                    if (next[0].tagName == "TABLE") {
                        $("input", next).eq(0).focus();
                    } else {
                        next.focus();
                    }
                } else {
                    next = $(".Tab", $(this).closest(".controls")).eq(0);
                    next.focus();
                }
                return false;
            }
        }) 
        
    </script>--%>
    <script language="javascript" type="text/javascript">

        function sumCalc() {
            var txt1 = parseFloat(document.getElementById('txtIznos').value.replace(",", "."));
            var txt2 = parseFloat(document.getElementById('txtIznFakt').value.replace(",", "."));
            document.getElementById('txtLova').value = ((txt1 - txt2).toFixed(2)).replace(".", ",");
            
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="projectreport">
        <a name="content_start" id="content_start"></a>
        <%-- <div>
            <cc1:AspNetNotify ID="AspNetNotify1" runat="server" Sticky="true" />
        </div>
        <br />--%>
        <fieldset style="width: 99%">
            <h2 class="none">
                        <asp:Label ID="lblStatus" runat="server" ForeColor="#990000" 
                    style="font-size: medium"></asp:Label>
            </h2>
            <legend>UREĐIVANJE PODATAKA O PREDMETU<asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            </legend>
            <table class="style42">
                <tr>
                    <td class="style27">
                        Zadnji arhivski:</td>
                    <td class="style28">
                        <asp:TextBox ID="txtArhZadnji" runat="server" Width="281px" CssClass="Tab" 
                            ForeColor="Red"></asp:TextBox>
                    </td>
                    <td class="style19">
                        <%-- OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Želite spremiti zapis?');"--%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                        <asp:Button ID="btnUnos" runat="server" Text="Unos" Width="91px" 
                            OnClick="btnUnos_Click" CssClass="botuni" Height="27px" />
                        &nbsp;
                        <asp:Button ID="btnPovratak" runat="server" Text="Povratak" Width="91px" OnClick="btnPovratak_Click"
                            CssClass="botuni" CausesValidation="False" PostBackUrl="~/Projekti.aspx" 
                            Height="27px" />
                        &nbsp;
                        <asp:Button ID="btnPrilozi" runat="server" Text="Prilozi" Width="91px" 
                            OnClick="btnPrilozi_Click" CssClass="botuni" Height="27px" />
                    </td>
                </tr>
                <tr>
                    <td class="style43">
                        Arhivski broj:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtArhivski" runat="server" style="text-align: left" Width="281px" CssClass="Tab"></asp:TextBox>
                    </td>
                    <td class="style108">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        Napomena:
                    </td>
                </tr>
                <tr>
                    <td class="style43">
                        Poslovna godina:
                        </td>
                    <td class="style44">
                        <asp:TextBox ID="txtGodina" runat="server" style="text-align: left"  Width="281px" CssClass="Tab"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtGodina"
                            Display="Dynamic" ErrorMessage="Godina mora biti cijeli broj" ForeColor="Black"
                            MaximumValue="2200" MinimumValue="1900" SetFocusOnError="True" ToolTip="Unesite između 1900 i 2200"
                            Type="Integer">*</asp:RangeValidator>
                        </td>
                    <td class="style16" rowspan="15" >
                        <asp:TextBox ID="txtPutProj" runat="server" Width="580px" TextMode="MultiLine" 
                            Height="643px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style120">
                        Vrsta posla:
                        </td>
                    <td class="style133">
                        <asp:DropDownList ID="ddlVrsta" runat="server" Height="22px" Width="480px" 
                            AppendDataBoundItems="True">
                            <asp:ListItem Text="-- Odaberite vrijednost --" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" Display="Dynamic" ErrorMessage="Morate odabrati vrstu posla"
                            Operator="NotEqual" ValueToCompare="-1" ControlToValidate="ddlVrsta">*</asp:CompareValidator>
                    </td>
                </tr>
                <tr >
                    <td valign="top" class="style127">
                        Opis projekta:
                        <asp:RequiredFieldValidator ID="rfvNaziv" runat="server" ControlToValidate="txtNaziv"
                            ErrorMessage="Naziv je obavezno polje" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                        </td>
                    <td class="style128">
                        <asp:TextBox ID="txtNaziv" runat="server" Width="507px" Height="56px" style="text-align: left" 
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style131">
                        Status:
                        </td>
                    <td class="style132">
                        <asp:DropDownList ID="ddlStatus" runat="server" Height="22px" Width="173px" 
                            AppendDataBoundItems="True">
                            <asp:ListItem Text="-- Odaberite vrijednost --" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlStatus"
                            Display="Dynamic" ErrorMessage="Morate odabrati status predmeta" Operator="NotEqual"
                            SetFocusOnError="True" ValueToCompare="-1">*</asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style129">
                        Naručitelj:
                        </td>
                    <td class="style39">
                        <asp:DropDownList ID="ddlKlijent" runat="server" Height="22px" Width="173px" 
                            AppendDataBoundItems="True" 
                            onselectedindexchanged="ddlKlijent_SelectedIndexChanged">
                            <asp:ListItem Text="-- Odaberite vrijednost --" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="Button2" runat="server" CssClass="botuni" Height="20px" 
                            OnClick="Button2_Click" CausesValidation="false"
                            Text="Novi" Width="61px" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnInfo" runat="server" CssClass="botuni" Height="20px" OnClick="btnInfo_Click"
                            Text="Info" Width="61px" />
                    <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Height="575px" CssClass="modalPopup"
                            Width="700px" Style="z-index: 111; background-color: White; position: absolute;
                            left: 35%; top: 12%; border: outset 2px gray; padding: 5px; display: none">
                          
                            <table cellpadding="0" cellspacing="5" style="width: 100%; height: 100%;" width="100%">
                                <tr style="background-color: #0924BC">
                                    <td align="center" colspan="2" style="color: White; font-weight: bold; font-size: 1.2em;
                                        padding: 3px">
                                        Unos novoga klijenta <a id="A1" class="btnClose" href="#" style="color: white; float: right;
                                            text-decoration: none">X</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label5" runat="server" Text="Naziv:"></asp:Label>
                                        <asp:TextBox ID="txtKlNaziv" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label12" runat="server" Text="OIB:"></asp:Label>
                                        <asp:TextBox ID="txtKlOib" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text="Grad:"></asp:Label>
                                        <asp:TextBox ID="txtKlGrad" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text="Adresa:"></asp:Label>
                                        <asp:TextBox ID="txtKlAdresa" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label8" runat="server" Text="E-mail:"></asp:Label>
                                        <asp:TextBox ID="txtKlEmail" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label9" runat="server" Text="Mobitel:"></asp:Label>
                                        <asp:TextBox ID="txtKlMob" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label10" runat="server" Text="Telefon:"></asp:Label>
                                        <asp:TextBox ID="txtKlTel" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="Label11" runat="server" Text="žiro račun:"></asp:Label>
                                        <asp:TextBox ID="txtKlZiro" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPor" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Spremi" />
                                        <input type="button" class="btnClose" value="Otkaži" />
                                        <%--  <asp:Button ID="btnClear" runat="server" Text="Počisti datume" OnClick="btnClear_Click" />--%>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlpopup2" runat="server" BackColor="White" Height="575px" CssClass="modalPopup"
                            Width="700px" Style="z-index: 111; background-color: White; position: absolute;
                            left: 35%; top: 12%; border: outset 2px gray; padding: 5px; display: none">
                            <table width="100%" style="width: 100%; height: 100%;" cellpadding="0" cellspacing="5">
                                <tr style="background-color: #0924BC">
                                    <td colspan="2" style="color: White; font-weight: bold; font-size: 1.2em; padding: 3px"
                                        align="center">
                                        Unos nove kat. općine <a id="A2" style="color: white; float: right; text-decoration: none"
                                            class="btnZatvori" href="#">X</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label14" runat="server" Text="Šifra:"></asp:Label>
                                        <asp:TextBox ID="TextBox42" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label13" runat="server" Text="Naziv:"></asp:Label>
                                        <asp:TextBox ID="TextBox32" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label15" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Button ID="Button4" runat="server" OnClick="btnKat_Click" Text="Spremi" />
                                        <input type="button" class="btnZatvori" value="Otkaži" />
                                        <%--  <asp:Button ID="btnClear" runat="server" Text="Počisti datume" OnClick="btnClear_Click" />--%>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlpopup3" runat="server" BackColor="White" Height="775px" CssClass="modalPopup"
                            Width="800px" Style="z-index: 11; background-color: White; position: absolute;
                            left: 35%; top: 12%; border: outset 2px gray; padding: 5px; display: none">
                            <table width="100%" style="width: 100%; height: 100%;" cellpadding="0" cellspacing="5">
                                <tr style="background-color: #0924BC">
                                    <td colspan="2" style="color: White; font-weight: bold; font-size: 1.2em; padding: 3px"
                                        align="center">
                                        Pregled podataka o klijentu <a id="A3" style="color: white; float: right; text-decoration: none"
                                            class="btnMakni" href="#">X</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label16" runat="server" Text="Naziv:"></asp:Label>
                                        <asp:TextBox ID="TextBox51" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label25" runat="server" Text="OIB:"></asp:Label>
                                        <asp:TextBox ID="TextBox59" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label17" runat="server" Text="Titula:"></asp:Label>
                                        <asp:TextBox ID="TextBox52" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label19" runat="server" Text="Grad:"></asp:Label>
                                        <asp:TextBox ID="TextBox53" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label20" runat="server" Text="Adresa:"></asp:Label>
                                        <asp:TextBox ID="TextBox54" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label21" runat="server" Text="E-mail:"></asp:Label>
                                        <asp:TextBox ID="TextBox55" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label22" runat="server" Text="Mobitel:"></asp:Label>
                                        <asp:TextBox ID="TextBox56" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label23" runat="server" Text="Tel 1:"></asp:Label>
                                        <asp:TextBox ID="TextBox57" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label24" runat="server" Text="Tel 2:"></asp:Label>
                                        <asp:TextBox ID="TextBox58" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label26" runat="server" Text="Tekući:"></asp:Label>
                                        <asp:TextBox ID="TextBox60" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label27" runat="server" Text="Potencijalni:"></asp:Label>
                                        <asp:CheckBox ID="chkPoten" runat="server" Width="200px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 45%; text-align: left;">
                                        <asp:Label ID="Label28" runat="server" Text="Nepovezani:"></asp:Label>
                                        <asp:CheckBox ID="chkNepovez" runat="server" Width="200px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label18" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <input type="button" class="btnMakni" value="Otkaži" onclick="HidePopup3()" />
                                        <%--  <asp:Button ID="btnClear" runat="server" Text="Počisti datume" OnClick="btnClear_Click" />--%>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                    <td class="style112">
                    </td>
                </tr>
                <td class="style49">
                    Kat. općina:
                </td>
                <td class="style50">
                    <asp:DropDownList ID="ddlKat" runat="server" Height="22px" Width="173px" 
                        AppendDataBoundItems="True">
                        <asp:ListItem Text="-- Odaberite vrijednost --" Value="-1"></asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Button3" runat="server" CssClass="botuni" Height="20px" OnClick="Button3_Click"
                        Text="Novi" Width="61px" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td class="style43">
                        Kat. čestica:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtCestica" runat="server" style="text-align: left"  Width="281px"></asp:TextBox>
                    </td>
                   
                </tr>
                <tr>
                    <td class="style51">
                        Otvorio predmet:
                    </td>
                    <td class="style52">
                        <asp:TextBox ID="txtKreirao" style="text-align: left"  runat="server" Width="281px" ReadOnly="True"></asp:TextBox>
                    </td>
                   
                </tr>
                <tr>
                    <td class="style51">
                        Dat. kreiranja:
                    </td>
                    <td class="style52">
                        <asp:TextBox ID="txtDatKreir" runat="server" CssClass="Pokupi" Width="281px" ReadOnly="false"></asp:TextBox>
                    </td>
                   
                </tr>
                <tr>
                    <td class="style43">
                        Planirani završetak:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtTeren" style="text-align: left"  runat="server" Width="281px"></asp:TextBox>
                    </td>
                   
                </tr>
                <tr>
                    <td class="style53" colspan="2">
                        <hr />
                    </td>
                  
                </tr>
                <tr>
                    <td class="style55">
                        Naručen katastar:
                    </td>
                    <td class="style56">
                        <%--  <asp:Button ID="btnClear" runat="server" Text="Počisti datume" OnClick="btnClear_Click" />--%>
                        <asp:TextBox ID="txtNarucen" runat="server" Width="281px" Height="21px"></asp:TextBox>
                    </td>
                   
                </tr>
                <tr>
                    <td class="style55">
                        Stigli podaci katastar:
                    </td>
                    <td class="style56">
                        <asp:TextBox ID="txtStigao" runat="server" Width="281px" Height="21px"></asp:TextBox>
                        <%----%>
                    </td>
                   
                </tr>
                <tr>
                    <td class="style43">
                        Iznos pristojbi:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtKatCijena" style="text-align: left" runat="server" Width="281px" 
                            ToolTip="Decimalni broj, zarezom odvojite"></asp:TextBox>
                    </td>
                   
                </tr>
                <tr>
                    <td class="style53" colspan="2">
                        <hr />
                    </td>
                    
                </tr>
                <tr>
                    <td class="style88">
                        Dat. završetka:
                    </td>
                    <td class="style56">
                        <asp:TextBox ID="txtZavrs" runat="server" CssClass="Pokupi" Width="173px" Height="21px"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator8" runat="server" Display="Dynamic" ErrorMessage="Format datuma je pogrešan"
                            Operator="DataTypeCheck" Type="Date" ControlToValidate="txtZavrs" ForeColor="Red"></asp:CompareValidator>
                    </td>
                    <td class="style90">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; <asp:Button ID="btnKatastar" runat="server" Height="20px" OnClick="btnKatastar_Click"
                            Text="Katastar- zahtjev" CssClass="botuni" Width="128px" />
                        </td>
                </tr>
                <tr>
                    <td class="style21">
                        Projekt završio:
                    </td>
                    <td class="style11">
                        <asp:DropDownList ID="ddlZavrsio" runat="server" Height="22px" Width="173px" AppendDataBoundItems="True"
                            AutoPostBack="True">
                            <asp:ListItem Text="-- Odaberite vrijednost --" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;
                        </td>
                    <td class="style99">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                        <asp:Button ID="btnSud" runat="server" Height="20px" OnClick="btnSud_Click" Text="Sud- zahtjev"
                            CssClass="botuni" Width="128px" />
                        <asp:TextBox ID="txtKat2" runat="server" Height="15px" Width="50px" 
                        Visible="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style53" colspan="2">
                        <hr />
                    </td>
                    <td class="style54">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style43">
                        Ugov. iznos:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtIznos" runat="server" Width="281px" 
                            ToolTip="Decimalni broj, zarezom odvojite" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="style16" rowspan="16">
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        &nbsp;
                        <asp:ObjectDataSource ID="odsOdg" runat="server" SelectMethod="DohvatiUsername"  TypeName="Geodezija.Helper">
                        </asp:ObjectDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="style43">
                        Iznos fakture:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtIznFakt" runat="server" Width="281px" 
                            ToolTip="Decimalni broj, zarezom odvojite" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style43">
                        Lova:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtLova" runat="server" Width="281px" onfocus="javascript:sumCalc();"
                            ToolTip="Decimalni broj, zarezom odvojite" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style118">
                        Ponuda/ nar.:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtPonNar" runat="server" style="text-align: left"  Width="281px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style62">
                        Poslana faktura
                        <asp:CheckBox ID="chkFakturaPoslana" runat="server" OnCheckedChanged="chkFakturaPoslana_CheckedChanged"
                            AutoPostBack="True" />
                    </td>
                    <td class="style63">
                        &nbsp;<asp:Label ID="Label2" runat="server" Text="Šifra fakture:"></asp:Label>
                        &nbsp;&nbsp;
                        <asp:TextBox ID="txtFaktSifra" runat="server" Height="20px" Width="146px"></asp:TextBox>
                        &nbsp;<asp:Button ID="btnFaktura" runat="server" Height="20px"
                            OnClick="btnFaktura_Click" Text="Kreiraj fakturu" Width="118px" 
                            CssClass="botuni" />
                        &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text="Startaj od:"></asp:Label>
                        &nbsp;<asp:TextBox ID="txtFaktStart" runat="server" Height="20px" ToolTip="Kreni od upisanog broja"
                            Width="42px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style64">
                        Plaćeno:
                    </td>
                    <td class="style65">
                        <asp:CheckBox ID="chkPlaceno" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="style119" colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="style66">
                        DGU DAT. PODNOŠENJA ZAHTJEVA ZA PREGLED I OVJERU:
                    </td>
                    <td class="style13">
                        <asp:TextBox ID="txtDatPredajeDgu" runat="server" Width="173px" CssClass="Pokupi"
                            Height="21px"></asp:TextBox>
                        <%----%>
                        <asp:CompareValidator ID="CompareValidator5" runat="server" Display="Dynamic" ErrorMessage="Format datuma je pogrešan"
                            Operator="DataTypeCheck" Type="Date" ControlToValidate="txtDatPredajeDgu" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>
               
                <tr>
                    <td class="style66">
                        DGU DAT. POTVRDE ELABORATA:
                    </td>
                    <td class="style13">
                        <asp:TextBox ID="txtPotvrda" runat="server" CssClass="Pokupi" Width="173px" Height="21px"></asp:TextBox>
                        <%--  <a href="javascript:OpenPopupPage('Calendar.aspx','<%= txtNarucen.ClientID %>','<%= Page.IsPostBack %>');">
                    <img src="Styles/images/icon-calendar.gif" align="top" width="21" ></a>--%>
                        <asp:CompareValidator ID="CompareValidator7" runat="server" Display="Dynamic" ErrorMessage="Format datuma je pogrešan"
                            Operator="DataTypeCheck" Type="Date" ControlToValidate="txtPotvrda" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style43">
                        DGU KLASA ZAPRIMLJENOG PREDMETA:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtKlasa" style="text-align: left"  runat="server" Width="281px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style43">
                        DGU URUDŽBENI:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtUrud" runat="server" style="text-align: left"  Width="281px"></asp:TextBox>
                    </td>
                </tr>
               
                    <tr>
                    <td class="style66">
                        PREDAJA ELABORATA NARUČITELJU:
                    </td>
                    <td class="style13">
                        <asp:TextBox ID="txtPredaja" runat="server" CssClass="Pokupi" Width="173px" Height="21px"></asp:TextBox>
                        <%--<script type="text/javascript" src="Scripts/langs/jquery.datepick-hr.js"></script>--%>
                        <asp:CompareValidator ID="CompareValidator6" runat="server" Display="Dynamic" ErrorMessage="Format datuma je pogrešan"
                            Operator="DataTypeCheck" Type="Date" ControlToValidate="txtPredaja" ForeColor="Red"></asp:CompareValidator>
                        <%--class="field"--%>
                    </td>
                </tr>
                    <tr>
                    <td class="style43">
                        Dat. ažuriranja:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtDatAzu" runat="server" Width="281px" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style59" valign="top">
                    </td>
                    <td class="style60">
                        <asp:ValidationSummary ID="vsProjekt" runat="server" ForeColor="Red" 
                            ShowMessageBox="True" />
                    </td>
                </tr>
                <tr>
                    <td class="style43">
                        Šifra:
                    </td>
                    <td class="style44">
                        <asp:TextBox ID="txtSifra" runat="server" Width="281px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                    </td>
                    <td class="style15">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="style21">
                        <br />
                        <asp:Button ID="Button1" runat="server" CssClass="botuni" OnClick="Button1_Click"
                            Text="Uplatnica" Width="87px" />
                        &nbsp;
                    </td>
                    <td class="style11">
                        <%-- <a href="javascript:OpenPopupPage('Calendar.aspx','<%= txtStigao.ClientID %>','<%= Page.IsPostBack %>');">
                    <img src="Styles/images/icon-calendar.gif" align="top" width="21" ></a>--%>&nbsp;&nbsp;&nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td class="style20">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnBrisi" runat="server" Text="Briši" Width="81px" OnClientClick="return ConfirmDialog(this, 'Potvrda', 'Želite obrisati zapis?');"
                            OnClick="btnBrisi_Click" CssClass="botuni" Height="22px" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnNovi" runat="server" Text="Novi" Width="81px" OnClick="btnNovi_Click"
                            CssClass="botuni" Height="22px" />
                    </td>
                </tr>
            </table>
            <p style="width: 621px">
                <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
            </p>
            <h5>
                PREGLED BILJEŠKI ZA ODABRANI PREDMET</h5>
            <div id="DataDiv" style="overflow: auto; border: 1px solid olive; width: 98%; height: 300px;"
                onscroll="Onscrollfnction();">
                <asp:GridView ID="gvBiljeskeProj" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="4" DataSourceID="SqlDataSource1" DataKeyNames="sifra" EmptyDataText="There are no data records to display."
                    ForeColor="#333333" GridLines="None" Width="97%" OnSelectedIndexChanged="gvBiljeskeProj_SelectedIndexChanged"
                    PageSize="5" CssClass="CustomView" ShowHeaderWhenEmpty="True" OnRowDataBound="gvBiljeskeProj_RowDataBound"
                    Height="179px" Font-Size="Small">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataRowStyle ForeColor="#FF3300" />
                    <EmptyDataTemplate>
                        <asp:HyperLink ID="NewBiljeska" Text="Trenutno nema podataka, kliknite za dodavanje"
                            ImageUrl="~/Styles/images/icon-save.gif" NavigateUrl="~/Biljeske.aspx" runat="server" />
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="sifra" HeaderText="ID" ReadOnly="True" SortExpression="sifra"
                            InsertVisible="False" />
                        <asp:BoundField DataField="datum" HeaderText="Datum" SortExpression="datum" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" ItemStyle-Width="30%">
                            <ItemStyle Width="30%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="projektID" HeaderText="Projekt ID" SortExpression="projektID" />
                        <asp:BoundField DataField="unio" HeaderText="Unio" SortExpression="unio" />
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
            &nbsp;</p>
            <p style="width: 594px; height: 55px">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                    ProviderName="<%$ ConnectionStrings:GeoistraConnectionString1.ProviderName %>"
                    SelectCommand="SELECT [sifra], [datum], [opis], [projektID], [unio] FROM [Biljeske] WHERE ([projektID] = @projektID) ORDER BY [datum] DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="projektID" QueryStringField="ID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="textBox1" runat="server" TextMode="MultiLine" Width="180px" Visible="False"
                    Height="16px"></asp:TextBox>
            </p>
        </fieldset>
    </div>
</asp:Content>
