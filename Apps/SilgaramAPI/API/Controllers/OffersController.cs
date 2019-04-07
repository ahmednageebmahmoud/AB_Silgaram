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
    [RoutePrefix("Silgaram/api/Offers")]
    public class OffersController : ApiController
    {
        OffersData OfferData = new OffersData();

        /// <summary>
        /// الحصول على العروض التى تعرض فى الوقت الحالى 
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCurrentOffers")]
        public   IHttpActionResult GetCurrentOffers(int skip,int take)
        {
            return Json(OfferData.GetCurrentOffers(skip,take));
        }

               /// <summary>
        /// جلب العروض العيا
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetOffersTop")]
        public IHttpActionResult GetOffersTop(int skip, int take)
        {
            return Json(OfferData.GetOffersTop(skip, take));
        }

        /// <summary>
        /// الحصول على العروض الحالية ولاكن بناء على الفشة التى ينتمى اليها الاعلان
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCurrentOffersByCategoryId")]
        public IHttpActionResult GetCurrentOffersByCategoryId(int categoryId, int skip, int take)
        {
            return Json(OfferData.GetCurrentOffersByCategoryId(categoryId,skip, take));
        }


        /// <summary>
        /// الحصول على العروض التى تعرض فى الوقت الحالى 
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCurrentOffersBySubCategoryId")]
        public IHttpActionResult GetCurrentOffersBySubCategoryId(int subCategoryId, int skip, int take)
        {
            return Json(OfferData.GetCurrentOffersBySubCategoryId(subCategoryId, skip, take));
        }

        /// <summary>
        /// الحصول على كل التفاصيل الخاصة بـ عرض معين
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetOfferById")]
        public IHttpActionResult GetOfferById(int offerId)
        {
            return Json(OfferData.GetOfferById(offerId));
        }

        /// <summary>
        /// جلب بحث للعروض بناء على الاسم او جزء من الاسم
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetOffersByName")]
        public IHttpActionResult GetOffersByName(string name,int skip, int take )
        {
            return Json(OfferData.GetOffersByName(name, skip, take));
        }


 

        protected override void Dispose(bool disposing)
        {
            OfferData.Dispose();
        }
    }
}
