using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Geodezija
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          //  lblUser.Text = Membership.GetUser().UserName;
            if (!IsPostBack)
            {
                DayPilotCalendar1.StartDate = firstDayOfWeek(DateTime.Now, DayOfWeek.Sunday);

                DayPilotCalendar1.DataBind();
            }
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
