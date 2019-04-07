using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http;
using DAL.Bll;
using DAL.Models.ViewModel;
using System.Web.Http.Description;
using DAL.Service;

namespace API.Controllers
{
    [Authorize]
    [BaseApiController]
    [RoutePrefix("Silgaram/api/Notifications")]
    public class NotificationsController : ApiController
    {
        NotificationService NotificationS = new NotificationService();

        /// <summary>
        /// الحصول على الاشعارات لليوم الحالى و الاشعارات التى لم تنتهى من اليوم السابق وهكدذا بناء على عدد التخطى والعدد الجدديد المراد الحصول علية
        /// </summary>
        /// <param name="skip">عدد التخطى</param>
        /// <param name="take">عدد الاشعارات المرد الحصول عليها </param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))] 
        [Route("GetNotifications")]
        public async Task<IHttpActionResult> GetNotifications(int skip , int take)
        {

            return Json(NotificationS.GetNotifications(AccessToken.GetUserId(),skip, take));
        }


        /// <summary>
        /// التاكيد على قراءه الاشعار فقط فى حالة اذا كا الاشعار تم انشاء من السيرفر وليس تلقائى من التطبيق 
        /// </summary>
        /// <param name="notifyId"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("PutReadNotify")]
        public async Task<IHttpActionResult> PutReadNotify(int notifyId)
        {
            return Json(NotificationS.ClintReadNotify(notifyId));
        }
        

    }//End Controller 
}
