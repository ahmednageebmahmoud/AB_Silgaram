using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http;
using DAL.Bll;
using DAL.Models.ViewModel;
using System.Web.Http.Description;
namespace API.Controllers
{
    [BaseApiController]
    [RoutePrefix("Silgaram/api/PointPackages")]
    public class PointPackagesController : ApiController
    {
        PointPackagesData PointPackageData = new PointPackagesData();

        /// <summary>
        /// الحصول على حزم النقاط من اجل عرضها للمستخدم
        /// </summary>
        /// <param name="skip">عدد التخطى</param>
        /// <param name="take">عدد حزم النقاط المرد الحصول عليها </param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))] 
        [Route("GetPointPackages/{skip}/{take}")]
        public async Task<IHttpActionResult> GetPointPackages(int skip , int take)
        {
             
            return Json(PointPackageData.GetSimplePointPackages(skip, take));
        }

        /// <summary>
        /// الحصول على حزمة معينة بكل تفاصيلها
        /// </summary>
        /// <param name="pointPackageId"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetPointPackageById/{pointPackageId}")]
        public async Task<IHttpActionResult> GetPointPackageById(int pointPackageId)
        {
            return Json(PointPackageData.GetPointPackage(pointPackageId));
        }
    }//End Controller 
}
