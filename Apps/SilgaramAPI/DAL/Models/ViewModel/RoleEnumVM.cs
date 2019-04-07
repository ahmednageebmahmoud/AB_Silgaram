using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class RoleEnumVM
    {
        public static int Manager { get { return Convert.ToInt32(RoleEnum.Manager); } }
        public static int Supervisor { get { return Convert.ToInt32(RoleEnum.Supervisor); } }
        public static int Client { get { return Convert.ToInt32(RoleEnum.Client); } }

        
    }
}
