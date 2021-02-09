using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
    public class ProductRepository: Repository<Product>, IProductRepository
    {


        private readonly ApplicationDbContext _db;

        public ProductRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

        public string getProductCode(string category_code)
        {
            POSLog pOSLog = _db.Pos_log.FirstOrDefault();
            string product_code;
            if (pOSLog == null)
            {
                POSLog pOSLog_new = new POSLog();
                _db.Pos_log.Add(pOSLog_new);

            }
            if (pOSLog.product_code == null)
            {
                product_code = category_code+"0001";

            }

            else
            {

                string temp = pOSLog.product_code.Substring(4, 4);
                int code_no = Convert.ToInt32(temp);
                code_no++;
                string s = code_no.ToString("0000");
                product_code = category_code + s;

            }
            return product_code;
        }
        public void Update(Product product)
        {
            Product AProduct = _db.Product_info.FirstOrDefault(c => c.id == product.id);
            if (AProduct != null)
            {
                AProduct.product_name = product.product_name;
                AProduct.product_type = product.product_type;
                AProduct.product_unit = product.product_unit;
                AProduct.quantity_in = product.quantity_in;
                AProduct.quantity_out = product.quantity_out;
                AProduct.unit_price = product.unit_price;
                AProduct.mrp_price = product.mrp_price;
                AProduct.description = product.description;
                AProduct.reorder_level = product.reorder_level;
                AProduct.category = product.category;
                AProduct.category_code = product.category_code;
                AProduct.group_code = product.group_code;
                AProduct.status = product.status;
                AProduct.manufacturer = product.manufacturer;
                AProduct.manufacturer_code = product.manufacturer_code;
                AProduct.batch = product.batch;
            }



        }


    }
}
