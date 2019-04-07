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
    [RoutePrefix("Silgaram/api/AdsEvaluation")]
    class AdsEvaluationController : ApiController
    {
        AdsEvaluationData AdFovoriteData = new AdsEvaluationData();

        /// <summary>
        /// اضافة تفييم الى الاعلان
        /// </summary>
        /// <param name="adId"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("AdEvaluation")]
        private IHttpActionResult AdEvaluation(int adId,decimal rate)
        {
            return null;
        //    return Json(AdFovoriteData.AdEvaluation(adId, rate));
        }





        protected override void Dispose(bool disposing)
        {
            AdFovoriteData.Dispose();
        }
    }
}
