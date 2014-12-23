<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Kalendar.aspx.cs" Inherits="Geodezija.Kalendar" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="color: red; font-weight: bold;">
        PREGLED AKTIVNOSTI </div>
    <div style="border: 1px solid red; padding: 10px;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Calendar ID="Calendar1" runat="server" CssClass="calendar" 
                    OnSelectionChanged="Calendar1_SelectionChanged" BackColor="White" 
                    BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                    ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                    <TodayDayStyle BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" 
                        BackColor="#CCCCCC"></TodayDayStyle>
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" CssClass="selected"></SelectedDayStyle>
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                        Font-Bold="True" Font-Size="12pt" ForeColor="#333399"></TitleStyle>
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                        VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>
                </asp:Calendar>
                <br />
                <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" DataEndField="kraj"
                    DataStartField="pocetak" DataTextField="opis" DataValueField="sifra" 
                    Days="7" NonBusinessHours="Hide"
                    OnEventClick="DayPilotCalendar1_EventClick" OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected"
                    EventClickJavaScript="alert('Event with ID {0} clicked.');" 
                    TimeRangeSelectedJavaScript="alert('Time slot starting at {0} clicked.');" 
                    BusinessBeginsHour="8" BusinessEndsHour="17" DataSourceID="SqlDataSource1" 
                    TimeFormat="Clock24Hours">
                </DayPilot:DayPilotCalendar>
                <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GeoistraConnectionString1 %>"
                    SelectCommand="SELECT * FROM [Aktivnost] WHERE NOT (([kraj] <= @start) OR ([pocetak] >= @end + 1))">
                    <SelectParameters>
                        <asp:ControlParameter Name="start" ControlID="DayPilotCalendar1" PropertyName="StartDate" />
                        <asp:ControlParameter Name="end" ControlID="DayPilotCalendar1" PropertyName="EndDate" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
