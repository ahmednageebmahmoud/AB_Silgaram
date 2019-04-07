using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Enums;
using DAL.Service;
using DAL.Models.ViewModel;

namespace DAL.Bll
{
    public class UserLoginData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();

        //GetUserData
        public object GetUserLogin(string userSerial)
        {
            if (string.IsNullOrEmpty(userSerial))
                return null;
            var data = db.Users.Where(x => x.Serial == userSerial).Single().UserLogins;
            return data.Select(x => new
            {
                x.Id,
                x.IsSuccess,
                DateString= DateService.GetDateByCulture("dd/MM/yyyy hh:mm:ss tt",x.LoginDate),
                x.User.UserName,
                IsLast=data.Last().Id==x.Id?true:false

            }).OrderByDescending(x=> x.Id).ToList();
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
                data.UserInformation.FirstName,
                data.UserInformation.MediumName,
                data.UserInformation.LastName,
                UserRoles = data.UserRoles.Select(c => new { c.Id, FkRole_Id = c.FkRole_Id.ToString(), c.FkUser_Id }).ToList(),
                data.UserInformation.FKJob_Id,
                data.UserInformation.File.FileUrl,
                data.CreateDate,
                data.UserInformation.FKGender_Id,
                data.UserInformation.FKSocialStatus_Id,
                data.UserInformation.Address.FKCountry_Id,
                data.UserInformation.Address.City,
                data.UserInformation.Address.PostalCode
            };

        }

        //GetUserData
        public object GetUserData(int userId)
        {
            var data= db.Users.Where(x => x.Id == userId).Single() ;
            if (data.UserInformation.File == null)
                data.UserInformation.File = new File() { FileUrl = DefaultsVM.ImageDefult };

            return  new {
                data.UserName,
                data.FullName,
                data.UserInformation.Job.JobName,
                data.UserInformation.File.FileUrl
            };
            
        }

        public object GetUserDataForUpdate(int userId)
        {
            var userData= db.Users.Where(x => x.Id == userId).Select(x=> new
            {
                x.Email,
                x.UserInformation.BirthDate,
                x.UserInformation.FirstName,
                x.UserInformation.MediumName,
                x.UserInformation.LastName,
                x.UserInformation.NationalId,
                 x.UserInformation.PhoneNumber,
                x.UserInformation.FKAddress_Id,
                x.UserInformation.FKJob_Id,
                FKGender_Id= x.UserInformation.FKGender_Id.ToString(),
                FKSocialStatus_Id=x.UserInformation.FKSocialStatus_Id.ToString(),
                Gender= ResourceService.GetToken(x.UserInformation.Gender.ResourceName),
                x.UserInformation.File.FileUrl,
                x.UserInformation.Address.FKCountry_Id,
                x.UserInformation.Address.FkProvince_Id,
                x.UserInformation.Address.PostalCode,
                x.UserInformation.Address.Street,
            }).Single();
            
            return userData;
        }

        public void Dispose()
        {
            db.Dispose();
        }
    }//end Class
}
