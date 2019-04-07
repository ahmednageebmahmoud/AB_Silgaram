using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace KnPayPayment.Service
{
    public class PayInfoService
    {
        public static string PaymentUserId => GetValue("PaymentApiUserId");
        public static string PaymentPassword => GetValue("PaymentApiPassword");
        public static string PaymentApiSecret => GetValue("PaymentApiSecret");
        public static string CallbackSecret => GetValue("CallbackSecret");
        public static string BaseApiUrl => GetValue("BaseApiUrl");
        

        internal static string GetValue(string key)
        {
            return WebConfigurationManager.AppSettings[key];
        }
    }
}
