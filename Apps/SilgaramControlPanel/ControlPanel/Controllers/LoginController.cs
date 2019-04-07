using DAL.Enums;
using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using static DAL.Enums.Enums;

namespace ControlPanel.Controllers
{
    public class LoginController : BaseController
    {
        // GET: Login
        public ActionResult Index()
        {
            //Check User Login Or Not
            if (User.Identity.IsAuthenticated)
            {
                //user Alredy Login Now Must be return Home Page
                return RedirectToAction("Index", "Home");
            }
            return View();
        }

        //Login
        [HttpPost]
        public ActionResult Login(User user, string returnUrl)
        {
            //Check Data Empty
            if (string.IsNullOrEmpty(user.UserName) || string.IsNullOrEmpty(user.Password))
                return Json(new { RequestType = RequestTypeEnumVM.Error, Message = Token.EnterUserNameAndPassword, Title=Token.Error }, JsonRequestBehavior.AllowGet);

            //Check User Name Used
            if (CheckedS.UserNameValid(user.UserName))
            {
                //Add User Login With Statues Login Right Now 
                User User = CreateS.UserLogin(user);
                if(User==null)
                    //Retune Message Invalid Data
                    return Json(new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidData }, JsonRequestBehavior.AllowGet);

                //Check last Login is Block
                if (User.IsBlocked)
                    //retuen message Account Block 
                    return Json(new { RequestType = RequestTypeEnumVM.Error, Message = Token.YoureAccountIsBlocked }, JsonRequestBehavior.AllowGet);
                else
                    //Check last Login Statues 
                    if (User.IsSuccessLogin)
                {
                    //Login & Redirect Url

                    //Login
                    //FormsAuthentication.SetAuthCookie(user.UserName, user.RememberMe);
                    
                  

                    var UserData = UserS.GetUser(User.Id);
                    if (UserData.UserInformation.File == null)
                        UserData.UserInformation.File =new File() {FileUrl= DefaultsVM.ImageDefult };

                    //Set User Objct Date In Cookie
                    CookieService.SetUserInCookie(UserData);
                    
                    if (Url.IsLocalUrl(returnUrl)&& returnUrl != "/"&& returnUrl != "Logout")
                        return Json(new { RequestType = RequestTypeEnumVM.Success, ReturnUrl =  returnUrl }, JsonRequestBehavior.AllowGet);
                    return Json(new { RequestType = RequestTypeEnumVM.Success, ReturnUrl = "/Home"}, JsonRequestBehavior.AllowGet);
                }
                else
                    //Retune Message Invalid Data
                    return Json(new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidData }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //User Not Found ( Invalid Data)
                return Json(new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidData }, JsonRequestBehavior.AllowGet);
            }
        }


    }//end Controller
}