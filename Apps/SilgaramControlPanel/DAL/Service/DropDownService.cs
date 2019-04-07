using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Models;
namespace DAL.Service
{
    public class DropDownService : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();

        public void Dispose()
        {
            db.Dispose();
        }

        /// <summary>
        /// Get All Countries
        /// </summary>
        /// <returns></returns>
        public object Countries()
        {
            var Data = db.Countries.ToList();
            return Data.Select(c => new
            {
                c.Id,
                c.CountryName,
            }).OrderByDescending(c => c.CountryName).ToList();
        }

        public object Pages()
        {
            var Data = db.Pages.ToList();
            return Data.Select(c => new
            {
                c.Id,
                Name = c.TokenValue,
            }).OrderByDescending(c => c.Name).ToList();
        }

        public object Categories()
        {
            var Data = db.Categories.ToList();
            return Data.Select(c => new
            {
                c.Id,
                c.CategoryName
            }).OrderByDescending(c => c.CategoryName).ToList();
        }

        public object SubCategories()
        {
            var Data = db.SubCategories.ToList();
            return Data.Select(c => new
            {
                c.Id,
                c.SubCategoryName,
                c.FkCategory_Id
            }).OrderByDescending(c => c.SubCategoryName).ToList();
        }

        //Menus 
        public object Menus()
        {
            var Data = db.Menus.ToList();
            return Data.Select(c => new
            {
                c.Id,
                Name = c.TokenValue,
            }).OrderByDescending(c => c.Name).ToList();
        }

        public object PagesRoleTypes()
        {
            var Data = db.PagesRoleTypes.ToList();
            return Data.Select(c => new
            {
                c.Id,
                Name = c.TokenValue,
            }).OrderByDescending(c => c.Name).ToList();
        }


        public object Roles()
        {
            var Data = db.Roles.ToList();
            return Data.Select(c => new
            {
                c.Id,
               Name= c.TokenValue,
            }).OrderByDescending(c => c.Name).ToList();
        }

        public object Provinces(int countryId)
        {
            var Data = db.Provinces.Where(c=> c.FKCountry_Id==countryId).ToList();
            return Data.Select(c => new
            {
                c.Id,
                c.ProvinceName,
            }).OrderByDescending(c => c.ProvinceName).ToList();
        }
        public object Provinces()
        {
            var Data = db.Provinces.ToList();
            return Data.Select(c => new
            {
                c.Id,
                c.ProvinceName,
                c.FKCountry_Id
            }).OrderByDescending(c => c.ProvinceName).ToList();
        }

        public object LanguageTypes()
        {
            var Data = db.LanguageTypes.ToList();
            return Data.Select(c => new
            {
                c.Id,
                Name = c.TokenValue,
            }).OrderByDescending(c => c.Name).ToList();
        }

        public object SocialStatus()
        {
            var Data = db.SocialStatus.ToList();
            return Data.Select(c => new
            {
                c.Id,
               Name= c.TokenValue,
            }).OrderByDescending(c => c.Name).ToList();
        }

        public object Genders()
        {
            var Data = db.Genders.ToList();
            return Data.Select(c => new
            {
                c.Id,
               Name= c.TokenValue,
            }).OrderByDescending(c => c.Name).ToList();
        }

        public object Jobs()
        {
            var Data = db.Jobs.ToList();
            return Data.Select(c => new
            {
                c.Id,
                c.JobName,
            }).OrderByDescending(c => c.JobName).ToList();
        }
    }
}
