using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class PositionTypeEnumVM
    {
        public static int P1 { get { return Convert.ToInt32(PositionTypeEnum.P1); } }
        public static int P2 { get { return Convert.ToInt32(PositionTypeEnum.P2); } }
        public static int P3 { get { return Convert.ToInt32(PositionTypeEnum.P3); } }
        public static int P4 { get { return Convert.ToInt32(PositionTypeEnum.P4); } }
        public static int P5 { get { return Convert.ToInt32(PositionTypeEnum.P5); } }
    }
}
