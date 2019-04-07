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
    public class MenusController : BaseController
    {
        MenusData MenuData = new MenusData();
         // GET: Menus
        public ActionResult Index()
        {
            return View( );
        }
        //Get Counties 
        public JsonResult GetMenus()
        { 
            return Json(MenuData.GetMenus(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChenage(Menu[] Menu)
        {
            return Json(MenuData.SaveChenage(Menu), JsonRequestBehavior.AllowGet);
        }



    }//End Controller
}