using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
using System.Text.RegularExpressions;
using DAL.Models.ViewModel;
using DAL.Resource;

namespace DAL.Service
{
    public class NotificationService : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();

        UserService UserS = new UserService();


        public void Dispose()
        {
            UserS.Dispose();
            db.Dispose();
        }

        public object GetNotifications(int userId, int skip, int take)
        {

            var Notifications = db.UsersPrivateNotifies.Where(c =>
           ! c.History.NotificationsIsReads.Any(v => v.FKUser_Id == userId)).ToList();

            //جلب العدد المحدد
            var PureNotifications = Notifications.OrderByDescending(v => v.Id).Skip(skip).Take(take).ToList();

            if (PureNotifications.Count == 0)
                return new ResponseVM ( RequestTypeEnumVM.Error, Token.NoMoreNotifications );


            var NotificationNotRead = PureNotifications.Select(c => new
            {
                c.Id,
                ActionDate = DateService.CaltDateTimeNotify(c.History.DateTime),
                Title = GetNotifyTitle( c.History.FkState_Id),
                Message = c.History.Title,
                NotificationCount= Notifications.Count

            }).ToList();

            return new ResponseVM(RequestTypeEnumVM.Error, Token.Success, NotificationNotRead);
        }

        public void ReadNotify(int? notifyId)
        {
            db.NotificationsIsReads.Add(new Models.NotificationsIsRead {
                FkHistory_Id= notifyId.Value,
                FKUser_Id= UserS.GetCurrentUserId()
            });
            db.SaveChanges();
        }

        public object ClintReadNotify(int? notifyId)
        {
            try
            {
                if (db.Histories.Find(notifyId) == null)
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.NotifyNotFound };

                db.NotificationsIsReads.Add(new Models.NotificationsIsRead
                {
                    FkHistory_Id = notifyId.Value,
                    FKUser_Id = AccessToken.GetUserId()
                });

                db.SaveChanges();
                return new ResponseVM {RequestType=RequestTypeEnumVM.Success,Message=Token.Saved };
            }
            catch (Exception ex)
            {
                return new ResponseVM {RequestType=RequestTypeEnumVM.Error,Message=Token.Error,InnerException=ex.InnerException };
            }
        }

        string GetNotifyTitle(int stateId)
        {
            if (stateId == StateEnumVM.Buy)                                 
                return  Token.RequestBuyAd;

            return null;
        }


   
    }//End Class
}
