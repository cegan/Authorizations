using System.Runtime.Serialization;

namespace SecureRESTService.DataContracts
{
    [DataContract]
    public class AuthorizedRoles
    {
        [DataMember]
        public string Role { get; set; }
    }
}