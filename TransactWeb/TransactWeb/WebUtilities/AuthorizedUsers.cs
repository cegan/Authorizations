using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace TransferAuthorizationWeb.WebUtilities
{
   
    public class AuthorizedUsers : AuthorizeAttribute
    {
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            var roles = HttpContext.Current.Request.Cookies["AuthorizedUserRoles"];

            if (roles != null)
            {
                var authorizedUserRoles = new JavaScriptSerializer().Deserialize<List<AuthorizedRoles>>(roles.Value);
                var rolesToAuthorize    = Roles.Split(',');

                if (rolesToAuthorize.Any())
                {
                    return (from role in rolesToAuthorize from c in authorizedUserRoles where role == c.Role select role).Any();
                }       
            }
            
            return false;
        }
    }

}