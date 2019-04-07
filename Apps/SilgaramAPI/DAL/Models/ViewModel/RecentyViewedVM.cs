using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
    class RecentyViewedVM
    {

        public object CountViewer { get;   set; }
        public object DateTime { get;   set; }
        public object Description { get;   set; }
        public object Image { get;   set; }
        public bool IsOffer { get;   set; }
        public bool IsAd { get;   set; }
        public object Title { get; set; }
    }
}
