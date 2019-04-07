using DAL.Resource;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Service
{
    public class DateService
    {

        public static DateTime DateNow { get { return DateTimeByCulture(DateTime.Now); } }
        /// <summary>
        /// get date by culture 
        /// </summary>
        /// <param name="format as MM or dd or yyyy"></param>
        /// <param name="date as date object"></param>
        /// <returns></returns>
        public static string GetDateByCulture(string format, DateTime date)
        {

            switch (XMLService.ReadInXmlFile("DateLanguage"))
            {
                case "ar":
                    return date.ToString(format, new CultureInfo("ar"));
                default:
                    return date.ToString(format, new CultureInfo("en"));
            }
        }

        public static string GetDateByCulture(DateTime date)
        {
            string Format = "dd/MM/yyyy";
            return date.ToString(Format, new CultureInfo("en"));

            switch (XMLService.ReadInXmlFile("DateLanguage"))
            {
                case "ar":
                    return date.ToString(Format, new CultureInfo("ar"));
                default:
                    return date.ToString(Format, new CultureInfo("en"));
            }
        }
        public static string GetDateTimeByCulture(DateTime? date, bool isArabTimeZone = true)
        {
            string Format = "dd/MM/yyyy hh:mm:ss tt";
            if (date == null) return null;

            if (isArabTimeZone)
            {

                /*
                 نحول التوقيت الى الكويت لان التحويل لان الوقت الذى يضاف هوا توقيت السيرفر والسيرف  فى الهند
                 */
                return TimeZoneInfo.ConvertTimeBySystemTimeZoneId(date.Value,
                             TimeZoneInfo.Local.Id, "Arab Standard Time").ToString(Format, new CultureInfo("en"));
            }
            return date.Value.ToString(Format, new CultureInfo("en"));
        }
        public static string GetDateTimeByCulture(DateTime date)
        {
            string Format = "dd/MM/yyyy hh:mm:ss tt";
                /*
                 نحول التوقيت الى الكويت لان التحويل لان الوقت الذى يضاف هوا توقيت السيرفر والسيرف  فى الهند
                 */
                return TimeZoneInfo.ConvertTimeBySystemTimeZoneId(date,
                             TimeZoneInfo.Local.Id, "Arab Standard Time").ToString(Format, new CultureInfo("en"));
        }

        internal static DateTime ParthDate(string endIn)
        {
            DateTime DateParthed;
            if (DateTime.TryParse(endIn, out DateParthed))
                return DateParthed;

            return DateTime.Parse(endIn);

        }

        public static DateTime DateTimeByCulture(DateTime date)
        {
            try
            {
                return DateTime.Parse(GetDateTimeByCulture(date));
            }
            catch
            {
                try
                {
                    return TimeZoneInfo.ConvertTimeBySystemTimeZoneId(date,
                            TimeZoneInfo.Local.Id, "Arab Standard Time");
                }
                catch
                {

                    return date;
                }

            }
        }

        public static string CaltDateTimeNotify(DateTime dateTime)
        {
            try
            {

                /*
               نتحقق من السنين ثم الشهمو ثم الايام ثم الدقلئق
                 */
                var dTime = DateTime.Now - dateTime;

                //A: Year
                if (dTime.Days >= 366)
                {
                    //notify befor year
                    //نتحقق هل هى اكبر من ثلاث سنوات ام لا
                    if (dTime.Days >= (366 * 3))
                        return Token.Ago + " " + (dTime.Days / 366) + " " + Token.Years;
                    //نتحقق هى اكبر من سنتين ام لا
                    else if (dTime.Days >= (366 * 2))
                        return Token.Ago + " " + Token.TwoYears;
                    else
                        //اذا هى سنة واحدة
                        return Token.Ago + " " + Token.OneYear;
                }

                //B:Month
                if (dTime.Days >= 31)
                {
                    //notify befor Month
                    //نتحقق هل هى اكبر من ثلاث شهور ام لا
                    if (dTime.Days >= (31 * 3))
                        return Token.Ago + " " + (dTime.Days / 31) + " " + Token.Months;
                    //نتحقق هى اكبر من شهرين ام لا
                    else if (dTime.Days >= (31 * 2))
                        return Token.Ago + " " + Token.TwoMonths;
                    else
                        //اذا هوا شهر واحد				  
                        return Token.Ago + " " + Token.OneMonth;
                }

                //C: Day
                if (dTime.Days > 0)
                {
                    //notify befor Day
                    if (dTime.Days >= 3)
                        return Token.Ago + " " + dTime.Days + " " + Token.Days;
                    else if (dTime.Days >= 2)
                        return Token.Ago + " " + Token.TwoDays;
                    else
                        return Token.Ago + " " + Token.OneDay;
                }

                //D: Hour
                if (dTime.Hours > 0)
                {
                    //notify befor Hour
                    if (dTime.Hours >= 3)
                        return Token.Ago + " " + dTime.Hours + " " + Token.Hour;
                    else if (dTime.Hours >= 2)
                        return Token.Ago + " " + Token.TwoHour;
                    else
                        return Token.Ago + " " + Token.OneHour;
                }

                //D: Minute
                if (dTime.Minutes > 0)
                {
                    //notify befor Minute
                    if (dTime.Minutes >= 3)
                        return Token.Ago + " " + dTime.Minutes + " " + Token.Minute;
                    else if (dTime.Minutes >= 2)
                        return Token.Ago + " " + Token.TwoMinute;
                    else
                        return Token.Ago + " " + Token.OneMinute;
                }

                return Token.JustNow;
            }
            catch (Exception)
            {
                return null;
            }
        }
        internal static bool IsDateTimeEquelCurrentDateTimeWithoutMilescound(DateTime date)
        {
            DateTime DateCheck = DateTime.Now;
            return DateCheck.Date == date.Date && DateCheck.Hour == date.Hour
                && DateCheck.Minute == date.Minute;
        }



        public static long GetMillisecound(DateTime dateTime)
        {
            long MilSec = (long)(dateTime - DateTime.Now).TotalMilliseconds;
            return MilSec;
        }
    }//end 
}
