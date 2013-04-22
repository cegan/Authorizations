using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MoonAPNS;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            var payload1 = new NotificationPayload("ec2c9674df4a2f1bc080f911464a88bd682fd7c976573d2e5534f812b2ecf41c", "Test", 19, "default");
           // payload1.AddCustom("RegionID", "IDQ10150");

            var p = new List<NotificationPayload> { payload1 };

            var push = new PushNotification(true, "Authorizations.p12", "LiveWire69");
            var rejected = push.SendToApple(p);
            foreach (var item in rejected)
            {
                Console.WriteLine(item);
            }
            Console.ReadLine();
        }
    }
}
