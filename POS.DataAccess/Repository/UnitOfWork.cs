using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;

namespace POS.DataAccess.Repository
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ApplicationDbContext _db;

        public UnitOfWork(ApplicationDbContext db)
        {
            _db = db;
            Supplier = new SupplierRepository(_db);
            POSLog = new POSLogRepository(_db);
            Manufacturer = new ManufacturerRepository(_db);
            Category = new CategoryRepository(_db);
            Product = new ProductRepository(_db);
            Unit = new UnitRepository(_db);
            ProductEventInfo = new ProductEventInfoRepository(_db);
            ProductStock = new ProductStockRepository(_db);
            ProductStockIn = new ProductStockInRepository(_db);
        }
 
        public ISupplierRepository Supplier { get; private set; }
        public IPOSLogRepository POSLog { get; private set; }
        public IManufacturerRepository Manufacturer { get; private set; }
        public ICategoryRepository Category { get; private set; }
        public IProductRepository Product { get; private set; }
        public IUnitRepository Unit { get; private set; }
        public IProductEventInfoRepository ProductEventInfo { get; private set; }
        public IProductStockRepository ProductStock { get; private set; }
        public IProductStockInRepository ProductStockIn { get; private set; }
        public void Dispose()
        {
            _db.Dispose();
        }

        public void Save()
        {
            _db.SaveChanges();
        }
    }
}
