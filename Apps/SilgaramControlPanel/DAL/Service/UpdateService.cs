using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using DAL.Bll;
using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.ViewModel.Models;

namespace DAL.Service
{
    public class UpdateService : IDisposable
    {
        public SilgaramEntities db;// = new ControlPanel();
        CheckedService CheckedS = new CheckedService();
        public int UserId { get { return new UserService().GetCurrentUserId(); } }
        List<HistoryDetailVM> HistoryDetails = new List<HistoryDetailVM>();

        public List<string> RemoveFiles;

        public void Dispose()
        {
            //  db.SaveChanges();
            CheckedS.Dispose();
        }


        internal object Offer(Offer offer, PagesAllow pageAllow)
        {

            if (offer.EndDateTime == null)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.EndDateTime + " " + Token.FiledIsRequired };
            if (offer.StartDateTime == null)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.StartDateTime + " " + Token.FiledIsRequired };


            //  Offer Updating
            var OfferUpdate = db.Offers.Find(offer.Id);

            //Check Time 
            if (offer.EndDateTime < offer.StartDateTime)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.InvalidDate };



            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log

                HistoryDetails.Add(new HistoryDetailVM("Id", offer.Id.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("Title", offer.Title, OfferUpdate.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", offer.Description, OfferUpdate.Description, true, false));

                //يمكنة التعديل فى وقت الاننتهاء فبذالك يجب وضع اشعار 
                if (offer.EndDateTime != OfferUpdate.EndDateTime)
                    HistoryDetails.Add(new HistoryDetailVM("EndDateTime", DateService.GetDateTimeByCulture(offer.EndDateTime), DateService.GetDateTimeByCulture(OfferUpdate.EndDateTime), true, false));


                OfferUpdate.Log.Histories.Add(new History()
                {
                    TitleEn = OfferUpdate.Title,
                    TitleAr = OfferUpdate.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Offers,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }


            OfferUpdate.Description = offer.Description;
            OfferUpdate.Title = offer.Title;
            OfferUpdate.SmallDiscription = offer.SmallDiscription;
            OfferUpdate.FkCategory_Id = offer.FkCategory_Id;
            OfferUpdate.FkSubCategory_Id = offer.FkSubCategory_Id;
            OfferUpdate.DiscountRate = offer.DiscountRate;
            OfferUpdate.Price = offer.Price;
            OfferUpdate.IsTop = offer.IsTop;
            OfferUpdate.EndDateTime = offer.EndDateTime;
            OfferUpdate.StartDateTime = offer.StartDateTime;

            //Upload image 
            if (offer.Files != null)
            {

                foreach (var item in offer.Files)
                {
                    if (item.State == StateEnumVM.Delete)
                    {
                        var AlbumFileDelete = OfferUpdate.Album.AlbumFiles.SingleOrDefault(c => c.Id == item.AlbumFileId);
                        if (AlbumFileDelete != null)
                        {
                            RemoveFiles.Add(AlbumFileDelete.File.FileUrl);
                            db.AlbumFiles.Remove(AlbumFileDelete);
                        }
                    }
                    else if (item.State == StateEnumVM.Create)
                    {
                        FileSaveVM FileSave = FileService.SaveFile(new FileSaveVM()
                        {
                            Extensions = DefaultsVM.ExtensionsImage,
                            File = item.File,
                            ServerPathSave = "/Files/Images/Offers"
                        });

                        if (!FileSave.IsSaved)
                            return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotSaveFile + " >> " + item.File.FileName };

                        OfferUpdate.Album.AlbumFiles.Add(new AlbumFile()
                        {
                            File = new File()
                            {
                                FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                                FkFileType_Id = FileTypeEnumVM.Image,
                                FileUrl = FileSave.SavedPath
                            }
                        });
                    }

                }
            }

            return null;
        }

        internal object PointPackage(PointPackage pointPackage, PagesAllow pageAllow)
        {
            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(pointPackage.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(pointPackage.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };
            if (pointPackage.Price <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Price };
            if (pointPackage.Points <= 0)
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Points };


            HistoryDetails = new List<HistoryDetailVM>();
            var PointPackage = db.PointPackages.Find(pointPackage.Id);

            //Check NameAr Duplicated
            if (db.PointPackages.Where(c => c.Id != pointPackage.Id).Any(c => c.NameAr == pointPackage.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + pointPackage.NameAr };

            //Check NameEn Duplicated
            if (db.PointPackages.Where(c => c.Id != pointPackage.Id).Any(c => c.NameEn == pointPackage.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + pointPackage.NameEn };



            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("NameAr", pointPackage.NameAr, PointPackage.NameAr, false, false));
            HistoryDetails.Add(new HistoryDetailVM("NameEn", pointPackage.NameEn, PointPackage.NameEn, false, true));
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                PointPackage.Log.Histories.Add(new History()
                {
                    TitleAr = PointPackage.NameAr,
                    TitleEn = PointPackage.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.PointPackages,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }
            //Update Now 
            PointPackage.NameAr = pointPackage.NameAr;
            PointPackage.NameEn = pointPackage.NameEn;
            PointPackage.Points = pointPackage.Points;
            PointPackage.Price = pointPackage.Price;

            return null;
        }

        //Report Type
        internal object ReportType(ReportType reportType, PagesAllow pageAllow)
        {
            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(reportType.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(reportType.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };

            HistoryDetails = new List<HistoryDetailVM>();
            var ReportType = db.ReportTypes.Find(reportType.Id);
            if (ReportType == null) return null;

            //Check NameAr Duplicated
            if (db.ReportTypes.Where(c => c.Id != reportType.Id).Any(c => c.NameAr == reportType.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + reportType.NameAr };

            //Check NameEn Duplicated                                                                                          
            if (db.ReportTypes.Where(c => c.Id != reportType.Id).Any(c => c.NameEn == reportType.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + reportType.NameEn };


            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("Id", ReportType.Id.ToString(), true, false));
            HistoryDetails.Add(new HistoryDetailVM("NameAr", ReportType.NameAr, reportType.NameAr, false, false));
            HistoryDetails.Add(new HistoryDetailVM("NameEn", ReportType.NameEn, reportType.NameEn, false, true));


            //Update Now 
            ReportType.NameAr = reportType.NameAr;
            ReportType.NameEn = reportType.NameEn;


            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                ReportType.Log.Histories.Add(new History()
                {
                    TitleEn = ReportType.NameEn,
                    TitleAr = ReportType.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.ReportTypes,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }
            return null;
        }

        internal object AdsSlider(AdsSlider ad, PagesAllow pageAllow)
        {

            //Ad Updating
            var AdUpdate = db.AdsSliders.Find(ad.Id);
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                AdUpdate.Log.Histories.Add(new History()
                {
                    TitleEn = "Ad",
                    TitleAr = "اعلان",
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.AdsSlider,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                });

            }

            //Save Image
            if (ad.NewFile != null)
            {
                FileSaveVM Filesave = FileService.SaveFile(new FileSaveVM()
                {
                    Extensions = DefaultsVM.ExtensionsImage,
                    File = ad.NewFile,
                    ServerPathSave = "/Files/Images/"
                });

                if (!Filesave.IsSaved)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.CanNotSaveFile);

                RemoveFiles.Add(AdUpdate.File.FileUrl);

                AdUpdate.File.FileUrl = Filesave.SavedPath;
                AdUpdate.File.FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink;
            }
            AdUpdate.FkPositionType_Id = ad.FkPositionType_Id;
            return null;
        }

        internal object Ad(Ad ad, PagesAllow pageAllow)
        {
            int DayesPeriodCount = 0;
            int.TryParse(db.AppsInformations.Find(AppInformationEnumVM.AdPeriodDays).Value, out DayesPeriodCount);

            //Ad Updating
            var AdUpdate = db.Ads.Find(ad.Id);


       //Check Dates
            if (ad.EndDateTime < ad.StartDateTime)
            {
                return new ResponseVM(RequestTypeEnumVM.Error, Token.EndDateTimeMustBeMoreThanStartDateTime);
            }


            //Ad Start Date Time And End Date Time
            if (ad.IsApprove && !AdUpdate.IsApprove && AdUpdate.StartDateTime == null)
            {
                if (ad.StartDateTime == null)
                    AdUpdate.StartDateTime = DateTime.Now;
                AdUpdate.EndDateTime = DateTime.Now.AddDays(DayesPeriodCount);
            }
            else if (ad.StartDateTime != AdUpdate.StartDateTime ||ad.EndDateTime!=AdUpdate.EndDateTime)
            {
                AdUpdate.StartDateTime = ad.StartDateTime;
                AdUpdate.EndDateTime = ad.EndDateTime;
            }

       

            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                //Set History Details For Log

                HistoryDetails.Add(new HistoryDetailVM("Id", ad.Id.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("Title", ad.Title, AdUpdate.Title, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Description", ad.Description, AdUpdate.Description, true, false));


                HistoryDetails.Add(new HistoryDetailVM("IsApprove", ad.IsApprove.ToString(), AdUpdate.IsApprove.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("IsTop", ad.IsTop.ToString(), AdUpdate.IsTop.ToString(), true, false));


                //يمكنة التعديل فى وقت الاننتهاء فبذالك يجب وضع اشعار 
                if (ad.EndDateTime != AdUpdate.EndDateTime && AdUpdate != null)
                    HistoryDetails.Add(new HistoryDetailVM("EndDateTime", DateService.GetDateTimeByCulture(ad.EndDateTime.Value), DateService.GetDateTimeByCulture(AdUpdate.EndDateTime.Value), true, false));


                AdUpdate.Log.Histories.Add(new History()
                {
                    TitleEn = AdUpdate.Title,
                    TitleAr = AdUpdate.Title,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Ads,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });

                //Check Notify Approve
                if (ad.IsApprove != AdUpdate.IsApprove)
                {
                    if (ad.IsApprove)
                        //وضع اشعار بـ الموافقة على الاعلان
                        AdUpdate.Log.Histories.Add(new History()
                        {
                            TitleEn = AdUpdate.Title,
                            TitleAr = AdUpdate.Title,
                            DateTime = DateTime.Now,
                            FKPage_Id = PageEnumVM.Ads,
                            FkState_Id = StateEnumVM.Approve,
                            FkUser_Id = UserId,
                            HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                        });
                    else if (!ad.IsApprove)
                        //وضع اشعار بعدم الموافقة على الاعلان
                        AdUpdate.Log.Histories.Add(new History()
                        {
                            TitleEn = AdUpdate.Title,
                            TitleAr = AdUpdate.Title,
                            DateTime = DateTime.Now,
                            FKPage_Id = PageEnumVM.Ads,
                            FkState_Id = StateEnumVM.Reject,
                            FkUser_Id = UserId,
                            HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                        });
                }
            }

            //Save Image
            if(ad.Files!=null)
            foreach (var img in ad.Files)
            {
                if (img.State == StateEnumVM.Delete)
                {
                    var AlbumFileDelete = AdUpdate.Album.AlbumFiles.SingleOrDefault(c => c.Id == img.AlbumFileId);
                    if (AlbumFileDelete != null)
                    {
                            RemoveFiles.Add(AlbumFileDelete.File.FileUrl);
                            db.AlbumFiles.Remove(AlbumFileDelete);   
                    }
                }
                else
                {
                    if (img.File != null)
                    {
                        FileSaveVM Filesave = FileService.SaveFile(new FileSaveVM()
                        {
                            Extensions = DefaultsVM.ExtensionsImage,
                            File = img.File,
                            ServerPathSave = "/Files/Images/"
                        });

                        if (!Filesave.IsSaved)
                            return new ResponseVM(RequestTypeEnumVM.Error, Token.CanNotSaveFile + " " + img.File.FileName);

                        AdUpdate.Album.AlbumFiles.Add(new AlbumFile()
                        {
                            File = new File()
                            {
                                FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                                FkFileType_Id = FileTypeEnumVM.Image,
                                FileUrl = Filesave.SavedPath
                            }
                        });
                    }
                }
            }



            AdUpdate.Title = ad.Title;
            AdUpdate.Description = ad.Description;
            AdUpdate.Price = ad.Price;
            AdUpdate.IsTop = ad.IsTop;
            AdUpdate.IsApprove = ad.IsApprove;
            AdUpdate.FkCategory_Id = ad.FkCategory_Id;
            AdUpdate.FkSubCategory_Id = ad.FkSubCategory_Id;
            AdUpdate.IsAllowMessaging = ad.IsAllowMessaging;
            AdUpdate.IsAutoPost = ad.IsAutoPost;
            AdUpdate.IsPostWithOutPhoneNumber = ad.IsPostWithOutPhoneNumber;
            AdUpdate.PhoneNumber = ad.PhoneNumber;
            AdUpdate.Location.Latitude = ad.Latitude;
            AdUpdate.Location.Longitude = ad.Longitude;

            return null;
        }

        internal object SubCategory(SubCategory subCategory, PagesAllow pageAllow)
        {
            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(subCategory.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(subCategory.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };


            HistoryDetails = new List<HistoryDetailVM>();
            var SubCategory = db.SubCategories.Find(subCategory.Id);

            //Check NameAr Duplicated
            if (db.SubCategories.Where(c => c.Id != subCategory.Id).Any(c => c.NameAr == subCategory.NameAr && c.FkCategory_Id == subCategory.FkCategory_Id))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + subCategory.NameAr + " " + Token.With + Token.Country + " >> " + SubCategory.Category.CategoryName };

            //Check NameEn Duplicated
            if (db.SubCategories.Where(c => c.Id != subCategory.Id).Any(c => c.NameEn == subCategory.NameEn && c.FkCategory_Id == subCategory.FkCategory_Id))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + subCategory.NameEn + " " + Token.With + Token.Country + " >> " + SubCategory.Category.CategoryName };


            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("Id", SubCategory.Id.ToString(), true, false));
            HistoryDetails.Add(new HistoryDetailVM("NameAr", SubCategory.NameAr, subCategory.NameAr, false, false));
            HistoryDetails.Add(new HistoryDetailVM("NameEn", SubCategory.NameEn, subCategory.NameEn, false, true));


          
            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                SubCategory.Log.Histories.Add(new History()
                {
                    TitleEn = SubCategory.NameAr,
                    TitleAr = SubCategory.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.SubCategories,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }



            //Save Image
            if (subCategory.NewFile != null)
            {
                FileSaveVM Filesave = FileService.SaveFile(new FileSaveVM()
                {
                    Extensions = DefaultsVM.ExtensionsImage,
                    File = subCategory.NewFile,
                    ServerPathSave = "/Files/Images/"
                });

                if (!Filesave.IsSaved)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.CanNotSaveFile);

                RemoveFiles.Add(SubCategory.File.FileUrl);

                SubCategory.File.FileUrl = Filesave.SavedPath;
                SubCategory.File.FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink;
            }


            //Update Now 
            SubCategory.NameAr = subCategory.NameAr;
            SubCategory.NameEn = subCategory.NameEn;
            return null;
        }

        internal object Category(Category cateogry, PagesAllow pageAllow)
        {
            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(cateogry.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(cateogry.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };


            HistoryDetails = new List<HistoryDetailVM>();
            var Category = db.Categories.Find(cateogry.Id);

            //Check NameAr Duplicated
            if (db.Categories.Where(c => c.Id != cateogry.Id).Any(c => c.NameAr == cateogry.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + Category.NameAr };

            //Check NameEn Duplicated                                                                                          
            if (db.Categories.Where(c => c.Id != cateogry.Id).Any(c => c.NameEn == cateogry.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + Category.NameEn };


            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("Id", Category.Id.ToString(), true, false));
            HistoryDetails.Add(new HistoryDetailVM("NameAr", Category.NameAr, cateogry.NameAr, false, false));
            HistoryDetails.Add(new HistoryDetailVM("NameEn", Category.NameEn, cateogry.NameEn, false, true));


                if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                Category.Log.Histories.Add(new History()
                {
                    TitleEn = Category.NameAr,
                    TitleAr = Category.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Categories,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }
            //Update Now 
            Category.NameAr = cateogry.NameAr;
            Category.NameEn = cateogry.NameEn;



            return null;
        }

        internal object SubMenu(SubMenu subMenu)
        {
            var SubMenu = db.SubMenus.Find(subMenu.Id);
            SubMenu.ClassIcon = subMenu.ClassIcon;
            SubMenu.OrderNumber = subMenu.OrderNumber;
            SubMenu.FkMenu_Id = subMenu.FkMenu_Id;

            return null;
        }

        //Update Menu
        internal object Menu(Menu menu)
        {
            var Menu = db.Menus.Find(menu.Id);
            Menu.ClassIcon = menu.ClassIcon;
            Menu.OrderNumber = menu.OrderNumber;

            return null;
        }

        //Nationality Update
        internal object Nationality(Nationality nationality, PagesAllow pageAllow)
        {

            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(nationality.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(nationality.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };


            HistoryDetails = new List<HistoryDetailVM>();
            var Nationality = db.Nationalities.Find(nationality.Id);

            //Check NameAr Duplicated
            if (db.Nationalities.Where(c => c.Id != nationality.Id).Any(c => c.NameAr == nationality.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + nationality.NameAr };

            //Check NameEn Duplicated                                                                                            
            if (db.Nationalities.Where(c => c.Id != nationality.Id).Any(c => c.NameEn == nationality.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + nationality.NameEn };


            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("Id", Nationality.Id.ToString(),true, false));
            HistoryDetails.Add(new HistoryDetailVM("NameAr", Nationality.NameAr, nationality.NameAr, false, false));
            HistoryDetails.Add(new HistoryDetailVM("NameEn", Nationality.NameEn, nationality.NameEn, false, true));


                       if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                Nationality.Log.Histories.Add(new History()
                {
                    TitleEn = Nationality.NameAr,
                    TitleAr = Nationality.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Nationalities,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }

            //Update Now 
            Nationality.NameAr = nationality.NameAr;
            Nationality.NameEn = nationality.NameEn;


            return null;
        }
        
        //Pages Role
        internal object PagesRole(PagesRole pagesRole, PagesAllow pageAllow)
        {

            HistoryDetails = new List<HistoryDetailVM>();
            var PagesRole = db.PagesRoles.Find(pagesRole.Id);

            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("IsCreate", PagesRole.IsCreate.ToString(), pagesRole.IsCreate.ToString(), true, false));
            HistoryDetails.Add(new HistoryDetailVM("IsDelete", PagesRole.IsDelete.ToString(), pagesRole.IsDelete.ToString(), true, false));
            HistoryDetails.Add(new HistoryDetailVM("IsDisplay", PagesRole.IsDisplay.ToString(), pagesRole.IsDisplay.ToString(), true, false));
            HistoryDetails.Add(new HistoryDetailVM("IsUpdate", PagesRole.IsUpdate.ToString(), pagesRole.IsUpdate.ToString(), true, false));

           
                       if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                PagesRole.Log.Histories.Add(new History()
                {
                    TitleEn = ResourceService.GetToken(PagesRole.Page.ResourceName,true),
                    TitleAr = ResourceService.GetToken(PagesRole.Page.ResourceName, false),
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.PagesRoles,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }
            //Update Now 
            PagesRole.IsCreate = pagesRole.IsCreate;
            PagesRole.IsDelete = pagesRole.IsDelete;
            PagesRole.IsDisplay = pagesRole.IsDisplay;
            PagesRole.IsUpdate = pagesRole.IsUpdate;

            return null;
        }

        //Update Pages Allow 
        internal object PagesAllow(PagesAllow pagesAllow, PagesAllow pageAllow)
        {
            HistoryDetails = new List<HistoryDetailVM>();
            var PagesAllow = db.PagesAllows.Find(pagesAllow.Id);



            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("IsAllowLog", PagesAllow.IsAllowLog.ToString(), pagesAllow.IsAllowLog.ToString(), true, false));
            HistoryDetails.Add(new HistoryDetailVM("IsAllowNotify", PagesAllow.IsAllowNotify.ToString(), pagesAllow.IsAllowNotify.ToString(), true, false));


                             if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                PagesAllow.Log.Histories.Add(new History()
                {
                    TitleEn = ResourceService.GetToken(PagesAllow.Page.ResourceName, true),
                    TitleAr = ResourceService.GetToken(PagesAllow.Page.ResourceName, false),
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.PagesAllow,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }
            //Update Now 
            PagesAllow.IsAllowLog = pagesAllow.IsAllowLog;
            PagesAllow.IsAllowNotify = pagesAllow.IsAllowNotify;



            return null;
        }

        internal object AppsInformation(AppsInformation appConfig, PagesAllow pageAllow)
        {

            HistoryDetails = new List<HistoryDetailVM>();
            var AppsInformationUpdate = db.AppsInformations.Find(appConfig.Id);
            if (appConfig.Value == AppsInformationUpdate.Value) return null;



            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM(AppsInformationUpdate.ResourceName, appConfig.Value, AppsInformationUpdate.Value, true, false));


            //Update Now 


            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                AppsInformationUpdate.Log.Histories.Add(new History()
                {
                    TitleAr = appConfig.Value,
                    TitleEn = appConfig.Value,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.AppsInformations,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }
            AppsInformationUpdate.Value = appConfig.Value;

            return null;
        }
        //Province Update
        internal object Province(Province province, PagesAllow pageAllow)
        {
            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(province.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(province.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };


            HistoryDetails = new List<HistoryDetailVM>();
            var ProvinceUpdate = db.Provinces.Find(province.Id);

            //Check NameAr Duplicated
            if (db.Provinces.Where(c => c.Id != province.Id).Any(c => c.NameAr == province.NameAr && c.FKCountry_Id == province.FKCountry_Id))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + province.NameAr + " " + Token.With + Token.Country + " >> " + ProvinceUpdate.Country.CountryName };

            //Check NameEn Duplicated
            if (db.Provinces.Where(c => c.Id != province.Id).Any(c => c.NameEn == province.NameEn && c.FKCountry_Id == province.FKCountry_Id))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + province.NameEn + " " + Token.With + Token.Country + " >> " + ProvinceUpdate.Country.CountryName };


            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("NameAr", province.NameAr, ProvinceUpdate.NameAr, false, false));
            HistoryDetails.Add(new HistoryDetailVM("NameEn", province.NameEn, ProvinceUpdate.NameEn, false, true));


            //Update Now 
            ProvinceUpdate.NameAr = province.NameAr;
            ProvinceUpdate.NameEn = province.NameEn;


            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                ProvinceUpdate.Log.Histories.Add(new History()
                {
                    TitleAr = ProvinceUpdate.NameAr,
                    TitleEn = ProvinceUpdate.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Provinces,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }

            return null;
        }
        /// <summary>
        /// Update Any User
        /// </summary>
        /// <param name="userInformation"></param>
        /// <param name="address"></param>
        /// <param name="user"></param>
        /// <param name="userRoles"></param>
        /// <param name="image"></param>
        /// <param name="PageAllow"></param>
        /// <returns></returns>
        internal object User(UserInformation userInformation, Address address, User user, UserRole[] userRoles, HttpPostedFileBase image, PagesAllow PageAllow)
        {

            User UserUpdate = db.Users.Find(user.Id);

            //Check Email unic
            if (string.IsNullOrEmpty(user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + " " + Token.FiledIsRequired };
            if (db.Users.Where(x => x.Id != user.Id).Any(x => x.Email == user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + " " + Token.BeforeUsed };

            //Check NationalId unic
            if (!string.IsNullOrEmpty(userInformation.NationalId))
                if (db.UserInformations.Where(x => x.User.Id != UserUpdate.Id).Any(x => x.NationalId == userInformation.NationalId))
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NationalId + " " + Token.BeforeUsed };

            //Password
            if (!string.IsNullOrEmpty(user.NewPassword))
                UserUpdate.Password = user.NewPassword;

            //Add
            if (PageAllow.IsAllowLog)
            {
                //Set History Details For Log
                HistoryDetails.Add(new HistoryDetailVM("UserName", user.UserName, true, false));
                HistoryDetails.Add(new HistoryDetailVM("Email", user.Email, UserUpdate.Email, true, false));
                HistoryDetails.Add(new HistoryDetailVM("IsBlocked", user.IsBlocked.ToString(), UserUpdate.IsBlocked.ToString(), true, false));
                HistoryDetails.Add(new HistoryDetailVM("FirstName", userInformation.FirstName, UserUpdate.UserInformation.FirstName, true, false));
                HistoryDetails.Add(new HistoryDetailVM("LastName", userInformation.LastName, UserUpdate.UserInformation.LastName, true, false));
                HistoryDetails.Add(new HistoryDetailVM("MediumName", userInformation.MediumName, UserUpdate.UserInformation.MediumName, true, false));
                HistoryDetails.Add(new HistoryDetailVM("NationalId", userInformation.NationalId, UserUpdate.UserInformation.NationalId, true, false));

                var HistoryDetailsForCreating = LogService.CheckHistoryDetails(HistoryDetails);
                if (HistoryDetailsForCreating != null)
                    UserUpdate.Log.Histories.Add(new History()
                    {
                        DateTime = DateTime.Now,
                        FKPage_Id = PageEnumVM.Users,
                        FkState_Id = StateEnumVM.Update,
                        FkUser_Id = UserId,
                        HistoryDetails = HistoryDetailsForCreating
                    });

            }


            //Update user
            UserUpdate.Email = user.Email;
            UserUpdate.IsBlocked = user.IsBlocked;
            UserUpdate.IsAgent = user.IsAgent;

            if (string.IsNullOrEmpty(userInformation.FirstName))
                userInformation.FirstName = "";
            if (string.IsNullOrEmpty(userInformation.LastName))
                userInformation.LastName = "";

            if (db.UserInformations.Any(c => c.User.Id != UserUpdate.Id && c.PhoneNumber == userInformation.PhoneNumber))
                return new ResponseVM(RequestTypeEnumVM.Error, Token.Phone + " >> " + Token.BeforeUsed);


            //Update user information
            UserUpdate.UserInformation.FirstName = userInformation.FirstName;
            UserUpdate.UserInformation.MediumName = userInformation.MediumName;
            UserUpdate.UserInformation.LastName = userInformation.LastName;
            UserUpdate.UserInformation.PhoneNumber = userInformation.PhoneNumber;
            if (!string.IsNullOrEmpty(userInformation.NationalId))
                UserUpdate.UserInformation.NationalId = userInformation.NationalId;
            if (userInformation.FKGender_Id.HasValue)
                UserUpdate.UserInformation.FKGender_Id = userInformation.FKGender_Id;
            if (userInformation.FKJob_Id.HasValue)
                UserUpdate.UserInformation.FKJob_Id = userInformation.FKJob_Id;
            if (userInformation.FKSocialStatus_Id.HasValue)
                UserUpdate.UserInformation.FKSocialStatus_Id = userInformation.FKSocialStatus_Id;
            if (userInformation.BirthDate.HasValue)
                UserUpdate.UserInformation.BirthDate = userInformation.BirthDate;



            //Address
            if (!UserUpdate.UserInformation.FKAddress_Id.HasValue)
            {
                var NewAddress = new Models.Address();
                if (address.FKCountry_Id > 0)
                    NewAddress.FKCountry_Id = address.FKCountry_Id;
                if (address.FkProvince_Id > 0)
                    NewAddress.FkProvince_Id = address.FkProvince_Id;

                if (!string.IsNullOrEmpty(address.Street))
                    NewAddress.Street = address.Street;
                if (!string.IsNullOrEmpty(address.PostalCode))
                    NewAddress.PostalCode = address.PostalCode;
                if (!string.IsNullOrEmpty(address.City))
                    NewAddress.City = address.City;



                UserUpdate.UserInformation.Address = NewAddress;
            }
            else
            {
                if (address.FKCountry_Id.HasValue)
                    UserUpdate.UserInformation.Address.FKCountry_Id = address.FKCountry_Id;
                if (address.FkProvince_Id.HasValue)
                    UserUpdate.UserInformation.Address.FkProvince_Id = address.FkProvince_Id;

                UserUpdate.UserInformation.Address.Street = address.Street;
                UserUpdate.UserInformation.Address.PostalCode = address.PostalCode;
                UserUpdate.UserInformation.Address.City = address.City;
            }

           

            //Update Language
            if (userInformation.Languages != null)
            {
                if (userInformation.Languages.Any(v => v.IsDefault && v.State == StateEnumVM.Update||  v.State == StateEnumVM.Create))
                    foreach (var item in UserUpdate.UserInformation.Language.LanguageUsings)
                    {
                        item.IsDefault = false;
                    }
                foreach (LanguageUsing LanguageUsing in userInformation.Languages)
                {

                    if (LanguageUsing.State == StateEnumVM.Create)
                    {
                        //Check If Languages == null
                        if (UserUpdate.UserInformation.Language == null)
                        {
                            UserUpdate.UserInformation.Language = new Language()
                            {
                                LanguageUsings = new List<LanguageUsing>()
                                {
                                    LanguageUsing
                                }
                            };

                        }
                        else
                        {
                            if (!UserUpdate.UserInformation.Language.LanguageUsings.Any(c => c.FKLanguageType_Id == LanguageUsing.FKLanguageType_Id))
                                UserUpdate.UserInformation.Language.LanguageUsings.Add(LanguageUsing);
                        }

                    }


                    else if (LanguageUsing.State == StateEnumVM.Update)
                        UserUpdate.UserInformation.Language.LanguageUsings.Single(c => c.Id == LanguageUsing.Id).IsDefault = LanguageUsing.IsDefault;
                    else if (LanguageUsing.State == StateEnumVM.Delete)
                        db.LanguageUsings.Remove(db.LanguageUsings.Find(LanguageUsing.Id));

                }
            }

            //Update Role
            if (userRoles != null)
                foreach (UserRole uRole in userRoles)
                {
                    if (uRole.State == StateEnumVM.Create)
                        UserUpdate.UserRoles.Add(uRole);
                    else if (uRole.State == StateEnumVM.Delete)
                        db.UserRoles.Remove(db.UserRoles.Find(uRole.Id));
                }

            //Update Image 
            if (image != null)
            {
                //Save Image
                FileSaveVM FileSave = FileService.SaveFile(new FileSaveVM()
                {
                    File = image,
                    ServerPathSave = "/Files/Images/Users/Profile/",
                    Extensions = DefaultsVM.ExtensionsImage,
                });

                if (!FileSave.IsSaved)
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotSaveFile };

                if (UserUpdate.UserInformation.File == null)
                {
                    UserUpdate.UserInformation.File = new File()
                    {
                        FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                        FkFileType_Id = FileTypeEnumVM.Image,
                        FileUrl = FileSave.SavedPath,
                    };
                }
                else
                {
                    userInformation.OldImageUrl = UserUpdate.UserInformation.File.FileUrl;
                    UserUpdate.UserInformation.File.FileUrl = FileSave.SavedPath;
                }
            }

            return null;
        }

        //Country Update
        internal object Country(Country country, PagesAllow pageAllow)
        {
            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(country.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(country.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };
            if (string.IsNullOrEmpty(country.CountryKey))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.Key };


            HistoryDetails = new List<HistoryDetailVM>();
            var Country = db.Countries.Find(country.Id);

            //Check NameAr Duplicated
            if (db.Countries.Where(c => c.Id != country.Id).Any(c => c.NameAr == country.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + country.NameAr };

            //Check NameEn Duplicated                                                                                          
            if (db.Countries.Where(c => c.Id != country.Id).Any(c => c.NameEn == country.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + country.NameEn };


            //Check CountryKey Duplicated                                                                                          
            if (db.Countries.Where(c => c.Id != country.Id).Any(c => c.CountryKey == country.CountryKey))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + country.CountryKey };


            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("NameAr", country.NameAr, Country.NameAr, false, false));
            HistoryDetails.Add(new HistoryDetailVM("NameEn", country.NameEn, Country.NameEn, false, true));


            if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                Country.Log.Histories.Add(new History()
                {
                    TitleAr = Country.NameAr,
                    TitleEn = Country.NameEn,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Countries,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }

            //Update Now 
            Country.NameAr = country.NameAr;
            Country.NameEn = country.NameEn;
            Country.CountryKey = country.CountryKey;

            Country.File.FileUrl = country.FlagUrl;
            return null;
        }

        /// <summary>
        /// User Current User
        /// </summary>
        /// <param name="userInformation"></param>
        /// <param name="address"></param>
        /// <param name="user"></param>
        /// <param name="image"></param>
        /// <returns></returns>
        internal object User(UserInformation userInformation, Address address, User user, HttpPostedFileBase image)

        {
            /*
             -- language
            */

            User UserUpdate = db.Users.Find(user.Id);

            //Check Email unic
            if (string.IsNullOrEmpty(user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + " " + Token.FiledIsRequired };
            if (db.Users.Where(x => x.Id != user.Id).Any(x => x.Email == user.Email))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.Email + " " + Token.BeforeUsed };

            //Check NationalId unic
            if (!string.IsNullOrEmpty(userInformation.NationalId))
                //return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NationalId + " " + Token.FiledIsRequired };
                if (db.UserInformations.Where(x => UserId != user.Id).Any(x => x.NationalId == userInformation.NationalId))
                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NationalId + " " + Token.BeforeUsed };

            //Password
            if (!string.IsNullOrEmpty(user.NewPassword))
                UserUpdate.Password = user.NewPassword;

            //user
            UserUpdate.Email = user.Email;

            //user 
            UserUpdate.UserInformation.FirstName = userInformation.FirstName;
            UserUpdate.UserInformation.MediumName = userInformation.MediumName;
            UserUpdate.UserInformation.LastName = userInformation.LastName;
            UserUpdate.UserInformation.NationalId = userInformation.NationalId;
            UserUpdate.UserInformation.FKGender_Id = userInformation.FKGender_Id;
            UserUpdate.UserInformation.FKJob_Id = userInformation.FKJob_Id;
            UserUpdate.UserInformation.FKSocialStatus_Id = userInformation.FKSocialStatus_Id;
            UserUpdate.UserInformation.BirthDate = userInformation.BirthDate;
            UserUpdate.UserInformation.PhoneNumber = userInformation.PhoneNumber;

            //Chwck From Phone Number
            if (db.UserInformations.Any(c => c.User.Id != UserUpdate.Id && c.PhoneNumber == userInformation.PhoneNumber))
                return new ResponseVM(RequestTypeEnumVM.Error, Token.Phone + " >> " + Token.BeforeUsed);

            //Address
            if (UserUpdate.UserInformation.Address == null)
            {
                var NewAddress = new Models.Address();
                if (address.FKCountry_Id > 0)
                    NewAddress.FKCountry_Id = address.FKCountry_Id;
                NewAddress.Street = address.Street;
                NewAddress.PostalCode = address.PostalCode;
                NewAddress.City = address.City;

                UserUpdate.UserInformation.Address = NewAddress;
            }
            else
            {
                if (address.FKCountry_Id > 0)
                    UserUpdate.UserInformation.Address.FKCountry_Id = address.FKCountry_Id;
                if (address.FkProvince_Id > 0)
                    UserUpdate.UserInformation.Address.FkProvince_Id = address.FkProvince_Id;
                UserUpdate.UserInformation.Address.Street = address.Street;
                UserUpdate.UserInformation.Address.City = address.City;
                UserUpdate.UserInformation.Address.PostalCode = address.PostalCode;
            }

            


            //Update Language
            if (userInformation.Languages != null)
                if (userInformation.Languages.Any(v => v.IsDefault && v.State == StateEnumVM.Update || v.State == StateEnumVM.Create))
                    foreach (var item in UserUpdate.UserInformation.Language.LanguageUsings)
                    {
                        item.IsDefault = false;
                    }
            foreach (LanguageUsing LanguageUsing in userInformation.Languages)
            {
                if (LanguageUsing.State == StateEnumVM.Create)
                    if (UserUpdate.UserInformation.Language.LanguageUsings.Any(c => c.FKLanguageType_Id == LanguageUsing.FKLanguageType_Id))
                    {
                        //only Update
                        UserUpdate.UserInformation.Language.LanguageUsings.Single(c => c.FKLanguageType_Id == LanguageUsing.FKLanguageType_Id).IsDefault = LanguageUsing.IsDefault;
                    }
                    else
                    {

                        UserUpdate.UserInformation.Language.LanguageUsings.Add(LanguageUsing);
                    }

                else if (LanguageUsing.State == StateEnumVM.Update)

                    UserUpdate.UserInformation.Language.LanguageUsings.Single(c => c.Id == LanguageUsing.Id).IsDefault = LanguageUsing.IsDefault;
                else if (LanguageUsing.State == StateEnumVM.Delete)
                    db.LanguageUsings.Remove(db.LanguageUsings.Find(LanguageUsing.Id));

            }



            //Update Image 
            if (image != null)
            {
                //Save Image
                FileSaveVM FileSave = FileService.SaveFile(new FileSaveVM()
                {
                    File = image,
                    ServerPathSave = "/Files/Images/Users/Profile/",
                    Extensions = DefaultsVM.ExtensionsImage,
                });

                if (!FileSave.IsSaved)

                    return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotSaveFile };

                if (UserUpdate.UserInformation.File == null)
                {
                    UserUpdate.UserInformation.File = new File()
                    {
                        FKAppInformation_Id = AppInformationEnumVM.ControllPanelLink,
                        FkFileType_Id = FileTypeEnumVM.Image,
                        FileUrl = FileSave.SavedPath,
                    };
                }
                else
                {
                    userInformation.OldImageUrl = UserUpdate.UserInformation.File.FileUrl;
                    UserUpdate.UserInformation.File.FileUrl = FileSave.SavedPath;
                }
            }


            return null;
        }
        //Job Update
        internal object Job(Job job, PagesAllow pageAllow)
        {
            //Check Fildes Is Reqierd
            if (string.IsNullOrEmpty(job.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameAr };
            if (string.IsNullOrEmpty(job.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.FiledIsRequired + " >> " + Token.NameEn };

            HistoryDetails = new List<HistoryDetailVM>();
            var Job = db.Jobs.Find(job.Id);
            if (Job == null) return null;

            //Check NameAr Duplicated
            if (db.ReportTypes.Where(c => c.Id != job.Id).Any(c => c.NameAr == job.NameAr))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + job.NameAr };

            //Check NameEn Duplicated                                                                                          
            if (db.ReportTypes.Where(c => c.Id != job.Id).Any(c => c.NameEn == job.NameEn))
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.CanNotDuplicate + " >> " + job.NameEn };


            //Set History Details For Log
            HistoryDetails.Add(new HistoryDetailVM("Id", Job.Id.ToString() ,true, false));
            HistoryDetails.Add(new HistoryDetailVM("NameAr", Job.NameAr, job.NameAr, false, false));
            HistoryDetails.Add(new HistoryDetailVM("NameEn", Job.NameEn, job.NameEn, false, true));


            //Update Now 
            Job.NameAr = job.NameAr;
            Job.NameEn = job.NameEn;


                       if (pageAllow.IsAllowLog || pageAllow.IsAllowNotify)
            {
                Job.Log.Histories.Add(new History()
                {
                    TitleEn = Job.NameEn,
                    TitleAr = Job.NameAr,
                    DateTime = DateTime.Now,
                    FKPage_Id = PageEnumVM.Jobs,
                    FkState_Id = StateEnumVM.Update,
                    FkUser_Id = UserId,
                    HistoryDetails = LogService.CheckHistoryDetails(HistoryDetails)
                });
            }



            return null;
        }

    }//End Class
}
