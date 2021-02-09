using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository
{
   public class ProductEventInfoRepository: Repository<ProductEventInfo>, IProductEventInfoRepository
    {
        private readonly ApplicationDbContext _db;

        public ProductEventInfoRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

        public void Update(ProductEventInfo productEventInfo)
        {
            _db.Product_event_info.Update(productEventInfo);
        }
    }
}
