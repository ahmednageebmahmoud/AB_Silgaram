using DAL.Bll;
using DAL.Models;
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
    [RoutePrefix("Silgaram/api/CommercialBanners")]
    public class CommercialBannersController : ApiController
    {
        CommercialBannersData AdData = new CommercialBannersData();

         /// <summary>
         /// انشاء طلب لـ اعلان تجارى
         /// </summary>
         /// <param name="commercialBanner"></param>
         /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("CreateRequestAd")]
        public IHttpActionResult CreateRequestAd(CommercialBanner commercialBanner)
        {
            return Json(AdData.CreateRequest(commercialBanner));
        }
         
        protected override void Dispose(bool disposing)
        {
            AdData.Dispose();
        }
    }
}
