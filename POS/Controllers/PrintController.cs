using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using POS.ViewModels;
using Wkhtmltopdf.NetCore;

namespace POS.Controllers
{
    public class PrintController : Controller
    {

        private readonly IGeneratePdf _generatePdf;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;


        public PrintController(IUnitOfWork unitOfWork, IMapper mapper, IGeneratePdf generatePdf)
        {
            _generatePdf = generatePdf;
            _unitOfWork = unitOfWork;
            _mapper = mapper;

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
        [Route("~/print/Suppliers")]
        public async Task<IActionResult> SuppliersList()
        {


            string client_code = getClient();
            List<Supplier> suppliers = _unitOfWork.Supplier.GetAll(u => u.client_code == client_code).ToList();

            /////////////////////////////////
            var kv = new Dictionary<string, string>
            {
                { "username", "USER" },
                { "age", "20" },
                { "url", "google.com" }
            };

            var options = new ConvertOptions
            {
                HeaderHtml = "http://localhost:44317/header.html",
                PageOrientation = Wkhtmltopdf.NetCore.Options.Orientation.Portrait,
                FooterHtml = "http://localhost:44317/footerTwo.html",
                Replacements = kv,
                PageMargins = new Wkhtmltopdf.NetCore.Options.Margins()
                {
                    Top = 15,
                    Left = 10,
                    Right = 10,
                    Bottom = 15
                }

            };
            _generatePdf.SetConvertOptions(options);


        
            var model = ToExpando(new {  Date = DateTime.Now.ToString("dd/MM/yyyy"), SuppliersList = suppliers });
            string htmlViewX = await System.IO.File.ReadAllTextAsync("Reports/SupplierList.cshtml");
            return await _generatePdf.GetPdfViewInHtml(htmlViewX, model);

        }




        [HttpGet]
        [Route("~/print/Manufacturers")]
        public async Task<IActionResult> ManufacturerList()
        {
            string client_code = getClient();
            List<Manufacturer> manufacturers = _unitOfWork.Manufacturer.GetAll(u => u.client_code == client_code).ToList();

            /////////////////////////////////
            var kv = new Dictionary<string, string>
            {
                { "username", "USER" },
                { "age", "20" },
                { "url", "google.com" }
            };

            var options = new ConvertOptions
            {
                HeaderHtml = "http://localhost:44317/header.html",
                PageOrientation = Wkhtmltopdf.NetCore.Options.Orientation.Portrait,
                FooterHtml = "http://localhost:44317/footerTwo.html",
                Replacements = kv,
                PageMargins = new Wkhtmltopdf.NetCore.Options.Margins()
                {
                    Top = 15,
                    Left = 10,
                    Right = 10,
                    Bottom = 15
                }

            };
            _generatePdf.SetConvertOptions(options);



            var model = ToExpando(new { Date = DateTime.Now.ToString("dd/MM/yyyy"), ManufacturerList = manufacturers });
            string htmlViewX = await System.IO.File.ReadAllTextAsync("Reports/ManufacturerList.cshtml");
            return await _generatePdf.GetPdfViewInHtml(htmlViewX, model);

        }



        [HttpGet]
        [Route("~/print/Receipt")]
        public async Task<IActionResult> Reciept(string invoice)
        {

            string client_code = getClient();
            List<ProductEventInfo> peList = _unitOfWork.ProductEventInfo.GetAll(
                u => u.invoice == invoice
                && u.transaction_type == "SALE"
                && u.client_code == client_code
                ).ToList();
            if (peList.Count == 0)
            {
                return Json(new { success = false, message = "No SALE found with this invoice No.!" });
            }
            SaleVM sv = new SaleVM();
           
            foreach (ProductEventInfo pe in peList)
            {
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
                List<ProductStockOut> prodstockout = _unitOfWork.ProductStockOut.GetAll(u => u.client_code == client_code && u.transaction_id == pe.transaction_id).ToList();
                if (prodstockout.Count() == 0)
                {
                    continue;

                }
                sv.sales_list = new List<ProductObject>();
                sv.sales_list = (from p in prodstockout
                                 select (new ProductObject
                                 {
                                     product_code = p.product_code,
                                     product_name = p.product_name.Length > 30 ? p.product_name.Substring(0, 30) + "..." : p.product_name,
                                     mrp_price = p.mrp_price,
                                     unit_price = p.unit_price,
                                     discount = p.discount_percentage,
                                     total_price = p.total_price_deducted,
                                     expire_date = p.expire_date,
                                     quantity = p.quantity
                                 })).ToList();

            }
            double ratio = 74;
            double page_height = 102+(sv.sales_list.Count()*(ratio));
            /////////////////////////////////
            var kv = new Dictionary<string, string>
            {
                { "username", "USER" },
                { "age", "20" },
                { "url", "google.com" }
            };

            var options = new ConvertOptions
            {
             
                PageOrientation = Wkhtmltopdf.NetCore.Options.Orientation.Portrait,
                PageHeight = page_height,
                // PageWidth = 73.97500,//If width is changed so must be the ratio variable
                PageWidth = ratio,
                PageMargins = new Wkhtmltopdf.NetCore.Options.Margins()
                {
                    Top = 0,
                    Left = 2,
                    Right = 2,
                    Bottom = 0
                }

            };
            _generatePdf.SetConvertOptions(options);
            var model = ToExpando(new { Date = DateTime.Now.ToString("dd/MM/yyyy"), SaleList = sv, EntryTime = DateTime.SpecifyKind(sv.entry_time, DateTimeKind.Local).ToString("mm:ss tt") });
            string htmlViewX = await System.IO.File.ReadAllTextAsync("Reports/Receipt.cshtml");
            return await _generatePdf.GetPdfViewInHtml(htmlViewX, model);

        }



        [HttpGet]
        [Route("~/print/PurchaseOrder")]
        public async Task<IActionResult> Invoice(string invoice)
        {
            string client_code = getClient();
            ProductEventInfo pe = _unitOfWork.ProductEventInfo.GetFirstOrDefault(
                u => u.invoice == invoice
                && u.transaction_type == "PURCHASE"
                && u.client_code == client_code
                );
            if (pe == null)
            {
                return Json(new { success = false, message = "No PURCHASE found with this invoice no.!" });
            }
      
           
                PurchaseVM pv = new PurchaseVM();
                pv.transaction_id = pe.transaction_id;
                pv.invoice = pe.invoice;
                pv.total = pe.dr_total;
                pv.payment = pe.dr_amount;
                pv.discount = pe.dr_discount;
                pv.entry_date = pe.entry_date;
                pv.supplier_code = pe.supplier_code;
                pv.supplier_name = pe.supplier_name;
                Supplier supl = _unitOfWork.Supplier.GetFirstOrDefault(u => u.code == pv.supplier_code);
                List<ProductStockIn> prodstockin = _unitOfWork.ProductStockIn.GetAll(u => u.client_code == client_code && u.transaction_id == pe.transaction_id).ToList();
                if (prodstockin.Count() == 0)
                {

                return Json(new { success = false, message = "No Items Found!" });

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
                                        quantity = p.quantity
                                    })).ToList();


                


            

            var options = new ConvertOptions
            {

                PageOrientation = Wkhtmltopdf.NetCore.Options.Orientation.Portrait,
                HeaderHtml = "http://localhost:44317/header.html",
                PageMargins = new Wkhtmltopdf.NetCore.Options.Margins()
                {
                    Top = 20,
                    Left = 10,
                    Right = 5,
                    Bottom = 20
                }

            };
            _generatePdf.SetConvertOptions(options);



            var model = ToExpando(new { Date = DateTime.Now.ToString("dd/MM/yyyy"), Purchase = pv, Supplier =supl});
            string htmlViewX = await System.IO.File.ReadAllTextAsync("Reports/PurchaseOrder.cshtml");
            return await _generatePdf.GetPdfViewInHtml(htmlViewX, model);

        }
        public ExpandoObject ToExpando(object anonymousObject)
        {
            IDictionary<string, object> anonymousDictionary = new RouteValueDictionary(anonymousObject);
            IDictionary<string, object> expando = new ExpandoObject();
            foreach (var item in anonymousDictionary)
                expando.Add(item);
            return (ExpandoObject)expando;
        }


    }
}
