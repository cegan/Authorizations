using System;

namespace MvcApplication1.Models
{
    public class AchAuthorization
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string AccountNumber { get; set; }
        public string Notes { get; set; }
        public string Amount { get; set; }
        public string OriginatingSystem { get; set; }
        public DateTime? IssuedOn { get; set; }
        public bool? IsApproved { get; set; }
    }
}