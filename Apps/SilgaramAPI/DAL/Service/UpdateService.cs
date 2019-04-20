using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using DAL.Bll;
using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.ViewModel.Models;

namespace DAL.Service
{
    public class UpdateService
    {
        public SilgaramEntities db;// = new ControlePanel();
        CheckedService CheckedS = new CheckedService();
        public int UserId { get { return new UserService().GetCurrentUserId(); } }
        List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();



        internal object Ad(AdVM ad, PagesAllow pageAllow)
        {
            int UserId = AccessToken.GetUserId();
            var AdUpdate = db.Ads.Find(ad.Id);
            if (AdUpdate == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.AdNotFound);

            //نتحقق ان المستخدم الذى انشائ الاعلان هوا ذاتة الذى يريد التعديل
            if (UserId != AdUpdate.FkUser_Id)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.YouNotCreatedThisAd };

            //Check Property is Null
            if (string.IsNullOrEmpty(ad.Title))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Title + "  >> " + Token.FiledIsRequired };

            if (string.IsNullOrEmpty(ad.Description))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Description + "  >> " + Token.FiledIsRequired };

            if (ad.Price <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Price + "  >> " + Token.FiledIsRequired };

            if (ad.FkCategory_Id <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Category + "  >> " + Token.FiledIsRequired };

            if (ad.FkSubCategory_Id <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.SubCategory + "  >> " + Token.FiledIsRequired };


            //Check Length
            if (ad.Title.Length > 50)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Title + "  >> " + Token.MaxLength + " 50" };

            if (ad.Description.Length > 1000)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Description + "  >> " + Token.MaxLength + " 500" };

            if (string.IsNullOrEmpty(ad.Latitude))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Latitude + "  >> " + Token.FiledIsRequired };
            if (string.IsNullOrEmpty(ad.Longitude))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Longitude + "  >> " + Token.FiledIsRequired };






            //Remove Images
            var ImageRomve = ad.Images.Where(c => c.State == StateEnumVM.Delete).ToList();
            foreach (var img in ImageRomve)
            {
                var FileDelete = AdUpdate.Album.AlbumFiles.Where(c => c.Id == img.FileId).SingleOrDefault();
                if (FileDelete != null)
                {
                    ad.RemoveImagesFormServer.Add(FileDelete.File.FileUrl);
                    FileService.RemoveFile(FileDelete.File.FileUrl);
                    db.Files.Remove(FileDelete.File);
                }

            }

            //Add New Images 
            var ImagesNedaed = AdUpdate.Album.AlbumFiles.Count - ImageRomve.Count;
            if (ImagesNedaed < 8)
            {
                //Now Save New Images 
                var NewImages = ad.Images.Where(c => !string.IsNullOrEmpty(c.FileBase64)).ToList();

                List<AlbumFile> AlbumFiles = new List<AlbumFile>();

                foreach (var img in NewImages)
                {
                    FileSaveVM ImgeSave = FileService.SaveFile(new FileSaveVM()
                    {
                        Extensions = DefaultsVM.ExtensionsImage,
                        FileBase64 = img.FileBase64,
                        ServerPathSave = "/Files/Images/Ads/"
                    });

                    //Check Is not Save
                    if (!ImgeSave.IsSave)
                    {
                        //remove old image savein server
                        FileService.RemoveFiles(AlbumFiles);
                        return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotSaveFile + "  >> " + img.FileName };
                    }

                    //Ad File
                    AlbumFiles.Add(new AlbumFile()
                    {
                        File = new File()
                        {
                            FkFileType_Id = FileTypeEnumVM.Image,
                            FKAppInformation_Id = AppInformationEnumVM.ApiLink,
                            FileUrl = ImgeSave.SavedPath,
                        }
                    });
                }

                foreach (var albumImage in AlbumFiles)
                {
                    AdUpdate.Album.AlbumFiles.Add(albumImage);
                }
            }


            //Ad Log
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("Title", ad.Title, AdUpdate.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", ad.Description, AdUpdate.Description, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Price", ad.Price.ToString(), AdUpdate.Price.ToString(), true, false));
                AdUpdate.Log.Histories.Add(new History()
                {
                    TitleAr = ad.Title,
                    TitleEn = ad.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Ads,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }



            //Update Ad
            AdUpdate.Title = ad.Title;
            AdUpdate.Description = ad.Description;
            AdUpdate.Price = ad.Price;
            AdUpdate.FkCategory_Id = ad.FkCategory_Id;
            AdUpdate.FkSubCategory_Id = ad.FkSubCategory_Id;
            AdUpdate.FkUser_Id = UserId;
            AdUpdate.PhoneNumber = ad.PhoneNumber;
            AdUpdate.IsAllowMessaging = ad.IsAllowMessaging;
            AdUpdate.IsPostWithOutPhoneNumber = ad.IsPostWithOutPhoneNumber;
            AdUpdate.IsAutoPost = ad.IsAutoPost;
            return null;
        }

        internal object ChangeLanguage(string lang)
        {
            var UserDataUpdate = db.Users.Find(AccessToken.GetUserId());
            if (string.IsNullOrEmpty(lang))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Languages + " >> " + Token.FiledIsRequired };
            if (UserDataUpdate.UserInformation.Language == null)
            {

                UserDataUpdate.UserInformation.Language = new Language()
                {
                    LanguageUsings = new List<LanguageUsing>
                        {
                            new LanguageUsing
                            {
                                LanguageType=db.LanguageTypes.Where(c=> c.Code==lang).Single(),
                                IsDefault=true

                            }
                        }
                };
            }
            else
            {
                var LanguUpdate = UserDataUpdate.UserInformation.Language.LanguageUsings.Where(c => c.LanguageType.Code == lang).SingleOrDefault();
                if (LanguUpdate == null)
                {
                    UserDataUpdate.UserInformation.Language = new Language
                    {
                        LanguageUsings = new List<LanguageUsing>
                        {
                            new LanguageUsing
                            {
                                LanguageType=db.LanguageTypes.Where(c=> c.Code==lang).Single(),
                                IsDefault=true
                            }
                        }
                    };
                }
                else
                {

                    LanguUpdate.IsDefault = true;
                }
            }
            return null;
        }

        internal object UpdateUserData(UserDataVM userDataVM)
        {

            var UserDataUpdate = db.Users.Find(AccessToken.GetUserId());

            if (!string.IsNullOrEmpty(userDataVM.Email))
                if (!UserDataUpdate.Email.Equals(userDataVM.Email))
                {
                    if (!CheckedS.EmailIsCorrect(userDataVM.Email))
                        return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + " >> " + Token.InvalidEmail };

                    if (db.Users.Any(c => c.Email == userDataVM.Email && c.Id != UserDataUpdate.Id))
                        return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + " >> " + Token.ErrorDuplicate };
                    UserDataUpdate.Email = userDataVM.Email;
                }


            //Check Is Update Phone 
            if (!string.IsNullOrEmpty(userDataVM.Phone))
            {

                if (db.UserInformations.Any(c => c.PhoneNumber == userDataVM.Phone && c.User.Id != UserDataUpdate.Id))
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Phone + " >> " + Token.BeforeUsed };

                UserDataUpdate.UserInformation.PhoneNumber = userDataVM.Phone;
            }
            //Check Is Update Password 
            if (!string.IsNullOrEmpty(userDataVM.Password))
            {
                if (!UserDataUpdate.Password.Equals(userDataVM.OldPassword))
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.OldPasswordInvalid);
                UserDataUpdate.Password = userDataVM.Password;
            }

            //Check Is Update Full Name 
            if (!string.IsNullOrEmpty(userDataVM.FullName))
            {

                UserDataUpdate.UserInformation.FullName = userDataVM.FullName;
            }

            //Check Is Update Birth Date 
            if (userDataVM.BirthDate != null)
            {
                UserDataUpdate.UserInformation.BirthDate = userDataVM.BirthDate;
            }

            //Check Is Update Profile Image 
            if (!string.IsNullOrEmpty(userDataVM.FileBase64))
            {
                //Uplaod Image 
                FileSaveVM FileSave = FileService.SaveFile(new FileSaveVM()
                {
                    FileBase64 = userDataVM.FileBase64,
                    ServerPathSave = "/Files/Images/Users/Profile/"
                });


                if (!FileSave.IsSave)
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotSaveFile };

                if (UserDataUpdate.UserInformation.File == null)
                    UserDataUpdate.UserInformation.File = new File();

                UserDataUpdate.UserInformation.File.FileUrl = FileSave.SavedPath;
                UserDataUpdate.UserInformation.File.FKAppInformation_Id = AppInformationEnumVM.ApiLink;
            }

            return null;
        }


    }//End Class
}
