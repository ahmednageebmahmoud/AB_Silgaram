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
    public class DropDownService : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();

        public void Dispose()
        {
            db.Dispose();
        }

        public object Countries()
        {
            var Data = db.Countries.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.CountryName,
                    c.CountryKey,
                    CountryFlag = c.File.FullFileUrl
                }).ToList()
            };
        }

        public object Provinces(int countryId)
        {
            var Data = db.Provinces.Where(c => c.FKCountry_Id == countryId).ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.ProvinceName,
                }).ToList()
            };
        }
        public object Jobs()
        {
            var Data = db.Jobs.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.JobName,
                }).ToList()
            };
        }
        public object SubCategories(int categoryId)
        {
            var Data = db.SubCategories.Where(c => c.FkCategory_Id == categoryId).ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.SubCategoryName,
                    Image = c.File.FullFileUrl
                }).ToList()
            };
        }

        public object GetCategoriesWithSubCategory()
        {

            var Data = db.Categories.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.CategoryName,
                    SubCategories=c.SubCategories.Select(v=> new {
                        v.Id,
                        Name=v.SubCategoryName,
                    Image = v.File.FullFileUrl

                    })
                }).ToList()
            };
        }

        public object FullCategories()
        {

            var Data = db.Categories.ToList();
            var DataSlider = db.PositionTypes.ToList();

            if (Data.Count == 0 && DataSlider.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = new
                {
                    Categories = Data.Select(c => new
                    {
                        c.Id,
                        Name = c.CategoryName,
                        SubCategories = c.SubCategories.Select(v => new
                        {
                            v.Id,
                            Name = v.SubCategoryName,
                            Image = v.File.FullFileUrl
                        }).ToList()
                    }).ToList(),
                    Slider = DataSlider.Select(c => new
                    {
                        Position = c.ResourceName,
                        Ads = c.AdsSliders.Select(v => new { Image = v.File.FullFileUrl })
                    })
                }
            };
        }

        public object Categories()
        {
            var Data = db.Categories.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.CategoryName,
                    
                }).ToList()
            };
        }

        public object Agents(int skip, int take)
        {
            var Data = db.Users.Where(c => c.IsAgent).OrderByDescending(c => c.Id).Skip(skip).Take(take).ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new AgentVM
                {
                    Id = c.Id,
                    Name = c.UserInformation.FullName,
                    Image = c.ImageUrl,
                    JobName = c.JobName,
                    Phone = c.Phone
                }).ToList()
            };
        }

        public object ReportTypes()
        {
            var Data = db.ReportTypes.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.ReportName,

                }).ToList()
            };
        }

        public object Slider()
        {
            var Data = db.PositionTypes.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {

                    Position = c.ResourceName,
                    Ads = c.AdsSliders.Select(v => new { Image = v.File.FullFileUrl })
                })
            };
        }

        public object SocialMediaLinks()
        {

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data =   new
                {
                    FaceBookLink = db.AppsInformations.Find(AppInformationEnumVM.FaceBookLink).Value,
                    TwitterLink = db.AppsInformations.Find(AppInformationEnumVM.TwitterLink).Value,
                    InstagramLink = db.AppsInformations.Find(AppInformationEnumVM.InstagramLink).Value
                }
            };
        }

        public object SubCategories()
        {
            var Data = db.SubCategories.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    c.FkCategory_Id,
                    Name = c.SubCategoryName,
                 Image=  c.File.FullFileUrl
                }).ToList()
            };
        }

        public object SocialStatus()
        {
            var Data = db.SocialStatus.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.TokenValue,
                }).ToList()
            };
        }
        public object Genders()
        {
            var Data = db.Genders.ToList();
            if (Data.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.DataNotFound };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Select(c => new
                {
                    c.Id,
                    Name = c.TokenValue,
                }).ToList()
            };
        }
        public object AboutUs()
        {
            int Id = LanguageService.IsEn ? AppInformationEnumVM.AboutUsEn : AppInformationEnumVM.AboutUsAr;
            var Data = db.AppsInformations.Find(Id);

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Value
            };
        }
        public object Terms()
        {
            int Id = LanguageService.IsEn ? AppInformationEnumVM.TermsEn : AppInformationEnumVM.TermsAr;
            var Data = db.AppsInformations.Find(Id);

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Data.Value
            };
        }



    }//end Class
}
