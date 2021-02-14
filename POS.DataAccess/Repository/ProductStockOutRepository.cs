using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository
{
    public class ProductStockOutRepository : Repository<ProductStockOut>, IProductStockOutRepository
    {

        private readonly ApplicationDbContext _db;

        public ProductStockOutRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

        public void Update(ProductStockOut productStockOut)
        {
            _db.Product_stock_Out.Update(productStockOut);
        }
    }
}
