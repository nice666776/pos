using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
    public class ProductEventInfo
    {
        public int id { get; set; }
        public string transaction_id { get; set; }
        public string transaction_type { get; set; }
        public string invoice { get; set; }
        public DateTime entry_date { get; set; }
        public string supplier_code { get; set; }
        public string supplier_name { get; set; }
        public string customer_code { get; set; }
        public string customer_name { get; set; }
        public double cr_amount { get; set; }
        public double cr_discount{ get; set; }
        public double cr_total { get; set; }
        public double dr_amount { get; set; }
        public double dr_discount { get; set; }
        public double dr_total { get; set; }
        public string user_id { get; set; }
        public string client_code { get; set; }
   

    }
}
