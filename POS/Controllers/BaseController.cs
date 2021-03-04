using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace POS.Controllers
{
    public class BaseController : Controller
    {
        public string getClient()
        {
            return "01";
        }
        public string getTrade()
        {
            return "0101";
        }
    }
}
