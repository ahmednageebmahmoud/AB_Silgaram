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
    [RoutePrefix("Silgaram/api/Service")]
    public class ServiceController : ApiController
    {
        DropDownService DropDownS = new DropDownService();

        /// <summary>
        /// الحصول على جميع الدول دفعة ااحدة
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCountries")]
        public IHttpActionResult GetCountries()
        {
            return Json(DropDownS.Countries());
        }


        /// <summary>
        /// الحصول على المقاطعات
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetProvinces")]
        public IHttpActionResult GetProvinces(int countryId)
        {
            return Json(DropDownS.Provinces(countryId));
        }


        /// <summary>
        /// الحصول على جميع الوظائف
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetJobs")]
        public IHttpActionResult GetJobs()
        {
            return Json(DropDownS.Jobs());
        }


        /// <summary>
        /// الحصول على جميع الفئات 
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCategories")]
        public IHttpActionResult GetCategories()
        {
            return Json(DropDownS.Categories());
        }

        /// <summary>
        /// الحصول على جميع الفئات الفرعي بناء على الفئة الرئيسية
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetSubCategories")]
        public IHttpActionResult GetSubCategories(int categoryId)
        {
            return Json(DropDownS.SubCategories(categoryId));
        }

        /// <summary>
        /// الحصول على الفئات الرئيسية والفرعية معا 
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetCategoriesWithSubCategory")]
        public IHttpActionResult GetCategoriesWithSubCategory()
        {
            return Json(DropDownS.GetCategoriesWithSubCategory());
        }


        /// <summary>
        /// الحصول على جميع الفئات الفرعية
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetSubCategories")]
        public IHttpActionResult GetSubCategories()
        {
            return Json(DropDownS.SubCategories());
        }

        /// <summary>
        /// هنا الحصول على الفئات وداخله كل فئة الفئات الفرعية الخاصة بها 
        /// 
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetFullCategories")]
        public IHttpActionResult GetFullCategories()
        {
            return Json(DropDownS.FullCategories());
        }


        /// <summary>
        /// الحصول على جميع الانواع البشرية 
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetGenders")]
        public IHttpActionResult GetGenders()
        {
            return Json(DropDownS.Genders());
        }

        /// <summary>
        /// الحصول على جميع الحالات الاجتماعية
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetSocialStatus")]
        public IHttpActionResult GetSocialStatus()
        {
            return Json(DropDownS.SocialStatus());
        }
        /// <summary>
        ///الحول على من نحن
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetAboutUs")]
        public IHttpActionResult GetAboutUs()
        {
            return Json(DropDownS.AboutUs());
        }

        [ResponseType(typeof(ResponseVM))]
        [Route("GetTerms")]
        public IHttpActionResult GetTerms()
        {
            return Json(DropDownS.Terms());
        }


        [ResponseType(typeof(ResponseVM))]
        [Route("GetSocialMediaLinks")]
        public IHttpActionResult GetSocialMediaLinks()
        {
            return Json(DropDownS.SocialMediaLinks());
        }

        /// <summary>
        /// الحصول على الاسليدر
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetSlider")]
        public IHttpActionResult GetSlider()
        {
            return Json(DropDownS.Slider());
        }


        /// <summary>
        /// الحصول على انواع الابلاغ عن الاعلانات 
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetReportTypes")]
        public IHttpActionResult GetReportTypes()
        {
            return Json(DropDownS.ReportTypes());
        }


        /// <summary>
        /// الحصول على الوكلاء
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(ResponseVM))]
        [Route("GetAgents/{skip}/{take}")]
        public IHttpActionResult GetAgents(int skip ,int take )
        {
            return Json(DropDownS.Agents(skip,take));
        }


        protected override void Dispose(bool disposing)
        {
            DropDownS.Dispose();
        }
    }
}
