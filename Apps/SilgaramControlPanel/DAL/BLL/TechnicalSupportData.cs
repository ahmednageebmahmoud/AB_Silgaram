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
    public class TechnicalSupportData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        UserService UserS = new UserService();
        CreateService CreateS = new CreateService();

        //Get TechnicalSupport
        public object GetTechnicalSupport(int CoutnContactUGet, int CoutnContactUSkip) {
            var TechnicalSupports = db.TechnicalSupports.OrderByDescending(c=> c.Id).Skip(CoutnContactUSkip).Take(CoutnContactUGet).ToList();

            if (TechnicalSupports.Count == 0)
                return new ResponseVM {RequestType=RequestTypeEnumVM.Info,Message=Token. DataNotFound};
            return TechnicalSupports.Select(x => new
            {
                x.Id,
                Date = DateService.GetDateTimeByCulture(x.CreateDateTime),
                UsreReadMessage = x.TechnicalSupportReads.Select(c => new { ImageUrl = c.User.UserInformation.File.FullFileUrl, c.User.FullName }).ToList(),
                x.Message,
                x.Email,
                x.Phone,
                x.UserName,
            }).ToList();
        }

        public object CreateTechnicalSupport(TechnicalSupportVM technicalSupport)
        {
            try
            {
                CreateS.db = db;

                var ObjectReturn = CreateS.CreateTechnicalSupport(technicalSupport);
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();
                return new ResponseVM {RequestType=RequestTypeEnumVM.Success,Message=Token.Created };
            } 
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.NotCreated, InnerException=ex.InnerException };

            }
        }

        //Get   Technical Support Notifications
        public object GetTechnicalSupportForNotifications(int userId, int skip, int take)
        {
            var TechnicalSupports = db.TechnicalSupports.Where(c=> !c.TechnicalSupportReads.Any(b=> b.FkUser_Id==userId)).OrderByDescending(c => c.Id).Skip(skip).Take(take).ToList();

            if (TechnicalSupports.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };
            return TechnicalSupports.Select(x => new
            {
                x.Id,
                RedirectUrl = "/TechnicalSupport/Read?id=" + x.Id,
                Date = DateService.CaltDateTimeNotify(x.CreateDateTime),
                 x.UserName,
                 x.Message,
                TechnicalSupportCount= TechnicalSupports.Count
            }).ToList();
        }

        //Get Technical Support Details
        public object GetTechnicalSupportDetails(int contactUsId)
        {
            var TechnicalSupport = db.TechnicalSupports.Find(contactUsId);

            if (TechnicalSupport == null)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.TechnicalSupportFound };

            if (!PageService.GetPageAllow(PageEnumVM.TechnicalSupports).IsAllowNotify)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.YouNotAllowedShowTheTechnicalSupportMessage };



            //Set Current User Read This TechnicalSupport
            if (!TechnicalSupport.TechnicalSupportReads.Any(c => c.FkUser_Id == UserS.GetCurrentUserId()))
            {
                TechnicalSupport.TechnicalSupportReads.Add(new TechnicalSupportRead()
                {
                    FkUser_Id = UserS.GetCurrentUserId(),
                });
            db.SaveChanges();
            }


            return new
            {
                TechnicalSupport.UserName,
                TechnicalSupport.Message,
                TechnicalSupport.Phone,
                Date= DateService.GetDateTimeByCulture(TechnicalSupport.CreateDateTime),
                TechnicalSupport.Email,
            };
        }

        public void Dispose()
        {
            db.Dispose();
            UserS.Dispose();
        }
    }//End Class
}
