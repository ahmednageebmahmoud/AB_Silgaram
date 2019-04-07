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
    public class AdsEvaluationData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        CreateService CreateS = new CreateService();
        bool IsLanguageEnglish = LanguageService.IsEn;
        int UserId = AccessToken.GetUserId();

        /*
        public object AdEvaluation(int adId, decimal rate)
        {
            try
            {
                var Ad = db.Ads.Find(adId);

                CreateS.db = db;
                object ObjectReturn = CreateS.CreateAdEvaluation(Ad, rate);
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();

                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Success,Data= new {
                    Ad.AdsEvaluationResult.Start1,
                    Ad.AdsEvaluationResult.Start1_5,

                    Ad.AdsEvaluationResult.Start2,
                    Ad.AdsEvaluationResult.Start2_5,


                    Ad.AdsEvaluationResult.Start3,
                    Ad.AdsEvaluationResult.Start3_5,

                    Ad.AdsEvaluationResult.Start4,
                    Ad.AdsEvaluationResult.Start4_5,

                    Ad.AdsEvaluationResult.Start5,
                }
                };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, DevMessage = ex.Message, InnerException = ex.InnerException };
            }
        }*/






        public void Dispose()
        {
            db.Dispose();
        }

   
    }//End Class
}
