using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Bll
{
    public class CommercialBannersData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        CreateService CreateS = new CreateService();

        public object CreateRequest(CommercialBanner commercialBanner)
        {
            try
            {
                PagesAllow PagesAllow = PageService.GetPageAllow(PageEnumVM.CommercialBanners);

                    CreateS.db = db;
                    object ObjectReturn = CreateS.CommercialBanner(commercialBanner, PagesAllow);
                    if (ObjectReturn != null)
                        return ObjectReturn;

                db.SaveChanges();
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Created };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, DevMessage = ex.Message, InnerException = ex.InnerException };
            }
        }
        public void Dispose()
        {
            db.Dispose();
        }
   
    }//End Class
}
