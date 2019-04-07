using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DAL.Service;
using DAL.Models.ViewModel;
using KnPayPayment.Models;

namespace API.Controllers
{
    /// <summary>
    /// سيرفيس عمليات الدفع فى سيلغرام
    /// </summary>
    [RoutePrefix("Silgaram/api/Payments")]
    public class PaymentsController : ApiController
    {
      
        [Route("SavePaymentProcess")]
        public IHttpActionResult SavePaymentProcess([FromUri]PaymentVM payInfo)
        {
            //Save Information
            PaymentService.SavePaymentProcess(payInfo);
            return Ok();
        }


        /// <summary>
        /// هذة السيرفيس هى للحصول على معلومات الدفع لـ اى عملة دفع تمت فى سيلغرام
        /// </summary>
        /// <param name="paymrntOrderNo"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetPaymentInformation/{paymrntOrderNo}")]
        public IHttpActionResult GetPaymentInformation(string paymrntOrderNo)
        {
            return Json(PaymentService.GetPaymentInformation(paymrntOrderNo));
        }


    }//end class
}
