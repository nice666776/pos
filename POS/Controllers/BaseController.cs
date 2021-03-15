using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text.RegularExpressions;
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

        private static Random random = new Random();
        public static string RandomString(int length)
        {
            const string chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }


        public static string MySpecialString()
        {

            string base64Guid = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
            string pattern = "[\\~#%&*{}/:<>?|\"-$^.()!@]";
            string replacement = random.Next(9).ToString();
            Regex regEx = new Regex(pattern);
            string sanitized = Regex.Replace(regEx.Replace(base64Guid, replacement), @"\s+", " ");

            return sanitized.Trim('=');
        }

        public string getTrade()
        {
            string trade_code = null;
            if (HttpContext.Request.Headers.TryGetValue("trade_code", out var traceValue))
            {
                if (traceValue == "undefined") return trade_code = null;
                trade_code = traceValue;
            }
            return trade_code;
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
