using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
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
        public void Update(ProductStock productStock)
        {
            _db.Product_stock.Update(productStock);
        }
    }
}
