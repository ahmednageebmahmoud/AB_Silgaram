using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http;
using DAL.Bll;
using DAL.Models.ViewModel;
using System.Web.Http.Description;
using DAL.Models;

namespace API.Controllers
{
    [Authorize]
    [BaseApiController]
    [RoutePrefix("Silgaram/api/UserPointPackages")]
    public class UserPointPackagesController : ApiController
    {
        UserPointPackagesData UserPointPackageData = new UserPointPackagesData();


        /// <summary>
        /// الحصول على مشتريات المستخدم من النقاط
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetUserPointPackages")]
        [HttpGet]
        public async Task<IHttpActionResult> GetUserPointPackages(int skip , int take)
        {
            return Json(UserPointPackageData.GetUserPointPackages(skip,take));
        }

        /// <summary>
        /// شراء حزمة نقاط
        /// </summary>
        /// <param name="pointPackageId"></param>
        /// <param name="isCredit"></param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("BuyPointPackage/{pointPackageId}/{isCredit}")]
        [HttpPost]
        public async Task<IHttpActionResult> BuyPointPackage(int pointPackageId,bool isCredit)
        {
            return Json(UserPointPackageData.BuyPointPackage(pointPackageId, isCredit));
        }


        /// <summary>
        /// التحقق من الدفع من اجل شراء الباقة سواء اختيارية ا عادية
        /// </summary>
        /// <param name="orderId">معرف الدفع</param>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("CheckPay/{orderId}")]
        [HttpGet]
        public async Task<IHttpActionResult> CheckPay(string orderId)
        {
            return Json(UserPointPackageData.CheckPay(orderId));
        }



    }//End Controller 
}
