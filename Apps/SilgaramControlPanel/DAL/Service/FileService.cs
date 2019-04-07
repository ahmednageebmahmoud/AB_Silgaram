using DAL.Models.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http.Headers;
using DAL.Models;
using System.Web.Script.Serialization;
using System.IO;
using System.Web;

namespace DAL.Service
{
    public class FileService
    {

        public static FileSaveVM SaveFile(FileSaveVM file)
        {
            try
            {
                string Extension = Path.GetExtension(file.File.FileName);

                    file.IsSaved = false;
                if(!file.Extensions.Any(c=> c==Extension.ToLower()))
                    return file;

                file.SavedPath =  Path.GetFileName(file.File.FileName) + new Random().Next().ToString() + Extension;
     
                file.File.SaveAs(HttpContext.Current.Server.MapPath(file.ServerPathSave)+file.SavedPath);

                file.SavedPath = file.ServerPathSave + file.SavedPath;
                file.IsSaved = true;
                return file;
            }
            catch (Exception ex)
            {
                file.IsSaved = false;
                return file;
            }
        }

        public static void RemoveFile(string oldImageUrl)
        {
            try
            {
                System.IO.File.Delete(HttpContext.Current.Server.MapPath(oldImageUrl));
            }
            catch (Exception ex)
            {

            }

        }

        public static void RemoveFiles(List<string> imagesRemove)
        {
            try
            {
                foreach (var item in imagesRemove)
                {
                    if(item!=null)
                    RemoveFile(HttpContext.Current.Server.MapPath(item));
                }

            }
            catch (Exception ex)
            {

            }
      
        }
    }//End Class
}
