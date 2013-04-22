using System.Runtime.Serialization;

namespace TransferAuthorizationService.DataContracts
{
    [DataContract]
    public class UserInformation
    {
        [DataMember]
        public string NetworkId { get; set; }

        [DataMember]
        public string Password { get; set; }

        [DataMember]
        public string NameFirst { get; set; }

        [DataMember]
        public string NameLast { get; set; }

        [DataMember]
        public string Title { get; set; }
    }
}