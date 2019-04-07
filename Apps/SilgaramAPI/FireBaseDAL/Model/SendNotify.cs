using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FireBaseDAL.Model
{
    /// <summary>
    /// class for sed cloud message 
    /// https://firebase.google.com/docs/cloud-messaging/http-server-ref#device-group-management
    /// </summary>
    public class SendNotify
    {
        /// <summary>
        /// لتحديد نوع الرسالة
        /// </summary>
        public int messaeType { get; set; }
        /// <summary>
        /// any object data in with notify
        /// </summary>
        public object data { get; set; }
        /// <summary>
        /// List of all devices assigned to a user<
        /// </summary>
       // public string[] registration_ids { get; set; }

        /// <summary>
        /// Notification Body
        /// </summary>
//        public NotificationBody notification { get; set; }


        /// <summary>
        /// to 
        /// Defult Is : /topics/foo-bar
        /// </summary>
        public string to { get; set; }

        public SendNotify()
        {
            this.to= "/topics/foo-bar";
        }


    }
}
