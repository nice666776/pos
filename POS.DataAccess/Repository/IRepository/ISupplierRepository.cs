using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
    public interface ISupplierRepository:IRepository<Supplier>
    {
        public void Update(Supplier supplier);
        public string getSupplierCode();
    }
}
