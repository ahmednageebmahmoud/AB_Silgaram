using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Enums;
using DAL.Models.ViewModel;
using DAL.Service;
using System.Web;
using DAL.Resource;

namespace DAL.Bll
{
    public class UsersData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        CheckedService CheckedS = new CheckedService();
        UpdateService UpdateS = new UpdateService();
        CreateService CreateS = new CreateService();
        UserService UserS = new UserService();

        public object GetUserInfromation()
        {
            var User = db.Users.Find(AccessToken.GetUserId());
            if (User == null)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.UserNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = UserInformation(User)


            };
        }
        public object UserInformation(User user)
        {
            return new
            {
                user.Id,
                user.UserName,
                user.Serial,
                user.Email,
                Image = user.UserInformation.File.FullFileUrl,
                user.UserInformation.FullName,
                user.Phone,
                user.UserInformation.BirthDate,
                user.CountryFlagUrl,
                user.UserInformation.File.FullFileUrl,
                CreateDate = DateService.GetDateTimeByCulture(user.CreateDate),
                user.Gender,
                user.Address,
                user.Country,
                user.Province,
                user.Points,
                user.FollowersCount,
                user.FollowingCount,
            };
        }
        public object ChangeLanguage(string lang)
        {
            try
            {
                UpdateS.db = db;

                object ObjectReturn = UpdateS.ChangeLanguage(lang);

                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();
                db = new SilgaramEntities();
                var User = db.Users.Find(AccessToken.GetUserId());

                return new ResponseVM (RequestTypeEnumVM.Success, Token.Updated,
                      UserInformation(User)
                );
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange, DevMessage = ex.Message };
            }
        }

        public object GetRecentyViewed(int skip, int take)
        {
            var User = db.Users.Find(AccessToken.GetUserId());

            List<RecentyViewedVM> RecentyVieweds = new List<RecentyViewedVM>();

            RecentyVieweds.AddRange(User.AdsViewers.Select(c => new RecentyViewedVM
            {
                CountViewer = c.CountViewer,
                Title = c.Ad.Title,
                Description = c.Ad.Description,
                Image = c.Ad.BaseImage,
                DateTime = c.DateTime,
                IsAd = true
            }));

            RecentyVieweds.AddRange(User.OffersViewers.Select(c => new RecentyViewedVM
            {
                CountViewer = c.CountViewer,
                Title = c.Offer.Title,
                Description = c.Offer.Description,
                Image = c.Offer.BaseImage,
                DateTime = c.DateTime,
                IsOffer = true
            }));

            if (RecentyVieweds.Count == 0)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.NoDataMore);

            return new ResponseVM(RequestTypeEnumVM.Success, Token.Success,
                RecentyVieweds.OrderByDescending(c => c.DateTime).Skip(skip).Take(take));

        }

        public object ForgetPassword(string email)
        {

            try
            {
                var User = db.Users.Where(c => c.Email == email).Single();
                if (User == null)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.UserNotFound);

                LanguageService.SetCulture(UserS.GetCurrentUserCulture(User));


                EmailService.SendPassword(email, User.UserName, User.Password);
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Sent };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, DevMessage = ex.Message };
            }
        }

        public object UpdateUserData(UserDataVM userDataVM)
        {
            try
            {
                UpdateS.db = db;
                object ObjectReturn = UpdateS.UpdateUserData(userDataVM);

                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Updated };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange, DevMessage = ex.Message };
            }
        }




        /// <summary>
        /// Save Change Calling From Api
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public object SaveChenage(UserVM user)
        {
            //PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Users);


            try
            {
                CreateS.db = db;

                var ObjectReturn = CreateS.User(user);

                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();

                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Created };

            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange, DevMessage = ex.Message, InnerException = ex };
            }
        }

        public object GetUserDataForUpdate(string serial)
        {
            if (!CheckedS.Serial(serial))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.UserNotFound };


            var CurrentUser = UserS.GetCurrentUser();
            if (CurrentUser.Serial == serial)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotUpdateYourInformationFromHere };

            var User = db.Users.Where(x => x.Serial == serial).Single();

            var userData = new
            {
                User.Id,
                User.Email,
                User.UserName,
                User.IsBlocked,
                User.Serial,
                UserRoles = User.UserRoles.Select(c => new { c.FkRole_Id, c.Id }).ToList(),
                User.UserInformation.FullName,
                User.UserInformation.NationalId,
                PhoneNumbers = User.UserInformation.PhoneNumber,
                ImageUrl = User.UserInformation.File.FileUrl,
                Languages = User.UserInformation.Language.LanguageUsings.Select(c => new { Id = c.Id, FKLanguageType_Id = c.FKLanguageType_Id, IsDefault = c.IsDefault }),
                dd = User.UserInformation.IsBirthDate ? int.Parse(DateService.GetDateByCulture("dd", User.UserInformation.BirthDate.Value)) : 0,
                mm = User.UserInformation.IsBirthDate ? int.Parse(DateService.GetDateByCulture("MM", User.UserInformation.BirthDate.Value)) : 0,
                yyyy = User.UserInformation.IsBirthDate ? int.Parse(DateService.GetDateByCulture("yyyy", User.UserInformation.BirthDate.Value)) : 0,


                User.UserInformation.FKJob_Id,
                FKGender_Id = User.UserInformation.FKGender_Id,
                FKSocialStatus_Id = User.UserInformation.FKSocialStatus_Id,
                User.UserInformation.Address.FkProvince_Id,
                User.UserInformation.Address.FKCountry_Id,
                User.UserInformation.Address.PostalCode,
                User.UserInformation.Address.Street,
                User.FollowersCount,
                User.FollowingCount
            };

            return userData;
        }
        /// <summary>
        /// هنا يتابع المستخدم مستخدم آخر ونرسل اشعار 
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public object FollowingUser(int userId)
        {

            try
            {
                bool IsUnFollowing = false;


                PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Users);
                History NewHistory = new History();
                CreateS.db = db;
                object ObjectReturn = CreateS.CreateFollowing(userId, IsUnFollowing, PageAllow, NewHistory);
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();

                if (IsUnFollowing)
                    return new ResponseVM(RequestTypeEnumVM.Success, Token.Success, false);

                db = new SilgaramEntities();
                var UserFollowing = db.Users.Find(userId);
                bool UserIsEn = UserService.UserIsEn(UserFollowing);

                //Send Notify Now To Fire Base
                if (!string.IsNullOrEmpty(UserFollowing.FireBaseToken))
                {
                    NewHistory = db.Histories.Find(NewHistory.Id);

                    //ارسال اشعار الى المستخدم الحالى بانة يوجد مستخدم عمل لة متابعة
                    var ObjNotifiy =
                              NotifyVM.NotifyNode(
                                  usersFollowingYouId: AccessToken.GetUserId(),
                                  nameAction: UserIsEn ? NewHistory.NameActionEn : NewHistory.NameActionAr,
                                  body: UserIsEn ? NewHistory.TitleEn : NewHistory.TitleAr
                                  );
                    FireBaseService.SendSpecificNotification(UserFollowing.FireBaseToken, ObjNotifiy);
                }
                return new ResponseVM(RequestTypeEnumVM.Success, Token.Success, true);

            }
            catch (Exception ex)
            {
                return new ResponseVM(RequestTypeEnumVM.Error, Token.SomeErrorInServer, "", ex);
            }
        }

        public void Dispose()
        {
            db.Dispose();
            UserS.Dispose();
            CreateS.Dispose();
            CheckedS.Dispose();
        }

    }//end Class
}
