using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
  public  class UserChatVM
    {
        public int ChatId { get; set; }
        public CahtMessageVM LastMessageInChatRoom { get; set; }
        public string DateTimeCreateChat{ get; set; }
        public string AdTitle { get; set; }
        public int AdId { get;   set; }
    }
}
