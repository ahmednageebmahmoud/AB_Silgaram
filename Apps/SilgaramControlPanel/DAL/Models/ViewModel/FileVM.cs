using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace DAL.Models.ViewModel
{
    public class FileVM
    {
        public int AlbumFileId { get; set; }
        public int State { get; set; }
        public string FileUrl { get; set; }
        public HttpPostedFileBase File { get; set; }

    }
}
