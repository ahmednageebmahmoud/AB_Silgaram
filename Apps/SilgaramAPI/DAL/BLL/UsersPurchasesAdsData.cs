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
    public class UsersPurchasesAdsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;
        DeleteService DeleteS = new DeleteService();
        UpdateService UpdateS = new UpdateService();
        CreateService CreateS = new CreateService();

    
        public object GetUserPurchases(int skip, int take)
        {
            var UsersPurchases = db.Users.Find(AccessToken.GetUserId()).UsersPurchasesAds
                  .OrderByDescending(c => c.Id)
                  .Skip(skip).Take(take)
                  .ToList();

            if (UsersPurchases.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleUsersPurchasesDetailes(UsersPurchases)

            };
        }


        public object BuyAd(int adId)
        {
            try
            {
                PagesAllow PagesAllow = PageService.GetPageAllow(PageEnumVM.Ads);
                List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();

                History NewHistory = new History();
                CreateS.db = db;
                UsersPurchasesAd UserPurchas = new UsersPurchasesAd() { FkAd_Id = adId };

                object ObjectReturn = CreateS.BuyAd(UserPurchas, PagesAllow, NewHistory);
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();

           
                db = new SilgaramEntities();
                var UserOwnarAd= db.Ads.Find(adId).User;
                bool UserIsEn = UserService.UserIsEn(UserOwnarAd);
                
                //Send Notify Now To Fire Base
                if(!string.IsNullOrEmpty(UserOwnarAd.FireBaseToken))
                {
                NewHistory = db.Histories.Find(NewHistory.Id);

                //ارسال اشعار الى المستخدم الحالى بانة يوجد مستخدم عمل لة متابعة
                var ObjNotifiy =
                          NotifyVM.NotifyNode(
                              usersFollowingYouId: AccessToken.GetUserId(),
                              nameAction: UserIsEn ? NewHistory.NameActionEn : NewHistory.NameActionAr,
                              body: UserIsEn ? NewHistory.TitleEn : NewHistory.TitleAr
                              );
                
                FireBaseService.SendSpecificNotification(UserOwnarAd.FireBaseToken, ObjNotifiy );
                }

                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.BuyingSucceeded };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, DevMessage = ex.Message, InnerException = ex.InnerException };
            }
        }


        /// <summary>
        /// للتوفير فى كتابة الدوال وهى ترجع التفاصيل الابتدائة للاعلان 
        /// </summary>
        /// <param name="ads"></param>
        /// <returns></returns>
        public object GetSimpleUsersPurchasesDetailes(List<UsersPurchasesAd> usersPurchas)
        {
            return usersPurchas.Select(c => new
            {
                c.Id,

                Ad = new
                {
                    c.Ad.Title,
                    c.Ad.Description,
                    c.Ad.Price,
                    c.Ad.IsFavorite,
                    Image = c.Ad.Album.AlbumFiles.First().File.FullFileUrl,
                },
                c.AdPrice,
                DateTime = DateService.GetDateTimeByCulture(c.BayDateTime)

            }).ToList();
        }

 
        public void Dispose()
        {
            db.Dispose();
        }

   
    }//End Class
}
