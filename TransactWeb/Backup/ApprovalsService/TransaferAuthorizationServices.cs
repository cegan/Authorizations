using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.Web.Mail;
using TransferAuthorizationService.DataContracts;
using TransferAuthorizationService.ServiceContracts;


namespace TransferAuthorizationService 
{
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class TransferAuthorizationServices :ITransferAuthorizationServices
    {
        public void GetWireDisbursementApprovals(string id)
        {
            throw new NotImplementedException();
        }

        public string GetWireSetupApprovals(string id)
        {
            throw new NotImplementedException();
        }

        public List<ServiceResponse> AuthorizeAch(string id)
        {
            if(id == "1")
            {
                return new List<ServiceResponse> { new ServiceResponse { WasSuccessful = false, ErrorDetails = "Error Occurred Approving" } };
            }

            return new List<ServiceResponse> { new ServiceResponse  { WasSuccessful = true} };
        }

        public List<PendingAchApproval> GetAchApprovals(string id)
        {
            var pendingAchs = new List<PendingAchApproval>
            {
                new PendingAchApproval {Id = "1", Amount = "600.34",Account = "324-56567-939",Name = "Casey Egan", ArrivalDate = DateTime.Now.Date.AddDays(-1).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "2", Amount = "12.23",Account = "939-19385-001",Name = "Beth Ethen", ArrivalDate = DateTime.Now.Date.AddDays(-3).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "3", Amount = "56897.00",Account = "830-20384-493",Name = "Jeremy Williams", ArrivalDate = DateTime.Now.Date.AddDays(-5).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "4", Amount = "234.92",Account = "293-82894-333",Name = "Kyle Franzen", ArrivalDate = DateTime.Now.Date.AddDays(-9).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "5", Amount = "1290.00",Account = "929-299222-929",Name = "Eric Summer", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "6", Amount = "569.01",Account = "281-393932-221",Name = "Steve Gocke", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "7", Amount = "124567.90",Account = "929-10393-921",Name = "Kent Webb", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "8", Amount = "732.39",Account = "926-485434-434",Name = "Mike Freidman", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "9", Amount = "490.12",Account = "112-30845-392",Name = "Bugs Bunny", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "10", Amount = "22823.98",Account = "919-201193-321",Name = "Daffy Duck", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "11", Amount = "289.90",Account = "757-58443-090",Name = "Elmer Fudd", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "12", Amount = "532.49",Account = "729-91029-433",Name = "Cookie Monster", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "13", Amount = "981.45",Account = "444-92984-882",Name = "Big Bird", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "14", Amount = "872.12",Account = "844-11032-012",Name = "Tom and Jerry", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "15", Amount = "32.90",Account = "939-29454-595",Name = "Woody Woodpecker", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "16", Amount = "248.99",Account = "292-33923-110",Name = "Donald Duck", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "17", Amount = "198.34",Account = "737-83839-331",Name = "Mighty Mouse", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "18", Amount = "438345.45",Account = "848-90229-392",Name = "Speed Racer", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "19", Amount = "1.00",Account = "992-19283-332",Name = "Tweety", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "20", Amount = "45.39",Account = "929-92911-712",Name = "Pink Panther", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "21", Amount = "6000.39",Account = "929-92911-712",Name = "Pink Panther", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "22", Amount = "45.39",Account = "929-92911-712",Name = "Pink Panther", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "23", Amount = "129.39",Account = "929-92911-712",Name = "Pink Panther", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "24", Amount = "45.39",Account = "929-92911-712",Name = "Pink Panther", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "25", Amount = "45.39",Account = "929-92911-712",Name = "Pink Panther", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
            };

            return pendingAchs;
        }

        public List<PendingAchApproval> GetCheckApprovals(string id)
        {
            var pendingChecks = new List<PendingAchApproval>
            {
                new PendingAchApproval {Id = "1", Amount = "600.34",Account = "324-56567-939",Name = "Casey Egan", ArrivalDate = DateTime.Now.Date.AddDays(-1).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "2", Amount = "12.23",Account = "939-19385-001",Name = "Beth Ethen", ArrivalDate = DateTime.Now.Date.AddDays(-3).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "3", Amount = "56897.00",Account = "830-20384-493",Name = "Jeremy Williams", ArrivalDate = DateTime.Now.Date.AddDays(-5).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "4", Amount = "234.92",Account = "293-82894-333",Name = "Kyle Franzen", ArrivalDate = DateTime.Now.Date.AddDays(-9).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "5", Amount = "1290.00",Account = "929-299222-929",Name = "Eric Summer", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "6", Amount = "569.01",Account = "281-393932-221",Name = "Steve Gocke", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "7", Amount = "124567.90",Account = "929-10393-921",Name = "Kent Webb", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "8", Amount = "732.39",Account = "926-485434-434",Name = "Mike Freidman", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "9", Amount = "490.12",Account = "112-30845-392",Name = "Bugs Bunny", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "10", Amount = "22823.98",Account = "919-201193-321",Name = "Daffy Duck", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "11", Amount = "289.90",Account = "757-58443-090",Name = "Elmer Fudd", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "12", Amount = "532.49",Account = "729-91029-433",Name = "Cookie Monster", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "13", Amount = "981.45",Account = "444-92984-882",Name = "Big Bird", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "14", Amount = "872.12",Account = "844-11032-012",Name = "Tom and Jerry", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "15", Amount = "32.90",Account = "939-29454-595",Name = "Woody Woodpecker", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "16", Amount = "248.99",Account = "292-33923-110",Name = "Donald Duck", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "17", Amount = "198.34",Account = "737-83839-331",Name = "Mighty Mouse", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "18", Amount = "438345.45",Account = "848-90229-392",Name = "Speed Racer", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "19", Amount = "1.00",Account = "992-19283-332",Name = "Tweety", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "20", Amount = "45.39",Account = "929-92911-712",Name = "Pink Panther", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
            };

            return pendingChecks;
        }

        public List<PendingAchApproval> GetWireApprovals(string id)
        {
            var pendingWires = new List<PendingAchApproval>
            {
                new PendingAchApproval {Id = "1", Amount = "600.34",Account = "324-56567-939",Name = "Casey Egan", ArrivalDate = DateTime.Now.Date.AddDays(-1).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "2", Amount = "12.23",Account = "939-19385-001",Name = "Beth Ethen", ArrivalDate = DateTime.Now.Date.AddDays(-3).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "3", Amount = "56897.00",Account = "830-20384-493",Name = "Jeremy Williams", ArrivalDate = DateTime.Now.Date.AddDays(-5).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "4", Amount = "234.92",Account = "293-82894-333",Name = "Kyle Franzen", ArrivalDate = DateTime.Now.Date.AddDays(-9).ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "5", Amount = "1290.00",Account = "929-299222-929",Name = "Eric Summer", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "6", Amount = "569.01",Account = "281-393932-221",Name = "Steve Gocke", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "7", Amount = "124567.90",Account = "929-10393-921",Name = "Kent Webb", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "8", Amount = "732.39",Account = "926-485434-434",Name = "Mike Freidman", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "9", Amount = "490.12",Account = "112-30845-392",Name = "Bugs Bunny", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "10", Amount = "22823.98",Account = "919-201193-321",Name = "Daffy Duck", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "11", Amount = "289.90",Account = "757-58443-090",Name = "Elmer Fudd", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "12", Amount = "532.49",Account = "729-91029-433",Name = "Cookie Monster", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "13", Amount = "981.45",Account = "444-92984-882",Name = "Big Bird", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "14", Amount = "872.12",Account = "844-11032-012",Name = "Tom and Jerry", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "15", Amount = "32.90",Account = "939-29454-595",Name = "Woody Woodpecker", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "16", Amount = "248.99",Account = "292-33923-110",Name = "Donald Duck", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "17", Amount = "198.34",Account = "737-83839-331",Name = "Mighty Mouse", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "18", Amount = "438345.45",Account = "848-90229-392",Name = "Speed Racer", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "19", Amount = "1.00",Account = "992-19283-332",Name = "Tweety", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
                new PendingAchApproval {Id = "20", Amount = "45.39",Account = "929-92911-712",Name = "Pink Panther", ArrivalDate = DateTime.Now.Date.ToString("yyyy-MM-dd")},
            };

            return pendingWires;
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

        public string GetCheckDisbursementApproval(string id)
        {
            throw new NotImplementedException();
        }

        public List<ServiceResponse> SendErrorNotification(string errorDescription)
        {
            try
            {
                var message = new MailMessage
                {
                    From = "c.egan@me.com",
                    To = "c.egan@me.com",
                    Subject = "Authorization Error",
                    Body = errorDescription
                };


                //SmtpMail.SmtpServer = "17.158.52.72";
                //SmtpMail.Send(message);

                return new List<ServiceResponse> { new ServiceResponse { WasSuccessful = true, ErrorDetails = "All Good" } };

               
            }
            catch (Exception e)
            {
                return new List<ServiceResponse> { new ServiceResponse { WasSuccessful = false, ErrorDetails = e.Message } };
            }
        }
    }
}
