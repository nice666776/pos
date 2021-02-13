using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using POS.ViewModels;

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
        [Route("~/DropDown/suppliers")]
        public  IActionResult purchase_dropdown_supplier()
        {
            try

            {
                string client_code = "CL799";
                IEnumerable<Supplier> supList = _unitOfWork.Supplier.GetAll(u => u.client_code == client_code); 
                var suppliers = from c in supList select (new { c.code, c.name });
                return Json(new { success = true, Suppliers = suppliers });
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

                var productObject = new
                {
                    product_code = prod.product_code,
                    mrp_price = prod.mrp_price,
                    unit_price = prod.unit_price,
                    manufacturer = prod.manufacturer,
                    quantity = prod.quantity,
                    description = prod.description

                };

                return Json(new { success = true, message= productObject });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }

        [HttpGet]
        [Route("~/Product/Categorywise")]
        public IActionResult Categorywise(string category_code)
        {

            try

            {
                string client_code = "CL799";
                List<Product> prodList = _unitOfWork.Product.GetAll(u => u.category_code == category_code && u.client_code == client_code).ToList();
                if (prodList.Count == 0)
                {
                    return Json(new { success = false, message = "No Product Found" });
                }
                var prodListNew = from c in prodList select (new { c.product_code, c.product_name,c.subcategory_code,c.subcategory });

               
                return Json(new { success = true, message = prodListNew.OrderBy(u=>u.product_name) });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }


        [HttpPost]
        [Route("~/Purchase/confirm")]
        public IActionResult PurchaseConfirm([FromBody] PurchaseVM purchaseVM)
        {

            try
            {
                if (ModelState.IsValid)
                {
                    string client_code = "CL799";
                    string TRX_ID = "TRX54454";
                    if (purchaseVM.purchase_list == null)
                    {
                        return Json(new { success = false, message = "There are no Purchased product entry!" });
                    }
                    if (purchaseVM.purchase_list.Count == 0)
                    {
                        return Json(new { success = false, message = "Cannot have a purchase without a single product!" });
                    }

                    ProductEventInfo productEventInfo = new ProductEventInfo();
                    productEventInfo.transaction_id = TRX_ID;
                    productEventInfo.transaction_type = "PURCHASE";
                    productEventInfo.invoice = purchaseVM.invoice;
                    productEventInfo.entry_date = purchaseVM.entry_date;
                    productEventInfo.supplier_code = purchaseVM.supplier_code;
                    productEventInfo.supplier_name = _unitOfWork.Supplier.GetFirstOrDefault(u => u.code == purchaseVM.supplier_code && u.client_code == client_code).name;
                    double total = 0.0;
                    foreach (ProductObject po in purchaseVM.purchase_list)
                    {
                        Product product = _unitOfWork.Product.GetFirstOrDefault(u => u.product_code == po.product_code);
                        product.quantity_in += po.quantity;
                        product.quantity += po.quantity;
                        product.unit_price = po.unit_price;
                        product.mrp_price = po.mrp_price;
                        product.last_expire_date = po.expire_date;
                        _unitOfWork.Product.Update(product);
                        ProductStockIn prodStockIn = new ProductStockIn();
                        prodStockIn.transaction_id = TRX_ID;
                        prodStockIn.product_code = product.product_code;
                        prodStockIn.product_name = product.product_name;
                        prodStockIn.manufacturer_code = product.manufacturer_code;
                        prodStockIn.supplier_code = purchaseVM.supplier_code;
                        prodStockIn.quantity = po.quantity;
                        prodStockIn.unit_price = po.unit_price;
                        prodStockIn.mrp_price = po.mrp_price;
                        prodStockIn.total_price = po.quantity * po.unit_price;
                        prodStockIn.expire_date = po.expire_date;
                        prodStockIn.entry_date = purchaseVM.entry_date;
                        prodStockIn.invoice = purchaseVM.invoice;
                        prodStockIn.user_id = "ADMIN";
                        prodStockIn.client_code = client_code;
                        prodStockIn.barcode = product.barcode;

                        _unitOfWork.ProductStockIn.Add(prodStockIn);


                        total += po.quantity * po.unit_price;

                    }
                    productEventInfo.dr_amount = total;
                    productEventInfo.dr_discount = purchaseVM.discount;
                    productEventInfo.dr_total = productEventInfo.dr_amount - productEventInfo.dr_discount;
                    productEventInfo.cr_amount = productEventInfo.cr_discount = productEventInfo.cr_total = 0.0;
                    productEventInfo.user_id = "ADMIN";
                    productEventInfo.client_code = client_code;

                    _unitOfWork.ProductEventInfo.Add(productEventInfo);

                    _unitOfWork.Save();


                    return Json(new { success = true, message = "Successful!!" });
                }
                else
                {
                    return Json(new { success = false, message = "Input error !" });
                }


            }


            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
             

            
        }





    }
}
