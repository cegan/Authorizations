using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using MvcApplication1.Models;


namespace MvcApplication1.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult AchSetup()
        {
            return View();
        }

        public ActionResult CheckSetup()
        {
            return View();
        }

        public ActionResult WireSetup()
        {
            return View();
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult ApproveAchTransfer(string ID)
        {

            int achId = Convert.ToInt32(ID);

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                var ach = obj.AchAuthorizations.FirstOrDefault(i => i.ID == achId);

                if(ach != null)
                {
                    ach.IsApproved = true;
                    obj.SaveChanges();
                }

                obj.Database.Connection.Close();
            }

            return Json(ID, JsonRequestBehavior.AllowGet);
        }
       
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult AddAchTransfer(AchAuthorization authorization)
        {
            authorization.IssuedOn = DateTime.Now;
            authorization.OriginatingSystem = "Transact";
            authorization.IsApproved = false;
            authorization.ContactInformation_ID = 1;

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                obj.AchAuthorizations.Add(authorization);
                obj.SaveChanges();

                obj.Database.Connection.Close();
            }                                                                                                                

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult UpdateAchTransfer(AchAuthorization authorization)
        {
           
            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                var ach = obj.AchAuthorizations.FirstOrDefault(i => i.ID == authorization.ID);

                if(ach != null)
                {
                    ach.Name = authorization.Name;
                    ach.AccountNumber = authorization.AccountNumber;
                    ach.Amount = authorization.Amount;
                    ach.Notes = authorization.Notes;
                }

                obj.SaveChanges();
                obj.Database.Connection.Close();
            }

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult DeleteAchTransfer(AchAuthorization authorization)
        {

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                var ach = obj.AchAuthorizations.FirstOrDefault(i => i.ID == authorization.ID);

                if(ach != null)
                {
                    obj.AchAuthorizations.Remove(ach);
                    obj.SaveChanges();
                }

                obj.Database.Connection.Close();
            }

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }




        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult AddCheckTransfer(CheckAuthorization authorization)
        {

            authorization.IssuedOn = DateTime.Now;
            authorization.OriginatingSystem = "Transact";
            authorization.IsApproved = false;

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                obj.CheckAuthorizations.Add(authorization);
                obj.SaveChanges();

                obj.Database.Connection.Close();
            }

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult UpdateCheckTransfer(CheckAuthorization authorization)
        {

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                var check = obj.CheckAuthorizations.FirstOrDefault(i => i.ID == authorization.ID);

                if (check != null)
                {
                    check.Name = authorization.Name;
                    check.AccountNumber = authorization.AccountNumber;
                    check.Amount = authorization.Amount;
                    check.Notes = authorization.Notes;
                }

                obj.SaveChanges();
                obj.Database.Connection.Close();
            }

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult DeleteCheckTransfer(AchAuthorization authorization)
        {

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                var check = obj.CheckAuthorizations.FirstOrDefault(i => i.ID == authorization.ID);

                if (check != null)
                {
                    obj.CheckAuthorizations.Remove(check);
                    obj.SaveChanges();
                }

                obj.Database.Connection.Close();
            }

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }




        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult AddWireTransfer(WireAuthorization authorization)
        {

            authorization.IssuedOn = DateTime.Now;
            authorization.OriginatingSystem = "Transact";
            authorization.IsApproved = false;

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                obj.WireAuthorizations.Add(authorization);
                obj.SaveChanges();

                obj.Database.Connection.Close();
            }

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult UpdateWireTransfer(WireAuthorization authorization)
        {

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                var wire = obj.WireAuthorizations.FirstOrDefault(i => i.ID == authorization.ID);

                if (wire != null)
                {
                    wire.Name = authorization.Name;
                    wire.AccountNumber = authorization.AccountNumber;
                    wire.Amount = authorization.Amount;
                    wire.Notes = authorization.Notes;
                }

                obj.SaveChanges();
                obj.Database.Connection.Close();
            }

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult DeleteWireTransfer(WireAuthorization authorization)
        {

            using (var obj = new AuthorizationsEntities())
            {
                obj.Database.Connection.Open();

                var wire = obj.WireAuthorizations.FirstOrDefault(i => i.ID == authorization.ID);

                if (wire != null)
                {
                    obj.WireAuthorizations.Remove(wire);
                    obj.SaveChanges();
                }

                obj.Database.Connection.Close();
            }

            return Json(authorization.ID, JsonRequestBehavior.AllowGet);
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetAllPendingApprovals()
        {
            var pendingAchs = new List<PendingAchApproval>();

            using (var obj = new AuthorizationsEntities())
            {

                var r = obj.AchAuthorizations.Where(a => a.ApproverId == "EganC" || a.ApproverId == "User1" || a.ApproverId == "User2").OrderBy(o => o.IssuedOn);
                    
                foreach (var approval in r)
                {
                    if(approval.IsApproved == false)
                    {
                        var a = new PendingAchApproval
                        {
                            Id = approval.ID.ToString(),
                            Amount = approval.Amount.ToString(),
                            Account = approval.AccountNumber,
                            Name = approval.Name,
                            ArrivalDate = approval.IssuedOn.ToString(),
                            UserNotes = approval.Notes,
                            Approver = approval.ApproverId
                        };

                        pendingAchs.Add(a);
                    }
                }
            }

            return Json(pendingAchs.OrderBy(p => p.ArrivalDate), JsonRequestBehavior.AllowGet);

        }


        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetPendingAchApprovals(string id)
        {

            var pendingAchs = new List<PendingAchApproval>();

            using (var obj = new AuthorizationsEntities())
            {

                var r = obj.AchAuthorizations.Where(a => a.ApproverId == id && a.IsApproved == false).OrderBy(o => o.IssuedOn);

                foreach (var approval in r)
                {
                    var a = new PendingAchApproval
                    {
                        Id = approval.ID.ToString(),
                        Amount = approval.Amount.ToString(),
                        Account = approval.AccountNumber,
                        Name = approval.Name,
                        ArrivalDate = approval.IssuedOn.ToString(),
                        UserNotes = approval.Notes,
                        Approver = approval.ApproverId
                    };

                    pendingAchs.Add(a);
                }
            }

            return Json(pendingAchs.OrderBy(p => p.ArrivalDate), JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetPendingCheckApprovals(string id)
        {
            //var result = new TransferAuthorizationServices().GetCheckApprovals(id);

            //return Json(new JavaScriptSerializer().Serialize(result), JsonRequestBehavior.AllowGet);

            return null;
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetPendingWireApprovals(string id)
        {
            //var result = new TransferAuthorizationServices().GetWireApprovals(id);

            //return Json(new JavaScriptSerializer().Serialize(result), JsonRequestBehavior.AllowGet);

            return null;
        }





        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetAchApprovalById(string id)
        {
            //var result = new TransferAuthorizationServices().GetAchApprovalsById(id);

       
            //return Json(new JavaScriptSerializer().Serialize(result), JsonRequestBehavior.AllowGet);

            return null;
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetCheckApprovalById(string id)
        {
            //var result = new TransferAuthorizationServices().GetCheckApprovalsById(id);


            //return Json(new JavaScriptSerializer().Serialize(result), JsonRequestBehavior.AllowGet);


            return null;
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetWireApprovalById(string id)
        {
            //var result = new TransferAuthorizationServices().GetWireApprovalsById(id);


            //return Json(new JavaScriptSerializer().Serialize(result), JsonRequestBehavior.AllowGet);

            return null;
        }
    }
}
