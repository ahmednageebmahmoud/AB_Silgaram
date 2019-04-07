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

        //Get Simple Point Packages
        public object GetSimplePointPackages(int skip, int take)
        {
            var PointPackages = db.PointPackages.OrderByDescending(c=> c.Points).Skip(skip).Take(take).ToList();
            if (PointPackages.Count == 0)
                return new ResponseVM {RequestType=RequestTypeEnumVM.Info, Message=Token.NoDataMore };


            return PointPackages.Select(x => new { x.Id, x.PointPackageName,x.Description, x.Points, x.Price }).ToList();
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


        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
