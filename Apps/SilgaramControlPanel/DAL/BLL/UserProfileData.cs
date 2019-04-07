using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Enums;
using DAL.Service;
using DAL.Models.ViewModel;
using System.Web;
using DAL.Resource;

namespace DAL.Bll
{
    public class UserProfileData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        UpdateService UpdateS = new UpdateService();
        //GetUserData
        public object GetUserData(int userId)
        {
            var data= db.Users.Where(x => x.Id == userId).Single() ;
            if (data.UserInformation.File == null)
                data.UserInformation.File = new File() { FileUrl = DefaultsVM.ImageDefult };

            return  new {
                data.UserName,
                data.FullName,
                JobName= data.UserInformation.FKJob_Id.HasValue? data.UserInformation.Job.JobName:"",
              ImageUrl=  data.UserInformation.File.FullFileUrl
            };
            
        }

        public object GetUserDataForUpdate(int userId)
        {
            var User = db.Users.Where(x => x.Id == userId).Single();
            if (User == null)
                return null;

            int FkCity_Id = 0, FKCountry_Id = 0, FkProvince_Id=0;
            string PostalCode = string.Empty,
              Street2 = string.Empty,
              Street1 = string.Empty,
              City = string.Empty;

            if (User.UserInformation.Address != null)
            {
                if (User.UserInformation.Address.FKCountry_Id.HasValue)
                    FKCountry_Id = User.UserInformation.Address.FKCountry_Id.Value;
                if (User.UserInformation.Address.FkProvince_Id.HasValue)
                    FkProvince_Id = User.UserInformation.Address.FkProvince_Id.Value;


                PostalCode = User.UserInformation.Address.PostalCode;
            City = User.UserInformation.Address.City;

                Street1 = User.UserInformation.Address.Street;
            }

            return new
            {
                User.Email,
                User.UserInformation.BirthDate,
                User.UserInformation.FirstName,
                User.UserInformation.MediumName,
                User.UserInformation.LastName,
                User.UserInformation.NationalId,
 User.UserInformation.PhoneNumber,
                
                User.UserInformation.FKAddress_Id,
                User.UserInformation.FKJob_Id,
                     User.UserInformation.FKGender_Id,
                 User.UserInformation.FKSocialStatus_Id,
                ImageUrl=      User.UserInformation.File.FullFileUrl,

                FkCity_Id,
                FKCountry_Id,
                FkProvince_Id,
                PostalCode,
                Street2,
                Street1,
                City,
            Languages = User.UserInformation.Language.LanguageUsings.Select(c=> new LanguageUsing {Id=c.Id,FKLanguageType_Id=c.FKLanguageType_Id,IsDefault= c.IsDefault }),
                 
                dd = User.UserInformation.IsBirthDate? int.Parse(DateService.GetDateByCulture("dd", User.UserInformation.BirthDate.Value)):0,
                mm = User.UserInformation.IsBirthDate ? int.Parse(DateService.GetDateByCulture("MM", User.UserInformation.BirthDate.Value)):0,
                yyyy = User.UserInformation.IsBirthDate ? int.Parse(DateService.GetDateByCulture("yyyy", User.UserInformation.BirthDate.Value)):0
            };
        }

        public object SaveChange(UserInformation userInformation, Address address, User user, HttpPostedFileBase image)
        {
            try
            {
                UpdateS.db = db;

                var ObjectReturn = UpdateS.User(userInformation, address, user, image); 
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();

                var User = db.Users.Find(user.Id);
                CookieService.SetUserInCookie(User);
                LanguageService.SetCulture(User.UserInformation.Language.LanguageUsings.FirstOrDefault(c => c.IsDefault).LanguageType.Code);

                //Remove Old Image
                FileService.RemoveFile(userInformation.OldImageUrl);
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved};
            }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange };
            }

        }

        public void Dispose()
        {
            db.Dispose();
        }
    }//end Class
}
