﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TransferAuthorizationService
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class AuthorizationsEntities : DbContext
    {
        public AuthorizationsEntities()
            : base("name=AuthorizationsEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<AchAuthorization> AchAuthorizations { get; set; }
        public DbSet<CheckAuthorization> CheckAuthorizations { get; set; }
        public DbSet<WireAuthorization> WireAuthorizations { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<Approver> Approvers { get; set; }
        public DbSet<ContactInformation> ContactInformations { get; set; }
    }
}
