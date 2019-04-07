using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;

namespace DAL.Service
{
   public static class EvaluationService
    {

        /// <summary>
        /// تقريب الترقيم الى اقرب رقم
        /// </summary>
        /// <param name="rate"></param>
        /// <returns></returns>
        public static decimal RateRounds(decimal rate)
        {

            if (rate > 0 && rate <= 1)
                return 1;
            if (rate > 1 && rate <= 1.5m)
                return 1.5m;

            if (rate > 1.5m && rate <= 2)
                return 2;
            if (rate > 2 && rate <= 2.5m)
                return 2.5m;

            if (rate > 2.5m && rate <= 3)
                return 3;
            if (rate > 3 && rate <= 3.5m)
                return 3.5m;

            if (rate > 3.5m && rate <= 4)
                return 4;
            if (rate > 4 && rate <= 4.5m)
                return 4.5m;

            if (rate > 4.5m && rate <= 5)
                return 2;

            return 1;
        }

        /// <summary>
        /// انشاء نتائج التقييم
        /// </summary>
        /// <param name="ad"></param>
    /*    internal static void CreateEvaluationResult(Ad ad)
        {
            //مجموع المقيمين
            int CountEvlu = ad.AdsEvaluations.Count();

            //مجموع الذين قيمو لأ معدل معين
            int CountUserRateStart1 = ad.AdsEvaluations.Where(c => c.Rate == 1).Count();
            int CountUserRateStart1_5 = ad.AdsEvaluations.Where(c => c.Rate == 1.5m).Count();

            int CountUserRateStart2 = ad.AdsEvaluations.Where(c => c.Rate == 2).Count();
            int CountUserRateStart2_5 = ad.AdsEvaluations.Where(c => c.Rate == 2.5m).Count();

            int CountUserRateStart3 = ad.AdsEvaluations.Where(c => c.Rate == 3).Count();
            int CountUserRateStart3_5 = ad.AdsEvaluations.Where(c => c.Rate == 3.5m).Count();

            int CountUserRateStart4 = ad.AdsEvaluations.Where(c => c.Rate == 4).Count();
            int CountUserRateStart4_5 = ad.AdsEvaluations.Where(c => c.Rate == 4.5m).Count();

            int CountUserRateStart5 = ad.AdsEvaluations.Where(c => c.Rate == 5).Count();

            ad.AdsEvaluationResult = new AdsEvaluationResult()
            {
                //نحسب النسبة الموئية التى رشحت هذا المنتج لـ تقيم ما
                Start1 = 100 * (CountUserRateStart1 / CountEvlu),
                Start1_5 = 100 * (CountUserRateStart1_5 / CountEvlu),

                Start2 = 100 * (CountUserRateStart2 / CountEvlu),
                Start2_5 = 100 * (CountUserRateStart2_5 / CountEvlu),

                Start3 = 100 * (CountUserRateStart3 / CountEvlu),
                Start3_5 = 100 * (CountUserRateStart3_5 / CountEvlu),

                Start4 = 100 * (CountUserRateStart4 / CountEvlu),
                Start4_5 = 100 * (CountUserRateStart4_5 / CountEvlu),

                Start5 = 100 * (CountUserRateStart5 / CountEvlu),
            };
        }*/


        /// <summary>
        /// تحدبث معدل التقيم
        /// </summary>
        /// <param name="ad"></param>
  /*      internal static void UpdateEvaluationResult(Ad ad)
        {
            if (ad.AdsEvaluationResult == null)
            {
                CreateEvaluationResult(ad);
                return;
            }

            //مجموع المقيمين
            int CountEvlu = ad.AdsEvaluations.Count();

            //مجموع الذين قيمو لأ معدل معين
            int CountUserRateStart1 = ad.AdsEvaluations.Where(c => c.Rate == 1).Count();
            int CountUserRateStart1_5 = ad.AdsEvaluations.Where(c => c.Rate == 1.5m).Count();

            int CountUserRateStart2 = ad.AdsEvaluations.Where(c => c.Rate == 2).Count();
            int CountUserRateStart2_5 = ad.AdsEvaluations.Where(c => c.Rate == 2.5m).Count();

            int CountUserRateStart3 = ad.AdsEvaluations.Where(c => c.Rate == 3).Count();
            int CountUserRateStart3_5 = ad.AdsEvaluations.Where(c => c.Rate == 3.5m).Count();

            int CountUserRateStart4 = ad.AdsEvaluations.Where(c => c.Rate == 4).Count();
            int CountUserRateStart4_5 = ad.AdsEvaluations.Where(c => c.Rate == 4.5m).Count();

            int CountUserRateStart5 = ad.AdsEvaluations.Where(c => c.Rate == 5).Count();

            //نحسب النسبة الموئية التى رشحت هذا المنتج لـ تقيم ما
            ad.AdsEvaluationResult.Start1 = 100 * (CountUserRateStart1 / CountEvlu);
            ad.AdsEvaluationResult.Start1_5 = 100 * (CountUserRateStart1_5 / CountEvlu);

            ad.AdsEvaluationResult.Start2 = 100 * (CountUserRateStart2 / CountEvlu);
            ad.AdsEvaluationResult.Start2_5 = 100 * (CountUserRateStart2_5 / CountEvlu);

            ad.AdsEvaluationResult.Start3 = 100 * (CountUserRateStart3 / CountEvlu);
            ad.AdsEvaluationResult.Start3_5 = 100 * (CountUserRateStart3_5 / CountEvlu);

            ad.AdsEvaluationResult.Start4 = 100 * (CountUserRateStart4 / CountEvlu);
            ad.AdsEvaluationResult.Start4_5 = 100 * (CountUserRateStart4_5 / CountEvlu);

            ad.AdsEvaluationResult.Start5 = 100 * (CountUserRateStart5 / CountEvlu);
        }
*/

    }//End Class
}
