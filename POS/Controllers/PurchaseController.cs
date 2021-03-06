﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using POS.ViewModels;

namespace POS.Controllers
{
    public class PurchaseController : BaseController
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
                string client_code = getClient();
                string trade_code = getTrade();
                IEnumerable<Supplier> supList = _unitOfWork.Supplier.GetAll(u => u.client_code == client_code && u.trade_code == trade_code); 
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
                string client_code = getClient();
                string trade_code = getTrade();                                                     
                Product prod = _unitOfWork.Product.GetFirstOrDefault(u => u.product_code == product_code && u.client_code == client_code && u.trade_code == trade_code);
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
                string client_code = getClient();
                string trade_code = getTrade();
                List<Product> prodList = _unitOfWork.Product.GetAll(u => u.category_code == category_code && u.client_code == client_code && u.trade_code == trade_code).ToList();
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

           // try
          //  {
                if (ModelState.IsValid)
                {
                    
                    string client_code = getClient();
                string trade_code = getTrade();
                string user_id = GetUserId();
                //  string TRX_ID = _unitOfWork.ProductStock.setTransactionID(client_code);
                string TRX_ID = RandomString(12);
                    if (purchaseVM.invoice == null)
                    {
                        purchaseVM.invoice = _unitOfWork.ProductStock.setInvoiceNo(trade_code);

                    }
              
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
                productEventInfo.client_code = client_code;
                productEventInfo.trade_code = trade_code;
                    productEventInfo.invoice = purchaseVM.invoice;
                    productEventInfo.entry_date = purchaseVM.entry_date;
                   
                    productEventInfo.supplier_code = purchaseVM.supplier_code;
                    productEventInfo.supplier_name = _unitOfWork.Supplier.GetFirstOrDefault(u => u.code == purchaseVM.supplier_code && u.client_code == client_code && u.trade_code == trade_code).name;
                    double total = 0.0;
                    foreach (ProductObject po in purchaseVM.purchase_list)
                    {
                        Product product = _unitOfWork.Product.GetFirstOrDefault(u => u.product_code == po.product_code && u.client_code == client_code && u.trade_code == trade_code);
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
                        prodStockIn.user_id = user_id;
                        prodStockIn.client_code = client_code;
                        prodStockIn.barcode = product.barcode;
                    prodStockIn.trade_code = trade_code;
                        _unitOfWork.ProductStockIn.Add(prodStockIn);




                        ProductStock ps = _unitOfWork.ProductStock.GetFirstOrDefault(u => u.product_code == po.product_code && u.entry_date == purchaseVM.entry_date && u.client_code==client_code && u.trade_code == trade_code);
                        if(ps == null)
                        {
                            ps = new ProductStock();
                            ps.product_code = po.product_code;
                            ps.product_name = product.product_name;
                            ps.manufacturer_code = product.manufacturer_code;
                            var parameter = new DynamicParameters();
                            parameter.Add("ProductCode", po.product_code);
                            parameter.Add("ClientCode", client_code);
                            parameter.Add("EntryDate", purchaseVM.entry_date.ToString("yyyy-MM-dd"));


                           
                            ProductStock psPrevious = _unitOfWork.SP_Call.OneRecord<ProductStock>("latest_stock_entry", parameter);
                            if(psPrevious != null)
                            {
                                ps.opening_stock = (psPrevious.opening_stock + psPrevious.quantity_in) - psPrevious.quantity_out;
                               
                            }
                            else
                            {
                                ps.opening_stock = 0;
                            }
                            
                            ps.quantity_in = po.quantity;
                            ps.quantity_out = 0;
                            ps.closing_stock = (ps.opening_stock + ps.quantity_in) - ps.quantity_out;
                            ps.unit_price = po.unit_price;
                            ps.mrp_price = po.mrp_price;
                            ps.expire_date = po.expire_date;
                            ps.entry_date = purchaseVM.entry_date;
                            ps.user_id = user_id;
                            ps.barcode = product.barcode;
                            ps.client_code = client_code;
                            ps.trade_code = trade_code;
                            _unitOfWork.ProductStock.Add(ps);

                        }
                        else
                        {
                            ps.quantity_in += po.quantity;
                            ps.closing_stock = (ps.opening_stock + ps.quantity_in) - ps.quantity_out;
                            ps.unit_price = po.unit_price;
                            ps.mrp_price = po.mrp_price;
                            ps.user_id = user_id;
                            ps.expire_date = po.expire_date;
                            _unitOfWork.ProductStock.Update(ps);
                        }


                        total += po.quantity * po.unit_price;

                    }
                    productEventInfo.dr_amount = total;
                if (purchaseVM.percent)
                {
                    productEventInfo.dr_discount_percent = purchaseVM.discount;
                    productEventInfo.dr_discount = productEventInfo.dr_amount * (productEventInfo.dr_discount_percent / 100);
                    productEventInfo.dr_total = productEventInfo.dr_amount - productEventInfo.dr_discount;
                }
                else
                {
                    productEventInfo.dr_discount = purchaseVM.discount;
                    productEventInfo.dr_discount_percent = (productEventInfo.dr_discount / productEventInfo.dr_amount) * 100;
                    productEventInfo.dr_total = productEventInfo.dr_amount - productEventInfo.dr_discount;
                }



                    productEventInfo.cr_amount = productEventInfo.cr_discount = productEventInfo.cr_total = 0.0;
                    productEventInfo.user_id = user_id;
                    productEventInfo.client_code = client_code;
                productEventInfo.trade_code = trade_code;
                ProductEventInfo productEventInfoEntry = productEventInfo.ShallowCopy();
                _unitOfWork.ProductEventInfo.Add(productEventInfo);
                productEventInfoEntry.transaction_type = purchaseVM.payment_type.ToUpper();
                productEventInfoEntry.cr_amount = productEventInfo.dr_amount;
                productEventInfoEntry.cr_discount = productEventInfo.dr_discount;
                productEventInfoEntry.cr_discount_percent = productEventInfo.dr_discount_percent;
                productEventInfoEntry.cr_total = productEventInfo.cr_total;
                productEventInfoEntry.dr_amount = productEventInfoEntry.dr_discount = productEventInfoEntry.dr_total = 0.0;
                productEventInfoEntry.client_code = client_code;
                productEventInfoEntry.trade_code = trade_code;
                _unitOfWork.ProductEventInfo.Add(productEventInfoEntry);
                _unitOfWork.Save();


                    return Json(new { success = true, message = "Successful!!" , invoice= purchaseVM.invoice});
                }
                else
                {
                    return Json(new { success = false, message = "Input error !" });
                }


