namespace TransferAuthorizationWeb.Areas.Approvals.Models
{
    public class AchApprovalHistory
    {
        public decimal Amount { get; set; }
        public string ApprovalDate { get; set; }
        public string CheckNumber { get; set; }
        public string CheckSignerId { get; set; }
    }
}