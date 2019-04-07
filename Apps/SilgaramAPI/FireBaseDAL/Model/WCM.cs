using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace FireBaseDAL.Model
{
  public  class WCM
    {
        public static string FireBasePushNotificationsURL { get { return GetValue("FireBasePushNotificationsURL"); } }
        public static string ServerKey { get { return GetValue("ServerKey"); } }

        


        internal static string GetValue(string key)
        {
            return WebConfigurationManager.AppSettings[key];
        }
    }
}
