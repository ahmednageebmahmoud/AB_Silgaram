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
    public class UserLoginsController : BaseController
    {
        UserLoginsData PageAllowData = new UserLoginsData();

         // GET: City
        public ActionResult Index()
        {
            return View( );
        }
      

        //Get Pages Allow
        public JsonResult GetUserLogins(string userSerial,int take,int skip)
        {
            return Json(PageAllowData.GetUserLogins(userSerial, take, skip), JsonRequestBehavior.AllowGet);
        }

    }//End Controller
}