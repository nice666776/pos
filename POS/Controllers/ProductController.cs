using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
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
        [Route("~/Units/")]
        public JsonResult getAllUnit()
        {
            IEnumerable<Unit> list = _unitOfWork.Unit.GetAll();
            return Json(new { success = true, message = list });
        }
      
        public class MySelectListItem
        {
            public string Name { get; set; }
            public string Code { get; set; }
        }

        public class ProductVM
        {
            
            public IEnumerable<MySelectListItem> categories { get; set; }
            public IEnumerable<MySelectListItem> manufacturers { get; set; }
            public IEnumerable<MySelectListItem> units { get; set; }

        }


        [Route("~/Product/")]
        [Route("~/Product/index")]
        public IActionResult product_Index()
        {
            string client_code = "CL799";
            IEnumerable<Product> list = _unitOfWork.Product.GetAll(u=>u.client_code ==client_code);
            return Json(new { success = true, message = list });
        }

         
        [Route("~/Product/DropDown")]
        public async Task<IActionResult> product_dropdown()
        {
            
            try

            {
                string client_code = "CL799";

                ProductVM productVM = new ProductVM();
                IEnumerable<Category> CatList = await _unitOfWork.Category.GetAllAsync(u=>u.client_code == client_code);
                IEnumerable<Unit> UnitList = _unitOfWork.Unit.GetAll();
                IEnumerable<Manufacturer> ManList = _unitOfWork.Manufacturer.GetAll(u => u.client_code == client_code);
                productVM.categories = CatList.Select(i => new MySelectListItem
                {
                    Name = i.name,
                    Code = i.code

                });
                productVM.manufacturers = ManList.Select(i => new MySelectListItem
                {
                    Name = i.name,
                    Code = i.code

                });
                productVM.units = UnitList.Select(i => new MySelectListItem
                {
                    Name = i.unit,
                    Code = i.id.ToString()


                });

                return Json(new { success = true, message = productVM });
            }
            catch(Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }
        [HttpPost]
        [Route("~/Product/add")]
        public async Task<IActionResult> Upsert([FromBody] Product product)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string client_code = "CL799";
                    if (product.id == 0)
                    {
                       
                        string p_code = _unitOfWork.Product.getProductCode(product.category_code);
                        Category cat = await  _unitOfWork.Category.GetFirstOrDefaultAsync(u => u.code == product.category_code && u.client_code == client_code );
                        Manufacturer man = _unitOfWork.Manufacturer.GetFirstOrDefault(u => u.code== product.manufacturer_code && u.client_code == client_code);
                        product.manufacturer = man.name;
                        product.category = cat.name;
                        product.product_code = p_code;
                        product.product_name = product.product_name.ToUpper();
                        product.client_code = client_code;


                        _unitOfWork.Product.Add(product);
                        POSLog pOSLog = _unitOfWork.POSLog.GetFirstOrDefault(u =>  u.client_code == client_code);
                        pOSLog.product_code = p_code;
                        _unitOfWork.POSLog.Update(pOSLog);
                    }
                    else
                    {

                        product.product_name = product.product_name.ToUpper();
                        Category cat = await _unitOfWork.Category.GetFirstOrDefaultAsync(u => u.code == product.category_code && u.client_code == client_code);
                        Manufacturer man = _unitOfWork.Manufacturer.GetFirstOrDefault(u => u.code == product.manufacturer_code && u.client_code == client_code);
                        product.manufacturer = man.name;
                        product.category = cat.name;
                        product.product_name = product.product_name.ToUpper();

                        _unitOfWork.Product.Update(product);
                    }


                    _unitOfWork.Save();
                    Product product1 = _unitOfWork.Product.GetFirstOrDefault(u => u.product_code == product.product_code && u.client_code == client_code);
                    return Json(new { success = true, message = product });

                }
                else
                {
                    return Json(new { success = false, message = "Add failed!!" });
                }
            }
            catch(Exception e)
            {
                return Json(new { success = false, message = e.Message });
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
