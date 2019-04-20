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
        public string ImageUrl { get {
                if (this.UserInformation == null) return "";
                return this.UserInformation.File.FullFileUrl;
            } }
        public bool RememberMe { get;   set; }
        public string NewPassword { get; set; }
        //public string CurrentPassword { get; set; }
        public string ConfirmPassword { get; set; }
        public bool IsSuccessLogin { get; set; }
        public string CountryFlagUrl
        {
            get
            {
                if (this.UserInformation == null) return "";
                if (this.UserInformation.FKAddress_Id > 0)
                {
                    if (this.UserInformation.Address.FKCountry_Id.HasValue)
                        return this.UserInformation.Address.Country.File.FullFileUrl;
                }

                return "";

            }
        }
        public string CountryName
        {
            get
            {
                if (this.UserInformation == null) return "";
                if (this.UserInformation.FKAddress_Id > 0)
                {
                    if (this.UserInformation.Address.FKCountry_Id.HasValue)
                        return this.UserInformation.Address.Country.CountryName;
                }

                return "";

            }
        }

        public object Gender
        {
            get
            {
                if (this.UserInformation == null) return "";
                if (this.UserInformation.FKGender_Id.HasValue)
                {
                    return new
                    {
                        this.UserInformation.Gender.Id,
                        Name = this.UserInformation.Gender.ResourceName
                    };
                }
                return null;
            }
        }

        public string JobName
        {
            get
            {
                if (this.UserInformation == null) return "";
                if (this.UserInformation.FKJob_Id.HasValue)
                    return this.UserInformation.Job.JobName
                    ;
                return null;
            }
        }

        
        public object Address
        {
            get
            {
                if (this.UserInformation == null) return "";
                if (this.UserInformation.FKAddress_Id.HasValue)
                {
                    return new
                    {
                         this.UserInformation.Address.Street,
                        this.UserInformation.Address.City,
                        this.UserInformation.Address.PostalCode,
                    };
                }
                return null;
            }
        }
        public object Country
        {
            get
            {
                if (this.UserInformation == null) return "";
                if (this.UserInformation.FKAddress_Id.HasValue)
                {
                    if (this.UserInformation.Address.FKCountry_Id.HasValue)
                    {
                        return new
                        {
                            this.UserInformation.Address.Country.Id,
                            this.UserInformation.Address.Country.CountryKey,
                            Name = this.UserInformation.Address.Country.CountryName,
                            this.UserInformation.Address.Country.File.FullFileUrl
                        };
                    }
                    return null;
                }
                return null;
            }
        }
        public object Province
        {
            get
            {
                if (this.UserInformation == null) return "";
                if (this.UserInformation.FKAddress_Id.HasValue)
                {
                    if (this.UserInformation.Address.FkProvince_Id.HasValue)
                    {
                        return new
                        {
                            this.UserInformation.Address.Province.Id,
                            Name = this.UserInformation.Address.Province.ProvinceName,
                        };
                    }
                    return null;
                }
                return null;
            }
        }

        public string UserCulture { get; set; }
    


        public string Phone
        {
            get
            {
                return this.UserInformation.PhoneNumber;
            }
        }


        /// <summary>
        /// الشخص الحالى يتابع كم شخص
        /// </summary>
        public int FollowingCount
        {
            get
            {
                if (this.UserInformation.Following == null) return 0;
                return this.UserInformation.Following.UsersFollowings.Count();
            }
        }
        /// <summary>
        /// كم شخص يتابع الشخص الحالى
        /// </summary>
        public int FollowersCount { get { return this.UsersFollowings.Count(); } }
    }


    public partial class UserInformation
    {
    
        public string LanguageCode { get; set; }
        public bool IsBirthDate { get { return this.BirthDate != null; } }
        public List<LanguageUsing> Languages { get; set; }
        public string OldImageUrl { get; set; }
        public bool IsAdSummary { get; internal set; }
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
        public string State { get; set; }
    }


    public partial class Province
    {
        public string ProvinceName { get { return LanguageService.IsEn ? NameEn : NameAr; } }
        public string State { get; set; }
    }

    
    public partial class Nationality
    {
        public string NationalityName { get { return LanguageService.IsEn ? NameEn : NameAr; } }
        public string State { get; set; }


    }
    

    public partial class Country
    {
        public string CountryName { get { return LanguageService.IsEn ? NameEn : NameAr; } }
        public string State { get; set; }

    }
 
    
    
    public partial class PagesAllow
    {
        public string State { get; set; }
    }
    public partial class Role
    {
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }
    public partial class Menu
    {
        public string State { get; set; }
        public string TokenValue { get { return ResourceService.GetToken(this.ResourceName); } }
    }
    public partial class SubMenu
    {
        public string State { get; set; }
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
    
    public partial class File
    {
        public string FullFileUrl { get { return this.AppsInformation.Value+ this.FileUrl; } }
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
    }


    public partial class Ad
    {
        public bool IsStarted { get { return  DateTime.Now>= this.StartDateTime; } }
        public bool IsFinshed { get { return DateTime.Now > this.EndDateTime; } }
        private DateVM Timer
        {
            get
            {
                if(this.IsStarted)
                return new DateVM(this.EndDateTime.Value);
                return null;
            }
        }
        public bool IsFavorite
        {
            get
            {

                var UserId = AccessToken.GetUserId();
                if (UserId == null) return false;

                return
                    this.AdFavorites.Any(c => c.FkUser_Id == UserId);
            }
        }
        public int State { get; set; }
        public object CreateBy
        {
            get
            {
                if (this.Log == null) return null;
                bool IsFollowing = false;
                var user = this.Log.Histories.First().User;
                int UserLoggadId = AccessToken.GetUserId();

                //التحقق هل المستخدم الحالى يتابع المستخدم الى قام بنشر الاعلان ام لا يتابعة
                if (UserLoggadId > 0)
                    using (SilgaramEntities db = new SilgaramEntities())
                        IsFollowing =
                                db.UsersFollowings.Any(c => c.FkUser_Id == user.Id && c.Following.UsersFollowings.Any(v => v.User.Id == UserLoggadId));

                return new  
                {
                    user.Id,
                      user.UserInformation.FullName,
                     user.UserName,
                    Serial = user.Serial,
                    ImageUrl = user.UserInformation.File.FullFileUrl,
                    IsFollowing
                };
            }
        }
        public Location MapLocation
        {
            get
            {
                return new Models.Location
                {
                    Latitude = this.Location.Latitude,
                    Longitude = this.Location.Longitude,
                };
            }
        }
        public List<FileVM> Images
        {
            get
            {
                if (this.Album == null) return null;
                if (this.Album.AlbumFiles.Count == 0) return null;
                return this.Album.AlbumFiles.Select(b => new FileVM
                {
                    FileId = b.Id,
                    FileUrl = b.File.FullFileUrl,
                }).ToList();
            }
        }
        public string BaseImage
        {
            get
            {
                if (this.Album == null) return null;
                if (this.Album.AlbumFiles.Count == 0) return null;
                return this.Album.AlbumFiles.First().File.FullFileUrl;
            }
        }
        public bool CanUpdate { get { return this.FkUser_Id == AccessToken.GetUserId(); } }

        public string ShearLink { get; set; }

    }

    public partial class Offer
    {
        public bool IsStarted { get { return DateTime.Now>this.StartDateTime  ; } }
        public bool IsFinshed { get { return DateTime.Now > this.EndDateTime; } }
        public DateVM Timer
        {
            get
            {
                if (this.IsStarted)
                    return new DateVM(this.EndDateTime);
                return null;
            }
        }
        public bool IsFavorite
        {
            get
            {

                var UserId = AccessToken.GetUserId();
                if (UserId == null) return false;

                return
                    this.OfferFavorites.Any(c => c.FkUser_Id == UserId);
            }
        }
        public decimal PurePrice { get {
                return Price * (DiscountRate / 100);
            } }
        public List<string> Images { get {
                if (this.Album==null) return null;
                return this.Album.AlbumFiles.Select(v => v.File.FullFileUrl).ToList();
            } }
        public string BaseImage
        {
            get
            {
                if (this.Album==null) return null;
                return this.Album.AlbumFiles.First().File.FullFileUrl;
            }
        }

    }



    public partial class History
    {
        public string Title { get { return LanguageService.IsEn ? this.TitleEn : this.TitleAr; } }

        public string NameActionEn { get { return ResourceService.GetToken(this.State.ResourceName,true); } }
        public string NameActionAr { get { return ResourceService.GetToken(this.State.ResourceName,false); } }
    }


    public partial class ReportType
    {
        public string ReportName { get { return LanguageService.IsEn ? this.NameEn : this.NameAr; } }
    }






    public partial class ChatMessage
    {
        //IsOwnar
        public string UserImage
        {
            get
            {
                if (this == null) return "";
                if (this.IsOwnar)
                    return this.Chatting.Ad.User.ImageUrl;
                return this.Chatting.User.ImageUrl;
            }
        }
        public string UserName
        {
            get
            {
                if (this == null) return "";
                if (this.IsOwnar)
                    return this.Chatting.Ad.User.UserName;
                return this.Chatting.User.UserName;
            }
        }
        public string FullName
        {
            get
            {
                if (this == null) return "";
                if (this.IsOwnar)
                    return this.Chatting.Ad.User.UserInformation.FullName;
                return this.Chatting.User.UserInformation.FullName;
            }
        }
        public bool IsFromMe
        {
            get
            {
                if (this == null) return false;
                if (this.IsOwnar)
                    return this.Chatting.Ad.User.Id == AccessToken.GetUserId();
                return this.Chatting.User.Id == AccessToken.GetUserId();
            }
        }
    }



    public partial class PointPackage
    {
        public string PointPackageName { get { return LanguageService.IsEn ? this.NameEn : this.NameAr; } }
        public string Description { get { return LanguageService.IsEn ? string.Format("Create {0} advertisements only for {1}KWD", this.Points, this.Price) : string.Format("انشاء {0} اعلانات فقط بمقابل {1}دك", this.Points, this.Price); } }
    }








}
