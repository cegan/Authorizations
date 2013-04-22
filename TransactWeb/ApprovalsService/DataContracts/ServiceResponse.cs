using System.Runtime.Serialization;

namespace TransferAuthorizationService.DataContracts
{
    public class ServiceResponse
    {
        [DataMember]
        public bool WasSuccessful { get; set; }

        [DataMember]
        public string ErrorDetails { get; set; }
    }
}