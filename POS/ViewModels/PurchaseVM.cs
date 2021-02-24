using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.ViewModels
{
    public class PurchaseVM
    {
        public string supplier_code { get; set; }
        public string supplier_name { get; set; }
        public string transaction_id { get; set; }
        public DateTime entry_date { get; set; }
        public string invoice { get; set; }
        public double total { get; set; }
        public double payment { get; set; }
        public double discount { get; set; }
        public List<ProductObject> purchase_list { get; set; }

    }
}
