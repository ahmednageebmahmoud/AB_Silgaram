using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class AdTypeEnumVM
    {
        public static int Image { get { return Convert.ToInt32(AdTypeEnum.Image); } }
        public static int PrivateLive { get { return Convert.ToInt32(AdTypeEnum.PrivateLive); } }
        public static int PublicLive { get { return Convert.ToInt32(AdTypeEnum.PublicLive); } }
        public static int Video { get { return Convert.ToInt32(AdTypeEnum.Video); } }
    }
}
