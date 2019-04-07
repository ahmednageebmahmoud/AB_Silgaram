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
        //GetUserData
        public object GetUsers(int coutnUserTake, int coutnUserSkip)
        {
            var data = db.Users.OrderByDescending(x => x.Id).ToList();
            if (coutnUserSkip > data.Count)
                return null;

            var Users = data.Skip(coutnUserSkip).Take(coutnUserTake).ToList();

            return Users.Select(x => new
            {

                x.Id,
                x.UserName,
                x.FullName,
                x.UserInformation.FirstName,
                x.UserInformation.MediumName,
                x.UserInformation.LastName,
                UserRoles = x.UserRoles.Select(c => new { c.Id, c.FkRole_Id, c.FkUser_Id }).ToList(),
                x.UserInformation.FKJob_Id,
               ImageUrl = x.UserInformation.File.FullFileUrl,
                x.CreateDate,
                x.UserInformation.FKGender_Id,
                x.UserInformation.FKSocialStatus_Id,



                FKCountry_Id=     x.UserInformation.Address==null?0: x.UserInformation.Address.FKCountry_Id,
                FkProvince_Id=  x.UserInformation.Address == null ? 0 : x.UserInformation.Address.FkProvince_Id,
                PostalCode=  x.UserInformation.Address == null ? "" : x.UserInformation.Address.PostalCode,
                Street1=  x.UserInformation.Address == null ? "" : x.UserInformation.Address.Street,
                City=  x.UserInformation.Address == null ? "" : x.UserInformation.Address.City,

                x.Serial,
                UserCount = data.Count,
                x.IsBlocked
            }).ToList();
        }

        

        //GetUserById
        public object GetUserById(int userId)
        {
            var data = db.Users.Where(x=> x.Id==userId).Single();
            return  new
            {
                data.Id,
                data.UserName,
                data.FullName,
                data.IsBlocked,
                data.UserInformation.FirstName,
                data.UserInformation.MediumName,
                data.UserInformation.LastName,
                UserRoles = data.UserRoles.Select(c => new { c.Id, c.FkRole_Id, c.FkUser_Id }).ToList(),
                data.UserInformation.FKJob_Id,
                data.UserInformation.File.FileUrl,
                data.CreateDate,
                data.UserInformation.FKGender_Id,
                data.UserInformation.FKSocialStatus_Id,
                data.UserInformation.Address.FKCountry_Id,
                data.UserInformation.Address.PostalCode,

            };

        }

        //GetUserData
        public object GetUserData(int userId)
        {
            var data= db.Users.Where(x => x.Id == userId).Single() ;
            if (data.UserInformation.File == null)
                data.UserInformation.File = new File() { FileUrl =DefaultsVM.ImageDefult };

            return  new {
                data.UserName,
                data.FullName,
                data.UserInformation.Job.JobName,
                data.UserInformation.File.FullFileUrl
            };
            
        }

        //Save Chenage
        public object SaveChenage(UserInformation userInformation, Address address, User user, UserRole[] userRoles, HttpPostedFileBase image,bool isUpdate)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Users);


            try
            {
                UpdateS.db = db;
                CreateS.db = db;

                var ObjectReturn = new object();
                if (isUpdate)
                {
                    ObjectReturn = UpdateS.User(userInformation,  address, user, userRoles, image, PageAllow);
                }
                else
                {
                    ObjectReturn = CreateS.User(userInformation, address, user, userRoles, image, PageAllow);
                }

                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();

                if (isUpdate)
                {
                //Remove Old Image
                FileService.RemoveFile(userInformation.OldImageUrl);
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved, User = GetUserDataForUpdate(user.Serial) };

                }else
                {
                    
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved, User=GetUserDataForUpdate(user.Serial) };
                }
            }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange };
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
                User.UserInformation.FirstName,
                User.UserInformation.MediumName,
                User.UserInformation.LastName,
                User.UserInformation.NationalId,
                User.UserInformation.PhoneNumber,
                ImageUrl = User.UserInformation.File.FileUrl,

                Languages = User.UserInformation.Language !=null? User.UserInformation.Language.LanguageUsings.Select(c => new { Id = c.Id, FKLanguageType_Id = c.FKLanguageType_Id, IsDefault = c.IsDefault }):null,
                dd = User.UserInformation.IsBirthDate ? int.Parse(DateService.GetDateByCulture("dd", User.UserInformation.BirthDate.Value)) : 0,
                mm = User.UserInformation.IsBirthDate ? int.Parse(DateService.GetDateByCulture("MM", User.UserInformation.BirthDate.Value)) : 0,
                yyyy = User.UserInformation.IsBirthDate ? int.Parse(DateService.GetDateByCulture("yyyy", User.UserInformation.BirthDate.Value)) : 0,


                User.UserInformation.FKJob_Id,
                 User.UserInformation.FKGender_Id,
                User.UserInformation.FKSocialStatus_Id,
                User.Points,
                User.IsAgent,

                FKCountry_Id = User.UserInformation.Address == null ? 0 : User.UserInformation.Address.FKCountry_Id,
                FkProvince_Id = User.UserInformation.Address == null ? 0 : User.UserInformation.Address.FkProvince_Id,
                PostalCode = User.UserInformation.Address == null ? "" : User.UserInformation.Address.PostalCode,
                Street1 = User.UserInformation.Address == null ? "" : User.UserInformation.Address.Street,
                City = User.UserInformation.Address == null ? "" : User.UserInformation.Address.City,

            };
                        
            return userData;
        }

        public void Dispose()
        {
            db.Dispose();
            UserS.Dispose();
            CreateS.Dispose();
            UpdateS.Dispose();
            CheckedS.Dispose();       }

    }//end Class
}
