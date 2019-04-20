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
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text.RegularExpressions;

namespace DAL.Service
{
    public class CreateService : IDisposable
    {
        public SilgaramEntities db = new SilgaramEntities();
        CheckedService CheckedS = new CheckedService();
        List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();
        public void Dispose()
        {
            // db.Dispose();
            CheckedS.Dispose();
        }
        internal object CommercialBanner(CommercialBanner commercialBanner, PagesAllow pagesAllow)
        {
            //Check Required
            if (string.IsNullOrEmpty(commercialBanner.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + "  >> " + Token.FiledIsRequired };
            if (string.IsNullOrEmpty(commercialBanner.Phone))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Phone + "  >> " + Token.FiledIsRequired };
            if (string.IsNullOrEmpty(commercialBanner.Name))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Name + "  >> " + Token.FiledIsRequired };

            //Check Data Is Valid
            if (!CheckedS.EmailIsCorrect(commercialBanner.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidEmail };

            if (CheckedS.CheckMaxLength(commercialBanner.Name, 50))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Name + " " + Token.MaxLength + "=50" };
            if (CheckedS.CheckMaxLength(commercialBanner.Phone, 20))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Phone + " " + Token.MaxLength + "=20" };

            HistoryDetails.Add(new HistoryDetailVM("Name", commercialBanner.Name, true, false));
            HistoryDetails.Add(new HistoryDetailVM("Email", commercialBanner.Email, true, false));
            HistoryDetails.Add(new HistoryDetailVM("Phone", commercialBanner.Phone, true, false));

