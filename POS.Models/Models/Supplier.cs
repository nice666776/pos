using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace POS.Models.Models
{
    public class Supplier
    {
        public int id { get; set; }
        public string code { get; set; }
        public string name { get; set; }
        public string company { get; set; }
        public string address { get; set; }
        public string division { get; set; }
        public string district{ get; set; }
        public string thana { get; set; }
        public string mobile { get; set; }
        public string email { get; set; }
        public bool supplier_type { get; set; }
        public string remarks { get; set; }
        [DataType(DataType.Date)]
        public DateTime entry_date { get; set; }
        public string entry_by { get; set; }
        public string client_code { get; set; }
        public string trade_code { get; set; }
    }
}
