using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
using System.Text.RegularExpressions;
using System.Web;
using DAL.Models.ViewModel;

namespace DAL.Service
{
    public class MenuService : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        UserService UserS = new UserService();




        public void Dispose()
        {
            db.Dispose();
            UserS.Dispose();
        }

       
        public object GetControlPanelMenu()
        {
            List<int> CurrentUserRoles = UserS.GetCurrentUserRoles();
            List<PagesRole> PagesAllowToCurrentUsere = new List<PagesRole>();

            //اذا كان لدية صلاحية مدير فلا يطبق علية الشروط والاحام
            if (CurrentUserRoles.Any(c => c == RoleEnumVM.Manager))
            {
                PagesAllowToCurrentUsere = db.PagesRoles.ToList().Select(c => new PagesRole() { FkPage_Id = c.FkPage_Id }).ToList();
            }
            else
            {
                PagesAllowToCurrentUsere = db.PagesRoles.Where(c => (c.IsCreate || c.IsDelete || c.IsDisplay || c.IsUpdate)
                 && c.FkPageRoleTypes_Id == PagesRoleTypeEnumVM.Management
                 && CurrentUserRoles.Any(v => v == c.FkRole_Id)
                 && c.Page.IsControlPanel).ToList()
                 .Select(c => new PagesRole() { FkPage_Id = c.FkPage_Id }).ToList();

                if (PagesAllowToCurrentUsere.Count == 0) return null;
            }




            //Get Menu and sub Menue if this sub menu page allow to user 
            var Menus = db.Menus.ToList();
            var FullMenu = Menus.Select(c => new
            {
                //Fill Menu
                MenuName = c.TokenValue,
                OrderNumber = c.OrderNumber,
                ClassIcon = c.ClassIcon,
                //Fill Sub Menu
                SubMenus = c.SubMenus.Where(v => PagesAllowToCurrentUsere.Any(b => b.FkPage_Id == v.FKPage_Id)).Select(v => new {
                    v.OrderNumber,
                    SubMenuName = v.Page.TokenValue,
                    Url = v.Page.Url,
                    v.ClassIcon
                }).ToList()
            }).ToList();

            return FullMenu;
        }
 


    }//End Class
}
