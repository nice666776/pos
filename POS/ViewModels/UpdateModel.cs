using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.ViewModels
{
    public class UpdateModel
    {

        public  int id { get; set; }
        public string user_id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public List<Trade> trade_list { get; set; }
        public bool status { get; set; }
        public string password { get; set; }
        public string user_type { get; set; }
    }
}
