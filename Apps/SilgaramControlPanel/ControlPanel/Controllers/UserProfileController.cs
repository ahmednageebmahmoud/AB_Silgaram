using DAL.Bll;
using DAL.Models;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using static DAL.Enums.Enums;

namespace ControlPanel.Controllers
{[Authorize]
    public class UserProfileController : BaseController
    {
        UserProfileData UserProfileData = new UserProfileData();
        // GET: UserProfile
        public ActionResult Index()
        {
            return View();
        }

        //Get User Data
        public ActionResult GetUserData()
        { 
            return Json(UserProfileData.GetUserData(CookieService.UserInfo.Id), JsonRequestBehavior.AllowGet);
        }

        //Get User Data For Update
        public ActionResult GetUserDataForUpdate()
        { 
            return Json(UserProfileData.GetUserDataForUpdate(CookieService.UserInfo.Id), JsonRequestBehavior.AllowGet);
        }

        //Get Jobs
        [HttpGet]
        public JsonResult GetJobs()
        {
            return Json(DropDownS.Jobs(),JsonRequestBehavior.AllowGet);
        }


        //Get Provinces
        public JsonResult GetProvinces()
        {
            return Json(DropDownS.Provinces(), JsonRequestBehavior.AllowGet);
        }

        //Get Languages

        public JsonResult GetLanguages()
        {
            return Json(DropDownS.LanguageTypes(), JsonRequestBehavior.AllowGet);
        }


        //Get SocialStatus
        [HttpGet]
        public JsonResult GetSocialStatuses()
        {
            return Json(DropDownS.SocialStatus(), JsonRequestBehavior.AllowGet);
        }

        //Get Genders
        [HttpGet]
        public JsonResult GetGenders()
        {
            return Json(DropDownS.Genders(), JsonRequestBehavior.AllowGet);
        }


        //Get Roles
        [HttpGet]
        public JsonResult GetRoles()
        {
            return Json(DropDownS.Roles(), JsonRequestBehavior.AllowGet);
        }
        
        //Get Jobs
        [HttpGet]
        public JsonResult GetCountries()
        {
            return Json(DropDownS.Countries(),JsonRequestBehavior.AllowGet);
        }
        //SaveChange
        [HttpPost]
      public ActionResult SaveChange(UserInformation userInformation, Address address, User user,HttpPostedFileBase image)
        {
            //Fill Id
            user.Id = CookieService.UserInfo.Id;

            //Confirm Passowrd
            if (!string.IsNullOrEmpty(user.NewPassword))
            {

                //التحقق من ان كلمة السر هى كلمة السر الحالية
                if (!CheckedS.ConfirmNewPassword(user.Id,user.NewPassword))
                    return Json(new { RequestType = RequestStatus.Warning, Message = Token.CurrentPassword +" "+ Token.Error, Title = Token.Error }, JsonRequestBehavior.AllowGet);

                //التحقق من تطابق كلمة السر
                if (user.NewPassword != user.ConfirmPassword)
                    return Json(new { RequestType = RequestStatus.Warning, Message = Token.PasswordsAreNotConsistent, Title = Token.Warning }, JsonRequestBehavior.AllowGet);
            }

         return Json(UserProfileData.SaveChange(userInformation, address, user,image), JsonRequestBehavior.AllowGet);
        }
    }//end 
}