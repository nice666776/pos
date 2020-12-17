using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
namespace POS.Controllers
{
    public class SupplierController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IWebHostEnvironment _hostEnvironment;


        public SupplierController(IUnitOfWork unitOfWork, IWebHostEnvironment hostEnvironment)
        {
            _unitOfWork = unitOfWork;
            _hostEnvironment = hostEnvironment;
        }

      
        [Route("/")]
        [Route("~/index")]
        public IActionResult Index()
        {
            return Ok("Welcome Home!");
        }

      
        [Route("~/area")]
        public IActionResult GetArea()
        {
            //https://www.youtube.com/watch?v=SholKTNGdHk&ab_channel=RazorCXTechnologies
            string webRootPath = _hostEnvironment.WebRootPath;
            string j;
            var uploads = Path.Combine(webRootPath, @"area.json");
            using (var reader = new StreamReader(uploads))
            {
                j = reader.ReadToEnd();
            }
            return Ok(j);

        }


        public JsonResult getAll()
        {
            IEnumerable<Supplier> list = _unitOfWork.Supplier.GetAll();
            return Json(new { success = true, message = list });
        }

        [Route("~/supplier/")]
        [Route("~/supplier/index")]
        public IActionResult supplier_Index()
        {
            return getAll();
        }
        [HttpPost]
        [Route("~/supplier/add")]
        public IActionResult Upsert([FromBody]Supplier supplier)
        {

            if (ModelState.IsValid)
            {
                if (supplier.id == 0)
                {
                    string s_code = _unitOfWork.Supplier.getSupplierCode();
                    supplier.code = s_code;
                    supplier.name = supplier.name.ToUpper();
                    supplier.company = supplier.company.ToUpper();
                    supplier.address = supplier.address.ToUpper();
                    supplier.entry_date = DateTime.Now.Date;
                    supplier.entry_by = "ADMIN";

                    _unitOfWork.Supplier.Add(supplier);
                    POSLog pOSLog = _unitOfWork.POSLog.GetFirstOrDefault();
                    pOSLog.supplier_code = s_code;
                    _unitOfWork.POSLog.Update(pOSLog);
                }
                else
                {
                    supplier.name = supplier.name.ToUpper();
                    supplier.company = supplier.company.ToUpper();
                    supplier.address = supplier.address.ToUpper();
                    supplier.entry_date = DateTime.Now.Date;
                    supplier.entry_by = "ADMIN";
                    _unitOfWork.Supplier.Update(supplier);
                }

                

                _unitOfWork.Save();
                return Ok(supplier);
            }
            else
            {
                return Json(new { success = true, message = "Add failed!!" });
            }
           
        }
        [HttpDelete]
        [Route("supplier/delete/{id}")]
        public IActionResult Delete(int id)
        {
            var objFromDb = _unitOfWork.Supplier.Get(id);
            if (objFromDb == null)
            {
                return Json(new { success = false, message = "Error while deleting" });
            }
            _unitOfWork.Supplier.Remove(objFromDb);
            _unitOfWork.Save();
            return Json(new { success = true, message = "Delete Successful" });

        }
    }
}
