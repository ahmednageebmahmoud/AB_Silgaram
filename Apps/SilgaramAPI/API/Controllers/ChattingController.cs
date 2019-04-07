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
    [RoutePrefix("Silgaram/api/Chatting")]
    public class ChattingController : ApiController
    {
        ChattingData AdData = new ChattingData();

        /// <summary>
        /// الحصول على راسائل المستخدمة مرتبة من احدث الرسائل
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetUserChatting/{skip}/{take}")]
        public IHttpActionResult GetUserChatting(int skip, int take)
        {
            return Json(AdData.GetUserChatting(skip, take));
        }

        /// <summary>
        /// ارسال رسالة من اجل الشات 
        /// </summary>
        /// <param name="chat"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("Chat")]
        public IHttpActionResult Chat(ChatSendVM chat)
        {
            return Json(AdData.Chat(chat));
        }


        /// <summary>
        /// نتحقق بان المستخدم الحالى قام بفتح محادثة مع تلك الاعلان من قبل ام لار 
        /// بالاضافةالى رجوع آخر 10 رسائل اذا كان يوجد 
        /// </summary>
        /// <param name="adId"></param>
        /// <returns></returns>
        //[ResponseType(typeof(ResponseVM))]
        //[HttpGet]
        //[Route("CheckCreateChat/{adId}")]
        //public IHttpActionResult CheckCreateChat(int adId)
        //{
        //    return Json(AdData.CheckCreateChat(adId));
        //}

        /// <summary>
        /// الحصول على الراسائل بمقدار معين
        /// </summary>
        /// 
        /// <param name="chatId"></param>
        /// <param name="lastMessageId">آخر رسالة معرووضة فى الصفحة لجلب الرسائل الرسائل من بعدها</param>
        /// <param name="take">مقدار الراسئل الذىتريدة من بعد آخ رسالة </param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpGet]
        [Route("GetMessage/{chatId}/{lastMessageId}/{take}")]
        public IHttpActionResult GetMessage(int chatId,int lastMessageId, int take)
        {
            return Json(AdData.GetMessage(chatId, lastMessageId, take));
        }

        /// <summary>
        /// لمعرفة ان المستخدم الحالى ينكنة الوصول على الغرفة 
       /// وهذة سيرفر خاصة تستخدم دخل النود من اجل معرفة المتجسسين على الغرف
        /// </summary>
        /// <param name="chatId"></param>
        /// <returns></returns>
        //[ResponseType(typeof(ResponseVM))]
        //[HttpGet]
        //[Route("CheckUserAllowAccessToChatRoom/{chatId}")]
        //public IHttpActionResult CheckUserAllowAccessToChatRoom(int chatId)
        //{
            //return Json(AdData.CheckUserAllowAccessToChatRoom(chatId));
        //}



        protected override void Dispose(bool disposing)
        {
            AdData.Dispose();
        }
    }
}
