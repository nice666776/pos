﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using POS.ViewModels;

namespace POS.Controllers
{
    public class SaleController : BaseController
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
   
        [HttpGet]
        [Route("~/Product/Sale/info")]
        public IActionResult product_info(string product_code)
        {

            try
            {
                string client_code = getClient();
                string trade_code = getTrade();
                Product prod = _unitOfWork.Product.GetFirstOrDefault(u => u.product_code == product_code && u.client_code == client_code && u.trade_code == trade_code);
                if (prod == null)
                {
                    return Json(new { success = false, message = "No Product Found !" });
                }
                if(prod.quantity_in - prod.quantity_out <= 0)
                {
                    return Json(new { success = false, message =  prod.product_name+" is out of Stock!" });
                }


                var productObject = new
                {
                    product_code = prod.product_code,
                    product_name = prod.product_name,
                    category_name = prod.category,
                    mrp_price = prod.mrp_price,
                    unit_price = prod.unit_price,
                    manufacturer = prod.manufacturer,
                    description = prod.description,
                    available_quantity = prod.quantity,
                    discount= 0.00

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
                string trade_code = getTrade();
                if (search_string == null)
                {
                    return Json(new { success = false });
                }

                search_string = search_string.ToUpper();
                List<Product> prodList = _unitOfWork.Product.GetAll(u => (u.product_name.ToUpper().Contains(search_string) || u.product_code.Contains(search_string)) &&  u.client_code == client_code && u.trade_code==trade_code).ToList();
                if (prodList.Count() == 0)
                {
                    return Json(new { success = false });
                }


                var productObject = from p in prodList select (new { p.product_code, p.product_name,p.quantity,p.category,p.subcategory });

                return Json(new { success = true, message = productObject });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }



        [HttpGet]
        [Route("~/Supplier/search")]
        public IActionResult supplier_search(string search_string)
        {

            try
            {
                string client_code = getClient();
                string trade_code = getTrade();
                if (search_string == null)
                {
                    return Json(new { success = false });
                }

                search_string = search_string.ToUpper();
                List<Supplier> supList = _unitOfWork.Supplier.GetAll(u => (u.name.ToUpper().Contains(search_string) || u.code.Contains(search_string) || u.mobile.Contains(search_string)) && u.client_code == client_code && u.trade_code == trade_code).ToList();
                if (supList.Count() == 0)
                {
                    return Json(new { success = false });
                }


                var suppliers = from p in supList select (new { p.code, p.name, p.mobile, p.company });

                return Json(new { success = true, message = suppliers });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });

            }
        }

  
     

