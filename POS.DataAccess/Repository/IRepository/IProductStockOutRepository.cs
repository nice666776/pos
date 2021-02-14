using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
   public interface IProductStockOutRepository:IRepository<ProductStockOut>
    {

        public void Update(ProductStockOut productStockOut);
    }
}
