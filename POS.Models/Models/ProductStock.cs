using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace POS.Models.Models
{
   public class ProductStock
    {
        public int id { get; set; }
        public string product_code { get; set; }
        public string product_name { get; set; }
        public string manufacturer_code { get; set; }
        public double opening_stock { get; set; }
        public double quantity_out { get; set; }
        public double quantity_in { get; set; }
        public double closing_stock { get; set; }
        public double unit_price { get; set; }
        public double mrp_price { get; set; }
        [DataType(DataType.Date)]
        public DateTime expire_date { get; set; }
        [DataType(DataType.Date)]
        public DateTime entry_date { get; set; }
        public string user_id { get; set; }
        public string batch_no { get; set; }
        public string client_code { get; set; }
        public string barcode { get; set; }
        public string trade_code { get; set; }


    }
}
