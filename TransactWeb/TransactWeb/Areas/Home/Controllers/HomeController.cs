using System.Web.Mvc;


namespace TransferAuthorizationWeb.Areas.Home.Controllers
{
    public class HomeController : Controller
    {
        //[AuthorizedUsers(Roles = "Administrators,FundItApprovers")]
        public ActionResult Home()
        {
            return View();
        }
    }
}
