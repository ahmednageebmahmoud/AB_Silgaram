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
    public class UserPointPackagesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get PointPackages
        public object GetUserPointPackages(int pointPackageId, int skip, int take)
        {


            var PointPackage = db.PointPackages.Find(pointPackageId);

            if (PointPackage == null)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.PointPackageFound };

            var UserPointPackages = PointPackage.UserPointPackages.OrderByDescending(c => c.Id).Skip(skip).Take(take).ToList();

            if (skip > UserPointPackages.Count || UserPointPackages.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };


            return new
            {
                PointPackage = new
                {
                   PointPackage.PointPackageName,
                    CuurentPrice = PointPackage.Price,
                },
                UserPointPackages = UserPointPackages.Select(x => new
                {
                    x.Id,
                    x.FkUser_Id,
                    x.User.FullName,
                    x.User.UserName,
                    x.User.Serial,
                    BuyDateTime = DateService.GetDateByCulture(x.BuyDateTime),
                    x.Price,
                     x.IsPaid,
                    UserImageUrl = x.User.UserInformation.File.FullFileUrl,
                }).ToList()
            };
        }

        //Post Point Package Buy
          public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
