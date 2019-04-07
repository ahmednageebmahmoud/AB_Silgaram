using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace DAL.Service
{
   public class UserService:IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        public   int GetCurrentUserId()
        {

           
                return db.Users.Where(x => x.UserName == HttpContext.Current.User.Identity.Name).Single().Id;
        }
        public   User GetCurrentUser()
        {
            if(HttpContext.Current.User.Identity.IsAuthenticated)
                return db.Users.Where(x => x.UserName == HttpContext.Current.User.Identity.Name).Single();

            return new User() { UserCulture = "ar" };
        }

        public List<int> GetCurrentUserRoles()
        {
            
            return db.Users.Where(x => x.UserName == HttpContext.Current.User.Identity.Name).Single().UserRoles.Select(c=> c.FkRole_Id).ToList();
        }

        public   User GetUser(int id)
        {
                return db.Users.Single(c=> c.Id== id);
        }

        public void Dispose()
        {
            db.Dispose();
        }

        public User GetUser(string emial)
        {
            return db.Users.Where(x => x.Email == emial).Single();
        }
    }
}
