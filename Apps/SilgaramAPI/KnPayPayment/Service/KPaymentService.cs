using KnPayPayment.Models;
using KnPayPayment.Service;
using PaymentDAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;

namespace KnPayPayment.Service
{
    public class KPaymentService
    {
        public static PaymentInfromation InitializePayment(Payment payment)
        {
            using (HttpClient HC = new HttpClient())
            {
                PaymentInfromation PaymentInfo = new PaymentInfromation();
                JavaScriptSerializer Serializer = new JavaScriptSerializer();

                //Create Header
                HC.DefaultRequestHeaders.Accept.Clear();

                //Call Api
                var Respo = HC.GetAsync(PayInfoService.BaseApiUrl);

                var Content = Respo.Result.Content;
                string Message = Content.ReadAsStringAsync().Result;

                PaymentInfo = Serializer.Deserialize<PaymentInfromation>(Message);
                PaymentInfo.orderNumber = payment.order_no;
                PaymentInfo.callbackurl = payment.callback_url;

                //https://lounge.tahseeel.com/o/?id=11&hash=592081b91150" 


                if(!PaymentInfo.error)
                PaymentInfo.Hash= new Uri(PaymentInfo.link).Query.Replace('?', ' ').Split('&')[1].Split('=')[1];

                return PaymentInfo;
            }
        }

    }//end class
}
