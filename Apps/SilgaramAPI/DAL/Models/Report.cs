//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DAL.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Report
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public int FkUser_Id { get; set; }
        public int FkAd_Id { get; set; }
        public int FkReportType_Id { get; set; }
        public int FkLog_Id { get; set; }
    
        public virtual Ad Ad { get; set; }
        public virtual Log Log { get; set; }
        public virtual ReportType ReportType { get; set; }
        public virtual User User { get; set; }
    }
}
