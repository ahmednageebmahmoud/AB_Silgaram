using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
  public  class HistoryDetailVM
    {

        public int Id { get; set; }
        public string ColumResourceName { get; set; }
        public string ColumOldContent { get; set; }
        public string ColumNewContent { get; set; }
        public int FkHistory_Id { get; set; }
        public bool CoulmIsSingl { get; set; }
        public bool CoulmIsEn { get; set; }

        public bool IsNotifyTitle { get; set; }

        /// <summary>
        /// For  Update Case
        /// </summary>
        /// <param name="columResourceName">as NameAr</param>
        /// <param name="columNewContent">as احمد</param>
        /// <param name="columOldContent">as محمد</param>
        /// <param name="coulmIsSingl">as Email Coulm and basiclly coulmIsEn = false becuse this one Coulm </param>
        /// <param name="coulmIsEn">true is a NameEn</param>
        public HistoryDetailVM(string columResourceName, string columNewContent, string columOldContent, bool coulmIsSingl, bool coulmIsEn)
        {
            this.ColumResourceName = columResourceName;
            this.ColumNewContent = columNewContent;
            this.ColumOldContent = columOldContent;
            this.CoulmIsSingl = coulmIsSingl;
            this.CoulmIsEn = coulmIsEn;
        }

        /// <summary>
        /// For Delete Or Create Case 
        /// </summary>
        /// <param name="columResourceName">as NameAr</param>
        /// <param name="columNewContent">as احمد</param>
        /// <param name="coulmIsSingl">as Email Coulm and basiclly coulmIsEn = false becuse this one Coulm </param>
        /// <param name="coulmIsEn">true is a NameEn</param>

        public HistoryDetailVM(string columResourceName, string columNewContent, bool coulmIsSingl, bool coulmIsEn)
        {
            this.ColumResourceName = columResourceName;
            this.ColumNewContent = columNewContent;
            this.CoulmIsSingl = coulmIsSingl;
            this.CoulmIsEn = coulmIsEn;
        }
    }
}
