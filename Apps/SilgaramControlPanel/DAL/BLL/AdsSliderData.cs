using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Models.ViewModels;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Bll
{
    public class AdsSliderData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get AdsSlider
        public object GetAdsSlider()
        {
            var AdsSlider = db.AdsSliders.OrderByDescending(c => c.Id).ToList();
            if (AdsSlider.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return AdsSlider.Select(x => new
            {
                x.Id,
                x.FkPositionType_Id,
             Image=   x.File.FullFileUrl,
                x.ViewerCount
            }).ToList();
        }


        //Save Chenage
        public object SaveChanage(AdsSlider[] adsSlider)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.AdsSlider);
            List<string> RemoveFiles = new List<string>();

            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;

            UpdateS.RemoveFiles = RemoveFiles;
            DeleteS.RemoveFiles = RemoveFiles;

            try
            {
                foreach (AdsSlider ad in adsSlider)
                {
                    if (ad.State == StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.AdsSlider(ad, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else
                    if (ad.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.AdsSlider(ad, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (ad.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.AdsSlider(ad, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                }
                db.SaveChanges();
                        FileService.RemoveFiles(RemoveFiles);
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved };
              }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange };
            }
        }

        //Get User Information 
        public object GetUserInformation(User user)
        {
            return new
            {
                user.Email,
                user.UserName,
                ImageUrl = user.UserInformation.File.FullFileUrl,
            };
        }
       
        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
