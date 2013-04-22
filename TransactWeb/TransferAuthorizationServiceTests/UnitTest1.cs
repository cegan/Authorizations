using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TransferAuthorizationService;
using TransferAuthorizationWeb.Areas.Approvals.Controllers;

namespace TransferAuthorizationServiceTests
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            var t = new TransferAuthorizationServices();

            t.GetAchApprovals("1");


        }
    }
}
