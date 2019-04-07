using FireBaseDAL.Model;
using FireBaseDAL.Model.VM;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace FireBaseDAL.Service
{
    public class CloudMessageingService
    {
        public static void SendNotification(SendNotify sendNotify)
        {

            string Authorization = "key=" + WCM.ServerKey;

            using (HttpClient HC = new HttpClient())
            {
                JavaScriptSerializer Serializer = new JavaScriptSerializer();
               
                string ObjectJson = Serializer.Serialize(sendNotify);

                var ObjectJsonBytes = System.Text.Encoding.UTF8.GetBytes(ObjectJson);
                var ByteContent = new ByteArrayContent(ObjectJsonBytes);

                //Create Header
                HC.DefaultRequestHeaders.Accept.Clear();
                ByteContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                HC.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HC.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", Authorization);

                //Call Api
                var Respo = HC.PostAsync(WCM.FireBasePushNotificationsURL, ByteContent);

                var Content = Respo.Result.Content;
                string Message = Content.ReadAsStringAsync().Result;

                if (Respo.Result.StatusCode == HttpStatusCode.OK)
                {
                    //  PayInfo = Serializer.Deserialize<PaymentInfromation>(Message);
                }
                else
                {
                    //PayInfo.ErrorMessage = Serializer.Deserialize<object>(Message);
                }
            }
        }


    }
}
