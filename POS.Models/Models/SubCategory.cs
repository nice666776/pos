using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
    public class SubCategory
    {
        public int id { get; set; }
        public string code { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string client_code { get; set; }
        public string category_code { get; set; }
        public string category_name { get; set; }
        public string trade_code { get; set; }
    }
}
