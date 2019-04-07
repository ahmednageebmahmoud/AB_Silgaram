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
    public class ReportsController : BaseController
    {
        ReportsData PageAllowData = new ReportsData();

         // GET: City
        public ActionResult Index()
        {
            return View( );
        }
      

        //Get Pages Allow
        public JsonResult GetReports(int adId,int take,int skip)
        {
            return Json(PageAllowData.GetReports(adId, take, skip), JsonRequestBehavior.AllowGet);
        }

    }//End Controller
}