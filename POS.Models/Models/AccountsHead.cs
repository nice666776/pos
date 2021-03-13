using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
   public class AccountsHead
    {
        public int id { get; set; }
        public string ac_head_id { get; set; }
        public string ac_head_name { get; set; }
        public string description { get; set; }
        public string ac_group_id { get; set; }
        public string ac_type { get; set; }
        public bool ac_status{ get; set; }
        public string client_code { get; set; }
    }
}
