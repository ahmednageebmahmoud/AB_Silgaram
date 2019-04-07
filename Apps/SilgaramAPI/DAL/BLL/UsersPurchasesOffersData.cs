using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using KnPayPayment.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Bll
{
    public class UsersPurchasesOffersData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;
        DeleteService DeleteS = new DeleteService();
        UpdateService UpdateS = new UpdateService();
        CreateService CreateS = new CreateService();


        public object GetUserPurchases(int skip, int take)
        {
            var UsersPurchases = db.Users.Find(AccessToken.GetUserId()).UsersPurchasesOffers
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


        public object BuyOffer(int offerId, bool isCredit)
        {
            try
            {
                PagesAllow PagesAllow = PageService.GetPageAllow(PageEnumVM.Offers);
                List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();
                var Usere = db.Users.Find(AccessToken.GetUserId());


                var Offer = db.Offers.Find(offerId);
                if (Offer == null)
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.OfferNotFound };

                if (Offer.IsFinshed)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.OfferNotFound);

                PaymentInfromation PayInformation =
              PaymentService.InitializePayment_Email(
              Offer.PurePrice, Usere.UserName, Usere.Email, isCredit);

                if (PayInformation.error)
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = PayInformation.msg };

                CreateS.db = db;
                UsersPurchasesOffer UserPurchas = new UsersPurchasesOffer()
                {
                    FkOffer_Id = offerId,
                    Payment = new Payment()
                    {
                        Hash = PayInformation.Hash
                    }
                };

                object ObjectReturn = CreateS.BuyOffer(UserPurchas, Offer);
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();


                if (PagesAllow.IsAllowLog || PagesAllow.IsAllowNotify)
                {
                    HistoryDetails.Add(new HistoryDetailVM("Title", UserPurchas.Offer.Title, true, false));
                    HistoryDetails.Add(new HistoryDetailVM("Description", UserPurchas.Offer.Description, true, false));
                    HistoryDetails.Add(new HistoryDetailVM("Price", UserPurchas.Offer.Price.ToString(), true, false));

                    //Creae Notify
                    CreateS.CreateHistory(HistoryDetails, UserPurchas.Offer.Title, UserPurchas.Offer.Title, PageEnumVM.Offers, StateEnumVM.Buy);
                    db.SaveChanges();
                }


            
                return new ResponseVM(RequestTypeEnumVM.Success,  Token.BuyingSucceeded, PayInformation);
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
        public object GetSimpleUsersPurchasesDetailes(List<UsersPurchasesOffer> usersPurchas)
        {
            return usersPurchas.Select(c => new
            {
                c.Id,

                Offer = new
                {
                    c.Offer.Title,
                    c.Offer.Description,
                    c.Offer.Price,
                    c.Offer.IsFavorite,
                    Image = c.Offer.Album.AlbumFiles.First().File.FullFileUrl,
                },
                c.OfferPrice,
                DateTime = DateService.GetDateTimeByCulture(c.BayDateTime)

            }).ToList();
        }


        public void Dispose()
        {
            db.Dispose();
        }


    }//End Class
}
