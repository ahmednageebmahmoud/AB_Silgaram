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
    public class ProvincesData : IDisposable
    {
         SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get cities
        public object GetProvinces(int countryid)
        {
            var Provinces = db.Provinces.Where(x => x.FKCountry_Id == countryid).ToList();
            if (Provinces.Count == 0)
                return null;
            return Provinces.Select(x => new { x.Id, x.NameAr, x.NameEn, x.ProvinceName }).ToList();
        }



        //Save Chenage
        public object SaveChenage(Province[] provinces)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Provinces);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;
            try
            {
                foreach (Province province in provinces)
                {
                    if (province.State == StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.Province(province, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (province.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.Province(province, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (province.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.Province(province, PageAllow);
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
