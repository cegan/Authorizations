using System;
using System.DirectoryServices.AccountManagement;
using TransferAuthorizationWeb.WebUtilities;

namespace TransferAuthorizationWeb.Security
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["type"] != "form")
            {
                Response.Redirect("~/security/winlogin.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (var context = new PrincipalContext(ContextType.Machine, "EGAN"))
            //using (var context = new PrincipalContext(ContextType.Domain, "Fcsamerica.com"))
            {
                var isValidUser = context.ValidateCredentials(txtUserName.Text, txtPassword.Text);

                if(isValidUser)
                {
                    new UserSessionUtilities().CreateUserSession(txtUserName.Text);
                }
            }
        }
    }
}