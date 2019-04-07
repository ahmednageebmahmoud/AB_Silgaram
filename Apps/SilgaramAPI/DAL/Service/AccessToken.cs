using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace DAL.Service
{
    public class AccessToken
    {

        /// <summary>
        /// Get Value From Access Token
        /// </summary>
        /// <param name="key"></param>
        /// <returns>Return String Or Null</returns>
        static Claim GetValueFromAccessToken(string key)
        {
            var Identity = (ClaimsIdentity)HttpContext.Current.User.Identity;
            var Value = Identity.Claims.Where(c => c.Type == key).SingleOrDefault();
            return Value;
        }

        //Get User Id
        public static int GetUserId()
        {
            var UserId = GetValueFromAccessToken("UserId");
            if (UserId == null)
                return 0;
            return Convert.ToInt32(UserId.Value);
        }

        /// <summary>
        /// Get Culture From Access Token
        /// </summary>
        /// <returns></returns>
        internal static string GetCulture()
        {
            var Culture = GetValueFromAccessToken("Culture");
            if (Culture == null)
                return "Ar";
            return Culture.Value.ToString();
        }

        internal static void GetCulture(out string culture)
        {
            var Culture = GetValueFromAccessToken("Culture");
            if (Culture == null)
            culture ="ar";
            else
            culture = Culture.Value.ToString();
        }


        internal static string GetUserSerial()
        {
            var Serial = GetValueFromAccessToken("Serial");
                return Serial.Value.ToString();
        }
    }
}
