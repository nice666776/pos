using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;

namespace POS.Controllers
{
    public class PurchaseController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;
        

        public PurchaseController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

        }
      


        [HttpGet]
        [Route("~/Purchase/DropDown")]
        public async Task<IActionResult> purchase_dropdown()
        {

            try

            {
                string client_code = "CL799";
                IEnumerable<Category> catList = await _unitOfWork.Category.GetAllAsync(u => u.client_code == client_code);
                IEnumerable<Supplier> supList =  _unitOfWork.Supplier.GetAll(u => u.client_code == client_code);
                var categories = from c in catList select (new { c.code, c.name });
                var suppliers = from c in supList select (new { c.code, c.name });
                return Json(new { success = true, Categories = categories, Suppliers =suppliers });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }

        [HttpGet]
        [Route("~/Product/info")]
        public IActionResult product_info(string product_code)
        {

            try

            {
                string client_code = "CL799";
                Product prod = _unitOfWork.Product.GetFirstOrDefault(u => u.product_code == product_code && u.client_code == client_code);
                if(prod == null)
                {
                    return Json(new { success = false, message = "No Product Found" });
                }

                return Json(new { success = true, message= prod});
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }







    }
}
