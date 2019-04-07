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
    public class AdsViewreData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;


        public object CreateView(int adId)
        {
            try
            {
                var Ad = db.Ads.Find(adId);
                int UserId = AccessToken.GetUserId();

                if (Ad == null)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.AdNotFound);


                if (UserId > 0)
                    if (Ad.AdsViewers.Any(c => c.FKAd_Id == adId && c.FkUser_Id == UserId))
                    {
                        //update count view
                        var AdView = Ad.AdsViewers.Where(c => c.FKAd_Id == adId && c.FkUser_Id == UserId).Single();
                        AdView.CountViewer = AdView.CountViewer + 1;
                        AdView.DateTime = DateTime.Now;
                    }
                    else
                    {
                        //create
                        Ad.AdsViewers.Add(new AdsViewer()
                        {
                            FKAd_Id = adId,
                            FkUser_Id = UserId,
                            CountViewer = 1,
                         DateTime=   DateTime.Now
                        });

                    }
                else
                    Ad.AdsViewers.Add(new AdsViewer()
                    {
                        FKAd_Id = adId,
                        CountViewer = 1,
                        DateTime = DateTime.Now

                    });
                db.SaveChanges();
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Success };
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
