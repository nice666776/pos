using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.ViewModels
{
    public class PurchaseVM
    {
        public string supplier_code { get; set; }
        public DateTime entry_date { get; set; }
        public string invoice { get; set; }
        public double payment { get; set; }
        public double discount { get; set; }
        public List<ProductObject> purchase_list { get; set; }

    }
}
