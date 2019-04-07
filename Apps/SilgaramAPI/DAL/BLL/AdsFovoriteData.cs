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

    public class AdsFovoriteData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        AdsData AdData = new AdsData();
        bool IsLanguageEnglish = LanguageService.IsEn;
        int UserId = AccessToken.GetUserId();


        public object FovoriteToggle(int adId)
        {
            try
            {

        
            if(db.AdFavorites.Any(c => c.FKAd_Id == adId && c.FkUser_Id == UserId))
            {
                //Remove 
                db.AdFavorites.Remove( db.AdFavorites.Where(c => c.FKAd_Id == adId && c.FkUser_Id == UserId).Single());
                db.SaveChanges();
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.AdUnFovorite ,Data=false};
            }
            else
            {
                //create
                db.AdFavorites.Add(new AdFavorite() {
                    FKAd_Id=adId,
                    FkUser_Id=UserId,
                    DateTime=DateTime.Now
                } );

                db.SaveChanges();
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.AdFovorite,Data=true };
                }
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer ,DevMessage=ex.Message,InnerException=ex.InnerException };
            }
        }

        //Get Current User Ads Favorite
        public object GetFovorites(int skip,int take)
        {
            var Ads = db.AdFavorites.Where(c => c.FkUser_Id == UserId).OrderByDescending(c => c.Id).Skip(skip).Take(take).Select(c=> c.Ad).ToList();
            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = AdData.GetSimpleAdsDetailes(Ads)
            };

        }
        public void Dispose()
        {
            db.Dispose();
            AdData.Dispose();
        }

   
    }//End Class
}
