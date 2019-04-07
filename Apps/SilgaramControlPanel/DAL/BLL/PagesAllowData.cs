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
    public class PagesAllowData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Pages Allow
        public object GetPagesAllow()
        {
            var PagesAllows= db.PagesAllows.ToList();
            if (PagesAllows.Count == 0)
                return null;
            return PagesAllows.Select(x => new { x.Id, PageName=x.Page.TokenValue, x.IsAllowLog, x.IsAllowNotify, x.FkPage_Id }).ToList();
        }



        //Save Chenage
        public object SaveChenage(PagesAllow[] pagesAllows)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.PagesAllow);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;

            try
            {
                foreach (PagesAllow pagesAllow in pagesAllows)
                {
                    if (pagesAllow.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.PagesAllow(pagesAllow, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                   
                }
                db.SaveChanges();
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved};
            }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message =Token.NotSaveChange };
            }
        }

        public void Dispose()
        {
            db.Dispose();
            DeleteS.Dispose();
            UpdateS.Dispose();
            CreateS.Dispose();
               }
    }//End Class
}
