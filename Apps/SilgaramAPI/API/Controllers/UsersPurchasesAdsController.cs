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
    [RoutePrefix("Silgaram/api/UsersPurchasesAds")]
    public class UsersPurchasesAdsController : ApiController
    {
        UsersPurchasesAdsData AdData = new UsersPurchasesAdsData();

        
        /// <summary>
        /// الحصول على جميع مشترايات المستخدم من الاعلانات
        /// </summary>
        /// <param name="skip"></param>
        /// <param name="take"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetUserPurchases")]
        public   IHttpActionResult GetUserPurchases(int skip,int take)
        {
            return Json(AdData.GetUserPurchases(skip,take));
        }


        /// <summary>
        /// من اجل شراء اعلان
        /// وهنا لا يوجد دفع مادى لان تلك الاعلانات الذى ينشرها هم مستخدمين مجهولين
        /// </summary>
        /// <param name="adId"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("BuyAd")]
        public IHttpActionResult BuyAd(int adId )
        {
            return Json(AdData.BuyAd(adId));
        }

        protected override void Dispose(bool disposing)
        {
            AdData.Dispose();
        }
    }
}
