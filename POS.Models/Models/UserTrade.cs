using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
   public class UserTrade
    {

        public int id { get; set; }
        public string user_id { get; set; }
        public string trade_code { get; set; }
        public string client_code { get; set; }
    }
}
