using System;
using System.Web;
using System.Web.Security;

namespace TransferAuthorizationWeb.WebUtilities
{
    public class UserSessionUtilities
    {
        public void CreateUserSession(string userName)
        {
            var authenticationTicket        = new FormsAuthenticationTicket(1, userName, DateTime.Now, DateTime.Now.AddMinutes(30), false, "");
            var ticket                      = FormsAuthentication.Encrypt(authenticationTicket);

            var authenticationCookie        = new HttpCookie(FormsAuthentication.FormsCookieName, ticket);
            var userRoles                   = new HttpCookie("AuthorizedUserRoles", GetRolesForUser(userName));
            
            HttpContext.Current.Response.Cookies.Add(authenticationCookie);
            HttpContext.Current.Response.Cookies.Add(userRoles);

            HttpContext.Current.Response.Redirect(FormsAuthentication.GetRedirectUrl(userName, false));
        }

        private string GetRolesForUser(string userName)
        {
            return WebServiceUtilities.HttpGet("http://localhost/AuthorizationRESTService/GetUserRoles/eganc");
        }
    }


    public class AuthorizedRoles
    {
        public string Role { get; set; }
    }
}