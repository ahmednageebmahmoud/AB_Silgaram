using DAL.Bll;
using DAL.Models.ViewModel;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;

namespace API.Controllers
{
    [BaseApiController]
    [Authorize]
    [RoutePrefix("Silgaram/api/Users")]
    public class UsersController : ApiController
    {
        UsersData UsreData = new UsersData();

        /// <summary>
        /// الحصول على ما الذى قد شاهدة المستخدم سواء كان اعلانات او عروض
        /// </summary>
        /// <param name="skip"></param>
        /// <param name="take"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetRecentyViewed/{skip}/{take}")]
        [HttpGet]
        public IHttpActionResult GetRecentyViewed(int skip,int take)
        {
            return Json(UsreData.GetRecentyViewed(skip,take));
        }



        /// <summary>
        /// الحصول على كل المعلومات الخاصة بـ المستخدم
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetUserInfromation")]
        [HttpGet]
        public IHttpActionResult GetUserInfromation()
        {

            return Json(UsreData.GetUserInfromation());
        }

        /// <summary>
        /// تغير لغة المستخدم 
        /// ar or en
        /// </summary>
        /// <param name="lang"></param>
        /// <returns></returns>
        [HttpPost]
        [ResponseType(typeof(ResponseVM))]
        [Route("ChangeLanguage")]
        public IHttpActionResult ChangeLanguage(string lang)
        {
            return Json(UsreData.ChangeLanguage(lang));
        }



        /// <summary>
        /// متابعة مستخدم
        /// </summary>
        /// <param name="userId">معرف المستخدم الذى يرديد المستخدم الحالى متابعتة </param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("FollowingUser")]
        [HttpPost]
        public IHttpActionResult FollowingUser(int userId)
        {
            return Json(UsreData.FollowingUser(userId));
        }




        /// <summary>
        /// تعديل بيانات المستخدم دفعة واحدة 
        /// عن تعديل اى عنصر يجب وضع العلم بة بانة تم تعديلة
        /// </summary>
        /// <param name="userData"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("UpdateUserData")]
        [HttpPost]
        public IHttpActionResult UpdateAcount(UserDataVM userData)
        {
            return Json(UsreData.UpdateUserData(userData));
        }

        
        protected override void Dispose(bool disposing)
        {
            UsreData.Dispose();
        }
    }
}
