using System.Web.Mvc;

namespace TransferAuthorizationWeb.Areas.Home
{
    public class HomeAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Home";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Home",
                "Home/{controller}/{action}/{id}",
                new { action = "Home", id = UrlParameter.Optional }
            );
        }
    }
}
