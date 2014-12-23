using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;

namespace Geodezija
{
    public static class DateHelper
    {
        public static string ConvertDateFormat()
        {
            return ConvertDateFormat(Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern);
        }

        public static string ConvertDateFormat(string format)
        {
            string currentFormat = format;

            // Convert the date
            currentFormat = currentFormat.Replace("dddd", "DD");
            currentFormat = currentFormat.Replace("ddd", "D");

            // Convert month
            if (currentFormat.Contains("MMMM"))
            {
                currentFormat = currentFormat.Replace("MMMM", "MM");
            }
            else if (currentFormat.Contains("MMM"))
            {
                currentFormat = currentFormat.Replace("MMM", "M");
            }
            else if (currentFormat.Contains("MM"))
            {
                currentFormat = currentFormat.Replace("MM", "mm");
            }
            else
            {
                currentFormat = currentFormat.Replace("M", "m");
            }

            currentFormat = currentFormat.Contains("yyyy") ? currentFormat.Replace("yyyy", "yy") : currentFormat.Replace("yy", "y");

            return currentFormat;
        }
    }
}