using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace DAL.Models.ViewModel
{
    public static class WCMVM
    {
        public static string PaymentId { get { return GetValue("PaymentId"); } }
        public static string GatewayCode { get { return GetValue("GatewayCode"); } }
        public static string NodeJsAppPath { get { return GetValue("NodeJsAppPath"); } }


        public static string HostMail { get { return GetValue("HostMail"); } }
        public static string BaseEmail { get { return GetValue("BaseEmail"); } }
        public static string BaseEmailPassword { get { return GetValue("BaseEmailPassword"); } }


        internal static string GetValue(string key)
        {
            return WebConfigurationManager.AppSettings[key];
        }
    }
}
