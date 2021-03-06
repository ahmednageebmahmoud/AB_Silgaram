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
    
    public partial class UsersPurchasesOffer
    {
        public int Id { get; set; }
        public int FkUser_Id { get; set; }
        public int FkOffer_Id { get; set; }
        public decimal OfferPrice { get; set; }
        public int OfferDiscountRate { get; set; }
        public decimal OfferNetPrice { get; set; }
        public System.DateTime BayDateTime { get; set; }
        public long FkPayment_Id { get; set; }
    
        public virtual Offer Offer { get; set; }
        public virtual Payment Payment { get; set; }
        public virtual User User { get; set; }
    }
}
