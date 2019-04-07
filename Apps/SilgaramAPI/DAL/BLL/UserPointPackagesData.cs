using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using KnPayPayment.Models;
using KnPayPayment.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Bll
{
    public class UserPointPackagesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();
        List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();

        //Get PointPackages
        public object GetUserPointPackages(int skip, int take)
        {
            var User = db.Users.Find(AccessToken.GetUserId());
            if (User == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.UserNotFound);

            var UserPointPackages = User.UserPointPackages.OrderByDescending(c => c.Id).Skip(skip).Take(take);

            if (UserPointPackages.Count() == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.NoDataMore };



            return new
            {

                UserPointPackages = UserPointPackages.Select(x => new
                {
                    x.Id,
                    BuyDateTime = DateService.GetDateByCulture(x.BuyDateTime),
                    x.Price,
                    x.Points,
                    PointPackage = new
                    {
                        x.PointPackage.PointPackageName,
                        CuurentPrice = x.Price,
                    },
                }).ToList()
            };
        }


        //Post Point Package Buy
        public object BuyPointPackage(int pointPackageId, bool isCredit)
        {
            try
            {
                PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.UserPointPackages);

                var Usere = db.Users.Find(AccessToken.GetUserId());
                var PointPackage = db.PointPackages.Find(pointPackageId);

                if (PointPackage == null)
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.PointPackageFound };

                //generate payment url
                PaymentInfromation PayInformation =
                PaymentService.InitializePayment_Email(
                     PointPackage.Price, Usere.UserName, Usere.Email, isCredit);

                if (PayInformation.error)
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = PayInformation.msg };

                UserPointPackage UserPurchas = new UserPointPackage(){Payment = new Payment() {

                    Hash= PayInformation.Hash
                } };

                CreateS.db = db;
                //Create
                var ObjectReturn = CreateS.PointPackageBuy(PointPackage, UserPurchas, PageAllow, Usere.Serial);
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();

                return new ResponseVM(RequestTypeEnumVM.Success, Token.BuyingSucceeded, PayInformation);
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, InnerException = ex.InnerException };

            }
        }

        /*
         فى هذة الدالة سوف نتحقق من الدفع ثم وتزويد نقاط المستخدم
             */
        public object CheckPay(string orderId)
        {
            try
            {
                var User = db.Users.Find(AccessToken.GetUserId());
                int PaymentId = Convert.ToInt32(orderId.Split('-')[1]);
                var Payment = new PaymentVM();
                int Points = 0;
                string BuyDateTime = string.Empty;

                var UserPointPackage = db.UserPointPackages.Where(c => c.FkPayment_Id == PaymentId).SingleOrDefault();

                if (UserPointPackage == null)
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.PaymenNotFound };

                //الان نتحقق من عملية الدفع هل كانت مع الباقات او    
                if (UserPointPackage.FkUser_Id != User.Id)
                    return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.ThisNotForU };

                Points = UserPointPackage.Points;
                BuyDateTime = DateService.GetDateTimeByCulture(UserPointPackage.BuyDateTime);

                db.SaveChanges();
                return new ResponseVM(RequestTypeEnumVM.Success, Token.Success, new
                {
                    //بيانات الدفع المسجلة
                    Points,
                    BuyDateTime,
                    //بيانات الدفع الحقيقية
                    PaymentInfromation = Payment
                });



            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotPaid, InnerException = ex.InnerException };

            }
        }
        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
