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
    public class OffersData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Offers
        public object GetOffers(int skip, int take)
        {
            var Offers = db.Offers.OrderByDescending(c => c.Id).Skip(skip).Take(take).ToList();
            if (Offers.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return Offers.Select(x => new
            {
                x.Id,
                x.Description,
                x.SmallDiscription,
                Category=      x.Category.CategoryName,
                SubCategory =      x.SubCategory.SubCategoryName,
                x.DiscountRate,
                x.Title,
                x.Price,
                x.IsTop,
                x.CreateBy,
                x.OfferFavorites.Count,
                ViewerCount = x.OffersViewers.Count,
                Images = x.Album.AlbumFiles.Select(c => c.File.FullFileUrl).ToList(),
                x.CreateDateTime,
                EndDateTime = DateService.GetDateTimeByCulture(x.EndDateTime),
                StartDateTime = DateService.GetDateTimeByCulture(x.StartDateTime),
            }).ToList();
        }

        public object GetOfferByIdForUpdat(int adId)
        {
            var Offer = db.Offers.Find(adId);
            if (Offer == null)
                return null;
            return new
            {
                Offer.Id,
                Offer.Description,
                Offer.Title,
                Offer.Price,
                Offer.IsTop,
                Offer.CreateBy,
                Images = Offer.Album.AlbumFiles.Select(c => new FileVM {AlbumFileId=c.Id, FileUrl = c.File.FullFileUrl,State=0 }).ToList(),
                Offer.EndDateTime,
                Offer.StartDateTime,
                Offer.FkCategory_Id,
                Offer.FkSubCategory_Id,
                Offer.SmallDiscription,
                Offer.DiscountRate,

            };
        }

        //Save Chenage
        public object SaveChanage(Offer[] offers)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Offers);
            List<string> RemoveFiles = new List<string>();

            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;

            UpdateS.RemoveFiles = RemoveFiles;
            DeleteS.RemoveFiles = RemoveFiles;

            try
            {
                foreach (Offer offer in offers)
                {
                    if (offer.State == StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.Offer(offer, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else
                    if (offer.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.Offer(offer, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                      
                        //In Case Update .. Updateing One Offer from page /Offers/CreateAndUpdate 
                        db.SaveChanges();
                        FileService.RemoveFiles(RemoveFiles);

                        return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Updated, OfferId = offer.Id };
                    }
                    else if (offer.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.Offer(offer, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;

                        //In Case Create .. Creating One Offer from page /Offers/CreateAndUpdate 
                        db.SaveChanges();

                        if (offer.Files != null)
                        {
                            foreach (var item in offer.Files)
                            {
                                FileSaveVM FileSave = FileService.SaveFile(new FileSaveVM()
                                {
                                    Extensions = DefaultsVM.ExtensionsImage,
                                    File = item.File,
                                    ServerPathSave = "/Files/Images/Offers"
                                });

                                if (!FileSave.IsSaved)
                                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotSaveFile + " >> " + item.File.FileName };

                               offer.Album.AlbumFiles.Add(new AlbumFile()
                                {
                                    File = new File()
                                    {
                                        FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                                        FkFileType_Id = FileTypeEnumVM.Image,
                                        FileUrl = FileSave.SavedPath
                                    }
                                });

                            }
                        }
                        db.SaveChanges();
                        return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Created , OfferId= offer.Id};
                    }
                }
                db.SaveChanges();
                        FileService.RemoveFiles(RemoveFiles);
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved };
              }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange };
            }
        }

        //Get User Information 
        public object GetUserInformation(User user)
        {
            return new
            {
                user.Email,
                user.UserName,
                ImageUrl = user.UserInformation.File.FullFileUrl,
            };
        }
       
        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
