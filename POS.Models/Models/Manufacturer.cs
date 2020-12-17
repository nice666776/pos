using System;
using System.Collections.Generic;
using System.Text;

namespace POS.Models.Models
{
    public class Manufacturer
    {

        public int id { get; set; }
        public string name { get; set; }
        public string code { get; set; }
        public string address { get; set; }

        public string contact_person { get; set; }

        public string email { get; set; }

        public string phone { get; set; }
        public string brand { get; set; }
        public string comments { get; set; }
        public DateTime entry_date { get; set; }
        public string entry_by { get; set; }


    }
}
