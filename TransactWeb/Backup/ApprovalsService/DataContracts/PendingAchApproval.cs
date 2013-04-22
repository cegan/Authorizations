﻿using System;
using System.Runtime.Serialization;

namespace TransferAuthorizationService.DataContracts
{
    [DataContract]
    public class PendingAchApproval
    {
        [DataMember]
        public string Id { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Amount { get; set; }
        [DataMember]
        public string Account { get; set; }
        [DataMember]
        public string ArrivalDate { get; set; }
        [DataMember]
        public string UserNotes { get; set; }
    }



    [DataContract]
    public class AuthorizeReturn
    {
        [DataMember]
        public string WasSuccessful { get; set; }

        [DataMember]
        public string ErrorDetails { get; set; }
    }
}