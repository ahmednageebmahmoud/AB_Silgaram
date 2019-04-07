using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FireBaseDAL.Model
{
 public   class NotificationBody
    {
        /// <summary>
        /// notification title
        /// </summary>
        public string title { get; set; }
        /// <summary>
        /// notification body
        /// </summary>
        public string body { get; set; }
    }
}
