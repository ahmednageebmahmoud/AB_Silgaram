using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using DAL.Models;

namespace DAL.Service
{
 public   class LanguageService
    {

        public static string DefaultLangage { get { return "en"; } }
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
            string Culture;

            new UserService().Culture(out Culture);

            if (string.IsNullOrEmpty(Culture))
                return DefaultLangage;
            else
                return Culture;
        }

        internal static string GetUserLanguage(UserInformation userInformation)
        {
            return userInformation.Language.LanguageUsings.Where(c => c.IsDefault).Single().LanguageType.Code;
        }

        public static void SetCulture()
        {
            var Culture = new System.Globalization.CultureInfo(GetCulture().ToString());
            Thread.CurrentThread.CurrentCulture = Culture;
            Thread.CurrentThread.CurrentUICulture = Culture;
        }

        public static void SetCulture(string cult)
        {
            if (string.IsNullOrEmpty(cult))
                cult = DefaultLangage;

            var Culture = new System.Globalization.CultureInfo(cult);
            Thread.CurrentThread.CurrentCulture = Culture;
            Thread.CurrentThread.CurrentUICulture = Culture;
        }

        
    }//End Class
}
