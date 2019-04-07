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
    public class OffersController : BaseController
    {
        OffersData OffernData = new OffersData();

         // GET: Offern
        public ActionResult Index()
        {
            return View( );
        }
        // GET: Create And Update
        public ActionResult CreateAndUpdate()
        {
            return View();
        }

        //Get Offers
        
        public JsonResult GetOffers(int skip, int take)
        {  
            return Json(OffernData.GetOffers(skip, take), JsonRequestBehavior.AllowGet);
        }


        //Get Offer By Id 
        public JsonResult GetOfferById(int offerId)
        {
            return Json(OffernData.GetOfferByIdForUpdat(offerId), JsonRequestBehavior.AllowGet);
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
        public ActionResult SaveChanage(Offer[] offers)
        {
                return Json(OffernData.SaveChanage(offers), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}