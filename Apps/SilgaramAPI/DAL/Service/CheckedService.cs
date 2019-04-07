using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
using System.Text.RegularExpressions;
using System.Net.Mail;
using DAL.Models.ViewModel;

namespace DAL.Service
{
    public class CheckedService : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();

        public void Dispose()
        {
            db.Dispose();
        }

        /// <summary>
        /// Check Serial Number is With User
        /// </summary>
        /// <param name="serial"></param>
        /// <returns></returns>
        internal bool Serial(string serial)
        {
            return db.Users.Any(c => c.Serial == serial);
        }

        /// <summary>
        /// for login
        /// </summary>
        /// <param name="Email"></param>
        /// <param name="password"></param>
        /// <returns>bool</returns>
        public bool EmailPasswordIsValid(string email, string password)
        {
            return db.Users.Any(c => c.Email == email && c.Password == password);

        }

        public bool Roles(ICollection<UserRole> userRoles, int[] rolesId)
        {
                bool Checked = false;
                foreach (var roleId in rolesId)
                {
                    bool IsRole = userRoles.Any(c => c.FkRole_Id == roleId);
                    if (IsRole)
                        Checked = true;
                }

                return Checked;
        }


        /// <summary>
        /// For Confirm if User Blocked
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        internal bool IsUserBlocked(string email, string password)
        {
            return db.Users.Where(c => c.Email == email && c.Password == password).Single().IsBlocked;

        }

        public bool ConfirmNewPassword(int userId,string newPassword)
        {
            return db.Users.Where(x => x.Id == userId).Any(x => x.Password == newPassword);
        }

        /// <summary>
        /// Number Valid By Regx
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        internal bool NumberValid(string number)
        {
            return Regex.IsMatch(number, @"\d");
        }

        internal bool EmailIsCorrect(string email)
        {

            try
            {
                MailAddress m = new MailAddress(email);

                return true;
            }
            catch (FormatException)
            {
                return false;
            }
        }


        /// <summary>
        /// If Bedor Use Return (True) If Available For Use Return (False
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <returns></returns>
        internal bool PhoneNumberLoginIsNotAvailable(string phoneNumber)
        {
            return db.UserInformations.Any(x => x.PhoneNumber == phoneNumber );
        }

        /// <summary>
        /// التحقق هل يمكن استخدام اسم المستخدم وم لاء
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        internal bool UserNameIsNotAvailable(string userName)
        {
            return db.Users.Any(x => x.UserName == userName);
        }

        /// <summary>
        /// التحقق  هل يمكن للميل ان يستخدم ام لاء
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        internal bool EmailIsNotAvailable(string email)
        {
            return db.Users.Any(x => x.Email == email);
        }

        /// <summary>
        /// التاكد من معلومات تسجيل الدخول للمستخدم 
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        internal bool SignInByPhone(string PhoneNumber, string password)
        {
            return db.Users.Any(c => c.UserInformation.PhoneNumber== PhoneNumber  && c.Password == password);
        }
        
        /// <summary>
        /// التحقق من حالة حظر المستخدم
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        internal bool IsUserBlockedByPhone(string phoneNumber, string password)
        {
            return db.Users.Single(c => c.UserInformation.PhoneNumber== phoneNumber && c.Password == password).IsBlocked;
        }

        /// <summary>
        /// التاكد من معلومات تسجيل الدخول للمستخدم 
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        internal bool SignInByEmail(string email, string password)
        {
            return db.Users.Any(c => c.Email==email && c.Password == password);

        }

        /// <summary>
        /// التحقق ان النص اقل من او يساوى اكبر قيمة
        /// </summary>
        /// <param name="value"></param>
        /// <param name="maxLength"></param>
        /// <returns></returns>
        internal bool CheckMaxLength(string value,int maxLength)
        {
            return value.Length > maxLength;
        }


    }//End Class
}
