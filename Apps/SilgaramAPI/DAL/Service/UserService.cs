using DAL.Bll;
using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace DAL.Service
{
    public class UserService : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        public int GetCurrentUserId()
        {
            return db.Users.Where(x => x.UserName == HttpContext.Current.User.Identity.Name).Single().Id;
        }
        public User GetCurrentUser()
        {
            return db.Users.Where(x => x.UserName == HttpContext.Current.User.Identity.Name).Single();
        }

        internal void Culture(out string culture)
        {
            try
            {
                var CurrentUser = GetUser(GetCurrentUserId());
                culture = CurrentUser.UserInformation.Language.LanguageUsings.Where(c => c.IsDefault).Single().LanguageType.Code;
            }
            catch (Exception)
            {
                culture = LanguageService.DefaultLangage;
            }
        }


        /// <summary>
        /// التحقق من وجود المستخدم او لاء
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public static bool IsUser(int userId)
        {
            using (SilgaramEntities db = new SilgaramEntities())
                return db.Users.Any(c => c.Id == userId);
        }

        public static bool CheckIsBlocked()
        {
            using (SilgaramEntities db = new SilgaramEntities())
            {
                int UserId = AccessToken.GetUserId();
                return db.Users.Find(UserId).IsBlocked;
            }
        }

        public List<int> GetCurrentUserRoles()
        {

            return db.Users.Where(x => x.UserName == HttpContext.Current.User.Identity.Name).Single().UserRoles.Select(c => c.FkRole_Id).ToList();
        }

        public User GetUser(int id)
        {
            return db.Users.Single(c => c.Id == id);
        }

        public void Dispose()
        {
            db.Dispose();
        }

        public User GetUserByUserName(string userName)
        {
            return db.Users.Where(x => x.UserName == userName).Single();
        }
        public User GetUser(string emial)
        {
            return db.Users.Where(x => x.Email == emial).Single();
        }

        public object LoginByPhone(LoginVM loginVM)
        {

            CheckedService CheckedS = new CheckedService();
            CreateService CreateS = new CreateService();
            UserService UserS = new UserService();
            string Culture = LanguageService.DefaultLangage;

            UserVM UserData = new UserVM
            {
                PhoneNumber = loginVM.PhoneNumber,
                Password = loginVM.Password
            };

            //Create User Login And Check Is Block
            //Check User Name Used
            if (!CheckedS.PhoneNumberLoginIsNotAvailable(loginVM.PhoneNumber))
                //return invalid data
                return new ResponseVM(RequestTypeEnumVM.Error, Token.InvalidData);


            //Add User Login With Statues Login Right Now 
            User User = CreateS.UserLoginByPhone(UserData);
            if (User == null)
                //Retune Message Invalid Data
                return new ResponseVM(RequestTypeEnumVM.Error, Token.InvalidData);

            //Check last Login is Block
            if (User.IsBlocked)
                //retuen message Account Block 
                return new ResponseVM(RequestTypeEnumVM.Error, Token.YoureAccountIsBlocked);
            else
                //Check last Login Statues 
                if (!User.IsSuccessLogin)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.InvalidData);

            /*
             * Check user role mustbe if Client or Client
             **Notes** any user login in app basically included role client  
            */
            if (!CheckedS.Roles(User.UserRoles, new int[] { RoleEnumVM.Client }))
                return new ResponseVM(RequestTypeEnumVM.Error, Token.YouNotClient);

            if (User.UserInformation.Language == null)
                Culture = "ar";
            else if (User.UserInformation.Language.LanguageUsings != null)
                if (User.UserInformation.Language.LanguageUsings.Any(c => c.IsDefault))
                    Culture = User.UserInformation.Language.LanguageUsings.Where(c => c.IsDefault).Single().LanguageType.Code;

            LanguageService.SetCulture(Culture);
            //Now Create Access Token
            AccessTokenVM AccessToken = CreateS.CreateToken(User, Culture);
            ResponseVM Res = new ResponseVM();
            Res.RequestType = RequestTypeEnumVM.Success;
            Res.Data = new
            {
                UserInformation = GetUserinformation(User),
                AccessToken
            };

            //Save User FireBase Token
            if (string.IsNullOrEmpty(loginVM.FireBaseAccessToken))
                db.Users.Find(User.Id).FireBaseToken = null;
            else
                db.Users.Find(User.Id).FireBaseToken = loginVM.FireBaseAccessToken;
            db.SaveChanges();

            //return the token
            return Res;
        }

        internal string GetCurrentUserCulture(User user)
        {
            if (user.UserInformation == null || user.UserInformation.Language == null || user.UserInformation.Language.LanguageUsings.Count == 0)
                return LanguageService.DefaultLangage;

            if (!user.UserInformation.Language.LanguageUsings.Any(v => v.IsDefault))
                return user.UserInformation.Language.LanguageUsings.First().LanguageType.Code;

            return user.UserInformation.Language.LanguageUsings.First(v => v.IsDefault).LanguageType.Code;
        }

        /// <summary>
        /// تسجيل الدخول بواسطة الميل والاكتيف كودد
        /// </summary>
        /// <param name="email"></param>
        /// <param name="activeCode"></param>
        /// <returns></returns>
        public object LoginByEmail(LoginVM loginVM)
        {
            CheckedService CheckedS = new CheckedService();
            CreateService CreateS = new CreateService();

            UserService UserS = new UserService();
            string Culture = LanguageService.DefaultLangage;

            UserVM UserData = new UserVM
            {
                Email = loginVM.Email,
                Password = loginVM.Password
            };

            //Create User Login And Check Is Block
            //Check User Name Used
            if (!CheckedS.EmailIsNotAvailable(loginVM.Email))
                //return invalid data
                return new ResponseVM(RequestTypeEnumVM.Error, Token.InvalidData);


            //Add User Login With Statues Login Right Now 
            User User = CreateS.UserLogin(UserData);
            if (User == null)
                //Retune Message Invalid Data
                return new ResponseVM(RequestTypeEnumVM.Error, Token.InvalidData);

            //Check last Login is Block
            if (User.IsBlocked)
                //retuen message Account Block 
                return new ResponseVM(RequestTypeEnumVM.Error, Token.YoureAccountIsBlocked);
            else
                //Check last Login Statues 
                if (!User.IsSuccessLogin)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.InvalidData);

            /*
             * Check user role mustbe if Client or Client
             **Notes** any user login in app basically included role client  
            */
            if (!CheckedS.Roles(User.UserRoles, new int[] { RoleEnumVM.Client }))
                return new ResponseVM(RequestTypeEnumVM.Error, Token.YouNotClient);

            if (User.UserInformation.Language == null)
                Culture = "ar";
            else if (User.UserInformation.Language.LanguageUsings != null)
                if (User.UserInformation.Language.LanguageUsings.Any(c => c.IsDefault))
                    Culture = User.UserInformation.Language.LanguageUsings.Where(c => c.IsDefault).Single().LanguageType.Code;

            LanguageService.SetCulture(Culture);

            //Now Create Access Token
            AccessTokenVM AccessToken = CreateS.CreateToken(User, Culture);
            ResponseVM Res = new ResponseVM();
            Res.RequestType = RequestTypeEnumVM.Success;
            Res.Data = new
            {
                UserInformation = GetUserinformation(User),
                AccessToken
            };

            //Save User FireBase Token
            if (string.IsNullOrEmpty(loginVM.FireBaseAccessToken))
                db.Users.Find(User.Id).FireBaseToken = null;
            else
                db.Users.Find(User.Id).FireBaseToken = loginVM.FireBaseAccessToken;
            db.SaveChanges();

            //return the token
            return Res;
        }

        internal static object GetUserinformation(User user)
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
                user.UserInformation.FirstName,
                user.UserInformation.MediumName,
                user.UserInformation.LastName,
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
        internal static bool UserIsEn(User user)
        {

            if (user.UserInformation == null) return false;
            if (user.UserInformation.Language == null) return false;
            if (user.UserInformation.Language.LanguageUsings == null) return false;
            if (user.UserInformation.Language.LanguageUsings.Count() == 0) return false;

            return user.UserInformation.Language.LanguageUsings.Where(c => c.IsDefault).First().LanguageType.Code == "ar" ? false : true;
        }

    }//end class
}
