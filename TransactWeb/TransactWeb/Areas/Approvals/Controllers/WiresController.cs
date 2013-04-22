using System.Collections.Generic;
using System.Web.Mvc;
using TransferAuthorizationWeb.Areas.Approvals.Models;

namespace TransferAuthorizationWeb.Areas.Approvals.Controllers
{
    public class WiresController : Controller
    {
        
        public ActionResult PendingWires()
        {
            return View();
        }


        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult GetPendingWireApprovals()
        {
            var pendingChecks = new List<PendingCheckApprovals>
            {
                new PendingCheckApprovals {Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
            };

            return Json(pendingChecks, JsonRequestBehavior.AllowGet);
        }


        //[AuthorizedUsers(Roles = "Administrators,FundItApprovers")]
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult ApproveWire(string wireNumber)
        {
            if (!string.IsNullOrEmpty(wireNumber))
            {
                return Json(new { checkNumber = wireNumber }, JsonRequestBehavior.AllowGet);
            }

            return null;
        }

    }
}
