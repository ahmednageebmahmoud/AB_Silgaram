using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http;
using DAL.Bll;
using DAL.Models.ViewModel;
using System.Web.Http.Description;
namespace API.Controllers
{
    [Authorize]
    [BaseApiController]
    [RoutePrefix("Silgaram/api/TechnicalSupport")]
    public class TechnicalSupportController : ApiController
    {
        TechnicalSupportData TechnicalSupportData = new TechnicalSupportData();

        [ResponseType(typeof(ResponseVM))]
        [AllowAnonymous]
        [Route("PostTechnicalSupport")]
        public async Task<IHttpActionResult> PostTechnicalSupport(TechnicalSupportVM technicalSupport)
        {
            return Json(TechnicalSupportData.CreateTechnicalSupport(technicalSupport));
        }



         


    }//End Controller 
}
