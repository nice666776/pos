using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
    public class Trade
    {

        public int id { get; set; }
        public string name { get; set; }
        public string code { get; set; }
        public string description { get; set; }
        public string in_charge { get; set; }
        public string client_code { get; set; }
        public string block { get; set; }
        public string floor { get; set; }
        public double vat_percent { get; set; }
        public string phone { get; set; }
    }
}
