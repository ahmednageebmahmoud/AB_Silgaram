using FireBaseDAL.Model.VM;
using FireBaseDAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models.ViewModel;

namespace DAL.Service
{
 public   class FireBaseService
    {
        /// <summary>
        /// ارسال اشعار الى مستخدم معين
        /// </summary>
        /// <param name="userFireBaseToken"></param>
        /// <param name="notifyObject"></param>
        public static void SendSpecificNotification(string userFireBaseToken,object notifyObject)
        {
            CloudMessageingService.SendNotification(new FireBaseDAL.Model.SendNotify()
            {
                to= userFireBaseToken,
                data=notifyObject,
                messaeType= MessaeTypeEnumVM.SpecificNotification
            });
        }

        public static void SendSpecificMessage(string userFireBaseToken, object objMessage)
        {
            CloudMessageingService.SendNotification(new FireBaseDAL.Model.SendNotify()
            {
                to = userFireBaseToken,
                data = objMessage,
                messaeType = MessaeTypeEnumVM.Message
            });
        }
    }
}
