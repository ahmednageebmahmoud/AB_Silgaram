using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.Security;

namespace ControlPanel.Providers
{
    public class CustomRoleProvider : RoleProvider
    {
        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }

            set
            {
                throw new NotImplementedException();
            }
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetRolesForUser(string username)
        {//الهدف من هذا الكود جلب الرول من قاعدة البيانات اذا لم توجد فى الكاش 
            //واذا موجودة فى الكاش فلا داع لاجلبها من قاعدة البيانات 
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
                return null;

            //check cache 
            var cacheKey = string.Format("{0}_role", username);//sezer_role
            if (HttpRuntime.Cache[cacheKey]!=null)
            {//اذا يوجد نرجع الصلحيات من الكاش 
                return (string[])HttpRuntime.Cache[cacheKey];
            }
            //معنى ذاالك انة لا يوجد صلحيات فى الكاش ويجب جلبها من قاعدة البايانات
            string[] roles = new string[] { };
            using (SilgaramEntities db = new SilgaramEntities())
            {
                roles = db.UserRoles.Where(x => x.User.UserName == username).Select(x => x.Role.ResourceName).ToArray();
                if (roles.Count() > 0)
                {//بعد جلبهاا نقوم بحقظها فى الكاش لمدة 20 دقيقة من الان من اجل المرات القادمة
                    HttpRuntime.Cache.Insert(cacheKey, roles, null, DateTime.Now.AddMinutes(20), Cache.NoSlidingExpiration);
                }
            }
            return roles;    

        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            var roles = GetRolesForUser(username);
            return roles.Contains(roleName);
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}
