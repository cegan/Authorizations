using System.Web.Mvc;

namespace TransferAuthorizationWeb.Areas.UserMaintainTables
{
    public class UserMaintainTablesAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "UserMaintainTables";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "UserMaintainTables",
                "UserMaintainTables/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
