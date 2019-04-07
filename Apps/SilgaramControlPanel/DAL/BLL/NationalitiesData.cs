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
    public class NationalitiesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Nationalities
        public object GetNationalities()
        {
            var Nationalities = db.Nationalities.ToList();
            if (Nationalities.Count == 0)
                return null;
            return Nationalities.Select(x => new { x.Id, x.NameAr, x.NameEn, x.NationalityName }).ToList();
        }



        //Save Chenage
        public object SaveChenage(Nationality[] nationalities)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Nationalities);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;
            try
            {
                foreach (Nationality nationality in nationalities)
                {
                    if (nationality.State ==  StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.Nationality(nationality, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (nationality.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.Nationality(nationality, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (nationality.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.Nationality(nationality, PageAllow);
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
