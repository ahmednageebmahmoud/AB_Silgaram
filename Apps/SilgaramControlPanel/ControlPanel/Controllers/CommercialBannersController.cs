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
    public class CommercialBannersController : BaseController
    {
		CommercialBannerData ContactUData = new CommercialBannerData();
         // GET: ContactU
        public ActionResult Index()
        {
            return View( );
        }

        // GET: Read CommercialBanner
        public ActionResult Read()
        {
            return View();
        }

        //Get Counties 
        public JsonResult GetCommercialBanner(int skip, int  take)
        { 
            return Json(ContactUData.GetCommercialBanner(take, skip), JsonRequestBehavior.AllowGet);
        }
    }//End Controller
}