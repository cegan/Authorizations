namespace TransferAuthorizationWeb.Areas.Approvals.Models
{
    public class PendingWireApprovals : IApprovalsBase
    {
        public string Id { get; set; }

        public string Amount { get; set; }
        public string CustomerName { get; set; }
        public string BeneficiaryName { get; set; }
    }
}