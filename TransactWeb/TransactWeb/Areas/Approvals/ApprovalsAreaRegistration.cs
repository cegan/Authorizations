using System.Web.Mvc;

namespace TransferAuthorizationWeb.Areas.Approvals
{
    public class ApprovalsAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Approvals";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            //Default view for the Approvals Area
            context.MapRoute("Approvals2", "Approvals/{controller}", new { controller = "Ach", action = "PendingAch" });

            context.MapRoute(
                "ApprovalsDefault",
                "Approvals/{controller}/{action}/{id}",
                new { action = "PandingAch", id = UrlParameter.Optional }
            );
        }
    }
}
