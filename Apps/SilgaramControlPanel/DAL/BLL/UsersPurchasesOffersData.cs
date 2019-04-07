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
    public class UsersPurchasesOffersData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        CheckedService CheckedS = new CheckedService();

        //Get UsersPurchasesOffers
        public object GetUsersPurchasesOffers(int adId, int take, int skip)
        {

            var UsersPurchasesOffers = db.UsersPurchasesOffers.Where(c => c.FkOffer_Id == adId).OrderByDescending(c => c.Id).ToList();

            if (UsersPurchasesOffers.Count == 0)
                return false;

            if (skip > UsersPurchasesOffers.Count)
                return null;

            return UsersPurchasesOffers.Skip(skip).Take(take).Select(x => new
            {
                x.Id,
                SellingPrice=     x.OfferPrice,
                OfferTitle = x.Offer.Title,
                OfferCurrentPrice = x.Offer.Price,
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
