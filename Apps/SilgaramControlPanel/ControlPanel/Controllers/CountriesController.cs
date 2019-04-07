using DAL.Bll;
using DAL.Models;
using DAL.Resource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Resources;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using static DAL.Enums.Enums;

namespace ControlPanel.Controllers
{
    [Authorize]
    public class CountriesController : BaseController
    {
		CountriesData CountryData = new CountriesData();
         // GET: Country
        public ActionResult Index()
        {
            return View( );
        }
        //Get Counties 
        public JsonResult GetCountries()
        { 
            return Json(CountryData.GetCountries(), JsonRequestBehavior.AllowGet);
        }

        //Get Flags 
        public JsonResult GetFlags()
        {
            return Json(CountryData.GetFlags(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChenage(Country[] Countries)
        {
            return Json(CountryData.SaveChenage(Countries), JsonRequestBehavior.AllowGet);
        }



    }//End Controller
}