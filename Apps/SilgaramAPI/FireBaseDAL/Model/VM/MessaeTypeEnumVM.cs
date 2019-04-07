using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static FireBaseDAL.Enums.Enums;

namespace FireBaseDAL.Model.VM
{
    public class MessaeTypeEnumVM
    {
        public static int Message { get { return Convert.ToInt32(MessaeTypeEnum.Message); } }
        public static int PublicNotification { get { return Convert.ToInt32(MessaeTypeEnum.PublicNotification); } }
        public static int SpecificNotification { get { return Convert.ToInt32(MessaeTypeEnum.SpecificNotification); } }
    }
}
