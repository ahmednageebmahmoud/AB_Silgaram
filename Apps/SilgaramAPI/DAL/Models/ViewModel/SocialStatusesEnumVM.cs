using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class SocialStatusesEnumVM
    {
        public static int Married { get { return Convert.ToInt32(SocialStatusesEnum.Married); } }
        public static int Single { get { return Convert.ToInt32(SocialStatusesEnum.Single); } }
        public static int Widower { get { return Convert.ToInt32(SocialStatusesEnum.Widower); } }
    }
}
