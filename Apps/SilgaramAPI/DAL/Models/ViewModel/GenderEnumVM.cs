using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class GenderEnumVM
    {
        public static int Male { get { return Convert.ToInt32(GenderEnum.Male); } }
        public static int Female { get { return Convert.ToInt32(GenderEnum.Female); } }
    }
}
