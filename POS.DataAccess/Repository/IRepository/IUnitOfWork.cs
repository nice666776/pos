using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{

    public interface IUnitOfWork : IDisposable
    {
        ISupplierRepository Supplier { get; }
        IPOSLogRepository POSLog { get; }
        IManufacturerRepository Manufacturer { get; }
        ICategoryRepository Category { get; }
        IProductRepository Product { get; }
        void Save();
    }

}
