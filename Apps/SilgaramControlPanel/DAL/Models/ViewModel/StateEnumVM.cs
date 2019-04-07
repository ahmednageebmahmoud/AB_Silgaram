using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class StateEnumVM
    {
        public static int Create { get { return Convert.ToInt32(StateEnum.Create); } }
        public static int Delete { get { return Convert.ToInt32(StateEnum.Delete); } }
        public static int Update { get { return Convert.ToInt32(StateEnum.Update); } }
        public static int Reject { get { return Convert.ToInt32(StateEnum.Reject); } }
        public static int Approve { get { return Convert.ToInt32(StateEnum.Approve); } }
        public static int Report { get { return Convert.ToInt32(StateEnum.Report); } }
        public static int Buy { get { return Convert.ToInt32(StateEnum.Buy); } }
        



    }
}
