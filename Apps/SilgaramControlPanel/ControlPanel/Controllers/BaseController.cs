using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAL.Models;
using DAL.Bll;
using System.Globalization;
using DAL.Service;
using System.Web.Security;
using System.Security.Principal;

namespace ControlPanel.Controllers
{
    public class BaseController : Controller
    {
        public CheckedService CheckedS = new CheckedService();
        public CreateService CreateS = new CreateService();
        public DropDownService DropDownS = new DropDownService();
        public UserService UserS = new UserService();
        public MenuService MenuS = new MenuService();
        public NotificationService NotificationS = new NotificationService();

   
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {

            //using (SilgaramEntities db = new SilgaramEntities())
            //{
            //    var Logs = db.Logs.Where(c =>
            //      c.Ads.Count == 0 &&
            //      c.Categories.Count == 0 &&
            //      c.Cities.Count == 0 &&
            //      c.Countries.Count == 0 &&
            //      c.Jobs.Count == 0 &&
            //      c.Nationalities.Count == 0 &&
            //      c.PagesAllows.Count == 0 &&
            //      c.PagesRoles.Count == 0 &&
            //      c.Users.Count == 0 &&
            //      c.SubCategories.Count == 0
            //     ).ToList();

            //    //Remove Histories 
            //    //foreach (var item in Logs)
            //    //{
            //    //    db.Histories.RemoveRange(item.Histories);
            //    //}
            //    //                db.SaveChanges();

            //    //Remove  Logs
            //    foreach (var item in Logs)
            //    {
            //        db.Logs.Remove(item);
            //        db.SaveChanges();
            //    }

            //}



       //string[] Arrays=     System.IO.Directory.GetFiles(Server.MapPath("/Files/images/FlagsMiniSvg/"));
       //     var f = Arrays.ToString();

       //     System.IO.File.WriteAllLines(Server.MapPath("/TextFile1.txt"),Arrays);

            //Now Set Culture 
            LanguageService.SetCulture();

            //base.OnActionExecuting(filterContext);
        }
 
        protected override void Dispose(bool disposing)
        {
            CheckedS.Dispose();
            CreateS.Dispose();
            DropDownS.Dispose();
            UserS.Dispose();
            MenuS.Dispose();
        }
    }
}//end class
