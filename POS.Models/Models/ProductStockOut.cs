using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace POS.Models.Models
{
    public class ProductStockOut
    {

        public int id { get; set; }
        public string transaction_id { get; set; }
        public string product_code { get; set; }
        public string product_name { get; set; }
        public string manufacturer_code { get; set; }
        public string customer_code { get; set; }
        public double quantity { get; set; }
        public double unit_price { get; set; }
        public double total_price { get; set; }
        public double total_price_deducted { get; set; }
        
        public double mrp_price { get; set; }
        [DataType(DataType.Date)]
        public DateTime expire_date { get; set; }
        [DataType(DataType.Date)]
        public DateTime entry_date { get; set; }
        public string invoice { get; set; }
        public string user_id { get; set; }
        public string batch_no { get; set; }
        public string client_code { get; set; }
        public string barcode { get; set; }
        public string trade_code { get; set; }
        public double discount_percentage { get; set; }
        public double discount { get; set; }
    }
}
