using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
using DAL.Service;
using DAL.Models.ViewModel;
using DAL.Resource;
using System.Web;
using DAL.Bll;
using DAL.ViewModel.Models;

namespace DAL.Service
{
    public class CreateService : IDisposable
    {
        public SilgaramEntities db = new SilgaramEntities();
        CheckedService CheckedS = new CheckedService();
        public int UserId { get { return new UserService().GetCurrentUserId(); } }
        List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();

        public void Dispose()
        {
           // db.Dispose();
            CheckedS.Dispose();
        }

        /// <summary>
        /// User Login
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public User UserLogin(User user)
        {
            try
            {
                UserLogin UserLogin = new UserLogin();

                int userId = db.Users.Single(v => v.UserName == user.UserName).Id;
                var User = db.Users.Find(userId);
                if (!User.UserRoles.Any(c => c.FkRole_Id == RoleEnumVM.Manager || c.FkRole_Id == RoleEnumVM.Supervisor))
                    return null;

                UserLogin.LoginDate = DateTime.Now;
                UserLogin.FkUser_Id = userId;

                //Check Login Valid 
                if (CheckedS.UserNameAndPasswordIsValid(user.UserName, user.Password))
                {
                    //Login Success
                    UserLogin.IsSuccess = true;
                    User.IsSuccessLogin = true;
                }
                else
                {
                    //Login not Success
                    //Check Last 10 login user If all NotSuccess Or Not
                    int skipCount = db.UserLogins.Where(x => x.FkUser_Id == userId).Count() - 10;
                    if (skipCount > 0)
                    {
                        var UserLogins = db.UserLogins.Where(x => x.FkUser_Id == userId).ToList();
                        if (!UserLogins.Skip(skipCount).Any(x => x.IsSuccess == true))
                        {
                            User.IsBlocked = true;
                        }
                    }
                    UserLogin.IsSuccess = false;
                    User.IsSuccessLogin = false;
                }

                db.UserLogins.Add(UserLogin);
                db.SaveChanges();
                User.IsBlocked= CheckedS.IsUserBlocked(user.UserName, user.Password);

                return User;
            }
            catch (Exception ex)
            {
                return null;

            }
        }

