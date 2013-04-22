using System.Runtime.Serialization;

namespace TransferAuthorizationService.DataContracts
{
    [DataContract]
    public class Contact
    {
        [DataMember]
        public string Address { get; set; }

        [DataMember]
        public string City { get; set; }

        [DataMember]
        public string State { get; set; }

        [DataMember]
        public string ZipCode { get; set; }

        [DataMember]
        public string HomePhone { get; set; }

        [DataMember]
        public string MobilePhone { get; set; }

        [DataMember]
        public string EmailAddress { get; set; }

    }
}