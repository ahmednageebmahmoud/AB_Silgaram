using DAL.Models;
using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Bll
{
    public class JobsData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get jobs
        public object GetJobs() {
            var jobs = db.Jobs.ToList();
            if (jobs.Count == 0)
                return null;
            return jobs.Select(x => new { x.Id, x.NameAr,x.NameEn ,x.JobName }).ToList();
        }


        //Save Chenage
        public object SaveChenage(Job[] jobs)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.Jobs);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;
            try
            {
                foreach (Job job in jobs)
                {
                    if (job.State ==  StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.Job(job, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (job.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.Job(job, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (job.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.Job(job, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                }
                db.SaveChanges();
                return new { RequestType = RequestTypeEnumVM.Success, Message = Token.Saved };
            }
            catch (Exception ex)
            {
                return new { RequestType = RequestTypeEnumVM.Error, Message = Token.NotSaveChange };
            }
        }

        public void Dispose()
        {
            db.Dispose();
        }
    }//End Class
}
