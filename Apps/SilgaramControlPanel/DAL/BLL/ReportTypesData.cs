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
    public class ReportTypesData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        DeleteService DeleteS = new DeleteService();
        CreateService CreateS = new CreateService();
        UpdateService UpdateS = new UpdateService();

        //Get reportTypes
        public object GetReportTypes() {
            var reportTypes = db.ReportTypes.ToList();
            if (reportTypes.Count == 0)
                return null;
            return reportTypes.Select(x => new { x.Id, x.NameAr,x.NameEn ,x.ReportTypeName, ReportsCount= x.Reports.Count }).ToList();
        }


        //Save Chenage
        public object SaveChenage(ReportType[] reportTypes)
        {
            PagesAllow PageAllow = PageService.GetPageAllow(PageEnumVM.ReportTypes);
            DeleteS.db = db;
            UpdateS.db = db;
            CreateS.db = db;
            try
            {
                foreach (ReportType reportType in reportTypes)
                {
                    if (reportType.State ==  StateEnumVM.Delete)
                    {
                        //Delete
                        var ObjectReturn = DeleteS.ReportType(reportType, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (reportType.State == StateEnumVM.Update)
                    {
                        //Update
                        var ObjectReturn = UpdateS.ReportType(reportType, PageAllow);
                        if (ObjectReturn != null)
                            return ObjectReturn;
                    }
                    else if (reportType.State == StateEnumVM.Create)
                    {
                        //Create
                        var ObjectReturn = CreateS.ReportType(reportType, PageAllow);
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
