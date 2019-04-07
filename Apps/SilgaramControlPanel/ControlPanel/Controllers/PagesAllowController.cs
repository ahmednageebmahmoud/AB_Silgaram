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
    public class PagesAllowController : BaseController
    {
        PagesAllowData PageAllowData = new PagesAllowData();
         // GET: City
        public ActionResult Index()
        {
            return View( );
        }
         //Get Pages 
         public JsonResult GetPages()
        { 
            return Json(DropDownS.Pages(), JsonRequestBehavior.AllowGet);
        }

        //Get Pages Allow
        public JsonResult GetPagesAllow()
        {
            return Json(PageAllowData.GetPagesAllow(), JsonRequestBehavior.AllowGet);
        }

        //SaveChenage
        public ActionResult SaveChenage(PagesAllow[] pagesAllows)
        {
            return Json(PageAllowData.SaveChenage(pagesAllows), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}