using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class RequestTypeEnumVM
    {
        public static int Success { get { return Convert.ToInt32(RequestStatus.Success); } }
        public static int Error { get { return Convert.ToInt32(RequestStatus.Error); } }
        public static int Warning { get { return Convert.ToInt32(RequestStatus.Warning); } }
        public static int Info { get { return Convert.ToInt32(RequestStatus.Info); } }
        
    }
}
