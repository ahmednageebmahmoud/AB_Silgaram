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
    public class UsersPurchasesAdsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        CheckedService CheckedS = new CheckedService();

        //Get UsersPurchasesAds
        public object GetUsersPurchasesAds(int adId, int take, int skip)
        {

            var UsersPurchasesAds = db.UsersPurchasesAds.Where(c => c.FkAd_Id == adId).OrderByDescending(c => c.Id).ToList();

            if (UsersPurchasesAds.Count == 0)
                return false;

            if (skip > UsersPurchasesAds.Count)
                return null;

            return UsersPurchasesAds.Skip(skip).Take(take).Select(x => new
            {
                x.Id,
                SellingPrice=     x.AdPrice,
                AdTitle = x.Ad.Title,
                AdCurrentPrice = x.Ad.Price,
                x.User.UserName,
                x.User.Serial,
                ImageUrl = x.User.UserInformation.File.FullFileUrl
            });
        }



        public void Dispose()
        {
            db.Dispose();
            CheckedS.Dispose();
               }
    }//End Class
}
