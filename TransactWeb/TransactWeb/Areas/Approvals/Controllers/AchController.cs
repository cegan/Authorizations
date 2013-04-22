using System;
using System.Collections.Generic;
using System.Net;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using MoonAPNS;
using TransferAuthorizationService;
using TransferAuthorizationService.ServiceContracts;
using TransferAuthorizationWeb.Areas.Approvals.Models;
using TransferAuthorizationWeb.WebUtilities;

namespace TransferAuthorizationWeb.Areas.Approvals.Controllers
{
    public class AchController : Controller
    {
      

        //[AuthorizedUsers(Roles = "Administrators,FundItApprovers")]
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult AddAchTransfer(AchAuthorization authorization)
        {

            //var json = new JavaScriptSerializer().Serialize(authorization);
           
            var webClient = new WebClient();
            string data = webClient.DownloadString("http://192.168.1.2/TransferAuthorizationService/AddAchTransfer?name=" + authorization.Name + "&accountNumber=" + authorization.AccountNumber + "&amount=" + authorization.Amount.ToString() );
            
            
            
            return Json("", JsonRequestBehavior.AllowGet);
        }


      


        //[AuthorizedUsers(Roles = "Administrators,FundItApprovers")]
        public ActionResult PendingAch()
        {
            ViewData.Add("UserId", "EganC");

            return View();
        }

        //[AuthorizedUsers(Roles = "Administrators,FundItApprovers")]
        public JsonResult ApproveAch(string userId)
        {
            var achApprovalHistory = WebServiceUtilities.HttpGet("http://localhost/TransferAuthorizationService/ApproveAch/" + userId);

            return Json(achApprovalHistory, JsonRequestBehavior.AllowGet);
        }



        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetPendingAchApprovals(string userId)
        {
            ViewData.Add("UserId", "EganC");


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

            };

           // var pendingAchApprovals = WebServiceUtilities.HttpGet("http://localhost/TransferAuthorizationService/GetAchApprovals/1");

           // return Json(pendingAchApprovals, JsonRequestBehavior.AllowGet);


            return Json(pendingChecks, JsonRequestBehavior.AllowGet);
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult GetAchApprovalHistory(string userId)
        {
            var achApprovalHistory = WebServiceUtilities.HttpGet("http://localhost/TransferAuthorizationService/GetAchApprovalHistory/1");

            return Json(achApprovalHistory, JsonRequestBehavior.AllowGet);
        }
    }
}






































/*Note:If any business logic needs to be applied to the response data, you can deserialize the JSON to a typed list, work on the data,
           then serialize back to JSON.
             
           var approvals = new List<PendingAchApprovals>(new JavaScriptSerializer().Deserialize<IEnumerable<PendingAchApprovals>>(pendingAchApprovals));

           foreach (var returnedPendingApprovals in approvals)
           {
                
           }

           //return JSON
           return Json(returnedPendingChecks, JsonRequestBehavior.AllowGet);
             
            */
