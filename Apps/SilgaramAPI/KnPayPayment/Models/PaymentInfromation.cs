using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KnPayPayment.Models
{
  public  class PaymentInfromation
    {

        public string link { get; set; }
        public string msg { get;  set; }
        public bool error { get;  set; }
        public string orderNumber { get; set; }
        public string callbackurl { get; set; }
        public string Hash { get; set; }
    }
}
