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

        public int FileId { get; set; }
        public int State { get; set; }
        public string FileUrl { get; set; }
        public string FileBase64 { get; set; }
        public string FileName { get;   set; }
    }
}
