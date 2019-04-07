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
    public class SubCategoriesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get cities
        public object GetSubCategories(int categoryId)
        {
            var SubCategories = db.SubCategories.Where(x => x.FkCategory_Id == categoryId).ToList();
            if (SubCategories.Count == 0)
                return null;
            return SubCategories.Select(x => new { x.Id, x.NameAr, x.NameEn, x.SubCategoryName,
          Image=      x.File.FullFileUrl

            }).ToList();
        }



        //Save Chenage
        public object SaveChanage(SubCategory[] cities)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.SubCategories);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;
            List<string> RemoveFiles = new List<string>();
            DeleteS.RemoveFiles = RemoveFiles;
            UpdateS.RemoveFiles = RemoveFiles;
            try
            {
                foreach (SubCategory SubCategory in cities)
                {
                    if (SubCategory.State ==  StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.SubCategory(SubCategory, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (SubCategory.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.SubCategory(SubCategory, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (SubCategory.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.SubCategory(SubCategory, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                }
                db.SaveChanges();

                FileService.RemoveFiles(RemoveFiles);
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
