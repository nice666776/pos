using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.ViewModels
{
    public class ClientVM
    {

        public int id { get; set; }
        public string name { get; set; }
        public string code { get; set; }
        public string description { get; set; }
        public string phone { get; set; }
        public string address { get; set; }
        public string division { get; set; }
        public string district { get; set; }
        public string thana { get; set; }
        public string email { get; set; }
        public string zipcode { get; set; }
        public string logo { get; set; }

        public string admin_firstname { get; set; }
        public string admin_lastname { get; set; }
        public string admin_mobile { get; set; }
        public string admin_email { get; set; }
        public string admin_id { get; set; }
        public string password { get; set; }

    }
}
