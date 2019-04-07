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
    public class PagesRolesController : BaseController
    {
        PagesRolesData PageAllowData = new PagesRolesData();
         // GET: City
        public ActionResult Index()
        {
            return View( );
        }
         //Get Pages 
         public JsonResult GetPages()
        { 
            return Json(DropDownS.Pages(), JsonRequestBehavior.AllowGet);
        }


        //Get Roles
        public JsonResult GetRoles()
        {
            return Json(DropDownS.Roles(), JsonRequestBehavior.AllowGet);
        }

        //Get Pages Role Types
        public JsonResult GetPagesRoleTypes()
        {
            return Json(DropDownS.PagesRoleTypes(), JsonRequestBehavior.AllowGet);
        }


        //Get Pages Allow
        public JsonResult GetPagesRoles(int pageId)
        {
            return Json(PageAllowData.GetPagesRoles(pageId), JsonRequestBehavior.AllowGet);
        }

        //SaveChenage
        public ActionResult SaveChenage(PagesRole[] pagesRoles)
        {
            return Json(PageAllowData.SaveChenage(pagesRoles), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}