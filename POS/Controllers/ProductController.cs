using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;

namespace POS.Controllers
{
    public class ProductController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;

         public ProductController (IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

        }

        public JsonResult getAll()
        {
            IEnumerable<Product> list = _unitOfWork.Product.GetAll();
            return Json(new { success = true, message = list });
        }

        [Route("~/Product/")]
        [Route("~/Product/index")]
        public IActionResult product_Index()
        {
            return getAll();
        }
        [HttpPost]
        [Route("~/Product/add")]
        public IActionResult Upsert([FromBody] Product product)
        {

            if (ModelState.IsValid)
            {
                if (product.id == 0)
                {
                    string p_code = _unitOfWork.Product.getProductCode(product.category_code);
                    product.product_code = p_code;
                    product.product_name = product.product_name.ToUpper();
                    _unitOfWork.Product.Add(product);
                    POSLog pOSLog = _unitOfWork.POSLog.GetFirstOrDefault();
                    pOSLog.product_code = p_code;
                    _unitOfWork.POSLog.Update(pOSLog);
                }
                else
                {
                    product.product_name = product.product_name.ToUpper();

                    _unitOfWork.Product.Update(product);
                }



                _unitOfWork.Save();
                return Ok(product);
            }
            else
            {
                return Json(new { success = true, message = "Add failed!!" });
            }

        }


        [HttpDelete]
        [Route("product/delete/{id}")]
        public IActionResult Delete(int id)
        {
            var objFromDb = _unitOfWork.Product.Get(id);
            if (objFromDb == null)
            {
                return Json(new { success = false, message = "Error while deleting" });
            }
            _unitOfWork.Product.Remove(objFromDb);
            _unitOfWork.Save();
            return Json(new { success = true, message = "Delete Successful" });


        }    
    }
}
