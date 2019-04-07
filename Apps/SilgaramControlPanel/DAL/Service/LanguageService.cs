using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using DAL.Models;
using System.Web;

namespace DAL.Service
{
    public class LanguageService
    {

        public static string DefaultLangage { get { return "ar"; } }
        public static bool IsEn
        {
            get
            {
                if (GetCulture() == "en") return true;
                else return false;
            }
        }


        public static string GetCulture()
        {
            string Culture= DefaultLangage;

            if(HttpContext.Current.Request.IsAuthenticated)
            using (SilgaramEntities db = new SilgaramEntities())
                Culture = GetUserLanguage(db.Users.Find(CookieService.UserInfo.Id).UserInformation);

              return Culture;
        }

        internal static string GetUserLanguage(UserInformation userInformation)
        {
            return userInformation.Language.LanguageUsings.Where(c => c.IsDefault).Single().LanguageType.Code;
        }

        public static void SetCulture()
        {
            var Culture = new System.Globalization.CultureInfo(GetCulture().ToString());
            var CurrentCulture = new System.Globalization.CultureInfo("en");

            Thread.CurrentThread.CurrentCulture = CurrentCulture;
            Thread.CurrentThread.CurrentUICulture = Culture;
        }

        public static void SetCulture(string cult)
        {
            if (string.IsNullOrEmpty(cult))
                cult = DefaultLangage;

            var Culture = new System.Globalization.CultureInfo(cult);

            var CurrentCulture = new System.Globalization.CultureInfo("en");

            Thread.CurrentThread.CurrentCulture = CurrentCulture;
            Thread.CurrentThread.CurrentUICulture = Culture;
        }


    }//End Class
}
