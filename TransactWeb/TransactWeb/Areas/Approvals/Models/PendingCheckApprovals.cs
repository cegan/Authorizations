using System;

namespace TransferAuthorizationWeb.Areas.Approvals.Models
{
    public class PendingCheckApprovals
    {
        public int Id { get; set; }
        public int CheckNumber { get; set; }
        public int CheckSignerId { get; set; }
        public int CheckApproverId { get; set; }

        public decimal Amount { get; set; }
        
        public string Payee1 { get; set; }
        public string Payee2 { get; set; }
        public string Payee3 { get; set; }

        public DateTime ApproverApproved { get; set; }
        public DateTime SignerSigned { get; set; }

    }
}