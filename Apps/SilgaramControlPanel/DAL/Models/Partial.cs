using DAL.Models.ViewModel;
using DAL.Models.ViewModels;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace DAL.Models
{
    public partial class User
    {
        public string FullName
        {
            get
            {
                if (this.UserInformation != null)
                    return UserInformation.FirstName + " " + UserInformation.MediumName + " " + UserInformation.LastName;

                return "";
            }
        }
        public string ImageUrl { get; set; }
        public bool RememberMe { get; set; }
        public string NewPassword { get; set; }
        //public string CurrentPassword { get; set; }
        public string ConfirmPassword { get; set; }
        public bool IsSuccessLogin { get; set; }

        public string UserCulture { get; set; }
    }


    public partial class UserInformation
    {
        public string LanguageCode { get; set; }
        public bool IsBirthDate { get { return this.BirthDate != null; } }

        public List<PhoneNumber> PhoneNumbers { get; set; }
        public List<LanguageUsing> Languages { get; set; }
        public string OldImageUrl { get; set; }

    }
    public partial class PhoneNumber
    {
        public int State { get; set; }
    }

    public partial class UserRole
    {
        public int State { get; set; }
    }
    public partial class PagesRole
    {
        public int State { get; set; }
    }


    public partial class LanguageUsing
    {
        public int State { get; set; }
    }

    public partial class Job
    {
        public string JobName { get { return LanguageService.IsEn ? NameEn : NameAr; } }
        public int State { get; set; }


    }
    public partial class Nationality
    {
        public string NationalityName { get { return LanguageService.IsEn ? NameEn : NameAr; } }
        public int State { get; set; }


    }


    public partial class Country
    {
        public string CountryName { get { return LanguageService.IsEn ? NameEn : NameAr; } }
        public int State { get; set; }

        public string FlagUrl { get; set; }

    }
    public partial class Province
    {
        public string ProvinceName { get { return LanguageService.IsEn ? NameEn : NameAr; } }
        public int State { get; set; }
    }


    public partial class PagesAllow
    {
        public int State { get; set; }
    }
    public partial class Role
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }
    public partial class Menu
    {
        public int State { get; set; }
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }
    public partial class SubMenu
    {
        public int State { get; set; }
        public string SubMenuName { get { return this.Page.TokenValue; } }
    }

    public partial class Gender
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }

    public partial class LanguageType
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }

    public partial class Page
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }

    public partial class PagesRoleType
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }
    public partial class SocialStatu
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }

    public partial class State
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }
    public partial class AppsInformation
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }

    public partial class File
    {
        public string FullFileUrl { get { return this.AppsInformation.Value + this.FileUrl; } }
    }









    public partial class Category
    {
        public int State { get; set; }
        public string CategoryName { get { return LanguageService.IsEn ? this.NameEn : this.NameAr; } }
    }
    public partial class SubCategory
    {
        public int State { get; set; }
        public string SubCategoryName { get { return LanguageService.IsEn ? this.NameEn : this.NameAr; } }
        public HttpPostedFileBase NewFile { get; set; }
    }

    public partial class Ad
    {
        public bool IsStarted { get { return  DateTime.Now>=   this.StartDateTime; } }
        public bool IsFinshed { get { return DateTime.Now > this.EndDateTime; } }
        public DateVM Timer
        {
            get
            {
                if (this.IsStarted)
                    return new DateVM(this.EndDateTime.Value);
                return null;
            }
        }
        public int State { get; set; }
        public object CreateBy
        {
            get
            {
                if (this.Log == null) return null;
                var user = this.Log.Histories.First().User;
                return new  
                {
                    user.Email,
                    UserName = user.UserName,
                    Serial = user.Serial,
                    ImageUrl = user.UserInformation.File.FullFileUrl,
                };
            }
        }

        public string CreateDateTime
        {
            get
            {
                return DateService.GetDateTimeByCulture(this.Log.Histories.First().DateTime);
            }
        }
        public string StartDateTimeString
        {
            get
            {
                if (this.StartDateTime.HasValue)
                {
                    return DateService.GetDateTimeByCulture(this.StartDateTime.Value);
                }
                return null;
            }
        }
        public string EndDateTimeString
        {
            get
            {
                if (this.EndDateTime.HasValue)
                {
                    return DateService.GetDateTimeByCulture(this.EndDateTime.Value);
                }
                return null;
            }
        }


        public List<FileVM> Files { get; set; }
        public string Latitude { get;   set; }
        public string Longitude { get;   set; }

        public int ReportsCount { get {
                if (this.Reports == null) return 0;
                return this.Reports.Count;
            } }
        public int FavoritesCount
        {
            get
            {
                if (this.AdFavorites == null) return 0;
                return this.AdFavorites.Count;
            }
        }
        public int ViewersCount
        {
            get
            {
                if (this.AdsViewers == null) return 0;
                return this.AdsViewers.Count;
            }
        }
    }

   


    public partial class Offer
    {
        public int State { get; set; }
        public bool IsFinshed
        {
            get
            {
                return DateTime.Now > this.EndDateTime;

            }
        }
        public User CreateBy
        {
            get
            {
                if (this.Log == null) return null;
                var user = this.Log.Histories.First().User;
                return new User
                {
                    UserName = user.UserName,
                    Serial = user.Serial,
                    ImageUrl = user.UserInformation.File.FullFileUrl,
                };
            }
        }
        public string CreateDateTime
        {
            get
            {
                return DateService.GetDateTimeByCulture(this.Log.Histories.First().DateTime);
            }
        }

        public List<FileVM> Files { get; set; }
        public List<string> ImagesRemoveAfterSaveDB = new List<string>();
    }



    public partial class History
    {
        public string Titel { get { return LanguageService.IsEn ? this.TitleEn : this.TitleAr; } }
    }

    public partial class AdsSlider
    {
        public int State { get; set; }

        public HttpPostedFileBase NewFile { get; set; }
    }



    public partial class ReportType
    {
        public int State { get; set; }
        public string ReportTypeName { get { return LanguageService.IsEn ? this.NameEn : this.NameEn; } }
    }


    public partial class PointPackage
    {
        public string PointPackageName { get { return LanguageService.IsEn ? NameEn : NameAr; } }
        public int State { get; set; }
    }
        public partial class UserPointPackage
    {
        public bool IsPaid
        {
            get
            {
                if (this.Payment.Responsecode == "00")
                    return true;
                else
                    return false;
            }
        }
    }




}
