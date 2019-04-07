using DAL.Models.ViewModel;
using DAL.Models;
using DAL.Service;
using DAL.Resource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Security.Claims;
using System.Web.Http.Description;

namespace API.Controllers
{

    [RoutePrefix("Silgaram/api/Login")]
    [BaseApiController]
    //من اجل عد ظهورها فى صفحة المساعدة
    //[ApiExplorerSettings(IgnoreApi = true)]
    public class LoginController : ApiController
    {

        /// <summary>
        /// تسجيل الدخول بواسطة الاميل وكلمة السر
        /// </summary>
        /// <returns></returns>
        [Route("GetAccessTokenByEmail/{email}/{password}")]
        [HttpPost]

        private IHttpActionResult GetAccessTokenByEmail(string email, string password)
        {
            using (UserService UserS = new UserService())
                return Json(UserS.LoginByEmail(new LoginVM
                {
                    Email = email,
                    Password = password
                }));
        }
        /// <summary>
        /// تسجيل الدخول بواسطة الاميل وكلمة السر
        /// والاكسس توكن الخاص بـ الفايربيز
        /// </summary>
        /// <returns></returns>
        [Route("GetAccessTokenByEmail")]
        [HttpPost]
        public IHttpActionResult GetAccessTokenByEmail(LoginVM login)
        {
            using (UserService UserS = new UserService())
                return Json(UserS.LoginByEmail(login));
        }

        /// <summary>
        /// تسجيل الدخول بواسطة الهاتف وكلمة السر
        /// </summary>
        /// <returns></returns>
        [Route("GetAccessTokenByPhoneNumber/{phoneNumber}/{password}")]
        [HttpPost]
        private IHttpActionResult GetAccessTokenByPhoneNumber(string phoneNumber, string password)
        {
            UserService UserS = new UserService();
            return Json(UserS.LoginByPhone(new LoginVM {
                PhoneNumber=phoneNumber,
                Password=password
            }));
        }
        /// <summary>
        /// تسجيل الدخول بواسطة الهاتف وكلمة السر 
        /// والاكسس توكن الخاص بـ الفايربيز
        /// </summary>
        /// <returns></returns>
        [Route("GetAccessTokenByPhoneNumber")]
        [HttpPost]
        public IHttpActionResult GetAccessTokenByPhoneNumber(LoginVM login)
        {
            UserService UserS = new UserService();
            return Json(UserS.LoginByPhone(login));
        }


    }//end class 
}
