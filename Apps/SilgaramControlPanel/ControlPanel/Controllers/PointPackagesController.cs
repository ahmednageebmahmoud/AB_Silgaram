using DAL.Bll;
using DAL.Models;
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
    public class PointPackagesController : BaseController
    {
        PointPackagesData PointPackageData = new PointPackagesData();

         // GET: PointPackage
        public ActionResult Index()
        {
            return View( );
        }

         //Get PointPackages 
         public JsonResult GetPointPackages()
        {  
            return Json(PointPackageData.GetPointPackages(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChenage(PointPackage[] pointPackages)
        {
            return Json(PointPackageData.SaveChenage(pointPackages), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}