        [HttpPost]
        [Route("~/Sale/confirm")]
        public IActionResult SaleConfirm([FromBody] SaleVM saleVM)
        {

           // try
            //{
                if (ModelState.IsValid)
                {
                //if (saleVM.receive_type == null)
                //{
                //    return Json(new { success = false, message = "Please Confirm A Payment Receive type!" });
                //}
            //    saleVM.invoice= DateTime.Now.ToString("yy") + DateTime.Now.ToString("MM") + RandomString(7);
         
                saleVM.entry_date = DateTime.Now.Date;
                    string client_code = getClient();
                string trade_code = getTrade();
                string user_id = GetUserId();
                //  string TRX_ID = _unitOfWork.ProductStock.setTransactionID(client_code);
                saleVM.invoice = _unitOfWork.ProductStock.setInvoiceNo(trade_code);
                string TRX_ID = RandomString(12);
                    if (saleVM.sales_list == null)
                    {
                        return Json(new { success = false, message = "There are no Purchased product entry!" });
                    }
                    if (saleVM.sales_list.Count == 0)
                    {
                        return Json(new { success = false, message = "Cannot have a purchase without a single product!" });
                    }

                    ProductEventInfo productEventInfo = new ProductEventInfo();
                    productEventInfo.transaction_id = TRX_ID;
                    productEventInfo.transaction_type = "SALE";
                    productEventInfo.invoice = saleVM.invoice;
                    productEventInfo.entry_date = saleVM.entry_date;
                    productEventInfo.entry_time = DateTime.Now;
                    productEventInfo.customer_code = saleVM.customer_code;
                   // productEventInfo.customer_name = _unitOfWork.Customer.GetFirstOrDefault(u => u.code == saleVM.customer_code && u.client_code == client_code).name;
                    double total = 0.0;
                    foreach (ProductObject po in saleVM.sales_list)
                    {

                        Product product = _unitOfWork.Product.GetFirstOrDefault(u => u.product_code == po.product_code && u.client_code == client_code && u.trade_code==trade_code);
                        if(product.quantity < po.quantity)
                    {
                        return Json(new { success = false, message ="The quantity demanded for "+ product.product_name + " exceeds available quantity! Sales was Cancelled !" });
                    }
                        product.quantity_out += po.quantity;
                        product.quantity -= po.quantity;
                       // product.unit_price = po.unit_price;
                       // product.mrp_price = po.mrp_price;
                       // product.last_expire_date = po.expire_date;
                        _unitOfWork.Product.Update(product);
                        ProductStockOut prodStockOut = new ProductStockOut();
                        prodStockOut.transaction_id = TRX_ID;
                        prodStockOut.product_code = product.product_code;
                        prodStockOut.product_name = product.product_name;
                        prodStockOut.manufacturer_code = product.manufacturer_code;
                        prodStockOut.customer_code = saleVM.customer_code;
                        prodStockOut.quantity = po.quantity;
                        prodStockOut.unit_price = po.unit_price;
                        prodStockOut.mrp_price = po.mrp_price;
                        prodStockOut.total_price = po.quantity * po.mrp_price;
                        prodStockOut.discount_percentage = po.discount;
                        prodStockOut.discount = prodStockOut.total_price * (po.discount / 100);
                        prodStockOut.total_price_deducted = prodStockOut.total_price-prodStockOut.discount;
                        prodStockOut.expire_date = po.expire_date;
                        prodStockOut.entry_date = saleVM.entry_date;
                        prodStockOut.invoice = saleVM.invoice;
                        prodStockOut.user_id = user_id;
                        prodStockOut.client_code = client_code;
                        prodStockOut.barcode = product.barcode;
                    prodStockOut.trade_code = trade_code;
                        _unitOfWork.ProductStockOut.Add(prodStockOut);


                        ProductStock ps = _unitOfWork.ProductStock.GetFirstOrDefault(u => u.product_code == po.product_code && u.entry_date == saleVM.entry_date && u.client_code == client_code && u.trade_code == trade_code);
                        if (ps == null)
                        {
                            ps = new ProductStock();
                            ps.product_code = po.product_code;
                            ps.product_name = product.product_name;
                            ps.manufacturer_code = product.manufacturer_code;
                            var parameter = new DynamicParameters();
                            parameter.Add("ProductCode", po.product_code);
                            parameter.Add("ClientCode", client_code);
                            parameter.Add("EntryDate", saleVM.entry_date.ToString("yyyy-MM-dd"));



                            ProductStock psPrevious = _unitOfWork.SP_Call.OneRecord<ProductStock>("latest_stock_entry", parameter);
                            if (psPrevious != null)
                            {
                                ps.opening_stock = (psPrevious.opening_stock + psPrevious.quantity_in) - psPrevious.quantity_out;

                            }
                            else
                            {
                                return Json(new { success = false, message = product.product_name + " is out of stock! Sales was Cancelled !" });
                               // ps.opening_stock = 0;
                            }

                            ps.quantity_in = 0;
                            ps.quantity_out = po.quantity;
                            ps.closing_stock = (ps.opening_stock + ps.quantity_in) - ps.quantity_out;
                            ps.unit_price = po.unit_price;
                            ps.mrp_price = po.mrp_price;
                            ps.expire_date = po.expire_date;
                            ps.entry_date = saleVM.entry_date;
                            ps.user_id = user_id;
                            ps.barcode = product.barcode;
                            ps.client_code = client_code;
                        ps.trade_code = trade_code;
                            _unitOfWork.ProductStock.Add(ps);

                        }
                        else
                        {
                            ps.quantity_out += po.quantity;
                            ps.closing_stock = (ps.opening_stock + ps.quantity_in) - ps.quantity_out;
                            ps.unit_price = po.unit_price;
                            ps.mrp_price = po.mrp_price;
                            ps.user_id = user_id;
                            ps.expire_date = po.expire_date;
                            _unitOfWork.ProductStock.Update(ps);
                        }


                        total += prodStockOut.total_price_deducted;

                    }
                    productEventInfo.cr_amount = total;
                if (saleVM.percent)
                {
                    productEventInfo.cr_discount_percent = saleVM.discount;
                    productEventInfo.cr_discount = productEventInfo.cr_amount * (productEventInfo.cr_discount_percent / 100);
                    productEventInfo.cr_total = productEventInfo.cr_amount - productEventInfo.cr_discount;
                }
                else
                {
                    productEventInfo.cr_discount = saleVM.discount;
                    productEventInfo.cr_discount_percent = (productEventInfo.cr_discount / productEventInfo.cr_amount)*100;
                    productEventInfo.cr_total = productEventInfo.cr_amount - productEventInfo.cr_discount;
                }
                    

                 
                productEventInfo.dr_amount = productEventInfo.dr_discount = productEventInfo.dr_total = 0.0;
                productEventInfo.user_id = user_id;
                productEventInfo.client_code = client_code;
                productEventInfo.trade_code = trade_code;
                ProductEventInfo productEventInfoEntry = productEventInfo.ShallowCopy();
                _unitOfWork.ProductEventInfo.Add(productEventInfo);

                productEventInfoEntry.transaction_type = saleVM.receive_type.ToUpper();
                productEventInfoEntry.dr_amount = productEventInfo.cr_amount;
                productEventInfoEntry.dr_discount = productEventInfo.cr_discount;
                productEventInfoEntry.dr_discount_percent = productEventInfo.cr_discount_percent;

                productEventInfoEntry.dr_total = productEventInfo.cr_total;
                productEventInfoEntry.cr_amount = productEventInfoEntry.cr_discount = productEventInfoEntry.cr_discount_percent = productEventInfoEntry.cr_total = 0.0;
                productEventInfoEntry.client_code = client_code;
                productEventInfoEntry.trade_code = trade_code;
                _unitOfWork.ProductEventInfo.Add(productEventInfoEntry);
                _unitOfWork.Save();


                    return Json(new { success = true, message = "Successful!!", invoice= productEventInfo.invoice });
                }
                else
                {
                    return Json(new { success = false, message = "Input error !" });
                }


          //  }


            //catch (Exception e)
            //{
            //    return Json(new { success = false, message = e.Message });
            //}



        }




