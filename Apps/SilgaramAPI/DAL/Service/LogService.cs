using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
using DAL.Models.ViewModel;

namespace DAL.Service
{
    public class LogService
    {
        internal static ICollection<HistoryDetail> CheckHistoryDetails(List<HistoryDetailVM> historyDetails)
        {
            List<HistoryDetail> HistoryDetails = new List<HistoryDetail>();

            foreach (var log in historyDetails)
            {
                if(log.ColumResourceName.ToLower().Contains("name")|| log.ColumResourceName.ToLower().Contains("title") && (log.ColumNewContent == log.ColumOldContent)&& !log.CoulmIsSingl)
                {
                    /*
                  *  If this condetion on the object name and not user any deiffreent in data add ColumNewContent == name value 
                 * Must be set name becuse show in notification title      
                 */
                    HistoryDetails.Add(new HistoryDetail
                    {
                       // ColumNewContent = log.ColumNewContent,
                        ColumResourceName = log.ColumResourceName,
                        ColumOldContent = log.ColumOldContent,
                        CoulmIsEn = log.CoulmIsEn,
                        CoulmIsSingl = log.CoulmIsSingl,
                    });
                }
                else if(log.ColumNewContent != log.ColumOldContent)
                    HistoryDetails.Add(new HistoryDetail
                    {
                        ColumNewContent = log.ColumNewContent,
                        ColumResourceName = log.ColumResourceName,
                        ColumOldContent = log.ColumOldContent,
                        CoulmIsEn = log.CoulmIsEn,
                        CoulmIsSingl = log.CoulmIsSingl,
                    });
            }

            //Check Is Data Diffrent
            /*
             هذا التحقق يستخدم فى حالة التحديث .. 
             ولكى يتم وضع اشعار بالتحديث فيجب ان يكون هناك تحديثات 
             وهذا ما سوف نفعلة نتحقق ان توجد تحديثات بغض النظر عن اسماء الاوبجكت
             وهى تستخدم فى العمليات التحديث الذى تكون فى صفحة منفصلة
             */
            if(HistoryDetails.Where(c=> c.ColumNewContent == null&&!c.CoulmIsSingl|| c.ColumNewContent != null && c.CoulmIsSingl).Count()>0 && HistoryDetails.Where(c => c.ColumNewContent != null&&c.ColumOldContent!=null).Count()==0)
            {
                /*
             معنى ذالك ان الليستة تحتوى فقط على السجلات التى تحتوى على اسم الاوبجكت لكى يعرض فى الاشعارات ..اذا لا يوجد اختلاف فى الداتا يعنى لا يوجد تحديثات    
             
             */
                return null;

            }

            return HistoryDetails;
        }
        internal static ICollection<HistoryDetail> CheckHistoryDetailsForCreateOrDelete(List<HistoryDetailVM> historyDetails)
        {
            List<HistoryDetail> HistoryDetails = new List<HistoryDetail>();

            foreach (var log in historyDetails)
            {
                    HistoryDetails.Add(new HistoryDetail
                    {
                        ColumNewContent = log.ColumNewContent,
                        ColumResourceName = log.ColumResourceName,
                        ColumOldContent = log.ColumOldContent,
                        CoulmIsEn = log.CoulmIsEn,
                        CoulmIsSingl = log.CoulmIsSingl,
                    });
            }
            return HistoryDetails;
        }

    }//End Class
}
