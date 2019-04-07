using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ControlPanel.Controllers
{
    [Authorize]
    public class LogoutController : BaseController
    {
        // GET: Logou
        public ActionResult Index()
        {
            FormsAuthentication.SignOut();
            Request.Cookies.Remove("BackEnd");
            Session["CurrentUserData"] = null;
            Session["Menu"] = null;
            return RedirectToAction("Index", "Home");
        }
    }
}