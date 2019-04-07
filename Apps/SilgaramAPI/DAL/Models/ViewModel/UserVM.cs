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

        /// <summary>
        /// الآميل
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        /// الباسورد
        /// </summary>
        public string Password { get; set; }

        /// <summary>
        /// رقم الهاتف
        /// </summary>
        public string PhoneNumber { get; set; }

        /// <summary>
        /// الدولة
        /// </summary>
        public int CountryId { get; set; }
    }
}
