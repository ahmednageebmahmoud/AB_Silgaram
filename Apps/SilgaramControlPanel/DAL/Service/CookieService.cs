using DAL.Models;
using DAL.Models.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;

namespace DAL.Service
{
    public class CookieService
    {
        public static UserInformationCookieVM UserInfo => GetUser();
          static UserInformationCookieVM GetUser()
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                HttpCookie UserCook = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
                FormsAuthenticationTicket Ticek = FormsAuthentication.Decrypt(UserCook.Value);
                JavaScriptSerializer js = new JavaScriptSerializer();
                return js.Deserialize<UserInformationCookieVM>(Ticek.UserData);
            }

            return new UserInformationCookieVM();
        }


        public static void SetUserInCookie(User user)
        {
            var Lang = user.UserInformation.Language.LanguageUsings.Where(c => c.IsDefault).SingleOrDefault();
            //Set User Object
            UserInformationCookieVM UserInfo = new UserInformationCookieVM
            {
                Id = user.Id,
                UserName = user.UserName,
                Email = user.Email,
                ImageUrl = user.UserInformation.File.FullFileUrl,
            };

            HttpContext.Current.Request.Cookies.Remove(FormsAuthentication.FormsCookieName);

            JavaScriptSerializer js = new JavaScriptSerializer();
            string userObjectSerialize = js.Serialize(UserInfo);
            FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, user.UserName, DateTime.Now, DateTime.Now.AddMinutes(30), user.RememberMe, userObjectSerialize);
            string authTicketEncrypt = FormsAuthentication.Encrypt(authTicket);
            HttpContext.Current.Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, authTicketEncrypt));
        }

    }
}
