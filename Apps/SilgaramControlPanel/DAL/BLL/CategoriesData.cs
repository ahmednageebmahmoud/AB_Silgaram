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
    public class CategoriesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Categories
        public object GetCategories() {
            var country = db.Categories.ToList();
            if (country.Count == 0)
                return null;
            return country.Select(x => new { x.Id, x.NameAr,x.NameEn,x.CategoryName }).ToList();
        }

        public object GetSimpleCategories()
        {
            var country = db.Categories.ToList();
            if (country.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };
            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = country.Select(x => new { x.Id, x.CategoryName }).ToList()
            };
        }

        public void Dispose()
        {
            db.Dispose();
        }

        //Save Chenage
        public object SaveChenage(Category[] Categories)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Categories);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;
            try
            {
                foreach (Category cateogry in Categories)
                {
                    if (cateogry.State == StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.Category(cateogry, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (cateogry.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.Category(cateogry, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (cateogry.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.Category(cateogry, PageAllow);
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
