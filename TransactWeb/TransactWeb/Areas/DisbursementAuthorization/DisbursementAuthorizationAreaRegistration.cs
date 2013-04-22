using System.Web.Mvc;

namespace TransferAuthorizationWeb.Areas.DisbursementAuthorization
{
    public class DisbursementAuthorizationAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "DisbursementAuthorization";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "DisbursementAuthorization",
                "DisbursementAuthorization/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
