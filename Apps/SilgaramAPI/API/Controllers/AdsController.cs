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
    [RoutePrefix("Silgaram/api/Ads")]
    public class AdsController : ApiController
    {
        AdsData AdData = new AdsData();




        /// <summary>
        /// الحصول على الاعلانات التى تعرض فى الوقت الحالى 
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCurrentAds")]
        public   IHttpActionResult GetCurrentAds(int skip,int take)
        {
            return Json(AdData.GetCurrentAds(skip,take));
        }

               /// <summary>
        /// جلب الاعلانات العيا
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetAdsTop")]
        public IHttpActionResult GetAdsTop(int skip, int take)
        {
            return Json(AdData.GetAdsTop(skip, take));
        }

        /// <summary>
        /// الحصول على الاعلانات الحالية ولاكن بناء على الفشة التى ينتمى اليها الاعلان
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCurrentAdsByCategoryId")]
        public IHttpActionResult GetCurrentAdsByCategoryId(int categoryId, int skip, int take)
        {
            return Json(AdData.GetCurrentAdsByCategoryId(categoryId,skip, take
                ));
        }


        /// <summary>
        /// الحصول على الاعلانات التى تعرض فى الوقت الحالى 
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCurrentAdsBySubCategoryId")]
        public IHttpActionResult GetCurrentAdsBySubCategoryId(int subCategoryId, int skip, int take)
        {
            return Json(AdData.GetCurrentAdsBySubCategoryId(subCategoryId, skip, take));
        }

        /// <summary>
        /// الحصول على كل التفاصيل الخاصة بـ إعلان معين
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetAdById")]
        public IHttpActionResult GetAdById(int adId)
        {
            return Json(AdData.GetAdById(adId));
        }

        /// <summary>
        /// جلب بحث بالاعلانات بناء على الاسم او جزء من الاسم
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetAdsByName")]
        public IHttpActionResult GetAdsByName(string name,int skip, int take )
        {
            return Json(AdData.GetAdsByName(name, skip, take));
        }

      /// <summary>
      /// جلب الاعلانات الخاصة بـ مستخدم معين
      /// </summary>
      /// <param name="skip"></param>
      /// <param name="take"></param>
      /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetUserAds")]
        public IHttpActionResult GetUserAds(int skip, int take)
        {
            return Json(AdData.GetUserAds(skip, take));
        }

        /// <summary>
        /// انشاء اعلان جديد 
        /// </summary>
        /// <param name="ad">معلومات اساسية للاعلان</param>
        /// <param name="images">الصور ويجب ان لا تقل عن 1 صورة ةولا تزيد عن 10  صور</param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("CreateAd")]
        public IHttpActionResult CreateAd(AdVM ad )
        {
            ad.State = StateEnumVM.Create;
            return Json(AdData.SaveChanage(ad));
        }

        /// <summary>
        /// تعديل الاعلان 
        /// </summary>
        /// <param name="ad">معلومات اساسية للاعلان</param>
        /// <param name="images">الصور ويجب ان لا تقل عن 1 صورة ةولا تزيد عن 10  صور</param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("UpdateAd")]
        public IHttpActionResult UpdateAd(AdVM ad)
        {
            ad.State = StateEnumVM.Update;
            return Json(AdData.SaveChanage(ad));
        }

        /// <summary>
        /// حذف الاعلان
        /// </summary>
        /// <param name="ad">معلومات اساسية للاعلان</param>
        /// <param name="images">الصور ويجب ان لا تقل عن 1 صورة ةولا تزيد عن 10  صور</param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("DeleteAd")]
        public IHttpActionResult DeleteAd(AdVM ad)
        {
            ad.State = StateEnumVM.Delete;

            return Json(AdData.SaveChanage(ad));
        }

        /// <summary>
        /// الابلاغ عن اعلان
        /// </summary>
        /// <param name="re"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("Report")]
        public IHttpActionResult Report(ReportVM re)
        {
            return Json(AdData.Report(re));
        }
        protected override void Dispose(bool disposing)
        {
            AdData.Dispose();
        }
    }
}
