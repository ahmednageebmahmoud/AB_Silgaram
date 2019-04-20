using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
  public  class ChatSendVM
    {
        public string Message { get; set; }
        public int AdId { get; set; }
        public int ChatId{ get; set; }
    }
}
