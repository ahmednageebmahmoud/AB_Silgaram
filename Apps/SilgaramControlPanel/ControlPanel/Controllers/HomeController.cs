using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAL.Bll;
namespace ControlPanel.Controllers
{
   [Authorize]
    public class HomeController : BaseController
    {
        HomeData HomeData = new HomeData();

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }


        public ActionResult GetHomeDate()
        {
            return Json(HomeData.GetHomeData(), JsonRequestBehavior.AllowGet);
        }

    }
}