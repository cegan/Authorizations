using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.ServiceModel;
using System.ServiceModel.Activation;
using MoonAPNS;
using TransferAuthorizationService.DataContracts;
using TransferAuthorizationService.ServiceContracts;
using System.Linq;


namespace TransferAuthorizationService 
{
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class TransferAuthorizationServices : ITransferAuthorizationServices
    {

        public List<UserInformation> LoginUser(string userId, string password, string deviceToken)
        {
            var userInformation = new List<UserInformation>();

            using (var obj = new AuthorizationsEntities())
            {
                var user = obj.Employees.FirstOrDefault(a => a.NetworkId == userId);

                if(user != null)
                {
                    user.DeviceToken = deviceToken;
                    obj.SaveChanges();

                    var userInfo = new UserInformation
                    {
                        NetworkId   = user.NetworkId,
                        NameFirst   = user.NameFirst,
                        NameLast    = user.NameLast,
                        Title       = user.Title
                    };

                    userInformation.Add(userInfo);

                    return userInformation;
                }
            }

            return null;
        }

        public void SendNotification(string message, string type, string uniqueIds, string approver)
        {
            var payload = new NotificationPayload(GetApproverDeviceId(approver), message, 0, "default");
            payload.AddCustom("Type", type);
            payload.AddCustom("AprId", uniqueIds);

            SendNotification(payload);
        }


        public List<PendingAchApproval> GetAchAuthorizationHistory(string id)
        {
            var approvalHistory = new List<PendingAchApproval>();

            using (var obj = new AuthorizationsEntities())
            {

                var approvedAchs = obj.AchAuthorizations.Where(a => a.ApproverId.ToUpper() == id.ToUpper() && a.IsApproved == true).OrderBy(o => o.IssuedOn);

                foreach (var approval in approvedAchs)
                {
                    var a = new PendingAchApproval
                    {
                        Id = approval.ID.ToString(),
                        Amount = approval.Amount.ToString(),
                        Account = approval.AccountNumber,
                        Name = approval.Name,
                        ArrivalDate = approval.IssuedOn.ToString(),
                        ApprovedOn = approval.ApprovedOn.ToString(),
                        OriginatingSystem = approval.OriginatingSystem,

                        ContactInformation = new Contact
                        {
                            Address = approval.ContactInformation.Address,
                            City = approval.ContactInformation.City,
                            State = approval.ContactInformation.State,
                            ZipCode = approval.ContactInformation.ZipCode,
                            HomePhone = approval.ContactInformation.HomePhone,
                            MobilePhone = approval.ContactInformation.MobilPhone,
                            EmailAddress = approval.ContactInformation.EmailAddress,
                        }
                    };

                    approvalHistory.Add(a);
                }
            }

            return approvalHistory;
        }

        public List<PendingAchApproval> GetCheckAuthorizationHistory(string id)
         {
             var approvalHistory = new List<PendingAchApproval>();

             using (var obj = new AuthorizationsEntities())
             {
                 var approvedChecks = obj.CheckAuthorizations.Where(a => a.ApproverId.ToUpper() == id.ToUpper() && a.IsApproved == true).OrderBy(o => o.IssuedOn);

                 foreach (var approval in approvedChecks)
                 {
                     var a = new PendingAchApproval
                     {
                         Id = approval.ID.ToString(),
                         Amount = approval.Amount.ToString(),
                         Account = approval.AccountNumber,
                         Name = approval.Name,
                         ArrivalDate = approval.IssuedOn.ToString(),
                         ApprovedOn = approval.ApprovedOn.ToString(),
                         OriginatingSystem = approval.OriginatingSystem,

                         ContactInformation = new Contact
                         {
                             Address = approval.ContactInformation.Address,
                             City = approval.ContactInformation.City,
                             State = approval.ContactInformation.State,
                             ZipCode = approval.ContactInformation.ZipCode,
                             HomePhone = approval.ContactInformation.HomePhone,
                             MobilePhone = approval.ContactInformation.MobilPhone,
                             EmailAddress = approval.ContactInformation.EmailAddress,
                         }
                     };

                     approvalHistory.Add(a);
                 }
             }

             return approvalHistory;
         }

        public List<PendingAchApproval> GetWireAuthorizationHistory(string id)
         {
             var approvalHistory = new List<PendingAchApproval>();

             using (var obj = new AuthorizationsEntities())
             {
                 var approvedWires = obj.WireAuthorizations.Where(a => a.ApproverId.ToUpper() == id.ToUpper() && a.IsApproved == true).OrderBy(o => o.IssuedOn);

                 foreach (var approval in approvedWires)
                 {
                     var a = new PendingAchApproval
                     {
                         Id = approval.ID.ToString(),
                         Amount = approval.Amount.ToString(),
                         Account = approval.AccountNumber,
                         Name = approval.Name,
                         ArrivalDate = approval.IssuedOn.ToString(),
                         ApprovedOn = approval.ApprovedOn.ToString(),
                         OriginatingSystem = approval.OriginatingSystem,

                         ContactInformation = new Contact
                         {
                             Address = approval.ContactInformation.Address,
                             City = approval.ContactInformation.City,
                             State = approval.ContactInformation.State,
                             ZipCode = approval.ContactInformation.ZipCode,
                             HomePhone = approval.ContactInformation.HomePhone,
                             MobilePhone = approval.ContactInformation.MobilPhone,
                             EmailAddress = approval.ContactInformation.EmailAddress,
                         }
                     };

                     approvalHistory.Add(a);
                 }
             }

             return approvalHistory;
         }

       

        
        public List<PendingAchApproval> GetAchApprovals(string id)
        {
            var pendingAch = new List<PendingAchApproval>();

            using (var obj = new AuthorizationsEntities())
            {
                
                var r = obj.AchAuthorizations.Where(a => a.ApproverId.ToUpper() == id.ToUpper() && a.IsApproved == false).OrderBy(o => o.IssuedOn);

                foreach (var approval in r)
                {
                    var a = new PendingAchApproval
                    {
                        Id                  = approval.ID.ToString(),
                        Amount              = approval.Amount.ToString(),
                        Account             = approval.AccountNumber,
                        Name                = approval.Name,
                        ArrivalDate         = approval.IssuedOn.ToString(),
                        OriginatingSystem   = approval.OriginatingSystem,

                        ContactInformation  = new Contact
                        {
                            Address = approval.ContactInformation.Address,
                            City = approval.ContactInformation.City,
                            State = approval.ContactInformation.State,
                            ZipCode = approval.ContactInformation.ZipCode,
                            HomePhone = approval.ContactInformation.HomePhone,
                            MobilePhone = approval.ContactInformation.MobilPhone,
                            EmailAddress = approval.ContactInformation.EmailAddress,
                       }
                    };

                    pendingAch.Add(a);
                }
            }


            return pendingAch.OrderByDescending(p => p.ArrivalDate).ToList();
        }

        public List<PendingAchApproval> GetCheckApprovals(string id)
        {

            var pendingAch = new List<PendingAchApproval>();

            using (var obj = new AuthorizationsEntities())
            {

                var r = obj.CheckAuthorizations.Where(a => a.ApproverId.ToUpper() == id.ToUpper() && a.IsApproved == false).OrderBy(o => o.IssuedOn);

                foreach (var approval in r)
                {
                    var a = new PendingAchApproval
                    {
                        Id = approval.ID.ToString(),
                        Amount = approval.Amount.ToString(),
                        Account = approval.AccountNumber,
                        Name = approval.Name,
                        ArrivalDate = approval.IssuedOn.ToString(),
                        OriginatingSystem = approval.OriginatingSystem,

                        ContactInformation  = new Contact
                        {
                            Address = approval.ContactInformation.Address,
                            City = approval.ContactInformation.City,
                            State = approval.ContactInformation.State,
                            ZipCode = approval.ContactInformation.ZipCode,
                            HomePhone = approval.ContactInformation.HomePhone,
                            MobilePhone = approval.ContactInformation.MobilPhone,
                            EmailAddress = approval.ContactInformation.EmailAddress,
                       }
                    };

                    pendingAch.Add(a);
                }
            }

            return pendingAch;
        }

        public List<PendingAchApproval> GetWireApprovals(string id)
        {

            var pendingAch = new List<PendingAchApproval>();

            using (var obj = new AuthorizationsEntities())
            {

                var r = obj.WireAuthorizations.Where(a => a.ApproverId.ToUpper() == id.ToUpper() && a.IsApproved == false).OrderBy(o => o.IssuedOn);

                foreach (var approval in r)
                {
                    var a = new PendingAchApproval
                    {
                        Id = approval.ID.ToString(),
                        Amount = approval.Amount.ToString(),
                        Account = approval.AccountNumber,
                        Name = approval.Name,
                        ArrivalDate = approval.IssuedOn.ToString(),
                        OriginatingSystem = approval.OriginatingSystem,

                        ContactInformation = new Contact
                        {
                            Address = approval.ContactInformation.Address,
                            City = approval.ContactInformation.City,
                            State = approval.ContactInformation.State,
                            ZipCode = approval.ContactInformation.ZipCode,
                            HomePhone = approval.ContactInformation.HomePhone,
                            MobilePhone = approval.ContactInformation.MobilPhone,
                            EmailAddress = approval.ContactInformation.EmailAddress,
                        }
                    };

                    pendingAch.Add(a);
                }
            }

            return pendingAch;
        }



        public List<PendingAchApproval> GetCheckApprovalsById(string id)
        {
            using (var obj = new AuthorizationsEntities())
            {
                var approvalId = Convert.ToInt32(id);

                var approval = obj.CheckAuthorizations.FirstOrDefault(i => i.ID == approvalId);

                if (approval != null)
                {
                    var pendingAch = new List<PendingAchApproval>
                    {
                        new PendingAchApproval
                        {
                            Id          = approval.ID.ToString(), 
                            Amount      = approval.Amount.ToString(),
                            Account     = approval.AccountNumber,
                            Name        = approval.Name, 
                            ArrivalDate = approval.IssuedOn.ToString(),

                             ContactInformation  = new Contact
                            {
                                Address = approval.ContactInformation.Address,
                                City = approval.ContactInformation.City,
                                State = approval.ContactInformation.State,
                                ZipCode = approval.ContactInformation.ZipCode,
                                HomePhone = approval.ContactInformation.HomePhone,
                                MobilePhone = approval.ContactInformation.MobilPhone,
                                EmailAddress = approval.ContactInformation.EmailAddress,
                           }
                        }
                    };

                    return pendingAch;
                }
            }

            return null;
        }

        public List<PendingAchApproval> GetWireApprovalsById(string id)
        {
            using (var obj = new AuthorizationsEntities())
            {
                var approvalId = Convert.ToInt32(id);

                var approval = obj.WireAuthorizations.FirstOrDefault(i => i.ID == approvalId);

                if (approval != null)
                {
                    var pendingAch = new List<PendingAchApproval>
                    {
                        new PendingAchApproval
                        {
                            Id          = approval.ID.ToString(), 
                            Amount      = approval.Amount.ToString(),
                            Account     = approval.AccountNumber,
                            Name        = approval.Name, 
                            ArrivalDate = approval.IssuedOn.ToString(),

                             ContactInformation  = new Contact
                            {
                                Address = approval.ContactInformation.Address,
                                City = approval.ContactInformation.City,
                                State = approval.ContactInformation.State,
                                ZipCode = approval.ContactInformation.ZipCode,
                                HomePhone = approval.ContactInformation.HomePhone,
                                MobilePhone = approval.ContactInformation.MobilPhone,
                                EmailAddress = approval.ContactInformation.EmailAddress,
                           }
                        }
                    };

                    return pendingAch;
                }
            }

            return null;
        }

        public List<PendingAchApproval> GetAchApprovalsById(string id)
        {
            using (var obj = new AuthorizationsEntities())
            {
                var approvalId = Convert.ToInt32(id);

                var approval = obj.AchAuthorizations.FirstOrDefault(i => i.ID == approvalId);

                if (approval != null)
                {
                    var pendingAch = new List<PendingAchApproval>
                    {
                        new PendingAchApproval
                        {
                            Id          = approval.ID.ToString(), 
                            Amount      = approval.Amount.ToString(),
                            Account     = approval.AccountNumber,
                            Name        = approval.Name, 
                            ArrivalDate = approval.IssuedOn.ToString(),
                            OriginatingSystem   = approval.OriginatingSystem,

                            ContactInformation  = new Contact
                            {
                                Address = approval.ContactInformation.Address,
                                City = approval.ContactInformation.City,
                                State = approval.ContactInformation.State,
                                ZipCode = approval.ContactInformation.ZipCode,
                                HomePhone = approval.ContactInformation.HomePhone,
                                MobilePhone = approval.ContactInformation.MobilPhone,
                                EmailAddress = approval.ContactInformation.EmailAddress,
                           }
                        }
                    };

                    return pendingAch;
                }
            }

            return null;
        }



        public void AuthorizeAchsAsync(string achsToApprove, string deviceId)
        {
            var achsToAuthorize = new List<string>(achsToApprove.Split(','));
            var approvedAchs    = new List<string>();
            var failedAchs       = new List<string>();

            foreach (var itemtoAuthorize in achsToAuthorize)
            {
                if (!string.IsNullOrEmpty(itemtoAuthorize))
                {
                    try
                    {
                        var id = Convert.ToInt32(itemtoAuthorize);

                        using (var obj = new AuthorizationsEntities())
                        {
                            var achAuthorization = obj.AchAuthorizations.First(i => i.ID == id);

                            if(achAuthorization.Name == "Casey Egan")
                            {
                                throw new Exception("Something Really Bad Happened");
                            }

                            achAuthorization.IsApproved = true;
                            achAuthorization.ApprovedOn = DateTime.Now;
                          
                            obj.SaveChanges();
                            approvedAchs.Add(itemtoAuthorize);
                        }
                    }
                    catch (Exception e)
                    {
                        failedAchs.Add(itemtoAuthorize);
                    }
                }
            }

            var payload = new NotificationPayload(deviceId, "Ach Approval Was Successful", 0, "default");
            payload.AddCustom("Type", "AchAuth");
            payload.AddCustom("AprId", string.Join(",", approvedAchs));
            payload.AddCustom("FailId", string.Join(",", failedAchs));
            
            SendNotification(payload);
        }

        public void AuthorizeChecksAsync(string checksToApprove, string deviceId)
        {
            var checksToAuthorize = new List<string>(checksToApprove.Split(','));
            var approvedChecks = new List<string>();
            var failedChecks = new List<string>();

            foreach (var itemtoAuthorize in checksToAuthorize)
            {
                if (!string.IsNullOrEmpty(itemtoAuthorize))
                {
                    try
                    {
                        var id = Convert.ToInt32(itemtoAuthorize);

                        using (var obj = new AuthorizationsEntities())
                        {
                            var checkAuthorization = obj.CheckAuthorizations.First(i => i.ID == id);

                            if (checkAuthorization.Name == "Bugs Bunny")
                            {
                                throw new Exception("Something Really Bad Happened");
                            }

                            checkAuthorization.IsApproved = true;
                            checkAuthorization.ApprovedOn = DateTime.Now;

                            obj.SaveChanges();
                            approvedChecks.Add(itemtoAuthorize);
                        }
                    }
                    catch (Exception e)
                    {
                        failedChecks.Add(itemtoAuthorize);
                    }
                }
            }

            var payload = new NotificationPayload(deviceId, "Check Approval Was Successful", 0, "default");
            payload.AddCustom("Type", "CheckAuth");
            payload.AddCustom("AprId", string.Join(",", approvedChecks));
            payload.AddCustom("FailId", string.Join(",", failedChecks));

            SendNotification(payload);
        }

        public void AuthorizeWiresAsync(string wiresToApprove, string deviceId)
        {
            var wiresToAuthorize = new List<string>(wiresToApprove.Split(','));
            var approvedWires = new List<string>();
            var failedWires = new List<string>();

            foreach (var itemtoAuthorize in wiresToAuthorize)
            {
                if (!string.IsNullOrEmpty(itemtoAuthorize))
                {
                    try
                    {
                        var id = Convert.ToInt32(itemtoAuthorize);

                        using (var obj = new AuthorizationsEntities())
                        {
                            var wireAuthorization = obj.WireAuthorizations.First(i => i.ID == id);

                            if (wireAuthorization.Name == "Homer Simpson")
                            {
                                throw new Exception("Something Really Bad Happened");
                            }

                            wireAuthorization.IsApproved = true;
                            wireAuthorization.ApprovedOn = DateTime.Now;

                            obj.SaveChanges();
                            approvedWires.Add(itemtoAuthorize);
                        }
                    }
                    catch (Exception e)
                    {
                        failedWires.Add(itemtoAuthorize);
                    }
                }
            }

            var payload = new NotificationPayload(deviceId, "Wire Approval Was Successful", 0, "default");
            payload.AddCustom("Type", "WireAuth");
            payload.AddCustom("AprId", string.Join(",", approvedWires));
            payload.AddCustom("FailId", string.Join(",", failedWires));

            SendNotification(payload);
        }

        

        public List<AchApprovalHistory> GetAchApprovalHistory(string id)
        {
            var achApprovalHistory = new List<AchApprovalHistory>
            {
                new AchApprovalHistory {ApprovalDate = "3-8-2012",Amount = 30,CheckNumber = "12222",CheckSignerId = "Casey Egan"},
                new AchApprovalHistory {ApprovalDate = "12-8-2011",Amount = 30,CheckNumber = "12222",CheckSignerId = "Casey Egan"},
                new AchApprovalHistory {ApprovalDate = "5-12-2010",Amount = 30,CheckNumber = "12222",CheckSignerId = "Casey Egan"},
                new AchApprovalHistory {ApprovalDate = "9-8-2012",Amount = 30,CheckNumber = "12222",CheckSignerId = "Casey Egan"},

            };

            return achApprovalHistory;
        }


        public string SendErrorNotification(string errorDescription)
        {
            try
            {

                var mMessage = new System.Net.Mail.MailMessage();

                mMessage.From = new MailAddress("c.egan@me.com", "Casey Egan");
                mMessage.To.Add(new MailAddress("c.egan@me.com"));
                mMessage.IsBodyHtml = false;
                mMessage.Body = errorDescription;
                mMessage.Subject = "Authorization Error";
                //mMessage.Priority = MailPriority.Normal;

              


                var client = new SmtpClient("smtp.gmail.com", 587)
                    {
                        UseDefaultCredentials = false,
                        Credentials = new NetworkCredential("kcegan74@gmail.com", "LiveWire69"),
                        EnableSsl = true
                    };



                try
                {
                    client.Send(mMessage);
                }


                catch (SmtpException e)
                {
                    
                }
            }
            catch (Exception e)
            {
               
            }

            return string.Empty;
        }

        private void SendNotification(NotificationPayload payload)
        {
            var notification = new List<NotificationPayload> { payload };

            var push = new PushNotification(true, @"C:\MyProjects\TransactWeb\ApprovalsService\bin\Authorizations.p12", "LiveWire69");
            
            push.SendToApple(notification);

        }

        private string GetApproverDeviceId(string approver)
        {

            using (var obj = new AuthorizationsEntities())
            {
                var approvingUser = obj.Employees.FirstOrDefault(a => a.NetworkId == approver);

                if (approvingUser != null)
                    return approvingUser.DeviceToken;
            }

            return string.Empty;
        }
      
    }
}
