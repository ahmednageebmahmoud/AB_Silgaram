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
    public class AdsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Ads
        public object GetAds(int skip, int take)
        {
            var Ads = db.Ads.OrderByDescending(c => c.Id).Skip(skip).Take(take).ToList();
            if (Ads.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            if (AdService.AdsAutoPost(Ads,db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value))
                db.SaveChanges();
            return Ads.Select(x => new
            {
                x.Id,
                x.Description,
                x.Title,
                x.Price,
                x.IsTop,
                x.IsAllowMessaging,
                x.IsAutoPost,
                x.IsPostWithOutPhoneNumber,
                x.IsApprove,
                x.Category.CategoryName,
                x.SubCategory.SubCategoryName,
                x.CreateBy,
                x.IsStarted,
                x.FavoritesCount,
                x.ViewersCount,
                x.ReportsCount,
                Images=x.Album.AlbumFiles.Select(c=>  c.File.FullFileUrl).ToList(),
                x.CreateDateTime ,
                EndDateTime = x.EndDateTimeString,
                StartDateTime = x.StartDateTimeString,
                x.PhoneNumber,
                x.CountAutoPostToNow,
                x.Location.Latitude,
                x.Location.Longitude,
            }).ToList();
        }

        public object GetAdByIdForUpdat(int adId)
        {
            var Ad = db.Ads.Find(adId);
            if (Ad == null)
               return null;
            if (AdService.AdAutoPost(Ad, db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value))
                db.SaveChanges();

            return new
            {
                Ad.Id,
                Ad.Description,
                Ad.Title,
                Ad.Price,
                Ad.IsTop,
                Ad.IsApprove,
                Ad.FkCategory_Id,
                Ad.FkSubCategory_Id,
                Ad.IsStarted,
                Ad.IsAllowMessaging,
                Ad.IsAutoPost,
                Ad.IsPostWithOutPhoneNumber,
                Ad.CreateBy,
                Images = Ad.Album.AlbumFiles.Select(c => new FileVM {
                    AlbumFileId=c.Id,
                 FileUrl=   c.File.FullFileUrl
                }
                    ).ToList(),
                Ad.EndDateTime,
                Ad.StartDateTime,
                Ad.Location.Latitude,
                Ad.Location.Longitude,
                Ad.PhoneNumber
            };
        }

        //Save Chenage
        public object SaveChanage(Ad[] auctions)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Ads);
            List<string> RemoveFiles = new List<string>();

            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;

            UpdateS.RemoveFiles = RemoveFiles;
            DeleteS.RemoveFiles = RemoveFiles;

            try
            {
                foreach (Ad ad in auctions)
                {
                    if (ad.State == StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.Ad(ad, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;

                    }
                    else
                    if (ad.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.Ad(ad, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                      
                        //In Case Update .. Updateing One Ad from page /Ads/CreateAndUpdate 
                        db.SaveChanges();

                        FileService.RemoveFiles(RemoveFiles);
                        return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Updated, AdId = ad.Id };
                    }
                    else if (ad.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.Ad(ad, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;

                        //In Case Create .. Creating One Ad from page /Ads/CreateAndUpdate 
                        db.SaveChanges();

                        //Save Image
            if(ad.Files!=null)
                        foreach (var img in ad.Files)
                        {
                            if (img.File != null)
                            {
                                FileSaveVM Filesave = FileService.SaveFile(new FileSaveVM()
                                {
                                    Extensions = DefaultsVM.ExtensionsImage,
                                    File = img.File,
                                    ServerPathSave = "/Files/Images/"
                                });


                                if (!Filesave.IsSaved)
                                    return new ResponseVM(RequestTypeEnumVM.Error, Token.CanNotSaveFile + " " + img.File.FileName);

                                ad.Album.AlbumFiles.Add(new AlbumFile()
                                {
                                    File = new File()
                                    {
                                        FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                                        FkFileType_Id = FileTypeEnumVM.Image,
                                        FileUrl = Filesave.SavedPath
                                    }
                                });
                            }
                        }
                        db.SaveChanges();

                        return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Created , AdId= ad.Id};
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
