using DAL.Models.ViewModel;
using DAL.Service;
using FireBaseDAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace API.Controllers
{



    public class HomeController : Controller
    {
        public async Task< ActionResult> Index()
        {
            //string AccessToken = "fbZtyfJP4KI:APA91bFSI7q90AR-VeQxYTPy-jyuwQWSNptDJ78vn-8as1dFn3vvqn3a67umsLTXQIaUgDuks6hu11p_vxHp4zh2_B1Tyy9ncgA80r4xpfTFYi7ORMuSjHPbbIM51l9kSV2-y_9qA8jl";
            //var ObjNotifiy =
            //                 NotifyVM.NotifyNode(
            //                     usersFollowingYouId: 1,
            //                     nameAction: "عنوان : تجربة ارسال اشعار خاص ",
            //                     body: "الوصف : تجربة ارسال اشعار خاص"
            //                     );
            //FireBaseService.SendSpecificNotification(AccessToken, ObjNotifiy);








            //var Object = new CahtMessageVM
            //{
            //    Id = 1,
            //    Message = "هل هذا المنتج جيد",
            //    SendDateTime = DateTime.Now,
            //    UserName = "ahmed@nageeb",
            //    FullName = "ahmed nageeb mahmoud",
            //    UserImage = "http://silgaram-api.red-uae.com/Help#Login.png",
            //    IsOwnar = true,
            //    IsFromMe = true
            //};

            //FireBaseService.SendSpecificMessage(AccessToken, Object);


           

            ViewBag.Title = "Home Page";


 



            return View();
        }
    }
}
