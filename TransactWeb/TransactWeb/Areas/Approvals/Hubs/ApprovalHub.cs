using SignalR.Hubs;

namespace TransferAuthorizationWeb.Areas.Approvals.Hubs
{
    public class ApprovalHub : Hub
    {
        public void Authorized(string message)
        {
            //Call the addMessage method on all clients.
            Clients.addMessage(message);
        }
    }
}
