using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Models.ViewModels;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Bll
{
    public class HomeData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();

        //Get Home Data
        public object GetHomeData()
        {
            var SubMenus = db.SubMenus.ToList();
            int UserId = new UserService().GetCurrentUserId();
            var Date = DateTime.Now.Date;
            var MyAds = db.Ads.ToList();
            var MyUsersPurchasesAds = db.UsersPurchasesAds.ToList();

            var MyOffers = db.Offers.ToList();
            var MyUsersPurchasesOffers = db.UsersPurchasesOffers.ToList();
            var MyUsers = db.Users.ToList();
            object IncomingMessages=null,Users = null, OfferSubscriptions = null, 
                NewMessages = null, Ads = null, UsersPurchasesAds = null,
                Offers = null, UsersPurchasesOffers = null,PointPackages = null;

            bool
                IsTechnicalSupports = PageService.GetPageRole(PageEnumVM.TechnicalSupports).IsDisplay,
                IsAds = PageService.GetPageRole(PageEnumVM.Ads).IsDisplay,
                IsUsersPurchasesAds = PageService.GetPageRole(PageEnumVM.UsersPurchasesAds).IsDisplay,
                      IsOffers = PageService.GetPageRole(PageEnumVM.Offers).IsDisplay,
                IsUsersPurchasesOffers = PageService.GetPageRole(PageEnumVM.UsersPurchasesOffers).IsDisplay,
                IsUsers = PageService.GetPageRole(PageEnumVM.Users).IsDisplay;


                //Incoming Messages
            if (IsTechnicalSupports)
            {
                IncomingMessages = new
                {
                    Count = db.TechnicalSupports.Count(),
                    ClassIcon = SubMenus.Single(c => c.FKPage_Id == PageEnumVM.TechnicalSupports).ClassIcon
                };
                //New Messages
                NewMessages = new
                {
                    Count = db.TechnicalSupports.Where(c => !c.TechnicalSupportReads.Any(b => b.FkUser_Id == UserId)).Count(),
                    ClassIcon = SubMenus.Single(c => c.FKPage_Id == PageEnumVM.TechnicalSupports).ClassIcon
                };
            }

            //Ads
            if (IsAds)
              Ads = new
            {
                Count = MyAds.Count(),
                ClassIcon = SubMenus.Single(c => c.FKPage_Id == PageEnumVM.Ads).ClassIcon,
                  NewAdsCount=MyAds.Where(c=> c.Log.CreateDateTime.Date==DateTime.Now.Date).Count()
              };
            if (IsUsersPurchasesAds)
                UsersPurchasesAds = new
                {
                    Count = MyUsersPurchasesAds.Count(),
                    ClassIcon = SubMenus.Single(c => c.FKPage_Id == PageEnumVM.UsersPurchasesAds).ClassIcon,
                    NewAdsCount = MyUsersPurchasesAds.Where(c => c.BayDateTime.Date == DateTime.Now.Date).Count()
                };


            //Offers
            if (IsOffers)
                Offers = new
                {
                    Count = MyOffers.Count(),
                    ClassIcon = SubMenus.Single(c => c.FKPage_Id == PageEnumVM.Offers).ClassIcon,
                    NewOffersCount = MyOffers.Where(c => c.Log.CreateDateTime.Date == DateTime.Now.Date).Count()
                };
            if (IsUsersPurchasesOffers)
                UsersPurchasesOffers = new
                {
                    Count = MyUsersPurchasesOffers.Count(),
                    ClassIcon = SubMenus.Single(c => c.FKPage_Id == PageEnumVM.UsersPurchasesOffers).ClassIcon,
                    NewOffersCount = MyUsersPurchasesOffers.Where(c => c.BayDateTime.Date == DateTime.Now.Date).Count()
                };


 
     
         


            //Users
            if (IsUsers)
              Users = new
            {
                Count = MyUsers.Count(),
                CountNewUsersToday = MyUsers.Where(c => c.CreateDate == DateTime.Now).Count(),
                ClassIcon = SubMenus.Single(c => c.FKPage_Id == PageEnumVM.Users).ClassIcon,
            };

            var Data = new
            {
                IsTechnicalSupports,
                IsAds,
                IsUsersPurchasesAds,
                IsOffers,
                IsUsersPurchasesOffers,
                IsUsers,
                Ads,
                UsersPurchasesAds,
                PointPackages,
                OfferSubscriptions,
                Users,
                IncomingMessages,
                NewMessages
            };
            return Data;
        }

     
       
        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
