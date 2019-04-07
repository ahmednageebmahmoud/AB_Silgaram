using DAL.Bll;
using DAL.Models;
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
    public class JobsController : BaseController
    {
        JobsData JobData = new JobsData();

         // GET: Job
        public ActionResult Index()
        {
            return View( );
        }

         //Get Jobs 
         public JsonResult GetJobs()
        {  
            return Json(JobData.GetJobs(), JsonRequestBehavior.AllowGet);
        }


        //SaveChenage
        public ActionResult SaveChenage(Job[] jobs)
        {
            return Json(JobData.SaveChenage(jobs), JsonRequestBehavior.AllowGet);
        }


    }//End Controller
}