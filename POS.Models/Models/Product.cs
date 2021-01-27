using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
    public class Product
    {
        public int id { get; set; }
        public string product_code { get; set; }
        public string product_name { get; set; }
        public string product_type { get; set; }
        public string product_unit { get; set; }
        public double quantity_in { get; set; }
        public double quantity_out { get; set; }
        public double unit_price { get; set; }
        public double mrp_price { get; set; }
        public string description { get; set; }
        public double reorder_level { get; set; }
        public string category { get; set; }
        public string category_code { get; set; }
        public string group_code { get; set; }
        public bool status { get; set; }
        public string manufacturer { get; set; }
        public string batch { get; set; }
        public string entry_by { get; set; }
        public string client_code { get; set; }
    }
}
