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
    public class SubCategoriesController : BaseController
    {
        SubCategoriesData SubCategoryData = new SubCategoriesData();
         // GET: SubCategory
        public ActionResult Index()
        {
            return View( );
        }
         //Get SubCategorys 
         public JsonResult GetSubCategories(int categoryId)
        { 
            return Json(SubCategoryData.GetSubCategories(categoryId), JsonRequestBehavior.AllowGet);
        }

        //Get Country
        public JsonResult GetCategories()
        { 
            return Json(DropDownS.Categories(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChanage(SubCategory[] subCategories)
        {
            return Json(SubCategoryData.SaveChanage(subCategories), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}