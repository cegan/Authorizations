using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Web;
using SecureRESTService.DataContracts;

namespace AuthorizationRESTService
{
    [ServiceContract]
    public interface IAuthorizationService
    {
        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetUserRoles/{userName}")]
        List<AuthorizedRoles> GetUserRoles(string userName);

    }
}