        internal object ReportType(ReportType reportType, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(reportType.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(reportType.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };

            //Check NameAr Duplicated
            if (db.ReportTypes.Any(c => c.NameAr == reportType.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + reportType.NameAr };

            //Check NameEn Duplicated                                                                                          
            if (db.ReportTypes.Any(c => c.NameEn == reportType.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + reportType.NameEn };


            var Log = new Log() { CreateDateTime = DateTime.Now };
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("NameAr", reportType.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", reportType.NameEn, false, true));

                Log.Histories.Add(new History()
                {
                    TitleEn = reportType.NameAr,
                    TitleAr = reportType.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.ReportTypes,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }
            //Update Now 
            reportType.Log = Log;

            db.ReportTypes.Add(reportType);
            return null;
        }

        internal object PointPackage(PointPackage pointPackage, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(pointPackage.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(pointPackage.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };
            if (pointPackage.Points <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Price };
            if (pointPackage.Points == 0)

                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Points };



            //Check NameAr Duplicated
            if (db.Nationalities.Any(c => c.NameAr == pointPackage.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + pointPackage.NameAr };

            //Check NameEn Duplicated
            if (db.Nationalities.Any(c => c.NameEn == pointPackage.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + pointPackage.NameEn };


            var Log = new Log() { CreateDateTime = DateTime.Now };
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                Log.Histories.Add(new History()
                {
                    TitleEn = pointPackage.NameEn,
                    TitleAr = pointPackage.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.PointPackages,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });

            }
            //Update Now 
            pointPackage.Log = Log;


            db.PointPackages.Add(pointPackage);
            return null;
        }

        internal object AdsSlider(AdsSlider ad, PagesAllow pageAllow)
        {
            if (ad.NewFile == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.FiledIsRequired + " >> " + Token.Image);

           var Log = new Log() {CreateDateTime=DateTime.Now };
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                Log.Histories.Add(new History()
                {
                    TitleEn = "Ad",
                    TitleAr = "اعلان",
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.AdsSlider,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                });

            }
            //Update Now 
            ad.Log = Log;


            //Save Image 
            FileSaveVM FileSave = FileService.SaveFile(new FileSaveVM() {
                File=ad.NewFile,
                Extensions=DefaultsVM.ExtensionsImage,
                ServerPathSave="/Files/Images/"
            });

            if (!FileSave.IsSaved)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.CanNotSaveFile);
            ad.File = new File()
            {
                FileUrl=FileSave.SavedPath,
                FKAppInformation_Id=AppInformationEnumVM.ControllPanelLink,
                FkFileType_Id=FileTypeEnumVM.Image
            };

            db.AdsSliders.Add(ad);
            return null;
        }

        internal object SubCategory(SubCategory subCategory, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();
            Category Category = db.Categories.Find(subCategory.FkCategory_Id);

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(subCategory.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(subCategory.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };
            if (subCategory.FkCategory_Id == 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Category };



            //Check NameAr Duplicated
            if (db.SubCategories.Any(c => c.NameAr == subCategory.NameAr && c.FkCategory_Id == subCategory.FkCategory_Id))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + subCategory.NameAr + " " + Token.With + Token.Country + " >> " + Category.CategoryName };

            //Check NameEn Duplicated
            if (db.SubCategories.Any(c => c.NameEn == subCategory.NameEn && c.FkCategory_Id == subCategory.FkCategory_Id))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + subCategory.NameEn + " " + Token.With + Token.Country + " >> " + Category.CategoryName };


           var Log = new Log() {CreateDateTime=DateTime.Now };
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {

                //Set History Details For Log
                              HistoryDetails.Add(new HistoryDetailVM("NameAr", subCategory.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", subCategory.NameEn, false, true));

                Log.Histories.Add(new History()
                {
                    TitleEn = subCategory.NameEn,
                    TitleAr = subCategory.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.SubCategories,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });

            }
            //Update Now 
            subCategory.Log = Log;


            //Save Image 
            if (subCategory.NewFile == null)
            {
                subCategory.File = new File()
                {
                    FileUrl = "",
                    FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                    FkFileType_Id = FileTypeEnumVM.Image
                };

            }
            else
            {

            FileSaveVM FileSave = FileService.SaveFile(new FileSaveVM()
            {
                File = subCategory.NewFile,
                Extensions = DefaultsVM.ExtensionsImage,
                ServerPathSave = "/Files/Images/"
            });

            if (!FileSave.IsSaved)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.CanNotSaveFile);
            subCategory.File = new File()
            {
                FileUrl = FileSave.SavedPath,
                FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                FkFileType_Id = FileTypeEnumVM.Image
            };
            }




            db.SubCategories.Add(subCategory);
            return null;
        }

        internal object Offer(Offer offer, PagesAllow pageAllow)
        {


            HistoryDetails = new List<HistoryDetailVM>();

         
            //Check StartDateTime Must Be More than Or Equal  current DateTime 
            if (offer.StartDateTime < DateTime.Now)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.StartDateTimeMustBeMoreTthanOrEqualCurrent };

            //Check EndDateTime Must Be More than StartDateTime 
            if (offer.EndDateTime <= offer.StartDateTime)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.EndDateTimeMustBeMoreThanStartDateTime };


            //Create Log 
            Log Log = new Log() { CreateDateTime=DateTime.Now};
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("Title", offer.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", offer.Description, true, false));
                HistoryDetails.Add(new HistoryDetailVM("IsTop", offer.IsTop.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("Price", offer.Price.ToString(), true, false));

                Log.Histories.Add(new History()
                {
                    TitleEn = offer.Title,
                    TitleAr = offer.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Offers,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }
            offer.Log = Log;






            //Upload image 
            Album Album = new Album();
            List<AlbumFile> AlbumFiles = new List<AlbumFile>();
          
            Album.AlbumFiles = AlbumFiles;
            offer.Album = Album;

            db.Offers.Add(offer);
            return null;
        }

        internal object Ad(Ad ad, PagesAllow pageAllow)
        {
            int DayesPeriodCount = 0;
            int.TryParse(db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value,out DayesPeriodCount);

            //Check StartDateTime Must Be More than Or Equal  current DateTime 
            if (ad.StartDateTime < DateTime.Now)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.StartDateTimeMustBeMoreTthanOrEqualCurrent };

            //Ad Start Date Time
            if (ad.IsApprove && ad.StartDateTime == null)
                ad.StartDateTime = DateTime.Now;

            //Check EndDateTime Must Be More than StartDateTime 
            if (ad.EndDateTime <= ad.StartDateTime)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.EndDateTimeMustBeMoreThanStartDateTime };
 
            ad.FkUser_Id = new UserService().GetCurrentUserId();


            if (ad.StartDateTime !=null && ad.EndDateTime == null)
                ad.EndDateTime = DateTime.Now.AddDays(DayesPeriodCount);

            //Create Log 
            Log Log = new Log() { CreateDateTime=DateTime.Now};
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("Title", ad.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", ad.Description, true, false));
                HistoryDetails.Add(new HistoryDetailVM("IsApprove", ad.IsApprove.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("IsTop", ad.IsTop.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("Price", ad.Price.ToString(), true, false));

                Log.Histories.Add(new History()
                {
                    TitleEn = ad.Title,
                    TitleAr = ad.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Ads,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }
            ad.Log = Log;

            ad.Location = new Location {
                Longitude= ad.Longitude,
                Latitude = ad.Latitude,
            };
            ad.Album = new Album() {
                AlbumFiles = new List<AlbumFile>()
            };
            db.Ads.Add(ad);
            return null;
        }



        internal object Category(Category cateogry, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(cateogry.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(cateogry.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };

            //Check NameAr Duplicated
            if (db.Countries.Any(c => c.NameAr == cateogry.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + cateogry.NameAr };

            //Check NameEn Duplicated                                                                                          
            if (db.Countries.Any(c => c.NameEn == cateogry.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + cateogry.NameEn };


            var Log = new Log() { CreateDateTime=DateTime.Now};
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("NameAr", cateogry.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", cateogry.NameEn, false, true));

                Log.Histories.Add(new History()
                {
                    TitleEn = cateogry.NameAr,
                    TitleAr = cateogry.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Categories,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }
            //Update Now 
            cateogry.Log = Log;

            db.Categories.Add(cateogry);

            return null;
        }

        //Create Technical Support
        internal object CreateTechnicalSupport(TechnicalSupportVM technicalSupport)
        {
            if (string.IsNullOrEmpty(technicalSupport.UserName))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.UserName };
            if (string.IsNullOrEmpty(technicalSupport.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Email };
            if (string.IsNullOrEmpty(technicalSupport.Phone))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Phone };
            if (string.IsNullOrEmpty(technicalSupport.Message))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Message };

            if (!CheckedS.EmailIsCorrect (technicalSupport.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message= Token.InvalidEmail};
            if (!CheckedS.NumberValid(technicalSupport.Phone))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidNumber };



            db.TechnicalSupports.Add(new TechnicalSupport() {
                CreateDateTime = DateTime.Now,
                Email = technicalSupport.Email,
                UserName=technicalSupport.UserName,
                Phone=technicalSupport.Phone,
                Message=technicalSupport.Message,
            });

            return null;
        }






        //Nationality Create
        internal object Nationality(Nationality nationality, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(nationality.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(nationality.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };



            //Check NameAr Duplicated
            if (db.Nationalities.Any(c => c.NameAr == nationality.NameAr ))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + nationality.NameAr };

            //Check NameEn Duplicated
            if (db.Nationalities.Any(c => c.NameEn == nationality.NameEn  ))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + nationality.NameEn };


            var Log = new Log() {CreateDateTime=DateTime.Now };
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {

                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("NameAr", nationality.NameAr,false,false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", nationality.NameEn,false,true));

                Log.Histories.Add(new History()
                {
                    TitleEn = nationality.NameAr,
                    TitleAr = nationality.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Nationalities,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });

            }
            //Update Now 
            nationality.Log = Log;


            db.Nationalities.Add(nationality);
            return null;
        }

        internal object User(UserInformation userInformation, Address address, User user, UserRole[] userRoles, HttpPostedFileBase image, PagesAllow pageAllow)
        {

          

            //Check UserName unic
            if (string.IsNullOrEmpty(user.UserName))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.UserName + " >>" + Token.FiledIsRequired };
            if (db.Users.Any(x => x.UserName == user.UserName))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.UserName + " >>" + Token.BeforeUsed };


            //Check Email unic
            if (string.IsNullOrEmpty(user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + " >>" + Token.FiledIsRequired };
            if (db.Users.Any(x => x.Email == user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + " >>" + Token.BeforeUsed };

            //Check NationalId unic
            if (!string.IsNullOrEmpty(userInformation.NationalId))
                if (db.UserInformations.Any(x => x.NationalId == userInformation.NationalId))
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NationalId + " >>" + Token.BeforeUsed };

            //Password
            if (string.IsNullOrEmpty(user.NewPassword))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NationalId + " >>" + Token.FiledIsRequired };

            //التحقق من تطابق كلمة السر
            if (user.NewPassword != user.ConfirmPassword)
                return new { RequestType = RequestTypeEnumVM.Warning, Message = Token.PasswordsAreNotConsistent, Title = Token.Warning };

            //Check Phone Is Uniq
            if (string.IsNullOrEmpty(userInformation.PhoneNumber))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Phone + " >>" + Token.FiledIsRequired };
            if (db.UserInformations.Any(c => c.PhoneNumber == userInformation.PhoneNumber))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Phone + " >>" + Token.BeforeUsed };



            if (string.IsNullOrEmpty(userInformation.FirstName))
                userInformation.FirstName = "";
            if (string.IsNullOrEmpty(userInformation.LastName))
                userInformation.LastName = "";


            //Add Another Data
            user.Serial = Guid.NewGuid().ToString();
            user.CreateDate = DateTime.Now;
            user.Password = user.NewPassword;

            //Add Log
            var Log = new Log() { CreateDateTime = DateTime.Now };
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("UserName", user.UserName, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Email", user.Email, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Serial", user.Serial, true, false));

                Log.Histories.Add(new History()
                {
                    TitleAr = user.UserName,
                    TitleEn = user.UserName,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Users,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });

            }
            user.Log = Log;



            //Add Address
            if (address != null)
                userInformation.Address = address;


         
       


            //Add Language
            Language Language = new Language();
            if (userInformation.Languages != null)
            {
                Language.LanguageUsings = userInformation.Languages;
            }
            userInformation.Language = Language;


            //Add Role
            if (userRoles != null)
            {

                foreach (UserRole uRole in userRoles)
                {
                    if (!user.UserRoles.Any(c => c.FkRole_Id == uRole.FkRole_Id))
                        user.UserRoles.Add(uRole);
                }
            }
            else
                user.UserRoles.Add(new UserRole() { FkRole_Id = RoleEnumVM.Client });

            //Add Image 
            if (image == null)
                userInformation.File = new File()
                {
                    FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                    FkFileType_Id = FileTypeEnumVM.Image,
                    FileUrl = DefaultsVM.ImageDefult,
                };
            else
            {
                //Save Image
                FileSaveVM FileSave = FileService.SaveFile(new FileSaveVM()
                {
                    File = image,
                    ServerPathSave = "~/Files/Images/Users/Profile/",
                    Extensions = DefaultsVM.ExtensionsImage,
                });

                if (!FileSave.IsSaved)
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotSaveFile};

                userInformation.File = new File()
                {
                    FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                    FkFileType_Id = FileTypeEnumVM.Image,
                    FileUrl = FileSave.SavedPath,
                };
            }

            userInformation.Following = new Following();


            user.UserInformation = userInformation;
            db.Users.Add(user);
            return null;
        }

        //Country Create
        internal object Country(Country country, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(country.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(country.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };


            if (string.IsNullOrEmpty(country.CountryKey))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Key };


            //Check NameAr Duplicated
            if (db.Countries.Any(c => c.NameAr == country.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + country.NameAr };

            //Check NameEn Duplicated                                                                                          
            if (db.Countries.Any(c => c.NameEn == country.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + country.NameEn };
            if (db.Countries.Any(c => c.CountryKey == country.CountryKey))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + country.CountryKey };



            var Log = new Log() { CreateDateTime = DateTime.Now };
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("NameAr", country.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", country.NameEn, false, true));
                HistoryDetails.Add(new HistoryDetailVM("CountryKey", country.CountryKey, true, false));


                Log.Histories.Add(new History()
                {
                    TitleAr = country.NameAr,
                    TitleEn = country.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Countries,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }
            //Update Now 
            country.Log = Log;

            country.File = new File()
            {
                FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                FkFileType_Id = FileTypeEnumVM.Image,
                FileUrl = country.FlagUrl
            };

            db.Countries.Add(country);

            return null;
        }


        //Province Create
        internal object Province(Province province, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();
            Country Country = db.Countries.Find(province.FKCountry_Id);

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(province.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(province.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };
            if (province.FKCountry_Id == 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Country };



            //Check NameAr Duplicated
            if (db.Provinces.Any(c => c.NameAr == province.NameAr && c.FKCountry_Id == province.FKCountry_Id))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + province.NameAr + " >>" + Token.With + Token.Country + " >> " + Country.CountryName };

            //Check NameEn Duplicated
            if (db.Provinces.Any(c => c.NameEn == province.NameEn && c.FKCountry_Id == province.FKCountry_Id))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + province.NameEn + " >>" + Token.With + Token.Country + " >> " + Country.CountryName };


            var Log = new Log() { CreateDateTime = DateTime.Now };
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {

                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("NameAr", province.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", province.NameEn, false, true));

                Log.Histories.Add(new History()
                {
                    TitleAr = province.NameAr,
                    TitleEn = province.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Provinces,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });

            }
            //Update Now 
            province.Log = Log;


            db.Provinces.Add(province);
            return null;
        }


        //Job Create
        internal object Job(Job job, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(job.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(job.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };

            //Check NameAr Duplicated
            if (db.Jobs.Any(c => c.NameAr == job.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + job.NameAr };

            //Check NameEn Duplicated                                                                                          
            if (db.Jobs.Any(c => c.NameEn == job.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + job.NameEn };


            var Log = new Log() { CreateDateTime =DateTime.Now};
                        if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("NameAr", job.NameAr,false,false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", job.NameEn,false,true));

                Log.Histories.Add(new History()
                {
                    TitleEn = job.NameAr,
                    TitleAr = job.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Jobs,
                    FkState_Id = StateEnumVM.Create,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }
            //Update Now 
            job.Log = Log;

            db.Jobs.Add(job);
            return null;
        }
    }//End Class
}
