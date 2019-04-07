using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
    public class CahtMessageVM
    {
        public int AdId { get;   set; }
        public string FullName { get;  set; }
        public int Id { get;  set; }
        public bool IsFromMe { get;  set; }
        public bool IsOwnar { get;  set; }
        public string Message { get;  set; }
        public DateTime SendDateTime { get;  set; }
        public string UserImage { get;  set; }
        public string UserName { get;  set; }
    }
}
