using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using FireBaseDAL.Service;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace API.Controllers
{
    public class BaseApiController : ActionFilterAttribute
    {


        // as open request 
        public override void OnActionExecuting(HttpActionContext actionContext)
        {

            //Code ...

          


            //Now Set Culture 
            //Check User Is Login
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if(!UserService.IsUser(AccessToken.GetUserId()))
                {
                    var ResponseObject = new ResponseVM(RequestTypeEnumVM.Error,  Token.YourAccountHasBeenDeleted);
                    var response = new HttpResponseMessage
                    {
                        Content = new StringContent(JsonConvert.SerializeObject(ResponseObject))
                    };
                    throw new HttpResponseException(response);
                }

                LanguageService.SetCulture();

                //Check User Is Not Blocked
                if (UserService.CheckIsBlocked())
                {
                    var ResponseObject = new ResponseVM(RequestTypeEnumVM.Error,  Token.YouBlocked);
                    var response = new HttpResponseMessage
                    {
                        Content = new StringContent(JsonConvert.SerializeObject(ResponseObject))
                    };
                    throw new HttpResponseException(response);
                }

            }
       
            //set ar  language
            else
            {
                var Lang = actionContext.Request.Headers.AcceptLanguage.Select(c => c.Value).FirstOrDefault();


                //get Language from culture or set language default
                if (Lang == "en")
                    LanguageService.SetCulture("en");
                else
                    LanguageService.SetCulture("ar");

            }
        }

    }
}
