using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
    public class POSLog
    {
        public int id { get; set; }
        public string supplier_code { get; set; }
        public string manufacturer_code { get; set; }
        public string category_code { get; set; }
        public string product_code { get; set; }
    }
}
