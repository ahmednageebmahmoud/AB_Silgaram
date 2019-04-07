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
    
    public partial class Payment
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Payment()
        {
            this.UserPointPackages = new HashSet<UserPointPackage>();
        }
    
        public int Id { get; set; }
        public string GatewayName { get; set; }
        public string OrderNo { get; set; }
        public string CustomerEmail { get; set; }
        public string ReferenceNumber { get; set; }
        public Nullable<decimal> Amount { get; set; }
        public string Result { get; set; }
        public string GatewayAccount { get; set; }
        public string PostDate { get; set; }
        public string TrackID { get; set; }
        public string TranID { get; set; }
        public string Eci { get; set; }
        public string Responsecode { get; set; }
        public string PaymentID { get; set; }
        public string AuthCode { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserPointPackage> UserPointPackages { get; set; }
    }
}