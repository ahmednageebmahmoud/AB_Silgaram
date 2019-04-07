using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using KnPayPayment.Service;
using KnPayPayment.Models;
using DAL.Models;
using DAL.Resource;
using DAL.Models.ViewModel;
using System.Web;

namespace DAL.Service
{
    public class PaymentService
    {
        /// <summary>
        /// تهيئه وارجاع رابط الدفع
        /// </summary>
        /// <param name="paymentId"></param>
        /// <param name="price"></param>
        /// <param name="isEn"></param>
        /// <param name="email"></param>
        /// <param name="disclosureUrl"></param>
        /// <returns></returns>
        public static PaymentInfromation InitializePayment_Email(decimal amount, string userName, string email, bool isCreditCard)
        {
            return KPaymentService.InitializePayment(new PaymentDAL.Models.Payment(amount, CreateOrderNumber(), userName, email, isCreditCard));
        }

        public static object GetPaymentInformation(string paymrntOrderNo)
        {
            using (SilgaramEntities db = new SilgaramEntities())
            {
                var Payment = db.Payments.SingleOrDefault(c => c.OrderNo == paymrntOrderNo);
                if (Payment == null)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.PaymenNotFound);
                return new ResponseVM(RequestTypeEnumVM.Success, Token.Success, new
                {
                    Payment.Amount,
                    Payment.Auth,
                    Payment.DateTime,
                    Payment.Hash,
                    Payment.InvoiceId,
                    IsCancelled = Payment.IsCancelled > 1,
                    Payment.Mode,
                    Payment.PaymentID,
                    Payment.PostDate,
                    Payment.Ref,
                    Payment.Result,
                    Payment.Status,
                    Payment.TranID,
                    Payment.TransactionId,
                });
            }
        }




        /// <summary>
        /// تهيئه وارجاع رابط الدفع
        /// </summary>
        /// <param name="paymentId"></param>
        /// <param name="price"></param>
        /// <param name="isEn"></param>
        /// <param name="email"></param>
        /// <param name="disclosureUrl"></param>
        /// <returns></returns>
        public static PaymentInfromation InitializePayment_Phone(long paymentId, string orderNo, decimal amount, string userName, string phoneCode, string phone, bool isCreditCard)
        {
            return KPaymentService.InitializePayment(new PaymentDAL.Models.Payment(amount, orderNo, userName, phoneCode, phone, isCreditCard));
        }







        /// <summary>
        /// ارسال رسالة بريد آاكترونى الى المستخدم
        /// </summary>
        /// <param name="payment"></param>
        static void SendEmail(Payment payment)
        {
            using (SilgaramEntities db = new SilgaramEntities())
            {
                //  try
                //  {
                //      var PaymentInfo = GetPaymentInfo(payment);

                //      //Get User by Email
                //      var User = db.Users.Where(c => c.Email == payment.).SingleOrDefault();

                //      if (User == null)
                //          return;
                //bool IsEn=      UserService.UserIsEn(User);
                //      //new EmailService().SendPaymentMail(PaymentInfo, User.UserName, User.Email, IsEn);
                //  }
                //  catch (Exception)
                //  {
                //  }
            }
        }


        public static string CreateOrderNumber()
        {

            //نقوم باستخرج المعرف عند الحاجةس
            string OrderNo = string.Format("SelaGram-{0}-{1}", Guid.NewGuid(), AccessToken.GetUserId());

            if (OrderNo.Length > 128)
                OrderNo = OrderNo.Substring(0, 128);

            using (SilgaramEntities db = new SilgaramEntities())
                if (db.Payments.Any(c => c.OrderNo == OrderNo))
                    CreateOrderNumber();
            return OrderNo;
        }

        /// <summary>
        /// حفظ نتائج عملية الدفع واذا قام بـ الدفع نقوم بتزويد النقاط الخاصة بة
        /// </summary>
        /// <param name="payInfo"></param>
        public static void SavePaymentProcess(PaymentVM payInfo)
        {
            using (SilgaramEntities db = new SilgaramEntities())
            {
                var Payment = db.Payments.Single(c => c.Hash == payInfo.hash);

                Payment.Amount = payInfo.tx_amt;
                Payment.Auth = payInfo.Auth;
                Payment.IsCancelled = int.Parse(payInfo.cancelled);
                Payment.Auth = payInfo.inv_id;
                Payment.Auth = payInfo.PaymentID;
                Payment.Auth = payInfo.PostDate;
                Payment.Auth = payInfo.Ref;
                Payment.Auth = payInfo.result;
                Payment.Auth = payInfo.TranID;
                Payment.Auth = payInfo.tx_date;
                Payment.Auth = payInfo.tx_id;
                Payment.Auth = payInfo.tx_mode;
                Payment.Auth = payInfo.tx_status;
                db.SaveChanges();
            }
        }



    }//End Class
}
