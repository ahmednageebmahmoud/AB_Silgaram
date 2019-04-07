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
    public class ReportTypesController : BaseController
    {
        ReportTypesData ReportTypeData = new ReportTypesData();

         // GET: ReportType
        public ActionResult Index()
        {
            return View( );
        }

         //Get ReportTypes 
         public JsonResult GetReportTypes()
        {  
            return Json(ReportTypeData.GetReportTypes(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChange(ReportType[] reportTypes)
        {
            return Json(ReportTypeData.SaveChenage(reportTypes), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}