using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models.Authentication
{
    public class Registration
    {
        public string user_id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public string user_type { get; set; }
        public string password { get; set; }
        public bool status { get; set; }
        public string client_code { get; set; }
        public string trade_code { get; set; }
        public List<Trade> trade_list { get; set; }
        public DateTime date_added { get; set; }
    }
}
