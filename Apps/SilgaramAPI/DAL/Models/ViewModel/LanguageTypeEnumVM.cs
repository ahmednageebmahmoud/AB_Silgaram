using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class LanguageTypeEnumVM
    {
        public static int English { get { return Convert.ToInt32(LanguageTypeEnum.English); } }
        public static int Arabic { get { return Convert.ToInt32(LanguageTypeEnum.Arabic); } }
    }
}