           // }


         //   catch (Exception e)
          //  {
          //      return Json(new { success = false, message = e.Message });
           // }
             

            
        }


        [HttpGet]
        [Route("~/Purchase/history")]
        public IActionResult PurchaseHistoryByDate(DateTime entry_date)
        {

            try{

                string client_code = getClient();
                string trade_code = getTrade();
                List<ProductEventInfo> peList = _unitOfWork.ProductEventInfo.GetAll(
                    u => u.entry_date == entry_date
                    && u.transaction_type == "PURCHASE"
                    && u.client_code == client_code
                    && u.trade_code == trade_code
                    ).ToList();
                if(peList.Count == 0)
                {
                    return Json(new { success = false, message = "No Purchase was made in this day!" });
                }
                List<PurchaseVM> purchaseVMList = new List<PurchaseVM>();
                foreach(ProductEventInfo pe in peList)
                {

                    PurchaseVM pv = new PurchaseVM();
                    pv.transaction_id = pe.transaction_id;
                    pv.invoice = pe.invoice;
                    pv.total = pe.dr_total;
                    pv.payment = pe.dr_amount;
                    pv.discount_p = pe.dr_discount_percent;
                    pv.discount = pe.dr_discount;
                    pv.entry_date = pe.entry_date;
                    pv.supplier_code = pe.supplier_code;
                    pv.supplier_name = pe.supplier_name;
                    List<ProductStockIn> prodstockin = _unitOfWork.ProductStockIn.GetAll(u=>u.client_code == client_code && u.client_code == client_code && u.transaction_id == pe.transaction_id).ToList();
                    if(prodstockin.Count() == 0)
                    {
                        purchaseVMList.Add(pv);
                        continue;

                    }
                    pv.purchase_list = new List<ProductObject>();
                    pv.purchase_list = (from p in prodstockin
                                        select (new ProductObject
                                        {
                                            product_code = p.product_code,
                                            product_name = p.product_name,
                                            mrp_price = p.mrp_price,
                                            unit_price = p.unit_price,
                                            expire_date = p.expire_date,
                                            total_price = p.total_price,
                                            quantity = p.quantity
                                        })).ToList();


                    purchaseVMList.Add(pv);


                }


                return Json(new { success = true, message = purchaseVMList });
            }

            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
        
        }

        [HttpGet]
        [Route("~/Purchase/history/single")]
        public IActionResult PurchaseHistoryByInvoice(string invoice)
        {

            try
            {

                string client_code = getClient();
                string trade_code = getTrade();
                List<ProductEventInfo> peList = _unitOfWork.ProductEventInfo.GetAll(
                    u => u.invoice == invoice
                    && u.transaction_type == "PURCHASE"
                    && u.client_code == client_code &&
                    u.trade_code == trade_code
                    ).ToList();
                if (peList.Count == 0)
                {
                    return Json(new { success = false, message = "No PURCHASE found with this invoice no.!" });
                }
                List<PurchaseVM> purchaseVMList = new List<PurchaseVM>();
                foreach (ProductEventInfo pe in peList)
                {

                    PurchaseVM pv = new PurchaseVM();
                    pv.transaction_id = pe.transaction_id;
                    pv.invoice = pe.invoice;
                    pv.total = pe.dr_total;
                    pv.discount_p = pe.dr_discount_percent;
                    pv.payment = pe.dr_amount;
                    pv.discount = pe.dr_discount;
                    pv.entry_date = pe.entry_date;
                    pv.supplier_code = pe.supplier_code;
                    pv.supplier_name = pe.supplier_name;
                    List<ProductStockIn> prodstockin = _unitOfWork.ProductStockIn.GetAll(u =>u.trade_code == trade_code &&  u.client_code == client_code && u.transaction_id == pe.transaction_id).ToList();
                    if (prodstockin.Count() == 0)
                    {
                        purchaseVMList.Add(pv);
                        continue;

                    }
                    pv.purchase_list = new List<ProductObject>();
                    pv.purchase_list = (from p in prodstockin
                                        select (new ProductObject
                                        {
                                            product_code = p.product_code,
                                            product_name = p.product_name,
                                            mrp_price = p.mrp_price,
                                            unit_price = p.unit_price,
                                            expire_date = p.expire_date,
                                            total_price = p.total_price,
                                            quantity = p.quantity
                                        })).ToList();


                    purchaseVMList.Add(pv);

                }


                return Json(new { success = true, message = purchaseVMList });
            }

            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }

        }








    }
}
