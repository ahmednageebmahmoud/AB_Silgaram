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
    public class AdsSliderController : BaseController
    {
        AdsSliderData AdnData = new AdsSliderData();

         // GET: Adn
        public ActionResult Index()
        {
            return View( );
        }
        

        //Get AdsSlider
        
        public JsonResult GetAdsSlider()
        {  
            return Json(AdnData.GetAdsSlider(), JsonRequestBehavior.AllowGet);
        }

        //SaveChenage
        public ActionResult SaveChanage(AdsSlider[] adsSlider)
        {
            return Json(AdnData.SaveChanage(adsSlider), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}