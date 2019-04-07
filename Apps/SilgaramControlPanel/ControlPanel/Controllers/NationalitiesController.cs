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
    public class NationalitiesController : BaseController
    {
		NationalitiesData CountryData = new NationalitiesData();
         // GET: Country
        public ActionResult Index()
        {
            return View( );
        }
        //Get Counties 
        public JsonResult GetNationalities()
        { 
            return Json(CountryData.GetNationalities(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChenage(Nationality[] Nationalities)
        {
            return Json(CountryData.SaveChenage(Nationalities), JsonRequestBehavior.AllowGet);
        }



    }//End Controller
}