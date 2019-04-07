using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class PhoneTypeEnumVM
    {
        public static int Fax { get { return Convert.ToInt32(PhoneTypeEnum.Fax); } }
        public static int Home { get { return Convert.ToInt32(PhoneTypeEnum.Home); } }
        public static int Mobile { get { return Convert.ToInt32(PhoneTypeEnum.Mobile); } }
    }
}
