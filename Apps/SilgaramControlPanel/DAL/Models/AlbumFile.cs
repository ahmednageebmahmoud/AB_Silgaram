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
    
    public partial class AlbumFile
    {
        public int Id { get; set; }
        public int FkAlbum_Id { get; set; }
        public int FkFile_Id { get; set; }
    
        public virtual Album Album { get; set; }
        public virtual File File { get; set; }
    }
}
