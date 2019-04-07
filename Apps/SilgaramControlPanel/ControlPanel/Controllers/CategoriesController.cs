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
    public class CategoriesController : BaseController
    {
		CategoriesData CategoryData = new CategoriesData();
         // GET: Category
        public ActionResult Index()
        {
            return View( );
        }
        //Get Counties 
        public JsonResult GetCategories()
        { 
            return Json(CategoryData.GetCategories(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChenage(Category[] Categories)
        {
            return Json(CategoryData.SaveChenage(Categories), JsonRequestBehavior.AllowGet);
        }



    }//End Controller
}