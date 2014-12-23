<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Geodezija.Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 <link rel="Stylesheet" type="text/css" href="Styles/jquery.datepick.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="Stylesheet" type="text/css" href="Styles/CustomView.css" />
    <link href="Styles/jquery.jnotify.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.jnotify.js" type="text/javascript"></script>
    <script type="text/javascript" src="/Scripts/jquery-ui-1.9.2.custom.js"></script>
    <script type="text/javascript" src="/Scripts/jquery.ui.datepicker-hr.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-timepicker-addon.js"></script>
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
            //         $.datepick.setDefaults($.datepick.regional['hr']);

            //            $('.DateTimePicker').datepick({ dateFormat: 'dd/mm/yyyy', showAnim: 'fadeIn' });
            //            $.datepick.setDefaults($.datepick.regional['hr']);


            $('.DateTimePicker').datetimepicker();
            $.datepicker.regional['hr']
        });
    </script>
    <style type="text/css">
        .none
        {
            width: 197px;
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
            <legend>BRZA PRETRAGA</legend>
            <br />

             &nbsp;<asp:Label ID="Label1" runat="server" 
                Text="Upišite uzorak naziva predmeta:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtNazPred" runat="server"></asp:TextBox>
            <br />
            <br />
&nbsp;<asp:Label ID="Label3" runat="server" Text="Razdoblje kreiranja predmeta: "></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtPredOd" runat="server"></asp:TextBox>
&nbsp;&nbsp;
            <asp:Label ID="Label2" runat="server" Text="Do"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtPredDo" runat="server"></asp:TextBox>
            <br />
            <br />
            <hr />
            <br />
        </fieldset>
    </div>
</asp:Content>
