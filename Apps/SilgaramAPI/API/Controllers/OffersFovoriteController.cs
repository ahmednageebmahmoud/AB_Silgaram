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
    [RoutePrefix("Silgaram/api/OffersFovorite")]
    public class OffersFovoriteController : ApiController
    {
        OffersFovoriteData OfferFovoriteData = new OffersFovoriteData();

        /// <summary>
        /// الحصول على العروض المفضلة بمقدار معين
        /// </summary>
        /// <param name="skip">عدد التخطى</param>
        /// <param name="take">عدد العروض المراد الحصول عليها</param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetFovorites")]
        public IHttpActionResult GetFovorites(int skip, int take)
        {
            return Json(OfferFovoriteData.GetFovorites(skip,take));
        }


        /// <summary>
        /// اضافة عرض الى المفضلة او حذف من المفضلة
        /// </summary>
        /// <param name="offerId"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("FovoriteToggle")]
        public IHttpActionResult FovoriteToggle(int offerId)
        {
            return Json(OfferFovoriteData.FovoriteToggle(offerId));
        }





        protected override void Dispose(bool disposing)
        {
            OfferFovoriteData.Dispose();
        }
    }
}
