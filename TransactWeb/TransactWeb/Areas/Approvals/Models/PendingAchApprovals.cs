namespace TransferAuthorizationWeb.Areas.Approvals.Models
{
    public class PendingAchApprovals : IApprovalsBase
    {
        public string Id { get; set; }
        public string Amount { get; set; }
        public string CheckNumber { get; set; }
        public string CheckSignerId { get; set; }
        public string Payee1 { get; set; }
        public string Payee2 { get; set; }
        public string Payee3 { get; set; }
    }
}