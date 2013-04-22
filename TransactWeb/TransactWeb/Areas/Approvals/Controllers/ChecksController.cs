using System.Collections.Generic;
using System.Web.Mvc;
using TransferAuthorizationWeb.Areas.Approvals.Models;
using TransferAuthorizationWeb.WebUtilities;


namespace TransferAuthorizationWeb.Areas.Approvals.Controllers
{
    public class ChecksController : Controller
    {

        //[AuthorizedUsers(Roles = "Administrators,FundItApprovers")]
        public ActionResult PendingChecks()
        {
            return View();
        }


       
        //[AuthorizedUsers(Roles = "Administrators,FundItApprovers")]
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult ApproveCheck(string checkNumber)
        {
            if (!string.IsNullOrEmpty(checkNumber))
            {
                return Json(new { checkNumber = checkNumber }, JsonRequestBehavior.AllowGet);
            }

            return null;
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult GetPendingCheckApprovals()
        {
           
            var pendingChecks = new List<PendingCheckApprovals>
            {
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                new PendingCheckApprovals {Id=1, Amount = 500,CheckNumber = 45454545,CheckSignerId = 222,Payee1 = "Casey Egan",Payee2 = "Casey Egan",Payee3 = "Casey Egan"},
                
               
               
            };

            return Json(pendingChecks, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult GetCheckApprovalHistory()
        {
            var achApprovalHistory = new List<AchApprovalHistory>
            {
                new AchApprovalHistory {ApprovalDate = "3-8-2012",Amount = 30,CheckNumber = "12222",CheckSignerId = "Casey Egan"},
                new AchApprovalHistory {ApprovalDate = "12-8-2011",Amount = 30,CheckNumber = "12222",CheckSignerId = "Casey Egan"},
                new AchApprovalHistory {ApprovalDate = "5-12-2010",Amount = 30,CheckNumber = "12222",CheckSignerId = "Casey Egan"},
                new AchApprovalHistory {ApprovalDate = "9-8-2012",Amount = 30,CheckNumber = "12222",CheckSignerId = "Casey Egan"},
                
            };

            return Json(achApprovalHistory, JsonRequestBehavior.AllowGet);
        }

    }
}
