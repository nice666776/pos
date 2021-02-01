using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;

namespace POS.Controllers
{
    public class CategoryController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;
      


        public CategoryController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
           
        }

        public async Task<JsonResult> getAll()
        {
            IEnumerable<Category> list = await _unitOfWork.Category.GetAllAsync();
            return Json(new { success = true, message = list });
        }

        [Route("~/Category/")]
        [Route("~/Category/index")]
        public async Task<IActionResult> category_Index()
        {
            IEnumerable<Category> list = await _unitOfWork.Category.GetAllAsync();
            return Json(new { success = true, message = list });
        }
        [HttpPost]
        [Route("~/Category/add")]
        public async Task<IActionResult> Upsert([FromBody] Category category)
        {

            if (ModelState.IsValid)
            {
                if (category.id == 0)
                {
                    string c_code = _unitOfWork.Category.getCategoryCode();
                    category.code = c_code;
                    category.name = category.name.ToUpper();
                  await _unitOfWork.Category.AddAsync(category);
                    POSLog pOSLog = _unitOfWork.POSLog.GetFirstOrDefault();
                    pOSLog.category_code = c_code;
                    _unitOfWork.POSLog.Update(pOSLog);
                }
                else
                {
                    category.name = category.name.ToUpper();
                
                    _unitOfWork.Category.Update(category);
                }

                _unitOfWork.Save();
                return Ok(category);
            }
            else
            {
                return Json(new { success = false, message = "Add failed!!" });
            }

        }
        [HttpDelete]
        [Route("Category/delete/{id}")]
        public IActionResult Delete(int id)
        {
            var objFromDb = _unitOfWork.Category.GetAsync(id);
            if (objFromDb == null)
            {
                return Json(new { success = false, message = "Error while deleting" });
            }
           _unitOfWork.Category.RemoveAsync(id);
            _unitOfWork.Save();
            return Json(new { success = true, message = "Delete Successful" });

        }
    }
}
