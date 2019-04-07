using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;

namespace DAL.Service
{
    public class DeleteService:IDisposable
    {
        public SilgaramEntities db;// = new ControlePanel();
        List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();
        public int UserId { get { return new UserService().GetCurrentUserId(); } }
        public void Dispose()
        {
         //   db.Dispose();
        }

        //Ad Delete
        internal object Ad(AdVM ad, PagesAllow pageAllow)
        {

            var AdRemove = db.Ads.Find(ad.Id);

            if (AdRemove == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.AdNotFound);

            //نتحقق انة نفس المستخدم يريد حذف الاعلان 
            if (UserId != AdRemove.FkUser_Id)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.YouNotCreatedThisAd };


            //Check With Notify only
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Title", AdRemove.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", AdRemove.Description, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Price", AdRemove.Price.ToString(), true, false));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleAr=AdRemove.Title,
                    TitleEn=AdRemove.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Ads,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }

            //remove Images 
            FileService.RemoveFiles(AdRemove.Album.AlbumFiles.ToList());

            //Remove Log
           // db.Histories.RemoveRange(AdRemove.Log.Histories);
         //   db.Logs.Remove(AdRemove.Log);

            //Remove Ad
            db.Ads.Remove(AdRemove);

            return null;
        }



    }//End Class
}
