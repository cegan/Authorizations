using System.Collections.Generic;
using System.ServiceModel.Activation;
using SecureRESTService.DataContracts;

namespace AuthorizationRESTService
{

    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class AuthorizationService : IAuthorizationService
    {
        public List<AuthorizedRoles> GetUserRoles(string userName)
        {
            return new List<AuthorizedRoles> 
            { 
                new AuthorizedRoles { Role = "Administrators" }, 
                new AuthorizedRoles { Role = "FundItApprovers" },
                new AuthorizedRoles { Role = "TransactUsers" }
            };
        }
    }
}
