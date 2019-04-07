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
    public class OffersData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;
        DeleteService DeleteS = new DeleteService();
        UpdateService UpdateS = new UpdateService();
        CreateService CreateS = new CreateService();

        //Get Offers 
        public object GetCurrentOffers(int skip, int take)
        {
            var Offers = db.Offers.ToList();
            Offers= Offers.Where(c => c.IsStarted)

               .OrderByDescending(c => c.StartDateTime)
                 .Skip(skip).Take(take)
               .ToList();
            Offers = Offers.Where(c => !c.IsFinshed).ToList();
            if (Offers.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleOffersDetailes(Offers)
            };
        }

        //Get Offers By Category
        public object GetCurrentOffersByCategoryId(int categoryId, int skip, int take)
        {
            var Offers = db.Offers.Where(c => c.FkCategory_Id == categoryId).ToList();
            Offers= Offers.Where(c => c.IsStarted)
                .OrderByDescending(c => c.StartDateTime)
                .Skip(skip).Take(take)
                .ToList();
            Offers = Offers.Where(c => !c.IsFinshed).ToList();

            if (Offers.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleOffersDetailes(Offers)

            };
        }

        //Get Offers By Sub Category
        public object GetCurrentOffersBySubCategoryId(int subCategoryId, int skip, int take)
        {
            var Offers = db.Offers
                .Where(c => c.FkSubCategory_Id == subCategoryId ).ToList();
            Offers= Offers.Where(c => c.IsStarted)

                .OrderByDescending(c => c.StartDateTime)
                .Skip(skip).Take(take)
                .ToList();

            Offers = Offers.Where(c => !c.IsFinshed).ToList();
            if (Offers.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleOffersDetailes(Offers)
            };
        }

        public object GetOffersTop(int skip, int take)
        {
            var Offers = db.Offers
              .Where(c => c.IsTop == true ).ToList();
            Offers = Offers.Where(c => c.IsStarted)

                .OrderByDescending(c => c.StartDateTime)
                .Skip(skip).Take(take)
                .ToList();

            Offers = Offers.Where(c => !c.IsFinshed).ToList();
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
        /// عمل بحث بالاسم
        /// </summary>
        /// <param name="name"></param>
        /// <param name="skip"></param>
        /// <param name="take"></param>
        /// <returns></returns>
        public object GetOffersByName(string name, int skip, int take)
        {

            var Offers = db.Offers
                .Where(c => c.Title.ToLower().Contains(name.ToLower()))
                .ToList();
            Offers = Offers.Where(c => c.IsStarted)

                .OrderByDescending(c => c.Title)
                .Skip(skip).Take(take)
                .ToList();

            Offers = Offers.Where(c => !c.IsFinshed).ToList();
            if (Offers.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = GetSimpleOffersDetailes(Offers)
            };
        }

        //Get Offer By Id
        public object GetOfferById(int offerId)
        {
            var Offer = db.Offers.Find(offerId);
            if (Offer == null)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.OfferNotFound };

            return new ResponseVM { RequestType = RequestTypeEnumVM.Success, IsData = true,
                Data = new {
                    Offer.Id,
                    Offer.Title,
                    Offer.Description,
                    Offer.DiscountRate,
                    Offer.SmallDiscription,
                    Offer.Price,
                    Offer.PurePrice,
                    Offer.Category.CategoryName,
                    Offer.SubCategory.SubCategoryName,
                    Offer.IsFavorite,
                    ViewerCount = Offer.OffersViewers.Count,
                    Images = Offer.Album.AlbumFiles.Select(v => v.File.FullFileUrl).ToList(),
                    StartDateTime = DateService.GetDateTimeByCulture(Offer.StartDateTime),
                    EndDateTime = DateService.GetDateTimeByCulture(Offer.EndDateTime),

                Offer.Timer,

                } };

        }

        //Get Current User Offers Favorite
        public object GetCurrentUserOffersFavorite(int skip,int take)
        {
            int UserId = AccessToken.GetUserId();
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
        /// <param name="offers"></param>
        /// <returns></returns>
        public object GetSimpleOffersDetailes(IEnumerable<Offer> offers)
        {
            return offers.Select(c => new
            {

                c.Id,
                c.Title,
                c.Description,
                c.DiscountRate,
                c.SmallDiscription,
                c.Price,
                c.PurePrice,
                c.Category.CategoryName,
                c.SubCategory.SubCategoryName,
                c.IsFavorite,
                ViewerCount = c.OffersViewers.Count,
                StartDateTime = DateService.GetDateTimeByCulture(c.StartDateTime),
                EndDateTime = DateService.GetDateTimeByCulture(c.EndDateTime),
                c.Timer,
               c.BaseImage,
               c.Images,
            }).ToList();
    }


        public void Dispose()
        {
            db.Dispose();
        }

   
    }//End Class
}
