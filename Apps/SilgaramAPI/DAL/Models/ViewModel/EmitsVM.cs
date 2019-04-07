using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
   public static class EmitsVM
    {
        public static string Chatting { get { return "chatting"; } }
        public static string SpecificNotifications { get { return "specific-notifications"; } }
        public static string BaseNotifyRoomForSpecificUser { get { return "Notify-User-"; } }
    }
}
