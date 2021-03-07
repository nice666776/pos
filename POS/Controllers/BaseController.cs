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
            return "01";
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
