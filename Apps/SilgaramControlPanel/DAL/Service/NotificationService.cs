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

            List<int> CurrentUserRoles = UserS.GetCurrentUserRoles();

            List<PagesRole> PagesAllowToCurrentUsere = db.PagesRoles.Where(c => (c.IsDisplay)
            && c.FkPageRoleTypes_Id == PagesRoleTypeEnumVM.Notifications
            && CurrentUserRoles.Any(v => v == c.FkRole_Id)
            && c.Page.IsControlPanel).ToList()
            .Select(c => new PagesRole() { FkPage_Id = c.FkPage_Id }).ToList();

            if (PagesAllowToCurrentUsere.Count == 0) return null;


            var Notifications = db.Histories.Where(c =>
            c.NotificationsIsReads.Any(v => v.FKUser_Id == userId) == false).ToList()
                .Where(c => PagesAllowToCurrentUsere.Any(b => b.FkPage_Id == c.FKPage_Id)).ToList();

            var PureNotifications = Notifications.OrderByDescending(v => v.Id).Skip(skip).Take(take).ToList();

            if (PureNotifications.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.NoMoreNotifications };


            var NotificationNotRead = PureNotifications.Select(c => new
            {
                c.Id,
                RedirectUrl = c.RedirectUrl == null ? null : c.RedirectUrl + "&notifyId=" + c.Id,
                c.State.CssClassIcon,
                c.State.CssClassStyle,
                ActionDate = DateService.CaltDateTimeNotify(c.DateTime),
                Notify = GetNotifyMessage(c.FkState_Id, c.User, c.Page.TokenValue, c.Titel),
                NotificationCount= Notifications.Count
            }).ToList();

        
            return NotificationNotRead;
        }

        public void ReadNotify(int? notifyId)
        {
            db.NotificationsIsReads.Add(new Models.NotificationsIsRead {
                FkHistory_Id= notifyId.Value,
                FKUser_Id= UserS.GetCurrentUserId()
            });
            db.SaveChanges();
        }

      
        string GetNotifyMessage(int stateId, User user, string page, string titel)
        {
            string UserName = user == null ? "" : user.UserName;

            if (stateId == StateEnumVM.Create)
                return string.Format("{0} \n {1} {2} {3} {4}", UserName, Token.HasCreatedThe, titel, Token.In, page);
            else if (stateId == StateEnumVM.Update)
                return string.Format("{0} \n {1} {2} {3} {4}", UserName, Token.HasUpdatedThe, titel, Token.From, page);
            else if (stateId == StateEnumVM.Delete)
                return string.Format("{0} \n {1} {2} {3} {4}", UserName, Token.HasDeletedThe, titel, Token.From, page);
            else if (stateId == StateEnumVM.Reject)
                return string.Format("{0} \n {1} {2} {3} {4}", UserName, Token.HasRejectThe, titel, Token.From, page);
            else if (stateId == StateEnumVM.Approve)
                return string.Format("{0} \n {1} {2} {3} {4}", UserName, Token.HasApproveTo, titel, Token.From, page);
            else if (stateId == StateEnumVM.Report)
                return string.Format("{0} \n {1} {2} {3} {4}", UserName, Token.HasReportTo, titel, Token.From, page);
            else if (stateId == StateEnumVM.Buy)
                return string.Format("{0} \n {1} {2} {3} {4}", UserName, Token.HasBuyThe, titel, Token.From, page);

            return null;
        }

        public object CheckIsAllowUserForNotify(int userId, int notifyId)
        {
            try
            {
                List<int> CurrentUserRoles = UserS.GetCurrentUserRoles();

                var Notify = db.Histories.Find(notifyId);

                if (Notify == null)
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotifyNotFound };



                var PageIsAllow = db.PagesRoles.Any(c =>
                c.IsDisplay == true
                && c.FkPage_Id == Notify.FKPage_Id
                && c.FkPageRoleTypes_Id == PagesRoleTypeEnumVM.Notifications
                && CurrentUserRoles.Any(v => v == c.FkRole_Id)
                );

                if (!PageIsAllow)
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.YouNotAllowedShowThisNotify };

                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.NotifyNotFound };
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        //Get Notifications For Application
        public object GetNotificationsForApplication(int userId, int skip, int take)
        {
            return new ResponseVM {RequestType=RequestTypeEnumVM.Success,IsData=true,Data= null };
        }

        private object GetNotifyName(int stateId,  ICollection<HistoryDetail> historyDetails)
        {
            string Name = string.Empty;

            //Check Is Add HistoryDetails
            if (historyDetails != null)
            {
                if (historyDetails.Count > 0)
                    //Check Basiclly Is Add Name
                    if (historyDetails.Any(c => c.ColumResourceName.ToLower().Contains("name")))
                    {
                        //Check Name Is Single
                        if (historyDetails.Any(c => c.ColumResourceName.ToLower().Contains("name") && c.CoulmIsSingl == true))
                        { //Add Value Single 
                            Name = historyDetails.Where(c => c.ColumResourceName.ToLower().Contains("name") && c.CoulmIsSingl == true).First().ColumNewContent;
                        }
                        else
                        { //Add Value By UserLanguage
                            var History = historyDetails.Where(c => c.ColumResourceName.ToLower().Contains("name") && c.CoulmIsEn == LanguageService.IsEn).First();
                            Name = History.ColumNewContent != null ? History.ColumNewContent : History.ColumOldContent;
                        }
                    }
                    else
                    { //Add Any Value
                        Name = historyDetails.First().ColumNewContent != null ? historyDetails.First().ColumNewContent : historyDetails.First().ColumOldContent;
                    }
            }
            else
            {
                Name = "";
            }


            return Name;
        }
    }//End Class
}
