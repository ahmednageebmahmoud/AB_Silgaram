using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Service
{
    public class AdService
    {

        /// <summary>
        /// اعادة نشر الاعلانات الذى انتهت
        /// </summary>
        /// <param name="ads">الاعلانات</param>
        /// <param name="daysPeriod">عدد ايام عمر الاعلان</param>
        /// <returns></returns>
        public static bool AdsAutoPost(List<Ad> ads, string daysPeriod)
        {


            int DaysPeriod = 0;

            //التحقق من عدد ايام عمر الاعلان
            if (string.IsNullOrEmpty(daysPeriod) || int.TryParse(daysPeriod, out DaysPeriod) || DaysPeriod <= 0)
                return false;

            //جلب الاعلانات المسمحو لها فقط بـ اعادة النشر ويجب ان تكون تمت الموافقة عليها
            //ولا ننس ان يكون المستخدم متوافر عندة النقاط
            var AdsFinshed = ads.Where(c => c.IsApprove && c.IsAutoPost && c.User.Points > 0).ToList();

            //اتحقق من عددهم
            if (AdsFinshed.Count == 0)
                return false;

            //اعادة فلترة وجلب فقط الذى انتهى
            AdsFinshed = AdsFinshed.Where(c => c.IsFinshed).ToList();
            if (AdsFinshed.Count == 0)
                return false;

            //الان نقوم بـ اعادة النشر
            AdsFinshed.ForEach(ad =>
            {

                ad.StartDateTime = DateTime.Now;
                ad.EndDateTime = DateTime.Now.AddDays(DaysPeriod);
                ad.CountAutoPostToNow++;
                //حذف نقطة من نقاط المستخدم
                ad.User.Points--;
            });

            return true;
        }

        /// <summary>
        /// اعادة نشر الاعلان الذى انتهى
        /// </summary>
        /// <param name="ad">الاعلان</param>
        /// <param name="daysPeriod">عدد ايام الاعلان</param>
        /// <returns></returns>

        public static bool AdAutoPost(Ad ad, string daysPeriod)
        {

            if (ad.User.Points == 0) return false;
            int DaysPeriod = 0;

            //التحقق من عدد ايام عمر الاعلان
            if (string.IsNullOrEmpty(daysPeriod) || int.TryParse(daysPeriod, out DaysPeriod) || DaysPeriod <= 0)
                return false;


            //التحقق من الشروط الذى يجب توافرها من اجل اعادة عرض الاعلان
            if (!ad.IsAutoPost || ad.IsApprove || !ad.IsFinshed)
                return false;

            //الان نقوم بـ اعادة النشر
            ad.StartDateTime = DateTime.Now;
            ad.EndDateTime = DateTime.Now.AddDays(DaysPeriod);
            ad.CountAutoPostToNow++;
            //Delete 1 point form user points
            ad.User.Points--;
            return true;
        }
    }
}
