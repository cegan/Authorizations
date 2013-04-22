using System.Web.Mvc;

namespace TransferAuthorizationWeb.Areas.ParticipationRequests
{
    public class ParticipationRequestsAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "ParticipationRequests";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "ParticipationRequests",
                "ParticipationRequests/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