            //Ad Notify
            History History = new History();
            History.TitleAr = "طلب اعلان تجارى";
            History.TitleEn = "Commercial Banner Request";
            History.DateTime = DateTime.Now;
            History.FKPage_Id = PageEnumVM.CommercialBanners;
            History.FkState_Id = StateEnumVM.Create;
            History.HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails);
            db.Histories.Add(History);

            commercialBanner.DateTime = DateTime.Now;
            db.CommercialBanners.Add(commercialBanner);
            return null;
        }
        internal object BuyOffer(UsersPurchasesOffer userPurcha, Offer offer)
        {
            int UserId = AccessToken.GetUserId();


            userPurcha.OfferPrice = offer.Price;
            userPurcha.OfferDiscountRate = offer.DiscountRate;
            userPurcha.OfferNetPrice = offer.PurePrice;
            userPurcha.FkUser_Id = UserId;
            userPurcha.BayDateTime = DateTime.Now;
            db.UsersPurchasesOffers.Add(userPurcha);

            return null;
        }
        //internal object CreateAdEvaluation(Ad ad, decimal rate)
        //{

        //    if(ad==null)
        //        return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.AdNotFound };

        //    if (rate > 5 || rate < 0)
        //        return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.RateMustbeMoreThan5AndLessThan0 };
        //    if (ad.AdsEvaluations.Any(c =>   c.FkUser_Id == UserId))
        //    {
        //        //Update 
        //        ad.AdsEvaluations.Where(c =>  c.FkUser_Id == UserId).Single().Rate = EvaluationService.RateRounds(rate);

        //        //Update Ads Rate
        //        EvaluationService.UpdateEvaluationResult(ad);
        //    }
        //    else
        //    {
        //        //Create
        //        ad.AdsEvaluations.Add(new AdsEvaluation()
        //        {
        //            FkUser_Id = UserId,
        //            Rate= EvaluationService.RateRounds(rate)
        //        });


        //        //Create  Ads Rate
        //        EvaluationService.CreateEvaluationResult(ad);


        //    }




        //    return null;
        //}


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

            if (!CheckedS.EmailIsCorrect(technicalSupport.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidEmail };
            if (!CheckedS.NumberValid(technicalSupport.Phone))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidNumber };



            db.TechnicalSupports.Add(new TechnicalSupport()
            {
                CreateDateTime = DateTime.Now,
                Email = technicalSupport.Email,
                UserName = technicalSupport.UserName,
                Phone = technicalSupport.Phone,
                Message = technicalSupport.Message,
            });

            return null;
        }

        internal object BuyAd(UsersPurchasesAd usersPurcha, PagesAllow pagesAllow, History history)
        {
            int UserId = AccessToken.GetUserId();
            var User = db.Users.Find(UserId);

            var Ad = db.Ads.Find(usersPurcha.FkAd_Id);
            if (Ad == null)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.AdNotFound };


            usersPurcha.AdPrice = Ad.Price;
            usersPurcha.FkUser_Id = UserId;
            usersPurcha.BayDateTime = DateTime.Now;
            db.UsersPurchasesAds.Add(usersPurcha);


            if (pagesAllow.IsAllowLog || pagesAllow.IsAllowNotify)
            {

                HistoryDetails.Add(new HistoryDetailVM("AdTitle", Ad.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("AdPrice", Ad.Price.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("AdId", Ad.Id.ToString(), true, false));

                history = new History()
                {
                    TitleAr = string.Format("لقد قام المستتخدم {0} بطلب شراء اعلان {1}", User.UserInformation.FullName, Ad.Title),
                    TitleEn = string.Format("{0} has been request for buy ad {1}", User.UserInformation.FullName, Ad.Title),
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Ads,
                    FkState_Id = StateEnumVM.Buy,
                    FkUser_Id = UserId
                };

                //اضافة الاشعار لـ المستخدم الحالى
                db.UsersPrivateNotifies.Add(new UsersPrivateNotify()
                {
                    History = history,
                    FkUser_Id = Ad.FkUser_Id
                });
            }

            return null;
        }

        /// <summary>
        /// Create User Calling From Api
        /// </summary>
        /// <param name="model"></param>
        /// <param name="pageAllow"></param>
        /// <returns></returns>
        internal object User(UserVM user)
        {
            if (user == null)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.DataNotFound };

            //Check Required
            if (string.IsNullOrEmpty(user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + "  >> " + Token.FiledIsRequired };
            if (string.IsNullOrEmpty(user.PhoneNumber))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Phone + "  >> " + Token.FiledIsRequired };
            if (string.IsNullOrEmpty(user.Password))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Password + "  >> " + Token.FiledIsRequired };
            if (user.CountryId <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Country + "  >> " + Token.FiledIsRequired };

            //Check   unic
            if (CheckedS.EmailIsNotAvailable(user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + "  >> " + Token.BeforeUsed };
            if (CheckedS.PhoneNumberLoginIsNotAvailable(user.PhoneNumber))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Phone + "  >> " + Token.BeforeUsed };



            //Check  length
            if (user.Password.Length < 6)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.MinimumLength + "  >> " + Token.For + "  >> " + Token.Password + " 6" };
            //Check UserName
            if (user.PhoneNumber.Length > 15)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.UserName + "  >> " + Token.MaxLength + " 15" };

            //Check Data Is Valid
            if (!CheckedS.EmailIsCorrect(user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidEmail };
            if (!CheckedS.NumberValid(user.PhoneNumber))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidNumber };


            List<UserRole> UserRoles = new List<UserRole>()
            {
                new UserRole() {
                    FkRole_Id=RoleEnumVM.Client,
                }
            };

            UserInformation UserInformation = new UserInformation()
            {
                FullName="",
                Address = new Address()
                {
                    FKCountry_Id = user.CountryId
                },
                File = new File()
                {
                    FkFileType_Id = FileTypeEnumVM.Image,
                    FKAppInformation_Id = AppInformationEnumVM.ApiLink,
                    FileUrl = "",
                },
                Language = new Language
                {
                    LanguageUsings = new List<LanguageUsing>
                    {
                        new LanguageUsing
                        {
                            FKLanguageType_Id=LanguageTypeEnumVM.English,
                            IsDefault=true,
                        }
                    }
                },
                PhoneNumber = user.PhoneNumber,
                Following = new Following()
            };


            User User = new User()
            {
                Email = user.Email,
                Password = user.Password,
                UserName = user.Email,
                Serial = Guid.NewGuid().ToString(),
                IsBlocked = false,
                UserRoles = UserRoles,
                UserInformation = UserInformation,
                CreateDate = DateTime.Now,
                Points = 0,
                Log = new Log() { CreateDateTime = DateTime.Now }
            };

            User.UserName = GetUserNameNotDublicated(Regex.Replace(user.Email, "@.*", string.Empty));

            db.Users.Add(User);
            return null;
        }

        public string GetUserNameNotDublicated(string userName)
        {
            string NewUserName = userName;

            if (CheckedS.UserNameIsNotAvailable(NewUserName))
                return GetUserNameNotDublicated(NewUserName + string.Format("_{0}", new Random().Next(0, 5000)));

            return NewUserName;

        }

        internal object Chat(ChatSendVM chat, ChatMessage chatMessage, PagesAllow pagesAllow)
        {

            if (string.IsNullOrEmpty(chat.Message))
                return new ResponseVM(RequestTypeEnumVM.Error, Token.FiledIsRequired + " " + Token.Message);
            if (CheckedS.CheckMaxLength(chat.Message, 4000))
                return new ResponseVM(RequestTypeEnumVM.Error, Token.Message + " " + Token.MaxLength + " =4000");

            int UserId = AccessToken.GetUserId();

            //check user not found
            var User = db.Users.Find(UserId);
            if (User == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.UserNotFound);

            //check ad not found
            var Ad = db.Ads.Find(chat.AdId);
            if (Ad == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.AdNotFound);


            chatMessage.Message = chat.Message;
            chatMessage.SendDateTime = DateTime.Now;
            chatMessage.IsOwnar = Ad.FkUser_Id == UserId;

            if (chat.ChatId == 0)
            {


                if (Ad.FkUser_Id == UserId)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.YouCanNotCreateChatForYoureAds);

                if(db.Chattings.Any(c=> c.FkUser_Id==UserId && c.FkAd_Id==Ad.Id))
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.YoureAlreadyHaveChat);


                Ad.Chattings.Add(new Chatting()
                {
                    FkUser_Id = UserId,
                    Log = new Log() { CreateDateTime = DateTime.Now },
                    ChatMessages = new List<ChatMessage> { chatMessage }
                });
            }
            else
            {
                //update chat

                //create new chat
                if (chat.AdId == 0)
                    return new ResponseVM(RequestTypeEnumVM.Error, $"{Token.FiledIsRequired} : {Token.AdId} ");

                var Chat = db.Chattings.Find(chat.ChatId);
                if (chat == null|| Chat.FkAd_Id!=Ad.Id)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.ChatNotFound);


                Chat.ChatMessages.Add(chatMessage);

            }

                return null;
            }
        internal object ReportAd(ReportVM re, PagesAllow pagesAllow)
        {
            int UserId = AccessToken.GetUserId();
            //Check Property is Null
            if (string.IsNullOrEmpty(re.Description))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Description + "  >> " + Token.FiledIsRequired };

            if (re.AdId <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.AdId + "  >> " + Token.FiledIsRequired };

            if (re.ReportTypeId <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.ReportTypeId + "  >> " + Token.FiledIsRequired };

            //Check Length
            if (CheckedS.CheckMaxLength(re.Description, 1000))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Description + "  >> " + Token.MaxLength + " 1000" };

            ReportType ReportType = db.ReportTypes.Find(re.ReportTypeId);
            if (ReportType == null)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.ReportTypeNotFound };

            Ad Ad = db.Ads.Find(re.AdId);
            if (Ad == null)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.AdNotFound };

            if (Ad.FkUser_Id == AccessToken.GetUserId())
                return new ResponseVM(RequestTypeEnumVM.Error, Token.YouCanNotReportForYoureAds);

            Report Report = new Report();

            //Ad Log
            Log Log = new Log() { CreateDateTime = DateTime.Now };
            if (pagesAllow.IsAllowLog || pagesAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("TitleAd", Ad.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", re.Description, true, false));
                HistoryDetails.Add(new HistoryDetailVM("ReportTypeAr", ReportType.NameAr, false, true));
                HistoryDetails.Add(new HistoryDetailVM("ReportTypeEn", ReportType.NameEn, false, true));
                Log.Histories.Add(new History()
                {
                    TitleEn = Ad.Title,
                    TitleAr = Ad.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Reports,
                    FkState_Id = StateEnumVM.Report,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }
            Report.Log = Log;

            //Add Another Data
            Report.Description = re.Description;
            Report.FkAd_Id = re.AdId;
            Report.FkUser_Id = AccessToken.GetUserId();
            Report.FkReportType_Id = re.ReportTypeId;
            db.Reports.Add(Report);

            return null;
        }
        //Create Ad
        internal object Ad(AdVM ad, PagesAllow pagesAllow)
        {
            int UserId = AccessToken.GetUserId();

            if (db.Users.Find(UserId).Points == 0)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.YouDonNoHaveEnoughPoints);

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
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Description + "  >> " + Token.MaxLength + " 1000" };

            if (string.IsNullOrEmpty(ad.Latitude))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Latitude + "  >> " + Token.FiledIsRequired };

            if (string.IsNullOrEmpty(ad.Longitude))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Longitude + "  >> " + Token.FiledIsRequired };


            var Category = db.Categories.Find(ad.FkCategory_Id);
            if (Category == null)
                return new ResponseVM(RequestTypeEnumVM.Error, $"{Token.Category} : {Token.NotFound}");
            if (!Category.SubCategories.Any(c => c.Id == ad.FkSubCategory_Id))
                return new ResponseVM(RequestTypeEnumVM.Error, $"{Token.SubCategory} : {Token.NotFound}");



            Ad Ad = new Ad();

            //Ad Log
            Log Log = new Log() { CreateDateTime = DateTime.Now };
            if (pagesAllow.IsAllowLog || pagesAllow.IsAllowNotify)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("Title", ad.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", ad.Description, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Price", ad.Price.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("CategoryNameEn", Category.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("CategoryNameAr", Category.NameEn, false, true));

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
            Ad.Log = Log;

            //Save Image
            List<AlbumFile> AlbumFiles = new List<AlbumFile>();
            //يجب حفظ 10 صورر فقط
            var Images = ad.Images.Where(c => !string.IsNullOrEmpty(c.FileBase64)).OrderByDescending(c => c.State).Skip(0).Take(10).ToList();
            foreach (var img in ad.Images)
            {

                FileSaveVM ImgeSave = FileService.SaveFile(new FileSaveVM()
                {
                    FileBase64 = img.FileBase64,
                    ServerPathSave = "/Files/Images/"
                });

                //Checj Is Save
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
            Ad.Album = new Album()
            {
                AlbumFiles = AlbumFiles
            };

            Ad.Location = new Location
            {
                Latitude = ad.Latitude,
                Longitude = ad.Longitude
            };

            int DaysCount = 1;
            int.TryParse(db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value, out DaysCount);


            //Add Another Data
            Ad.Title = ad.Title;
            Ad.Description = ad.Description;
            Ad.Price = ad.Price;
            //نضع القيمة صحيحة موقتا
            Ad.FkCategory_Id = ad.FkCategory_Id;
            Ad.FkSubCategory_Id = ad.FkSubCategory_Id;
            Ad.FkUser_Id = UserId;
            Ad.IsTop = false;
            Ad.PhoneNumber = ad.PhoneNumber;
            Ad.IsAllowMessaging = ad.IsAllowMessaging;
            Ad.IsPostWithOutPhoneNumber = ad.IsPostWithOutPhoneNumber;
            Ad.IsAutoPost = ad.IsAutoPost;


            //وضع البيانات بشكل موقت
            Ad.IsApprove = true;
            Ad.StartDateTime = DateTime.Now;
            Ad.EndDateTime = DateTime.Now.AddDays(DaysCount);
            db.Ads.Add(Ad);
            return null;
        }
        public void CreateHistory(List<HistoryDetailVM> historyDetails, string titleEn, string titleAr, int pageId, int stateId)
        {
            int UserId = AccessToken.GetUserId();
            History History = new History();
            History.TitleAr = titleAr;
            History.TitleEn = titleEn;
            History.DateTime = DateTime.Now;
            History.FKPage_Id = pageId;
            History.FkState_Id = stateId;
            History.FkUser_Id = UserId;
            History.HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(historyDetails);
            db.Histories.Add(History);
        }
        /// <summary>
        /// Create Access Token 
        /// </summary>
        /// <param name="user"></param>
        /// <param name="culture"></param>
        /// <returns></returns>
        public AccessTokenVM CreateToken(User user, string culture)
        {
            //Set issued at date
            DateTime issuedAt = DateTime.UtcNow;
            //set the time when it expires
            DateTime expires = issuedAt.AddMonths(5);

            var tokenHandler = new JwtSecurityTokenHandler();

            //create a identity and add claims to the user which we want to log in
            ClaimsIdentity claimsIdentity = new ClaimsIdentity(new[]
            {
            new Claim(ClaimTypes.Name, user.UserName),

            //any user login in app basically included role client  
            new Claim(ClaimTypes.Role, "client"),
            new Claim(ClaimTypes.Email, user.Email),
            new Claim("UserId",user.Id.ToString()),
            });

            const string sec = "401b09eab3c013d4ca54922bb802bec8fd5318192b0a75f201d8b3727429090fb337591abd3e44453b954555b7a0812e1081c39b740293f765eae731f5a65ed1";
            var now = DateTime.UtcNow;
            var securityKey = new Microsoft.IdentityModel.Tokens.SymmetricSecurityKey(System.Text.Encoding.Default.GetBytes(sec));
            var signingCredentials = new Microsoft.IdentityModel.Tokens.SigningCredentials(securityKey, Microsoft.IdentityModel.Tokens.SecurityAlgorithms.HmacSha256Signature);


            //create the jwt
            var token =
                (JwtSecurityToken)
                    tokenHandler.CreateJwtSecurityToken(issuer: "Silgaram", audience: "Silgaram",
                    subject: claimsIdentity, notBefore: issuedAt, expires: expires, signingCredentials: signingCredentials);

            var TokenString = tokenHandler.WriteToken(token);
            return new AccessTokenVM()
            {
                Token = TokenString,
                Expires = DateService.GetDateTimeByCulture(expires, false)
            };
        }
        public User UserLogin(UserVM user)
        {
            try
            {
                UserLogin UserLogin = new UserLogin();

                int userId = db.Users.Single(v => v.Email == user.Email).Id;
                var User = db.Users.Find(userId);

                UserLogin.LoginDate = DateTime.Now;
                UserLogin.FkUser_Id = userId;

                //Check Login Valid 
                if (CheckedS.SignInByEmail(user.Email, user.Password))
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
                //التحقق باسم المستخدم وكلمة المرور فقط من اجل لا يجب اظهار هل المستخد بلزك او لاء الا فى حالة اذا كان المستخدم يدخل بيانات صحيحة 
                User.IsBlocked = CheckedS.IsUserBlocked(user.Email, user.Password);
                return User;
            }
            catch (Exception ex)
            {
                return null;

            }
        }
        internal User UserLoginByPhone(UserVM userData)
        {
            try
            {
                UserLogin UserLogin = new UserLogin();

                int userId = db.Users.Single(v => v.UserInformation.PhoneNumber == userData.PhoneNumber).Id;
                var User = db.Users.Find(userId);

                UserLogin.LoginDate = DateTime.Now;
                UserLogin.FkUser_Id = userId;

                //Check Login Valid 
                if (CheckedS.SignInByPhone(userData.PhoneNumber, userData.Password))
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
                //التحقق باسم المستخدم وكلمة المرور فقط من اجل لا يجب اظهار هل المستخد بلزك او لاء الا فى حالة اذا كان المستخدم يدخل بيانات صحيحة 
                User.IsBlocked = CheckedS.IsUserBlockedByPhone(userData.PhoneNumber, userData.Password);
                return User;
            }
            catch (Exception ex)
            {
                return null;

            }
        }
        internal object CreateFollowing(int userId, bool isUnFollowing, PagesAllow PageAllow, History history)
        {
            //Check User Following Not Found
            var UserFollowing = db.Users.Find(userId);
            if (UserFollowing == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.UserNotFound);

            var UserLogad = db.Users.Find(AccessToken.GetUserId());
            if (UserLogad.Id == userId)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.CanNotFollowing);


            isUnFollowing = false;
            if (UserLogad.UserInformation.Following.UsersFollowings.Any(c => c.FkUser_Id == userId))
            {

                UserLogad.UserInformation.Following.UsersFollowings.Remove(UserLogad.UserInformation.Following.UsersFollowings.Single(c => c.FkUser_Id == userId));
                isUnFollowing = true;
                return null;
            }

            //نتحقق اذا كان لم يتابع اى شخص من قبل نضع لى كائن المتابعة الجديد
            if (UserLogad.UserInformation.Following == null)
            {
                UserLogad.UserInformation.Following = new Following()
                {
                    UsersFollowings = new List<UsersFollowing>()
                    {
                        new UsersFollowing()
                        {
                            FkUser_Id=userId
                        }
                    }
                };
            }
            else
            {
                //اضافة متابع جديد الان
                UserLogad.UserInformation.Following.UsersFollowings.Add(new UsersFollowing() { FkUser_Id = userId });
            }

            if (PageAllow.IsAllowLog || PageAllow.IsAllowNotify)
            {

                history = new History()
                {
                    TitleAr = string.Format(" {0} لقد قام بمتابعتك", UserLogad.UserInformation.FullName),
                    TitleEn = string.Format("{0} has been  following", UserLogad.UserInformation.FullName),
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Users,
                    FkState_Id = StateEnumVM.Following,
                    FkUser_Id = AccessToken.GetUserId()
                };

                //اضافة الاشعار لـ المستخدم الحالى
                db.UsersPrivateNotifies.Add(new UsersPrivateNotify()
                {
                    History = history,
                    FkUser_Id = userId
                });
            }

            return null;
        }
        internal object PointPackageBuy(PointPackage pointPackage, UserPointPackage userPointPackage, PagesAllow pageAllow, string userSerial)
        {


            userPointPackage.FkUser_Id = AccessToken.GetUserId();
            userPointPackage.FKPointPackage_Id = pointPackage.Id;
            userPointPackage.Price = pointPackage.Price;
            userPointPackage.Points = pointPackage.Points;
            userPointPackage.BuyDateTime = DateTime.Now;
            userPointPackage.Payment = new Payment();
            userPointPackage.Payment.OrderNo = "";
            //Add  
            db.UserPointPackages.Add(userPointPackage);

            //بشكل موقت نزيد النقاط لان هيا المفروض تزيد عند اتمام عملية الدفع
            db.Users.Find(AccessToken.GetUserId()).Points += pointPackage.Points;

            //Add Historiy
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)

            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("NameAr", pointPackage.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", pointPackage.NameEn, false, true));


                History History = new History();
                History.TitleAr = pointPackage.NameAr;
                History.TitleEn = pointPackage.NameEn;
                History.DateTime = DateTime.Now;
                History.RedirectUrl = "/UserPointPackages?pointPackageId=" + pointPackage.Id + "&UserSerial=" + userSerial;
                History.FKPage_Id = PageEnumVM.UserPointPackages;
                History.FkState_Id = StateEnumVM.Buy;
                History.FkUser_Id = AccessToken.GetUserId();
                History.HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails);
                db.Histories.Add(History);
            }



            return null;
        }
    }//End Class
}
