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
    [RoutePrefix("Silgaram/api/AdsViewre")]
    public class AdsViewreController : ApiController
    {
        AdsViewreData AdViewreData = new AdsViewreData();

        /// <summary>
        /// اضافة مشاهدة للاعلان ولا يهم اذا كن هناك مستخدم او لاء
        /// </summary>
        /// <param name="adId"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [AllowAnonymous]
        [HttpPost]
        [Route("CreateView")]
        public IHttpActionResult CreateView(int adId)
        {
            return Json(AdViewreData.CreateView(adId));
        }





        protected override void Dispose(bool disposing)
        {
            AdViewreData.Dispose();
        }
    }
}
