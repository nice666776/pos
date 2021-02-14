using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;

namespace POS.Controllers
{
    public class SaleController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;


        public SaleController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

        }
        public IActionResult Index()
        {
            return View();
        }
        public string getClient()
        {
            return "CL799";
        }
        [HttpGet]
        [Route("~/Product/Sale/info")]
        public IActionResult product_info(string product_code)
        {

            try
            {
                string client_code = getClient();
                Product prod = _unitOfWork.Product.GetFirstOrDefault(u => u.product_code == product_code && u.client_code == client_code);
                if (prod == null)
                {
                    return Json(new { success = false, message = "No Product Found" });
                }

                var productObject = new
                {
                    product_code = prod.product_code,
                    product_name = prod.product_name,
                    category_name = prod.category,
                    mrp_price = prod.mrp_price,
                    unit_price = prod.unit_price,
                    manufacturer = prod.manufacturer,
                    description = prod.description

                };

                return Json(new { success = true, message = productObject });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }

        [HttpGet]
        [Route("~/Product/Sale/search")]
        public IActionResult product_search(string search_string)
        {

            try
            {
                string client_code = getClient();
                Product prod = _unitOfWork.Product.GetFirstOrDefault(u => (u.product_code.Contains(search_string) || u.product_code.Contains(search_string.ToUpper()))&&  u.client_code == client_code);
                if (prod == null)
                {
                    return Json(new { success = false });
                }

                var productObject = new
                {
                    product_code = prod.product_code,
                    product_name = prod.product_name
                    //mrp_price = prod.mrp_price,
                    //unit_price = prod.unit_price,
                    //manufacturer = prod.manufacturer,
                    //description = prod.description

                };

                return Json(new { success = true, message = productObject });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }





    }
}
