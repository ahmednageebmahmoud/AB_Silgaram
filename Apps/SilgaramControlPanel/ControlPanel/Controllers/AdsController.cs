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
    public class AdsController : BaseController
    {
        AdsData AdnData = new AdsData();

         // GET: Adn
        public ActionResult Index()
        {
            return View( );
        }
        // GET: Create And Update
        public ActionResult CreateAndUpdate()
        {
            return View();
        }

        //Get Ads
        
        public JsonResult GetAllAds(int skip, int take)
        {  
            return Json(AdnData.GetAds(skip, take), JsonRequestBehavior.AllowGet);
        }


        //Get Ad By Id 
        public JsonResult GetAdById(int adId)
        {
            return Json(AdnData.GetAdByIdForUpdat(adId), JsonRequestBehavior.AllowGet);
        }

        //Get Categories
        public JsonResult GetCategories()
        {
            return Json(DropDownS.Categories(), JsonRequestBehavior.AllowGet);
        }

        //Get Sub Categories
        public JsonResult GetSubCategories()
        {
            return Json(DropDownS.SubCategories(), JsonRequestBehavior.AllowGet);
        }



        //SaveChenage
        public ActionResult SaveChanage(Ad[] ads)
        {
            return Json(AdnData.SaveChanage(ads), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}