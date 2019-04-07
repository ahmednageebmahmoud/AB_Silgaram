using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
    public class ResponseVM
    {

        public string DevMessage { get; internal set; }
        public Exception InnerException { get; internal set; }
        public string Message { get; internal set; }
        public int RequestType { get; internal set; }
        public object Data { get; internal set; }
        public bool IsData { get; internal set; }


        public ResponseVM(int requestype,string message)
        {
            this.RequestType = requestype;
            this.Message = message;
        }

        public ResponseVM(int requestype, string message,object data)
        {
            this.RequestType = requestype;
            this.Message = message;
            this.IsData = true;
            this.Data = data;
        }

        public ResponseVM()
        {

        }
    }
}
