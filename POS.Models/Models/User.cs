using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
    public class User
    {
        public int id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string email { get; set; }
        public string user_type { get; set; }
        public string phone { get; set; }
        public bool status { get; set; }
        public string user_id { get; set; }
        public string added_by { get; set; }
        public DateTime add_date { get; set; }
        public string client_code { get; set; }
        public string trade_code { get; set; }


    }
}
