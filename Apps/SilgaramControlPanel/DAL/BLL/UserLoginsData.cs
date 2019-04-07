using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Bll
{
    public class UserLoginsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        CheckedService CheckedS = new CheckedService();

        //Get User Logins
        public object GetUserLogins(string serial, int take, int skip)
        {
            if (!CheckedS.Serial(serial))
                return false;
            var UserLogins = db.Users.Where(c => c.Serial == serial).Single().UserLogins.OrderByDescending(c => c.Id).ToList();
            if (skip > UserLogins.Count)
                return null;
            return UserLogins.Skip(skip).Take(take).Select(x => new { x.Id, x.User.FullName, x.User.UserName, x.IsSuccess, LoginDate = DateService.GetDateByCulture(x.LoginDate) }).ToList();
        }



        public void Dispose()
        {
            db.Dispose();
            CheckedS.Dispose();
               }
    }//End Class
}
