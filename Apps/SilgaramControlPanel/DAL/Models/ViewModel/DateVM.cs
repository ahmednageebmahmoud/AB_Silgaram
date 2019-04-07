using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModels
{
    public class DateVM
    {
        public int Days { get; set; }
        public int Hours { get; set; }
        public int Minutes { get; set; }
        public int Seconds { get; set; }
        public string StartIn { get;   set; }
        public string EndIn { get;   set; }

        public DateVM()
        {
                
        }

        /// <summary>
        /// Cult Date 
        /// </summary>
        /// <param name="Date"></param>
        public DateVM(DateTime date)
        {

                var Date = date - DateTime.Now;
                this.Days = Date.Days;
                this.Hours = Date.Hours;
                this.Minutes = Date.Minutes;
                this.Seconds = Date.Seconds;
        }

        public DateVM(DateTime endDate, DateTime startDate)
        {

            var Date = endDate - DateTime.Now;
            this.Days = Date.Days;
            this.Hours = Date.Hours;
            this.Minutes = Date.Minutes;
            this.Seconds = Date.Seconds;

            this.StartIn =DateService.GetDateTimeByCulture( startDate);
            this.EndIn = DateService.GetDateTimeByCulture(endDate);
        }

    }
}
