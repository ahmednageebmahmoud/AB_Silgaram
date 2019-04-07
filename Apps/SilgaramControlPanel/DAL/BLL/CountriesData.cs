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
    public class CountriesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Countries
        public object GetCountries() {
            var country = db.Countries.ToList();
            if (country.Count == 0)
                return null;
            return country.Select(x => new { x.Id, x.NameAr,x.NameEn,x.CountryName,x.CountryKey, FlagUrl=x.File.FullFileUrl }).ToList();
        }

        public object GetSimpleCountries()
        {
            var country = db.Countries.ToList();
            if (country.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };
            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = country.Select(x => new { x.Id, x.CountryName }).ToList()
            };
        }

        //Get Flags
        public object GetFlags()
        {
          return DefaultsVM.Flags.ToList();
        }

        public void Dispose()
        {
            db.Dispose();
        }

        //Save Chenage
        public object SaveChenage(Country[] countries)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Countries);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;
            try
            {
                foreach (Country country in countries)
                {
                    if (country.State == StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.Country(country, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (country.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.Country(country, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (country.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.Country(country, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                }
                db.SaveChanges();
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved };
            }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange };
            }
        }

    }//End Class
}
