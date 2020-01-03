using System;

namespace MyApp.Web.Models
{
    public class ErrorViewModel
    {
        public int MyProperty { get; set; }
        public string RequestId { get; set; }

        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
    }
}