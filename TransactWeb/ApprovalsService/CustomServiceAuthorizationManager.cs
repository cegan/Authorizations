using System;
using System.ServiceModel;
using System.Web;

namespace TransferAuthorizationService
{
    public class CustomServiceAuthorizationManager : ServiceAuthorizationManager 
    {
        protected override bool CheckAccessCore(OperationContext operationContext)
        {
            //// Extract the action URI from the OperationContext. Match this against the claims
            //// in the AuthorizationContext.
            var authtext = HttpContext.Current.Request.Headers["Authorization"];

            if(!string.IsNullOrEmpty(authtext))
            {
                var decoded = DecodeFrom64(authtext.Replace("Basic ", String.Empty)).Split(':');

                var username = decoded[0];
                var password = decoded[1];

                //1. Call New Authoeization Service To Return A List Of Roles
                //2. Add the Roles List To The Current Principal.
            }

            return true;
        }


        /// <summary>
        /// The method to Decode your Base64 strings.
        /// </summary>
        /// <param name="encodedData">The String containing the characters to decode.</param>
        /// <returns>A String containing the results of decoding the specified sequence of bytes.</returns>
        private static string DecodeFrom64(string encodedData)
        {
            var encodedDataAsBytes = Convert.FromBase64String(encodedData);
            var returnValue = System.Text.Encoding.UTF8.GetString(encodedDataAsBytes);
            return returnValue;
        }
    }
}
 