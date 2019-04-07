using KnPayPayment.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PaymentDAL.Models
{
    public class Payment
    {

        public decimal order_amt { get; set; }
        public string order_no { get; set; }
        public string cust_email { get; set; }
        public string cust_name { get; set; }

        public string cust_mobile { get; set; }
        public string phone_code { get; set; }

        public bool knet_allowed { get; set; }
        public bool cc_allowed { get; set; }
        public int total_items => 1;

        public int delivery_charges => 0;


        public string uid => PayInfoService.PaymentUserId;
        public string pwd => PayInfoService.PaymentPassword;
        public string secret => PayInfoService.PaymentApiSecret;
        public string BaseApiUrl => PayInfoService.BaseApiUrl;

        public string callback_url => PayInfoService.CallbackSecret;


        public string FullRequestUrl { get; set; }


        /// <summary>
        /// paument and send email
        /// </summary>
        /// <param name="amount"></param>
        /// <param name="orderNumber"></param>
        /// <param name="userName"></param>
        /// <param name="email"></param>
        /// <param name="creditCard"></param>
        public Payment(decimal amount, string orderNumber, string userName, string email, bool creditCard)
        {
            this.order_amt = GetPureAmount(amount);
            this.order_no = orderNumber;
            this.cust_name = userName;
            this.cust_email = email;

            if (creditCard)
            {
                this.cc_allowed = true;
                this.knet_allowed = false;
            }
            else
            {
                this.cc_allowed = false;
                this.knet_allowed = true;
            }
            this.FullRequestUrl = GenerateUrl();

        }

        /// <summary>
        /// payment and send mobile
        /// </summary>
        /// <param name="amount"></param>
        /// <param name="orderNumber"></param>
        /// <param name="userName"></param>
        /// <param name="phoneCode"></param>
        /// <param name="mobile"></param>
        /// <param name="creditCard"></param>
        public Payment(decimal amount, string orderNumber, string userName, string phoneCode, string mobile, bool creditCard)
        {

            this.order_amt = GetPureAmount(amount);
            this.order_no = orderNumber;
            this.cust_name = userName;
            this.phone_code = phoneCode;
            this.cust_mobile = mobile;

            if (creditCard)
            {
                this.cc_allowed = true;
                this.knet_allowed = false;
            }
            else
            {
                this.cc_allowed = false;
                this.knet_allowed = true;
            }



this.FullRequestUrl=            GenerateUrl();

        }

        public string GenerateUrl()
        {
            //  https://lounge.tahseeel.com/api/?p=order
            if (string.IsNullOrEmpty(this.cust_email))
             return     $"{this.BaseApiUrl}&uid={this.uid}&pwd={this.pwd}&secret={this.secret}&order_amt={this.order_amt}&order_no={this.order_no}&phone_code={this.phone_code}&cust_mobile={this.cust_mobile}&cust_name={this.cust_name}&callback_url={this.callback_url}&cc_allowed={this.cc_allowed}&knet_allowed={this.knet_allowed}&delivery_charges={this.delivery_charges}&total_items={this.total_items}";
            else                                                                                                        
                return   $"{this.BaseApiUrl}&uid={this.uid}&pwd={this.pwd}&secret={this.secret}&order_amt={this.order_amt}&order_no={this.order_no}&cust_email={this.cust_email}&cust_name={this.cust_name}&callback_url={this.callback_url}&cc_allowed={this.cc_allowed}&knet_allowed={this.knet_allowed}&delivery_charges={this.delivery_charges}&total_items={this.total_items}";
        }


        public decimal GetPureAmount(decimal amount)
        {
            return Math.Round(amount, 3);

        }


    }//end class
}
