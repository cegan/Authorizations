using System.IO;
using System.Net;


namespace TransferAuthorizationWeb.WebUtilities
{
    public static class WebServiceUtilities
    {
        public static string HttpGet(string url)
        {
            var req = WebRequest.Create(url);

            var result = string.Empty;

            using (var resp = req.GetResponse() as HttpWebResponse)
            {
                if (resp != null)
                {
                    var reader = new StreamReader(resp.GetResponseStream());

                    result = reader.ReadToEnd();
                }
            }

            return result;
        }

    }
}