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
    public class ReportsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        CheckedService CheckedS = new CheckedService();

        //Get User Logins
        public object GetReports(int adId, int take, int skip)
        {
            var Ad = db.Ads.Find(adId);
            if (Ad == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.AdNotFound);

            var Reports = Ad.Reports.OrderByDescending(c => c.Id).ToList();
            if (Reports.Count==0)
                return new ResponseVM(RequestTypeEnumVM.Info, Token.NoDataMore);

            return new ResponseVM(RequestTypeEnumVM.Success, Token.Success,
          new
          {
              AdInformation = new
              {
                  Ad.Title,
                  Ad.Description,
                  Ad.Category.CategoryName,
                  Ad.SubCategory.SubCategoryName,
                  Ad.CreateDateTime,
                  Ad.FavoritesCount,
                  Ad.CreateBy,
              },
              Reports = Reports.Skip(skip).Take(take).Select(x => new
              {
                  x.Id,
                  x.ReportType.ReportTypeName,
                  x.Description,
                  Date = DateService.GetDateByCulture(x.Log.CreateDateTime),
              
                  x.User.FullName,
                  x.User.UserName,
                  x.User.Serial,
                  UserReportsCount=        x.User.Reports.Count,
                  UserReportsCountForThisAd = Ad.Reports.Count(c=> c.FkUser_Id==x.User.Id),
                  x.User.Reports.Count,
                  ImageUrl = x.User.UserInformation.File.FullFileUrl,
              }).ToList()
          });
        }



        public void Dispose()
        {
            db.Dispose();
            CheckedS.Dispose();
               }
    }//End Class
}
