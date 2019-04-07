using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
  public  class AdVM
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }

        public int FkSubCategory_Id { get; set; }
        public int FkCategory_Id { get; set; }

        public List<FileVM> Images { get; set; }
        //public int DiscountRate { get; set; }
        public int State { get; set; }
        //public int AdTypeId { get; set; }

        public string Latitude { get; set; }
        public string Longitude { get; set; }

        public string PhoneNumber { get; set; }
        public bool IsAllowMessaging { get; set; }
        public bool IsPostWithOutPhoneNumber { get; set; }
        public bool IsAutoPost { get; set; }


        internal List<string> RemoveImagesFormServer = new List<string>();


    }
}
