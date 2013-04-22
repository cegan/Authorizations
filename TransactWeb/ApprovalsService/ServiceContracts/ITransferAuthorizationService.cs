using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Web;
using TransferAuthorizationService.DataContracts;

namespace TransferAuthorizationService.ServiceContracts
{
    [ServiceContract]
    public interface ITransferAuthorizationServices
    {

        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "LoginUser?userId={userId}&password={password}&deviceToken={deviceToken}")]
        List<UserInformation> LoginUser(string userId, string password, string deviceToken);


        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Wrapped, UriTemplate = "SendNotification?message={message}&type={type}&uniqueIds={uniqueIds}&approver={approver}")]
        void SendNotification(string message, string type, string uniqueIds, string approver);


      

        #region "HTTP Get Methods"


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetAchAuthorizationHistory/{id}")]
        List<PendingAchApproval> GetAchAuthorizationHistory(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetCheckAuthorizationHistory/{id}")]
        List<PendingAchApproval> GetCheckAuthorizationHistory(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetWireAuthorizationHistory/{id}")]
        List<PendingAchApproval> GetWireAuthorizationHistory(string id);



     

        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetCheckApprovalsById/{id}")]
        List<PendingAchApproval> GetCheckApprovalsById(string id);

        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetWireApprovalsById/{id}")]
        List<PendingAchApproval> GetWireApprovalsById(string id);
        
       
       
      
        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "AuthorizeAchsAsync?achsToApprove={achsToApprove}&deviceId={deviceId}")]
        void AuthorizeAchsAsync(string achsToApprove, string deviceId);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "AuthorizeChecksAsync?checksToApprove={checksToApprove}&deviceId={deviceId}")]
        void AuthorizeChecksAsync(string checksToApprove, string deviceId);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "AuthorizeWiresAsync?wiresToApprove={wiresToApprove}&deviceId={deviceId}")]
        void AuthorizeWiresAsync(string wiresToApprove, string deviceId);
       
      

        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetAchApprovals/{id}")]
        List<PendingAchApproval> GetAchApprovals(string id);


        [OperationContract]
        //[PrincipalPermission(SecurityAction.Demand, Role = "Admin")]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetAchApprovalsById/{id}")]
        List<PendingAchApproval> GetAchApprovalsById(string id);


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
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "SendErrorNotification?errorDescription={errorDescription}")]
        string SendErrorNotification(string errorDescription);




      
      

        #endregion
    }
}
