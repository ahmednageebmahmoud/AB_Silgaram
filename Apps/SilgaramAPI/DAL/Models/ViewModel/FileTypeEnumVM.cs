using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Models.ViewModel
{
 public   class FileTypeEnumVM
    {
        public static int Image { get { return Convert.ToInt32(FileTypeEnum.Image); } }
        public static int Text { get { return Convert.ToInt32(FileTypeEnum.Text); } }
        public static int Audio { get { return Convert.ToInt32(FileTypeEnum.Audio); } }
    }
}
