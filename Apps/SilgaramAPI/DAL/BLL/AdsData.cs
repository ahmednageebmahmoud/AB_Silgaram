using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Bll
{
    public class AdsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;
        DeleteService DeleteS = new DeleteService();
        UpdateService UpdateS = new UpdateService();
        CreateService CreateS = new CreateService();

        //Get Ads 
        public object GetCurrentAds(int skip, int take)
        {
            var Ads = db.Ads.Where(c => c.IsApprove).ToList();

            if (AdService.AdsAutoPost(Ads, db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value))
                db.SaveChanges();

            Ads = Ads.Where(c => c.IsStarted)
               .OrderByDescending(c => c.StartDateTime)
                 .Skip(skip).Take(take)
               .ToList();

            Ads = Ads.Where(c => !c.IsFinshed).ToList();
            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleAdsDetailes(Ads)
            };
        }

        //Get Ads By Category
        public object GetCurrentAdsByCategoryId(int categoryId, int skip, int take)
        {
            var Ads = db.Ads.Where(c => c.FkCategory_Id == categoryId && c.IsApprove).ToList();

            if (AdService.AdsAutoPost(Ads, db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value))
                db.SaveChanges();

            Ads = Ads.Where(c => c.IsStarted)

                .OrderByDescending(c => c.StartDateTime)
                .Skip(skip).Take(take)
                .ToList();
            Ads = Ads.Where(c => !c.IsFinshed).ToList();

            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleAdsDetailes(Ads)

            };
        }

        //Get Ads By Sub Category
        public object GetCurrentAdsBySubCategoryId(int subCategoryId, int skip, int take)
        {
            var Ads = db.Ads
                .Where(c => c.FkSubCategory_Id == subCategoryId && c.IsApprove).ToList();

            if (AdService.AdsAutoPost(Ads, db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value))
                db.SaveChanges();

            Ads = Ads.Where(c => c.IsStarted)

                .OrderByDescending(c => c.StartDateTime)
                .Skip(skip).Take(take)
                .ToList();

            Ads = Ads.Where(c => !c.IsFinshed).ToList();
            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleAdsDetailes(Ads)
            };
        }

        public object GetUserAds(int skip, int take)
        {
            User User = db.Users.Find(AccessToken.GetUserId());
            if (User == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.UserNotFound);


            var Ads = User.Ads.ToList();
            if (AdService.AdsAutoPost(Ads, db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value))
                db.SaveChanges();

            Ads = Ads.Where(c => c.IsStarted)

                .OrderByDescending(c => c.StartDateTime)
                .Skip(skip).Take(take)
                .ToList();

            Ads = Ads.Where(c => !c.IsFinshed).ToList();
            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleAdsDetailes(Ads)
            };
        }

        public object GetAdsTop(int skip, int take)
        {
            var Ads = db.Ads
              .Where(c => c.IsTop == true && c.IsApprove).ToList();
            if (AdService.AdsAutoPost(Ads, db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value))
                db.SaveChanges();

            Ads = Ads.Where(c => c.IsStarted)

                .OrderByDescending(c => c.StartDateTime)
                .Skip(skip).Take(take)
                .ToList();

            Ads = Ads.Where(c => !c.IsFinshed).ToList();
            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleAdsDetailes(Ads)
            };
        }

        /// <summary>
        /// عمل بحث بالاسم
        /// </summary>
        /// <param name="name"></param>
        /// <param name="skip"></param>
        /// <param name="take"></param>
        /// <returns></returns>
        public object GetAdsByName(string name, int skip, int take)
        {

            var Ads = db.Ads
                .Where(c => c.Title.ToLower().Contains(name.ToLower()))
                .Where(c => c.IsApprove).ToList();
            Ads = Ads.Where(c => c.IsStarted)

                .OrderByDescending(c => c.Title)
                .Skip(skip).Take(take)
                .ToList();

            Ads = Ads.Where(c => !c.IsFinshed).ToList();
            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleAdsDetailes(Ads)
            };
        }

        public object CheckUserAllowAccessToChatRoom(int chatId)
        {
            int UserId = AccessToken.GetUserId();
            var Chat = db.Chattings.Find(chatId);
            if (Chat == null)
                return false;
            if (UserId != Chat.FkUser_Id && UserId != Chat.Ad.FkUser_Id)
                return false;
            return true;
        }

        public object Report(ReportVM re)
        {
            try
            {
                PagesAllow PagesAllow = PageService.GetPageAllow(PageEnumVM.Reports);
                CreateS.db = db;
                object ObjectReturn = CreateS.ReportAd(re, PagesAllow);
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.SuccessReported };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, DevMessage = ex.Message, InnerException = ex.InnerException };
            }
        }

        //Get Ad By Id
        public object GetAdById(int adId)
        {
            var Ad = db.Ads.Find(adId);

            if (Ad == null)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.AdNotFound };

            if (AdService.AdAutoPost(Ad, db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value))
                db.SaveChanges();

            return new ResponseVM { RequestType = RequestTypeEnumVM.Success, IsData = true,
                Data = GetAdData(Ad) };

        }

        //Get Current User Ads Favorite
        public object GetCurrentUserAdsFavorite(int skip, int take)
        {
            int UserId = AccessToken.GetUserId();
            var Ads = db.AdFavorites.Where(c => c.FkUser_Id == UserId).OrderByDescending(c => c.Id).Skip(skip).Take(take).Select(c => c.Ad).ToList();
            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };


            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleAdsDetailes(Ads)
            };

        }

        /// <summary>
        /// للتوفير فى كتابة الدوال وهى ترجع التفاصيل الابتدائة للاعلان 
        /// </summary>
        /// <param name="ads"></param>
        /// <returns></returns>
        public object GetSimpleAdsDetailes(IEnumerable<Ad> ads)
        {
            return ads.Select(c => new
            {
                c.Id,
                c.Title,
                c.Description,
                c.Price,
                c.Category.CategoryName,
                SubCategoryName = c.FkSubCategory_Id.HasValue ? c.SubCategory.SubCategoryName : "",
                c.IsFavorite,
                ViewerCount = c.AdsViewers.Count,
                FavoritesCount=   c.AdFavorites.Count,
                StartDateTime = DateService.GetDateTimeByCulture(c.StartDateTime),
                EndDateTime = DateService.GetDateTimeByCulture(c.EndDateTime),
                c.CanUpdate,
                c.CreateBy,
                c.BaseImage,
                c.Images,
                   c.IsAllowMessaging,
                c.IsAutoPost,
                c.IsPostWithOutPhoneNumber,
                c.PhoneNumber,
                c.ShearLink
            }).ToList();
        }
        public object GetAdData(Ad ad)
        {
            return
                new
                {
                    ad.Id,
                    ad.Title,
                    ad.Description,
                    ad.Price,
                    ad.Category.CategoryName,
                    SubCategoryName = ad.FkSubCategory_Id.HasValue ? ad.SubCategory.SubCategoryName : "",
                    ad.MapLocation,
                    ad.Location.Latitude,
                    ad.Location.Longitude,
                    ad.IsFavorite,
                    ViewerCount = ad.AdsViewers.Count,
                   ad.Images,
                   ad.BaseImage,
                    StartDateTime = DateService.GetDateTimeByCulture(ad.StartDateTime),
                    EndDateTime = DateService.GetDateTimeByCulture(ad.EndDateTime),
                    ad.CreateBy,
                    ad.CanUpdate,
                    ad.IsAllowMessaging,
                    ad.IsAutoPost,
                    ad.IsPostWithOutPhoneNumber,
                    ad.PhoneNumber
                };
        } 
        //Save Change
        public object SaveChanage(AdVM ad)
        {
            try
            {
                PagesAllow PagesAllow = PageService.GetPageAllow(PageEnumVM.Ads);

                //Check State 
                if (ad.State == StateEnumVM.Delete)
                {
                    DeleteS.db = db;
                    object ObjectReturn = DeleteS.Ad(ad, PagesAllow);
                    if (ObjectReturn != null)
                        return ObjectReturn;

                    db.SaveChanges();
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Deleted };
                }
                else if (ad.State == StateEnumVM.Update)
                {
                    UpdateS.db = db;
                    object ObjectReturn = UpdateS.Ad(ad, PagesAllow);
                    if (ObjectReturn != null)
                        return ObjectReturn;

                    db.SaveChanges();
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Updated };
                }
                else if (ad.State == StateEnumVM.Create)
                {
                    CreateS.db = db;
                    object ObjectReturn = CreateS.Ad(ad, PagesAllow);
                    if (ObjectReturn != null)
                        return ObjectReturn;

                    db.SaveChanges();
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Created };
                }

                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.StateNotFound };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, DevMessage = ex.Message, InnerException = ex.InnerException };
            }
        }
        public void Dispose()
        {
            db.Dispose();
        }
   
    }//End Class
}
