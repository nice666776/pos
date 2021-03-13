using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
    public class ProductStockRepository : Repository<ProductStock>, IProductStockRepository
    {

        private readonly ApplicationDbContext _db;

        public ProductStockRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }



        public string setTransactionID(string client_code)
        {
            string trxID;
            POSLog objFromDb = _db.Pos_log.FirstOrDefault(u=>u.client_code == client_code);
            if (objFromDb.transaction_id == null)
            {
                trxID = "TRX000000001";
            }
            else
            {
                string sub = objFromDb.transaction_id.Substring(3, 9);
                int c = Convert.ToInt32(sub);
                c++;
                string s = c.ToString("000000000");
                trxID = "TRX" + s;

            }
            objFromDb.transaction_id = trxID;
            _db.Pos_log.Update(objFromDb);
            _db.SaveChanges();
            return trxID;
        }





        public string setInvoiceNo(string tradeCode)
        {
            string invID;
            POSLog objFromDb = _db.Pos_log.FirstOrDefault(u => u.trade_code == tradeCode);
            if (objFromDb.invoice_no == null)
            {
                invID = tradeCode  + "000000001";
            }
            else
            {
                string sub = objFromDb.invoice_no.Substring(4, 9);
                int c = Convert.ToInt32(sub);
                c++;
                string s = c.ToString("000000000");
                invID = tradeCode + s;

            }
            objFromDb.invoice_no = invID;
            _db.Pos_log.Update(objFromDb);
            _db.SaveChanges();
            return invID;
        }




        public void Update(ProductStock productStock)
        {
            _db.Product_stock.Update(productStock);
        }
    }
}
