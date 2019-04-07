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
    public class OffersFovoriteData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;
        int UserId = AccessToken.GetUserId();


        public object FovoriteToggle(int offerId)
        {
            try
            {

        
            if(db.OfferFavorites.Any(c => c.FKOffer_Id == offerId && c.FkUser_Id == UserId))
            {
                //Remove 
                db.OfferFavorites.Remove( db.OfferFavorites.Where(c => c.FKOffer_Id == offerId && c.FkUser_Id == UserId).Single());
                db.SaveChanges();
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.OfferUnFovorite };
            }
            else
            {
                //create

                db.OfferFavorites.Add(new OfferFavorite() {
                    FKOffer_Id=offerId,
                    FkUser_Id=UserId,
                    DateTime=DateTime.Now
                } );

                db.SaveChanges();
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.OfferFovoriteed };
                }
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer ,DevMessage=ex.Message,InnerException=ex.InnerException };

            }
        }

        //Get Current User Offers Favorite
        public object GetFovorites(int skip,int take)
        {
            var Offers = db.OfferFavorites.Where(c => c.FkUser_Id == UserId).OrderByDescending(c => c.Id).Skip(skip).Take(take).Select(c=> c.Offer).ToList();
            if (Offers.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };


            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleOffersDetailes(Offers)
            };

        }


        /// <summary>
        /// للتوفير فى كتابة الدوال وهى ترجع التفاصيل الابتدائة للاعلان 
        /// </summary>
        /// <param name="ads"></param>
        /// <returns></returns>
        public object GetSimpleOffersDetailes(IEnumerable<Offer> ads)
        {
            return ads.Select(c => new
            {
                c.Id,
                c.Title,
                c.Description,
                c.Price,
                c.Category.CategoryName,
                c.SubCategory.SubCategoryName,
                c.IsFavorite,
                ViewerCount = c.OffersViewers.Count,
                Image = c.Album.AlbumFiles.First().File.FullFileUrl,
                StartDateTime = DateService.GetDateTimeByCulture(c.StartDateTime),
                EndDateTime = DateService.GetDateTimeByCulture(c.EndDateTime),
            }).ToList();
    }








        public void Dispose()
        {
            db.Dispose();
        }

   
    }//End Class
}
