using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DayPilot.Web.Ui.Events;

namespace Geodezija
{
    public partial class Kalendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblUser.Text= User.Identity.Name;
                Calendar1.SelectedDate = DateTime.Today;
                setWeek();

                DataBind();
            }
        }

        protected void DayPilotCalendar1_EventClick(object sender, EventClickEventArgs e)
        {
            //Label1.Text = e.Value;
        }
        protected void DayPilotCalendar1_TimeRangeSelected(object sender, TimeRangeSelectedEventArgs e)
        {
        }
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            setWeek();
        }

        private void setWeek()
        {
            DateTime firstDay = firstDayOfWeek(Calendar1.SelectedDate, DayOfWeek.Sunday);
            Calendar1.VisibleDate = firstDay;
            for (int i = 0; i < 7; i++)
                Calendar1.SelectedDates.Add(firstDay.AddDays(i));

            DayPilotCalendar1.StartDate = firstDay;
        }

        /// <summary>
        /// Gets the first day of a week where day (parameter) belongs. weekStart (parameter) specifies the starting day of week.
        /// </summary>
        /// <returns></returns> 
        private static DateTime firstDayOfWeek(DateTime day, DayOfWeek weekStarts)
        {
            DateTime d = day;
            while (d.DayOfWeek != weekStarts)
            {
                d = d.AddDays(-1);
            }

            return d;
        }
    }
}