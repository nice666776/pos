using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
    public interface  IProductRepository: IRepository<Product>
    {
        public string getProductCode(string category_code);
        public void Update(Product product);
    }
}
