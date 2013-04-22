using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Web;
using TransferAuthorizationService.DataContracts;

namespace TransferAuthorizationService.ServiceContracts
{
    [ServiceContract]
    interface ITransferAuthorizationServices
    {
        #region "HTTP Get Methods"

        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "WireDisbursementApproval/{id}")]
        void GetWireDisbursementApprovals(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "WireSetupApproval/{id}")]
        string GetWireSetupApprovals(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "AuthorizeAch/{id}")]
        List<ServiceResponse> AuthorizeAch(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetAchApprovals/{id}")]
        List<PendingAchApproval> GetAchApprovals(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetCheckApprovals/{id}")]
        List<PendingAchApproval> GetCheckApprovals(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetWireApprovals/{id}")]
        List<PendingAchApproval> GetWireApprovals(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetAchApprovalHistory/{id}")]
        List<AchApprovalHistory> GetAchApprovalHistory(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "CheckDisbursementApproval/{id}")]
        string GetCheckDisbursementApproval(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "SendErrorNotification/{errorDescription}")]
        List<ServiceResponse> SendErrorNotification(string errorDescription);




        #endregion
    }
}
