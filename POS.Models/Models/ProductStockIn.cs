using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
   public class ProductStockIn
    {
        public int id { get; set; }
        public string transaction_id { get; set; }
        public string product_code { get; set; }

        public string product_name { get; set; }
        public string manufacturer_name { get; set; }
        public string manufacturer_code { get; set; }
        public string category { get; set; }
        public string category_code { get; set; }
        public double quantity { get; set; }
        public double unit_price { get; set; }
        public double total_price { get; set; }
        public double mrp_price { get; set; }
        public double expire_date { get; set; }
        public string invoice { get; set; }
        public string user_id { get; set; }
        public string batch_no { get; set; }
        public string client_code { get; set; }


    }
}
