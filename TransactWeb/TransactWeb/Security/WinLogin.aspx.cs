using System;
using System.Web;
using System.Web.UI;
using TransferAuthorizationWeb.WebUtilities;

namespace TransferAuthorizationWeb.Security
{
    public partial class WinLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var user = HttpContext.Current.User.Identity.Name;

                if (user.Length == 0)
                {
                    Response.StatusCode             = 401;
                    Response.StatusDescription      = "Unauthorized";
                    Response.End();
                }
                else
                {
                    new UserSessionUtilities().CreateUserSession(user);
                }
            }
        }
    }
}