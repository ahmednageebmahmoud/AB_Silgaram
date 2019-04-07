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
    public class OffersViewreData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;


        public object CreateView(int offerId)
        {
            try
            {
                var Offer = db.Offers.Find(offerId);
                if (Offer == null)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.OfferNotFound);
                int UserId = AccessToken.GetUserId();


                if (UserId > 0)
                    if (Offer.OffersViewers.Any(c => c.FKOffer_Id == offerId && c.FkUser_Id == UserId))
                    {
                        //update count view
                        var OfferView = Offer.OffersViewers.Where(c => c.FKOffer_Id == offerId && c.FkUser_Id == UserId).Single();
                        OfferView.CountViewer = OfferView.CountViewer + 1;
                        OfferView.DateTime = DateTime.Now;
                    }
                    else
                    {
                        //create

                        Offer.OffersViewers.Add(new OffersViewer()
                        {
                            FKOffer_Id = offerId,
                            FkUser_Id = UserId,
                            CountViewer = 1,
                            DateTime = DateTime.Now

                        });

                    }
                else
                    Offer.OffersViewers.Add(new OffersViewer()
                    {
                        FKOffer_Id = offerId,
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
