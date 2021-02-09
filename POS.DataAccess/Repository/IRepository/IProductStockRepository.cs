using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
   public interface IProductStockRepository:IRepository<ProductStock>
    {



        public void Update(ProductStock productStock);
    }
}
