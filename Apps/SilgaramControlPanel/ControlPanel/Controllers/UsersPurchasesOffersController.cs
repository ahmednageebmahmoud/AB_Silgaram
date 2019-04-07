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
    public class UsersPurchasesOffersController : BaseController
    {
        UsersPurchasesOffersData UsersPurchasesOffersData = new UsersPurchasesOffersData();

         // GET: City
        public ActionResult Index()
        {
            return View( );
        }
      

        //Get Pages Allow
        public JsonResult GetUsersPurchasesOffers(int adId, int take,int skip)
        {
            return Json(UsersPurchasesOffersData.GetUsersPurchasesOffers(adId,  take, skip), JsonRequestBehavior.AllowGet);
        }

    }//End Controller
}