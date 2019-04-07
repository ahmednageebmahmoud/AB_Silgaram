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
    public class UserPointPackagesController : BaseController
    {
        UserPointPackagesData PageAllowData = new UserPointPackagesData();

        // GET: User Point Packages
        public ActionResult Index()
        {
            return View( );
        }


        //Get Get Point Packages
        public JsonResult GetUserPointPackages(int pointPackageId, int take,int skip,int? notifyId)
        {
            if (notifyId.HasValue)
                NotificationS.ReadNotify(notifyId);

            return Json(PageAllowData.GetUserPointPackages(pointPackageId, take:take,skip:skip), JsonRequestBehavior.AllowGet);
        }

    }//End Controller
}