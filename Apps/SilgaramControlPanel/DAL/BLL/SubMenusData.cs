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
    public class SubMenusData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get SubMenu
        public object GetSubMenus()
        {
            var SubMenus = db.SubMenus.ToList();
            if (SubMenus.Count == 0)
                return null;
            return SubMenus.Select(x => new { x.Id, x.ClassIcon, x.OrderNumber, x.SubMenuName ,x.FkMenu_Id}).ToList();
        }

 

        public void Dispose()
        {
            db.Dispose();
        }

        //Save Chenage
        public object SaveChenage(SubMenu[] menus)
        {
            UpdateS.db = db;
            try
            {
                foreach (SubMenu subMenu in menus)
                {

                    if (subMenu.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.SubMenu(subMenu);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                     
                }
                db.SaveChanges();
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved };
            }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange };
            }
        }

    }//End Class
}
