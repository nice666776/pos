using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using AutoMapper;
using POS.ViewModels;

namespace POS.Controllers
{
    public class CategoryController : BaseController
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;


        public CategoryController(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
           
        }

        public async Task<JsonResult> getAll()
        {
            string client_code = getClient();
            string trade_code = getClient();
            IEnumerable<Category> list = await _unitOfWork.Category.GetAllAsync(u=>u.trade_code == trade_code );
            return Json(new { success = true, message = list });
        }

        [Route("~/Category/")]
        [Route("~/Category/index")]
        public async Task<IActionResult> category_Index()
        {
            string client_code = getClient();
            string trade_code = getTrade();
            IEnumerable<Category> list = await _unitOfWork.Category.GetAllAsync(u=> u.trade_code == trade_code);
            List<CategoryVM> categoryVMs = new List<CategoryVM>();
            foreach(Category cat in list)
            {
                CategoryVM categoryVM = new CategoryVM();
                categoryVM = _mapper.Map<CategoryVM>(cat);
                var SubCategories = _unitOfWork.SubCategory.GetAll(u => u.trade_code == trade_code && u.category_code == cat.code );
                categoryVM.subcategories = from s in SubCategories
                                           select (s.name).ToString();
                categoryVMs.Add(categoryVM);
            }
            return Json(new { success = true, message = categoryVMs });
        }

       


        [HttpPost]
        [Route("~/Category/add")]
        public async Task<IActionResult> Upsert([FromBody] CategoryVM categoryVM)
        {

            if (ModelState.IsValid)
            {
                string trade_code = getTrade();
                string client_code = getClient();
                Category category = _mapper.Map<Category>(categoryVM);
                if (category.id == 0)
                {
                  
                    string c_code = _unitOfWork.Category.getCategoryCode(client_code,trade_code);
                    category.code = c_code;
                    category.name = category.name.ToUpper();
                    category.client_code = client_code;
                    await _unitOfWork.Category.AddAsync(category);
                   


                    POSLog pOSLog = _unitOfWork.POSLog.GetFirstOrDefault(u=>u.trade_code== trade_code );
                    pOSLog.category_code = c_code;
                    _unitOfWork.POSLog.Update(pOSLog);
                }
                else
                {
                    category.name = category.name.ToUpper();
                
                    _unitOfWork.Category.Update(category);
                }

                if(categoryVM.subcategories!=null)
                {
                    IEnumerable<SubCategory> subCategories = _unitOfWork.SubCategory.GetAll(u => u.category_code == category.code && u.trade_code == trade_code);
                    if (subCategories.Count() != 0)
                    {
                        _unitOfWork.SubCategory.RemoveRange(subCategories);
                    }
                    if (categoryVM.subcategories.Count() != 0)
                    {
                        int i = 1;

                        foreach (string subcat in categoryVM.subcategories)
                        {

                            if (i <= 99)
                            {
                                SubCategory subCategory = new SubCategory();
                                subCategory.code = category.code + i.ToString("00");
                                subCategory.name = subcat.ToUpper();
                                subCategory.client_code = client_code;
                                subCategory.trade_code = trade_code;
                                subCategory.category_code = category.code;
                                subCategory.category_name = categoryVM.name;
                                i++;
                                _unitOfWork.SubCategory.Add(subCategory);
                            }

                        }
                    }
                }

                _unitOfWork.Save();
               CategoryVM categoryVMReturn = _mapper.Map<CategoryVM>(category);
                categoryVMReturn.subcategories = categoryVM.subcategories.ToList().ConvertAll(d => d.ToUpper()) ;
                return Ok(categoryVMReturn);
            }
            else
            {
                return Json(new { success = false, message = "Add failed!!" });
            }

        }
        //[HttpDelete]
        //[Route("Category/delete/{id}")]
        //public IActionResult Delete(int id)
        //{
        //    var objFromDb = _unitOfWork.Category.GetAsync(id);
        //    if (objFromDb == null)
        //    {
        //        return Json(new { success = false, message = "Error while deleting" });
        //    }
        //   _unitOfWork.Category.RemoveAsync(id);
        //    _unitOfWork.Save();
        //    return Json(new { success = true, message = "Delete Successful" });

        //}
    }
}
