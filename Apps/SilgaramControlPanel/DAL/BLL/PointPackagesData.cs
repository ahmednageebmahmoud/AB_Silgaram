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
    public class PointPackagesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Point Packages
        public object GetPointPackages() {
            var PointPackages = db.PointPackages.ToList();
            if (PointPackages.Count == 0)
                return null;
            return PointPackages.Select(x => new { x.Id, x.NameAr,x.NameEn ,x.PointPackageName,x.Points,x.Price}).ToList();
        }

        //Get Simple Point Packages
        public object GetSimplePointPackages(int skip, int take)
        {
            var PointPackages = db.PointPackages.OrderByDescending(c=> c.Points).Skip(skip).Take(take).ToList();
            if (PointPackages.Count == 0)
                return new ResponseVM {RequestType=RequestTypeEnumVM.Info, Message=Token.NoDataMore };


            return PointPackages.Select(x => new { x.Id, x.PointPackageName, x.Points, x.Price }).ToList();
        }

        //Get point Package Id
        
                   public object GetPointPackage(int pointPackageId)
        {
            var PointPackage = db.PointPackages.Find(pointPackageId);
            if (PointPackage==null)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.PointPackageFound };

            return new
            {
                PointPackage.Id,
                PointPackage.PointPackageName,
                PointPackage.Price,
                PointPackage.Points,
            };
        }

        //Save Chenage
        public object SaveChenage(PointPackage[] pointPackages)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.PointPackages);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;
            try
            {
                foreach (PointPackage pointPackage in pointPackages)
                {
                    if (pointPackage.State == StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.PointPackage(pointPackage, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (pointPackage.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.PointPackage(pointPackage, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (pointPackage.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.PointPackage(pointPackage, PageAllow);
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

        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
