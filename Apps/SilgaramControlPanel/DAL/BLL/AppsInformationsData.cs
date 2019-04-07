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
    public class AppsInformationsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        UpdateService UpdateS = new UpdateService();

        //Get jobs
        public object GetAppsInformations() {
            var AppsInformation = db.AppsInformations.ToList();
            return AppsInformation.Select(c => new
            {
                c.Id,
               Name= c.TokenValue,
                c.Value
            }).ToList();
                }


        //Save Chenage
        public object SaveChenage(AppsInformation[] appsInformations)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.AppsInformations);
           
            UpdateS.db = db;
   
            try
            {
                foreach (var item in appsInformations)
                {
                //Update
                var ObjectReturn = UpdateS.AppsInformation(item, PageAllow);
                if (ObjectReturn != null)
                    return ObjectReturn;
                }

                db.SaveChanges();
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved };
            }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange };
            }
        }

        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
