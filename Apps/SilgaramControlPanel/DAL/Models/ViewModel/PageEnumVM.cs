using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
  public static  class PageEnumVM
    {
        public static int Provinces { get { return Convert.ToInt32(PageEnum.Provinces); } }
        public static int Users { get { return Convert.ToInt32(PageEnum.Users); } }
        public static int Jobs { get { return Convert.ToInt32(PageEnum.Jobs); } }
        public static int Countries { get { return Convert.ToInt32(PageEnum.Countries); } }
        public static int PagesAllow { get { return Convert.ToInt32(PageEnum.PagesAllow); } }
        public static int PagesRoles { get { return Convert.ToInt32(PageEnum.PagesRoles); } }
        public static int Nationalities { get { return Convert.ToInt32(PageEnum.Nationalities); } }
        public static int UserLogins { get { return Convert.ToInt32(PageEnum.UserLogins); } }
        public static int Notifications { get { return Convert.ToInt32(PageEnum.Notifications); } }
        public static int TechnicalSupports { get { return Convert.ToInt32(PageEnum.TechnicalSupports); } }
        public static int Menus { get { return Convert.ToInt32(PageEnum.Menus); } }
        public static int SubMenus { get { return Convert.ToInt32(PageEnum.SubMenus); } }
        public static int Categories { get { return Convert.ToInt32(PageEnum.Categories); } }
        public static int SubCategories { get { return Convert.ToInt32(PageEnum.SubCategories); } }
        public static int Ads { get { return Convert.ToInt32(PageEnum.Ads); } }
        public static int Offers { get { return Convert.ToInt32(PageEnum.Offers); } }
        public static int AppsInformations { get { return Convert.ToInt32(PageEnum.AppsInformations); } }
        public static int UsersPurchasesAds { get { return Convert.ToInt32(PageEnum.UsersPurchasesAds); } }
        public static int UsersPurchasesOffers { get { return Convert.ToInt32(PageEnum.UsersPurchasesOffers); } }
        public static int AdsSlider { get { return Convert.ToInt32(PageEnum.AdsSlider); } }
        public static int ReportTypes { get { return Convert.ToInt32(PageEnum.ReportTypes); } }
        public static int Reports { get { return Convert.ToInt32(PageEnum.Reports); } }
        public static int CommercialBanners { get { return Convert.ToInt32(PageEnum.CommercialBanners); } }
        public static int PointPackages { get { return Convert.ToInt32(PageEnum.PointPackages); } }
        public static int UserPointPackages { get { return Convert.ToInt32(PageEnum.UserPointPackages); } }

        
    }
}
