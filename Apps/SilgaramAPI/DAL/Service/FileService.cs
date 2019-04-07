using DAL.Models.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http.Headers;
using DAL.Models;
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
                if (!file.ServerPathSave.EndsWith("/"))
                    file.ServerPathSave += "/";


                file.SavedPath =  "Image" +Guid.NewGuid().ToString() +".jpg";
     
                System.IO.File.WriteAllBytes(HttpContext.Current.Server.MapPath(file.ServerPathSave) + file.SavedPath, Convert.FromBase64String(file.FileBase64));

                file.SavedPath = file.ServerPathSave + file.SavedPath;
                file.IsSave = true;
                return file;
            }
            catch (Exception ex)
            {
                file.IsSave = false;
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

        internal static void RemoveFiles(List<AlbumFile> albumFiles)
        {
            try
            {
                foreach (var item in albumFiles)
                {
                    if (item != null)
                        RemoveFile(HttpContext.Current.Server.MapPath(item.File.FileUrl));
                }

            }
            catch (Exception ex)
            {

            }
        }
    }//End Class
}
