using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
   public interface IProductStockInRepository:IRepository<ProductStockIn>
    {

        public void Update(ProductStockIn productStockIn);
    }
}
