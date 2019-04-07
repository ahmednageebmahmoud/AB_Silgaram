using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
using DAL.Models.ViewModel;

namespace DAL.Service
{
   public class PageService
    {
        //Get Page Role
        public static PagesRole GetPageRole(int page)
        {
            using (SilgaramEntities db=new SilgaramEntities())
            {

                List<int> UserRoles = new UserService().GetCurrentUserRoles();

                //Ceck is Role 
                if(UserRoles.Any(c=> c==RoleEnumVM.Manager))
                    return new PagesRole()
                    {
                        IsCreate = true,
                        IsDisplay = true,
                        IsDelete = true,
                        IsUpdate = true,
                    };

                /*
                 يمكن ان يكون للمستخدم اكتر من صلاحية فبذالك يجب جلب الكل
                 */
                var PagesRole = db.PagesRoles.Where(c => c.FkPage_Id == page&&c.FkPageRoleTypes_Id==PagesRoleTypeEnumVM.Management&& UserRoles.Any(v=> v== c.FkRole_Id)).ToList();

                if (PagesRole.Count==0)
                    return new PagesRole()
                    {
                        IsCreate = false,
                        IsDisplay = false,
                        IsDelete = false,
                        IsUpdate = false,
                    };


                /*
                 هنا نسمح للمستخم بـ اجراء اى شىء بدام لدية موافقة فى احدى الحقول مع احدى الصلاحيات الخاصة بة
                 */
                return new  PagesRole()
                {
                    IsCreate= PagesRole.Any(v=> v.IsCreate),
                     IsDisplay= PagesRole.Any(v => v.IsDisplay),
                     IsDelete= PagesRole.Any(v => v.IsDelete),
                     IsUpdate= PagesRole.Any(v => v.IsUpdate),
                };
            }
        }

        //Get Page Allow
        internal static PagesAllow GetPageAllow(int page)
        {
            using (SilgaramEntities db = new SilgaramEntities())
            {
                var PagesAllow = db.PagesAllows.Where(c => c.FkPage_Id == page ).SingleOrDefault();
                if (PagesAllow == null)
                    return new PagesAllow();

                return new PagesAllow()
                {
                    IsAllowLog = PagesAllow.IsAllowLog,
                    IsAllowNotify = PagesAllow.IsAllowNotify,
                };
            }
        }
    }
}
