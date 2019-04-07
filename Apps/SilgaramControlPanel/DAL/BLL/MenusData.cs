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
    public class MenusData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get Menu
        public object GetMenus()
        {
            var Menus = db.Menus.ToList();
            if (Menus.Count == 0)
                return null;
            return Menus.Select(x => new { x.Id, x.ClassIcon, x.OrderNumber, x.TokenValue }).ToList();
        }

 

        public void Dispose()
        {
            db.Dispose();
        }

        //Save Chenage
        public object SaveChenage(Menu[] menus)
        {
            UpdateS.db = db;
            try
            {
                foreach (Menu Menus in menus)
                {

                    if (Menus.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.Menu(Menus);
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
