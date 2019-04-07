using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class PagesRoleTypeEnumVM
    {
        public static int Management { get { return Convert.ToInt32(PagesRoleTypeEnum.Management); } }
        public static int Notifications { get { return Convert.ToInt32(PagesRoleTypeEnum.Notifications); } }
        public static int Logs { get { return Convert.ToInt32(PagesRoleTypeEnum.Logs); } }
    }
}
