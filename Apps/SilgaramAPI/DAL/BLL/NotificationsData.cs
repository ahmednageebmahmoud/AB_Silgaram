using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Bll
{
    public class NotificationsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;

        //Get Notify
        public object GetNotify(int notifyId,int userId)
        {
            var Notify = db.Histories.Find(notifyId);

            //Set Notify Read
            if (!Notify.NotificationsIsReads.Any(c => c.FKUser_Id == userId))
            {
                Notify.NotificationsIsReads.Add(new NotificationsIsRead {
                    FKUser_Id=userId,
                });
                db.SaveChanges();
            }


            string NameAction = "", 
                PageName = "",
                NameObject = "",
                UserName = db.Users.Find(Notify.FkUser_Id).UserName;

            PageName = Notify.Page.TokenValue;
            NameAction = Notify.State.TokenValue;

            //Check Is Add HistoryDetails
            if (Notify.HistoryDetails != null)
            {
                //Check Basiclly Is Add Name
                if (Notify.HistoryDetails.Any(c => c.ColumResourceName.ToLower().Contains("name")))
                {
                    //Check Name Is Single
                    if (Notify.HistoryDetails.Any(c => c.ColumResourceName.ToLower().Contains("name") && c.CoulmIsSingl == true))
                    { //Add Value Single 
                        NameObject = Notify.HistoryDetails.Where(c => c.ColumResourceName.ToLower().Contains("name") && c.CoulmIsSingl == true).First().ColumNewContent;
                    }
                    else
                    { //Add Value By UserLanguage
                        var History = Notify.HistoryDetails.Where(c => c.ColumResourceName.ToLower().Contains("name") && c.CoulmIsEn == LanguageService.IsEn).First();
                        NameObject = History.ColumNewContent != null ? History.ColumNewContent : History.ColumOldContent;
                    }
                }
                else
                { //Add Any Value
                    NameObject = Notify.HistoryDetails.First().ColumNewContent != null ? Notify.HistoryDetails.First().ColumNewContent : Notify.HistoryDetails.First().ColumOldContent;
                }
            }
            else
            {
                NameObject = "";
            }

            var HistoryDetails = Notify.HistoryDetails.ToList();

            if (Notify.FkState_Id == StateEnumVM.Delete)
            {
                return new
                {
                    PageName,
                    UserName,
                    NameAction,
                    NameObject,
                    Heading = NameAction + " " + PageName,
                    Notify.FkState_Id,
                    Date = DateService.GetDateByCulture(Notify.DateTime),
                    Time = Notify.DateTime.ToShortTimeString(),
                    Notify.State.CssClassIcon,
                };

            }
            else
            if (Notify.FkState_Id == StateEnumVM.Create)
            {
                return new
                {
                    PageName,
                    UserName,
                    NameAction,
                    NameObject,
                    Heading = NameAction + " " + PageName,
                    Notify.FkState_Id,
                    Date = DateService.GetDateByCulture(Notify.DateTime),
                    Time = Notify.DateTime.ToShortTimeString(),
                    Notify.State.CssClassIcon,
                    /*
					 قد مثلا يتم وضع العدد او خلافة
					 */
                    HistoryDetails = HistoryDetails.
                    /*
					 الان احنا نريد الداتا على حسب لغة المستخدم فى النظام 
					 اذا هنا ك تحديد للغة نخرج الاوبجكت على حسب لغة المتصفح
					 اذا كان لم يكن هناك تحديد للغة فنعطى القيمة ترو لينتقل الى خطوة السيلكت
					 */
                    Where(c => c.CoulmIsEn ? (c.CoulmIsEn == IsLanguageEnglish) : true).Select(c => new
                    {
                        c.ColumNewContent,
                        ColumnName = ResourceService.GetToken(c.ColumResourceName)
                    }).ToList()
                };
            }
            else
            if (Notify.FkState_Id == StateEnumVM.Update)
            {
                return new
                {
                    PageName,
                    UserName,
                    NameAction,
                    NameObject,
                    Heading = NameAction + " " + PageName,
                    Notify.FkState_Id,
                    Date = DateService.GetDateByCulture(Notify.DateTime),
                    Time = Notify.DateTime.ToShortTimeString(),
                    Notify.State.CssClassIcon,
                    /*
					 قد مثلا يتم وضع العدد او خلافة
					 */
                    HistoryDetails =
                    /*
					 الان احنا نريد الداتا على حسب لغة المستخدم فى النظام 
					 اذا هنا ك تحديد للغة نخرج الاوبجكت على حسب لغة المتصفح
					 اذا كان لم يكن هناك تحديد للغة فنعطى القيمة ترو لينتقل الى خطوة السيلكت
					 */
                     GetHistoryDetails(HistoryDetails)
                };
            }
        
            return null;
        }


        List<object> GetHistoryDetails(IEnumerable<HistoryDetail> historyDetails)
        {
            List<object> HistoryDetails = new List<object>();

            foreach (var histor in historyDetails)
            {
                //Is Single 
                if (histor.CoulmIsSingl)
                {
                    HistoryDetails.Add(new
                    {
                        ColumNewContent = histor.ColumNewContent,
                        ColumOldContent = histor.ColumOldContent,
                        ColumnName = ResourceService.GetToken(histor.ColumResourceName)
                    });
                }
                //Is ColumResourceName Contines "en" 
                else if (histor.ColumResourceName.ToLower().Contains("en") || histor.ColumResourceName.ToLower().Contains("ar"))
                {
                    if (IsLanguageEnglish == histor.CoulmIsEn)
                        HistoryDetails.Add(new
                        {
                            ColumNewContent = histor.ColumNewContent,
                            ColumOldContent = histor.ColumOldContent,
                            ColumnName = ResourceService.GetToken(histor.ColumResourceName)
                        });
                }
            }

       return HistoryDetails;
                    }
        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
