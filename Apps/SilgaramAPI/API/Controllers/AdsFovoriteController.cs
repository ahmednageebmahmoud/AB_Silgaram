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
    [RoutePrefix("Silgaram/api/AdsFovorite")]
    public class AdsFovoriteController : ApiController
    {
        AdsFovoriteData AdFovoriteData = new AdsFovoriteData();

        /// <summary>
        /// الحصول على الاعلانات المفضلة بمقدار معين
        /// </summary>
        /// <param name="skip">عدد التخطى</param>
        /// <param name="take">عدد الاعلانات المراد الحصول عليها</param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetFovorites")]
        public IHttpActionResult GetFovorites(int skip, int take)
        {
            return Json(AdFovoriteData.GetFovorites(skip,take));
        }


        /// <summary>
        /// اضافة اعلان الى المفضلة
        /// </summary>
        /// <param name="adId"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [HttpPost]
        [Route("FovoriteToggle")]
        public IHttpActionResult FovoriteToggle(int adId)
        {
            return Json(AdFovoriteData.FovoriteToggle(adId));
        }





        protected override void Dispose(bool disposing)
        {
            AdFovoriteData.Dispose();
        }
    }
}
