using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
    public class AccountsGroup
    {
        public int id { get; set; }
        public string ac_group_id { get; set; }
        public string ac_group_name { get; set; }
        public string ac_type { get; set; }
        public string control_type { get; set; }
        public string description { get; set; }
        public string comments { get; set; }
        public string client_code { get; set; }
    }
}
