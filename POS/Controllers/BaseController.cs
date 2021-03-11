using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace POS.Controllers
{
    public class BaseController : Controller
    {
        public string getClient()
        {
            string client_code = null;
            if (HttpContext.Request.Headers.TryGetValue("client_code", out var traceValue))
            {
                if (traceValue == "undefined") return client_code = null;
                client_code = traceValue;
            }
            return client_code;
        }
        public string getTrade()
        {
            return "0101";
        }


        protected string GetUserId()
        {
            var User = this.User.Claims.FirstOrDefault(i => i.Type == "UserID");
            if(User == null)
            {
                return null;
            }
                return User.Value;
           
        }

        protected string GetUserRole()
        {
            var User = this.User.Claims.FirstOrDefault(i => i.Type == ClaimTypes.Role);
            if (User == null)
            {
                return null;
            }
            return User.Value;

        }
    }
}
