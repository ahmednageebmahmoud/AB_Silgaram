using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
    public class PaymentVM
    {

        public string cancelled { get; set; }
        public string hash { get; set; }
        public string inv_id { get; set; }
        public string tx_date { get; set; }
        public string tx_amt { get; set; }
        public string tx_id { get; set; }
        public string tx_mode { get; set; }
        public string tx_status { get; set; }
        public string result { get; set; }
        public string PaymentID { get; set; }
        public string PostDate { get; set; }
        public string TranID { get; set; }
        public string Auth { get; set; }
        public string Ref { get; set; }

    }
}
