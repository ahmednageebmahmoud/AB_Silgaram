using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
    public class DefaultsVM
    {
        public static string ImageDefult { get { return ""; } }

        public static string[] ExtensionsImage { get { return new string[] { ".jpeg", ".jpg", ".png" }; } }

    }
}
