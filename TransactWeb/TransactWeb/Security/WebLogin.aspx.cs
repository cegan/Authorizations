using System;

namespace TransferAuthorizationWeb.Security
{
    public partial class WebLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("~/security/login.aspx?type=form");
        }
    }
}