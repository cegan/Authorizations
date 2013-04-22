//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MvcApplication1
{
    using System;
    using System.Collections.Generic;
    
    public partial class ContactInformation
    {
        public ContactInformation()
        {
            this.AchAuthorizations = new HashSet<AchAuthorization>();
            this.CheckAuthorizations = new HashSet<CheckAuthorization>();
            this.WireAuthorizations = new HashSet<WireAuthorization>();
        }
    
        public int Id { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string ZipCode { get; set; }
        public string HomePhone { get; set; }
        public string MobilPhone { get; set; }
        public string EmailAddress { get; set; }
    
        public virtual ICollection<AchAuthorization> AchAuthorizations { get; set; }
        public virtual ICollection<CheckAuthorization> CheckAuthorizations { get; set; }
        public virtual ICollection<WireAuthorization> WireAuthorizations { get; set; }
    }
}