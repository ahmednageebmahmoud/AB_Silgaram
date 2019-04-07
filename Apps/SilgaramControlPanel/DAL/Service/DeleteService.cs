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
        public SilgaramEntities db;// = new ControlPanel();
        List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();
        public int UserId { get { return new UserService().GetCurrentUserId(); } }
        public List<string> RemoveFiles;
        public void Dispose()
        {
         //   db.Dispose();
        }
        internal object Province(Province province, PagesAllow pageAllow)
        {
            //Check With Notify only
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleAr = province.NameAr,
                    TitleEn = province.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Provinces,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                });
            }

            //Delete Now
            var ProvincDelete = db.Provinces.Find(province.Id);

            if (ProvincDelete.Addresses.Count > 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDelete + " >> " + ProvincDelete.ProvinceName };


            int LogId = ProvincDelete.FkLog_Id;
            db.Provinces.Remove(ProvincDelete);
            db.Logs.Remove(db.Logs.Find(LogId));
            return null;
        }

        internal object ReportType(ReportType reportType, PagesAllow pageAllow)
        {
            //Delete Now
            var ReportTypeDelete = db.ReportTypes.Find(reportType.Id);
            if (ReportTypeDelete == null) return null;

            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Id", reportType.Id.ToString(), false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameAr", reportType.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", reportType.NameEn, true, true));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = ReportTypeDelete.NameEn,
                    TitleAr = ReportTypeDelete.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.ReportTypes,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }
            if (ReportTypeDelete.Reports.Count > 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDelete + " >> " + ReportTypeDelete.ReportTypeName };

            db.ReportTypes.Remove(ReportTypeDelete);
            return null;
        }

        internal object PointPackage(PointPackage pointPackage, PagesAllow pageAllow)
        {
            //Check With Notify only
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleAr = pointPackage.NameAr,
                    TitleEn = pointPackage.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.PointPackages,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                });
            }

            //Delete Now
            var PointPackageDelete = db.PointPackages.Find(pointPackage.Id);

            if (pointPackage == null)
                return new { RequestType = RequestTypeEnumVM.Error, Message = PointPackageDelete.PointPackageName + " " + Token.NotFound };

            if (PointPackageDelete.UserPointPackages.Count > 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDelete + " >> " + PointPackageDelete.PointPackageName };


            int LogId = PointPackageDelete.FkLog_Id;
            db.PointPackages.Remove(PointPackageDelete);
            db.Logs.Remove(db.Logs.Find(LogId));
            return null;
        }

        internal object SubCategory(SubCategory subCategory, PagesAllow pageAllow)
        {
            //Delete Now
            var SubCategoryDelete = db.SubCategories.Find(subCategory.Id);


            //Check With Notify only
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Id", SubCategoryDelete.Id.ToString(), false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameAr", SubCategoryDelete.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", SubCategoryDelete.NameEn, false, true));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = SubCategoryDelete.NameEn,
                    TitleAr = SubCategoryDelete.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.SubCategories,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }

              if (SubCategoryDelete.Ads.Count > 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDelete + " >> " + SubCategoryDelete.SubCategoryName };


            RemoveFiles.Add(SubCategoryDelete.File.FullFileUrl);

            int LogId = SubCategoryDelete.FkLog_Id;
            db.SubCategories.Remove(SubCategoryDelete);
            db.Logs.Remove(db.Logs.Find(LogId));
            return null;
        }

        internal object AdsSlider(AdsSlider ad, PagesAllow pageAllow)
        {
            //Delete Now
            var AdDelete = db.AdsSliders.Find(ad.Id);
            if (AdDelete == null) return null;

            //Check With Notify only
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = "Ad",
                    TitleAr = "اعلان",
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.AdsSlider,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                });
            }
                RemoveFiles.Add(AdDelete.File.FullFileUrl);
            db.AdsSliders.Remove(AdDelete);
            return null;
        }

        internal object Ad(Ad ad, PagesAllow pageAllow)
        {
            //Delete Now
            var AdDelete = db.Ads.Find(ad.Id);
            if (AdDelete == null) return null;

            //Check With Notify only
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Id", AdDelete.Id.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("Title", AdDelete.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", AdDelete.Description, true, false));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = AdDelete.Title,
                    TitleAr = AdDelete.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Ads,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }

            if (AdDelete.Album != null)
                RemoveFiles.AddRange(AdDelete.Album.AlbumFiles.Select(c => c.File.FullFileUrl));



            db.Reports.RemoveRange(AdDelete.Reports);
            db.Chattings.RemoveRange(AdDelete.Chattings);
            db.UsersPurchasesAds.RemoveRange(AdDelete.UsersPurchasesAds);
            db.Ads.Remove(AdDelete);
                        return null;
        }


        internal object Offer(Offer offer, PagesAllow pageAllow)
        {
            //Delete Now
            var OfferDelete = db.Offers.Find(offer.Id);
            if (OfferDelete == null) return null;


            //Check With Notify only
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Id", OfferDelete.Id.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("Title", OfferDelete.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", OfferDelete.Description, true, false));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = OfferDelete.Title,
                    TitleAr = OfferDelete.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Offers,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }

            if(OfferDelete.Album!=null)
            RemoveFiles.AddRange(OfferDelete.Album.AlbumFiles.Select(c=> c.File.FullFileUrl));

            db.UsersPurchasesOffers.RemoveRange(OfferDelete.UsersPurchasesOffers);
            db.Offers.Remove(OfferDelete);
            return null;
        }

        internal object Category(Category cateogry, PagesAllow pageAllow)
        {

            //Delete Now
            var cateogryDelete = db.Categories.Find(cateogry.Id);

            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Id", cateogryDelete.Id.ToString(), false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameAr", cateogryDelete.NameAr, false, false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", cateogryDelete.NameEn, false, true));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = cateogryDelete.NameEn,
                    TitleAr = cateogryDelete.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Categories,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }


    
            if (cateogryDelete.SubCategories.Count > 0 || cateogryDelete.Ads.Count > 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDelete + " >> " + cateogryDelete.CategoryName };

            int LogId = cateogryDelete.FkLog_Id;
            db.Categories.Remove(cateogryDelete);
            db.Logs.Remove(db.Logs.Find(LogId));
            return null;
        }



        //Nationality Delete
        internal object Nationality(Nationality nationality, PagesAllow pageAllow)
        {
            //Delete Now
            var NationalityDelete = db.Nationalities.Find(nationality.Id);

            //Check With Notify only
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Id", nationality.Id.ToString(),false,false));
                HistoryDetails.Add(new HistoryDetailVM("NameAr", nationality.NameAr,false,false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", nationality.NameEn,true,true));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = NationalityDelete.NameEn,
                    TitleAr = NationalityDelete.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Nationalities,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }

          
            if (NationalityDelete.UserInformations.Count > 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDelete + " >> " + NationalityDelete. NationalityName };


            int LogId = NationalityDelete.FkLog_Id;
            db.Nationalities.Remove(NationalityDelete);
            db.Logs.Remove(db.Logs.Find(LogId));
            return null;
        }

        //Country Delete
        internal object Country(Country country, PagesAllow pageAllow)
        {
            //Delete Now
            var CountryDelete = db.Countries.Find(country.Id);

            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Id", country.Id.ToString(),false,false));
                HistoryDetails.Add(new HistoryDetailVM("NameAr", country.NameAr,false,false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", country.NameEn,false,true));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = CountryDelete.NameEn,
                    TitleAr = CountryDelete.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Countries,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }


        
            if (CountryDelete.Addresses.Count > 0|| CountryDelete.Provinces.Count > 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDelete + " >> " + CountryDelete.CountryName };

            int LogId = CountryDelete.FkLog_Id;
            db.Countries.Remove(CountryDelete);
            db.Logs.Remove(db.Logs.Find(LogId));
            return null;
        }

        //Job Delete
        internal object Job(Job job, PagesAllow pageAllow)
        {
            //Delete Now
            var JobDelete = db.Jobs.Find(job.Id);
            if (JobDelete == null) return null;

            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Notify
                HistoryDetails.Add(new HistoryDetailVM("Id", job.Id.ToString(),false,false));
                HistoryDetails.Add(new HistoryDetailVM("NameAr", job.NameAr,false,false));
                HistoryDetails.Add(new HistoryDetailVM("NameEn", job.NameEn,true,true));

                //Set Notify 
                db.Histories.Add(new History()
                {
                    TitleEn = JobDelete.NameEn,
                    TitleAr = JobDelete.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Jobs,
                    FkState_Id = StateEnumVM.Delete,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetailsForCreateOrDelete(HistoryDetails)
                });
            }


                if (JobDelete.UserInformations.Count > 0 )
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDelete + " >> " + JobDelete.JobName };


            int LogId = JobDelete.FkLog_Id;
            db.Jobs.Remove(JobDelete);
            db.Logs.Remove(db.Logs.Find(LogId));
            return null;
        }

    }//End Class
}
