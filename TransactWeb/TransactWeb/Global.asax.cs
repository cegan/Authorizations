using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.WebPages;


namespace TransferAuthorizationWeb
{
   
    public class MvcApplication : HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {

            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
            RegisterDisplayModes();
        }


        private void RegisterDisplayModes()
        {
            DisplayModeProvider.Instance.Modes.Insert(0, new DefaultDisplayMode("iPad")
            {
                ContextCondition = (context => context.Request.UserAgent.IndexOf
                    ("iPad", StringComparison.OrdinalIgnoreCase) >= 0)
            });

            DisplayModeProvider.Instance.Modes.Insert(1, new DefaultDisplayMode("iPhone")
            {
                ContextCondition = (context => context.Request.UserAgent.IndexOf
                    ("iPhone", StringComparison.OrdinalIgnoreCase) >= 0)
            });
        }


        protected void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
            //var authCookie = Context.Request.Cookies[FormsAuthentication.FormsCookieName];

            //if (authCookie == null)
            //{
            //    var requestUtl = HttpContext.Current.Request.Url;

            //    if (!requestUtl.ToString().Contains("security"))
            //    {
            //        Response.Redirect("~/security/login.aspx");
            //    }
            //}
        }
    }
}