using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Enums;
using DAL.Service;
using DAL.Models.ViewModel;
using System.Web;
using DAL.Resource;

namespace DAL.Bll
{
    public class UserProfileData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        UpdateService UpdateS = new UpdateService();
        //GetUserData
        public object GetUserData(int userId)
        {
            var data= db.Users.Where(x => x.Id == userId).Single() ;
            if (data.UserInformation.File == null)
                data.UserInformation.File = new File() { FileUrl = DefaultsVM.ImageDefult };

            return  new {
                data.UserName,
                data.UserInformation.FullName,
                data.UserInformation.Job.JobName,
              ImageUrl=  data.UserInformation.File.FileUrl
            };
            
        }


        public void Dispose()
        {
            db.Dispose();
        }
    }//end Class
}
