﻿using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{

    public interface IUnitOfWork : IDisposable
    {
        ISupplierRepository Supplier { get; }
        ICustomerRepository Customer { get; }
        IPOSLogRepository POSLog { get; }
        IManufacturerRepository Manufacturer { get; }
        ICategoryRepository Category { get; }
        IProductRepository Product { get; }
        IUnitRepository Unit { get; }
        IProductEventInfoRepository ProductEventInfo { get; }
        IProductStockRepository ProductStock { get; }
        IProductStockInRepository ProductStockIn{ get; }
        IProductStockOutRepository ProductStockOut { get; }
        ISubCategoryRepository SubCategory { get; }
        ISP_Call SP_Call { get; }
        IUserRepository User { get; }
        void Save();
    }

}