        [HttpGet]
        [Route("~/Sale/history")]
        public IActionResult SaleHistoryByDate(DateTime entry_date)
        {

            try
            {

                string client_code = getClient();
                string trade_code = getTrade();
                List<ProductEventInfo> peList = _unitOfWork.ProductEventInfo.GetAll(
                    u => u.entry_date == entry_date
                    && u.transaction_type == "SALE"
                    && u.client_code == client_code
                    && u.trade_code== trade_code
                    ).ToList();
                if (peList.Count == 0)
                {
                    return Json(new { success = false, message = "No SALE was made in this day!" });
                }
                List<SaleVM> saleVMList = new List<SaleVM>();
                foreach (ProductEventInfo pe in peList)
                {

                    SaleVM sv = new SaleVM();
                    sv.transaction_id = pe.transaction_id;
                    sv.invoice = pe.invoice;
                    sv.payment = pe.cr_amount;
                    sv.total = pe.cr_total;
                    sv.discount = pe.cr_discount;
                    sv.discount_p = pe.cr_discount_percent;
                    sv.entry_date = pe.entry_date;
                    sv.entry_time = pe.entry_time;
                    sv.customer_code = pe.customer_code;
                    sv.customer_name = pe.customer_name;
                    List<ProductStockOut> prodstockout = _unitOfWork.ProductStockOut.GetAll(u => u.client_code == client_code && u.transaction_id == pe.transaction_id && u.trade_code==trade_code).ToList();
                    if (prodstockout.Count() == 0)
                    {
                        saleVMList.Add(sv);
                        continue;

                    }
                    sv.sales_list = new List<ProductObject>();
                    sv.sales_list = (from p in prodstockout
                                        select (new ProductObject
                                        {
                                            product_code = p.product_code,
                                            product_name = p.product_name,
                                            mrp_price = p.mrp_price,
                                            unit_price = p.unit_price,
                                            discount = p.discount_percentage,
                                            total_price = p.total_price_deducted,
                                            expire_date = p.expire_date,
                                            quantity = p.quantity
                                        })).ToList();


                    saleVMList.Add(sv);


                }


                return Json(new { success = true, message = saleVMList });
            }

            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }

        }

        [HttpGet]
        [Route("~/Sale/history/single")]
        public IActionResult SaleHistoryByInvoice(string invoice)
        {

            try
            {

                string client_code = getClient();
                string trade_code = getTrade();
               
                List<ProductEventInfo> peList = _unitOfWork.ProductEventInfo.GetAll(
                    u => u.invoice == invoice
                    && u.transaction_type == "SALE"
                    && u.client_code == client_code
                    && u.trade_code== trade_code
                    ).ToList();
                if (peList.Count == 0)
                {
                    return Json(new { success = false, message = "No SALE found with this invoice No.!" });
                }
                List<SaleVM> saleVMList = new List<SaleVM>();
                foreach (ProductEventInfo pe in peList)
                {

                    SaleVM sv = new SaleVM();
                    sv.transaction_id = pe.transaction_id;
                    sv.invoice = pe.invoice;
                    sv.payment = pe.cr_amount;
                    sv.total = pe.cr_total;
                    sv.discount = pe.cr_discount;
                    sv.discount_p = pe.cr_discount_percent;
                    sv.entry_date = pe.entry_date;
                    sv.entry_time = pe.entry_time;
                    sv.customer_code = pe.customer_code;
                    sv.customer_name = pe.customer_name;
                    List<ProductStockOut> prodstockout = _unitOfWork.ProductStockOut.GetAll(u => u.client_code == client_code && u.transaction_id == pe.transaction_id && u.trade_code == trade_code).ToList();
                    if (prodstockout.Count() == 0)
                    {
                        saleVMList.Add(sv);
                        continue;

                    }
                    sv.sales_list = new List<ProductObject>();
                    sv.sales_list = (from p in prodstockout
                                     select (new ProductObject
                                     {
                                         product_code = p.product_code,
                                         product_name =  p.product_name,
                                         mrp_price = p.mrp_price,
                                         unit_price = p.unit_price,
                                         discount = p.discount_percentage,
                                         total_price = p.total_price_deducted,
                                         expire_date = p.expire_date,
                                         quantity = p.quantity
                                     })).ToList();


                    saleVMList.Add(sv);


                }


                return Json(new { success = true, message = saleVMList });
            }

            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }

        }

    }
}
