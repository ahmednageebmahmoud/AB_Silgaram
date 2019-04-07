using DAL.Bll;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ControlPanel.Controllers
{
    public class ServiceController : BaseController
    {
        //Gat User Data
        public JsonResult FillUserData()
        {
            return Json(CookieService.UserInfo, JsonRequestBehavior.AllowGet);
        }
      
        //Get Notifications
        public JsonResult GetNotifications(int skip, int take)
        {
            return Json(NotificationS.GetNotifications(CookieService.UserInfo.Id, skip,take), JsonRequestBehavior.AllowGet);
        }

        //Get Technical Support
        public JsonResult GetTechnicalSupport(int skip, int take)
        {
            return Json(new TechnicalSupportData().GetTechnicalSupportForNotifications(CookieService.UserInfo.Id, skip, take), JsonRequestBehavior.AllowGet);
        }
        

        public object GetControlPanelMenu()
        {
            return Json(MenuS.GetControlPanelMenu(), JsonRequestBehavior.AllowGet);


        }
    }
}