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
            this.UsersPurchasesOffers = new HashSet<UsersPurchasesOffer>();
        }
    
        public long Id { get; set; }
        public Nullable<int> IsCancelled { get; set; }
        public string Hash { get; set; }
        public string InvoiceId { get; set; }
        public string DateTime { get; set; }
        public string Amount { get; set; }
        public string TransactionId { get; set; }
        public string Mode { get; set; }
        public string Status { get; set; }
        public string Result { get; set; }
        public string PaymentID { get; set; }
        public string PostDate { get; set; }
        public string TranID { get; set; }
        public string Auth { get; set; }
        public string Ref { get; set; }
        public string OrderNo { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserPointPackage> UserPointPackages { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UsersPurchasesOffer> UsersPurchasesOffers { get; set; }
    }
}
