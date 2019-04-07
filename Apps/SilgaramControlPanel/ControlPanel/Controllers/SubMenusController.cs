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
    public class SubMenusController : BaseController
    {
        SubMenusData SubMenuData = new SubMenusData();
         // GET: SubMenus
        public ActionResult Index()
        {
            return View( );
        }
        //Get SubMenus 
        public JsonResult GetSubMenus()
        { 
            return Json(SubMenuData.GetSubMenus(), JsonRequestBehavior.AllowGet);
        }

        //Get Menu 
        public JsonResult GetMenus()
        {
            return Json(DropDownS.Menus(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChenage(SubMenu[] SubMenu)
        {
            return Json(SubMenuData.SaveChenage(SubMenu), JsonRequestBehavior.AllowGet);
        }



    }//End Controller
}