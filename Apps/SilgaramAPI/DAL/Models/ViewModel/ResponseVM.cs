using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
    public class ResponseVM
    {

        public object DevMessage { get;    set; }
        public Exception InnerException { get;   set; }
        public string Message { get;   set; }
        public int RequestType { get;   set; }
        public object Data { get;   set; }
        public bool IsData { get;   set; }
        public ResponseVM(int requestType, string message, object data, object devMessage, Exception ex, bool isData = false)
        {
            this.RequestType = requestType;
            this.Message = message;
            this.Data = data;
            this.DevMessage = devMessage;
            this.InnerException = ex;
            this.DevMessage = ex.Message;
            this.IsData = isData;
        }
        public ResponseVM(int requestType, string message, object data, object devMessage, bool isData = false)
        {

            this.RequestType = requestType;
            this.Message = message;
            this.Data = data;
            this.DevMessage = devMessage;
            this.IsData = isData;
        }

        public ResponseVM()
        {

        }

        public ResponseVM(int requestType, string message, object data = null, bool isData = false)
        {
            this.Message = message;
            this.RequestType = requestType;
            this.Data = data;
            this.IsData = isData;

        }
    }
}
