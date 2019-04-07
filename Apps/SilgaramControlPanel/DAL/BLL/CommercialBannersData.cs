using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Bll
{
    public class CommercialBannerData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        UserService UserS = new UserService();
        CreateService CreateS = new CreateService();

        //Get CommercialBanner
        public object GetCommercialBanner(int CoutnContactUGet, int CoutnContactUSkip) {
            var CommercialBanners = db.CommercialBanners.OrderByDescending(c=> c.Id).Skip(CoutnContactUSkip).Take(CoutnContactUGet).ToList();

            if (CommercialBanners.Count == 0)
                return new ResponseVM {RequestType=RequestTypeEnumVM.Info,Message=Token. DataNotFound};
            return CommercialBanners.Select(x => new
            {
                x.Id,
                Date = DateService.GetDateTimeByCulture(x.DateTime),
                x.Email,
                x.Phone,
                x.Name,
            }).ToList();
        }

        public void Dispose()
        {
            db.Dispose();
            UserS.Dispose();
        }
    }//End Class
}
