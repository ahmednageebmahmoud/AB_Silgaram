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
    public class PagesRolesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Pages Allow
        public object GetPagesRoles(int pageId)
        {
            var PagesRoles= db.PagesRoles.Where(c=> c.FkPage_Id== pageId).ToList();
            if (PagesRoles.Count == 0)
                return null;
            return PagesRoles.Select(x => new { x.Id,

                PageName =x.Page.TokenValue,
                RoleName=x.Role.TokenValue,
                PageRoleTypeName=x.PagesRoleType.TokenValue,
                x.IsCreate, x.IsDelete,x.IsDisplay,x.IsUpdate, x.FkPage_Id ,
            x.FkPageRoleTypes_Id}).ToList();
        }



        //Save Chenage
        public object SaveChenage(PagesRole[] pagesAllows)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.PagesRoles);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;

            try
            {
                foreach (PagesRole PagesRole in pagesAllows)
                {
                    if (PagesRole.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.PagesRole(PagesRole, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                   
                }
                db.SaveChanges();
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved};
            }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message =Token.NotSaveChange };
            }
        }

        public void Dispose()
        {
            db.Dispose();
            DeleteS.Dispose();
            UpdateS.Dispose();
            CreateS.Dispose();
               }
    }//End Class
}
