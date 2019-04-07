using DAL.Bll;
using DAL.Models;
using DAL.Resource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using static DAL.Enums.Enums;

namespace ControlPanel.Controllers
{
    [Authorize]
    public class ProvincesController : BaseController
    {
        ProvincesData CityData = new ProvincesData();
         // GET: City
        public ActionResult Index()
        {
            return View( );
        }
         //Get Citys 
         public JsonResult GetProvinces(int countryId)
        { 
            return Json(CityData.GetProvinces(countryId), JsonRequestBehavior.AllowGet);
        }

        //Get Country
        public JsonResult GetCountries()
        { 
            return Json(DropDownS.Countries(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChenage(Province[] provinces)
        {
            return Json(CityData.SaveChenage(provinces), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}