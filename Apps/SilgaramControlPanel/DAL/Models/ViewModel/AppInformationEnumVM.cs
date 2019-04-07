using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class AppInformationEnumVM
    {
        public static int ControllPanelLink { get { return Convert.ToInt32(AppInformationEnum.ControllPanelLink); } }
        public static int ApiLink { get { return Convert.ToInt32(AppInformationEnum.ApiLink); } }
        public static int AboutUsAr { get { return Convert.ToInt32(AppInformationEnum.AboutUsAr); } }
        public static int AboutUsEn { get { return Convert.ToInt32(AppInformationEnum.AboutUsEn); } }
        public static int TermsAr { get { return Convert.ToInt32(AppInformationEnum.TermsAr); } }
        public static int TermsEn { get { return Convert.ToInt32(AppInformationEnum.TermsEn); } }



        public static int FaceBookLink { get { return Convert.ToInt32(AppInformationEnum.FaceBookLink); } }
        public static int TwitterLink { get { return Convert.ToInt32(AppInformationEnum.TwitterLink); } }
        public static int InstagramLink { get { return Convert.ToInt32(AppInformationEnum.InstagramLink); } }
        public static int AdPeriodDays { get { return Convert.ToInt32(AppInformationEnum.AdPeriodDays); } }


        


    }
}
