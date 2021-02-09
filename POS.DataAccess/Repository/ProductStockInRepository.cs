using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository
{
    public class ProductStockInRepository : Repository<ProductStockIn>, IProductStockInRepository
    {

        private readonly ApplicationDbContext _db;

        public ProductStockInRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }
        public void Update(ProductStockIn productStockIn)
        {
            _db.Product_stock_in.Update(productStockIn);
        }
    }
}
