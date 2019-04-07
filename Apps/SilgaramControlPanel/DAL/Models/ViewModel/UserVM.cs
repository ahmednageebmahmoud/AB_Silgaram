using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
 public   class UserVM
    {
        public int NewCountryId { get; set; }

        /// <summary>
        /// الآميل
        /// </summary>
        [Description("dd")]
        public string Email { get; set; }

        /// <summary>
        /// الباسورد
        /// </summary>
        public string Password { get; set; }
    }
}
