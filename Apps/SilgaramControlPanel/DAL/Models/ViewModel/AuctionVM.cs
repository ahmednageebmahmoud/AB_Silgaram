using DAL.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
    public class AuctionVM
    {
        public string Description { get; internal set; }
        public DateVM EndTime { get; internal set; }
        public int Id { get; internal set; }
        public string Image { get; internal set; }
        public string Name { get; internal set; }
        public DateVM StartTime { get; internal set; }
    }
}
