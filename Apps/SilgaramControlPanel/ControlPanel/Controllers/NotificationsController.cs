using DAL.Bll;
using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ControlPanel.Controllers
{
    public class NotificationsController : BaseController
    {
        NotificationsData NotifyData = new NotificationsData();

        // GET: Notifications
        public ActionResult Index()
        {
            return View();
        }

        //Check User Allow For This Notify
             public ActionResult CheckUserAllowForThisNotify(int notifyId)
        {
            return Json(NotificationS.CheckIsAllowUserForNotify(UserS.GetCurrentUserId(), notifyId),JsonRequestBehavior.AllowGet);
        }

        //Get Notify
        public ActionResult GetNotify(int notifyId)
        {
            return Json(NotifyData.GetNotify(notifyId, UserS.GetCurrentUserId()), JsonRequestBehavior.AllowGet);
        }
    }//end controller
}