using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.ViewModels
{
    public class ProductObject
    {
        public string product_code { get; set; }
        public string product_name { get; set; }
        public double mrp_price { get; set; }
        public double unit_price { get; set; }
        public double quantity { get; set; }
        public DateTime expire_date { get; set; }
                    
    }
}
