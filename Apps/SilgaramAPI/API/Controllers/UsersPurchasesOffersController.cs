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
    [RoutePrefix("Silgaram/api/UsersPurchasesOffers")]
    public class UsersPurchasesOffersController : ApiController
    {
        UsersPurchasesOffersData OfferData = new UsersPurchasesOffersData();

        
        /// <summary>
        /// الحصول على جميع مشترايات المستخدم من العروض
        /// </summary>
        /// <param name="skip"></param>
        /// <param name="take"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [ResponseType(typeof(ResponseVM))]
        [Route("GetUserPurchases")]
        public   IHttpActionResult GetUserPurchases(int skip,int take)
        {
            return Json(OfferData.GetUserPurchases(skip,take));
        }


        /// <summary>
        /// من اجل شراء عرض
        /// </summary>
        /// <param name="offerId"></param>
        /// <param name="isCredit"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("BuyOffer/{offerId}/{isCredit}")]
        public IHttpActionResult BuyOffer(int offerId,bool isCredit)
        {
            return Json(OfferData.BuyOffer(offerId, isCredit));
        }


        protected override void Dispose(bool disposing)
        {
            OfferData.Dispose();
        }
    }
}
