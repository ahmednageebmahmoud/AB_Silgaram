using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Enums
{
  public class Enums
    {

        public enum RequestStatus
        {
            Success=1,
            Error=2,
            Warning=3,
            Info=4
        }

        public enum AdTypeEnum
        {
            Image = 1,
            Video = 2,
            PrivateLive = 3,
            PublicLive = 4,
        }
        public enum PageEnum
        {
            Cities = 1,
            Users = 2,
            Jobs = 3,
            Countries = 4,
            PagesAllow = 5,
            PagesRoles = 6,
            Nationalities = 7,
            UserLogins=8,
            Notifications=9,
            TechnicalSupports=16,
            Menus=17,
            SubMenus=18,
            Ads=21,
            Offers=22,
            Reports=28,
            UserPointPackages=30,
            CommercialBanners=32

        }

        public enum PagesRoleTypeEnum
        {
            Management = 1,
            Notifications = 2,
            Logs = 3
        }

        public enum PhoneTypeEnum
        {

            Mobile = 1,
            Fax = 2,
            Home = 3,
            MobileLogin=4
        }

        public enum RoleEnum
        {
            Manager = 1,
            Supervisor=2,
            Client=3
        }

        public enum SocialStatusesEnum
        {
            Single = 1,
            Married = 2,
            Widower =3
        }

        public enum StateEnum
        {
            Create=1,
            Update=2,
            Delete=3,
            Reject = 4,
            Approve=5,
            Report =6,
            Buy = 7,
            Following=8,

        }

        public enum PositionTypeEnum
        {
            P1=1,
            P2= 2,
            P3= 3,
            P4=4,
            P5=5
        }

        public enum GenderEnum
        {
            Male=1,
            Female=2
        }
        public enum AppInformationEnum
        {
            ControllPanelLink = 1,
            ApiLink = 2,
            AboutUsAr = 3,
            AboutUsEn = 4,
            TermsAr = 5,
            TermsEn = 6,
            FaceBookLink = 7,
            TwitterLink = 8,
            InstagramLink = 9,
            AdPeriodDays=10
        }
        public enum FileTypeEnum
        {
            Image=1,
            Text=2,
            Audio=3
        }

        public enum LanguageTypeEnum
        {
            Arabic,
            English
        }
    }//End CLass
}
