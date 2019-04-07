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
    public class UsersController : BaseController
    {
        UsersData UserData = new UsersData();

         // GET: User
        public ActionResult Index()
        {
            return View();
        }

        //Create And Update
        public ActionResult CreateAndUpdate()
        {
            return View();
        }

        //Get Users 
        public JsonResult GetUsers(int coutnUserTake, int coutnUserSkip)
        {
            return Json(UserData.GetUsers(coutnUserTake, coutnUserSkip), JsonRequestBehavior.AllowGet);
        }

        //Get User For Update
        
                 public JsonResult GetUserForUpdate(string serial)
        {
            return Json(UserData.GetUserDataForUpdate(serial), JsonRequestBehavior.AllowGet);
        }
        //Get Countries
        public JsonResult GetCountries()
        { 
            return Json(DropDownS.Countries(), JsonRequestBehavior.AllowGet);
        }
        //Get Jobs
        public JsonResult GetJobs()
        {
            return Json(DropDownS.Jobs(), JsonRequestBehavior.AllowGet);
        }
        //Get SocialStatus
        public JsonResult GetSocialStatus()
        {
            return Json(DropDownS.SocialStatus(), JsonRequestBehavior.AllowGet);
        }
        //Get Provinces
        public JsonResult GetProvinces()
        {
            return Json(DropDownS.Provinces(), JsonRequestBehavior.AllowGet);
        }

        
        //Get Genders
        public JsonResult GetGenders()
        {
            return Json(DropDownS.Genders(), JsonRequestBehavior.AllowGet);
        }

        //Get Languages
        public JsonResult GetLanguages()
        {
            return Json(DropDownS.LanguageTypes(), JsonRequestBehavior.AllowGet);
        }

        //Get Roles
        public JsonResult GetRoles()
        {
            return Json(DropDownS.Roles(), JsonRequestBehavior.AllowGet);
        }
        
        //SaveChenage
        public ActionResult SaveChanage(UserInformation userInformation, Address address, User user,UserRole[] userRoles, HttpPostedFileBase image,bool isUpdate)
        {
         


              
            return Json(UserData.SaveChenage(userInformation, address, user, userRoles, image, isUpdate), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}