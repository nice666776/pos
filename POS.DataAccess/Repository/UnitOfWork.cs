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



        }
 
        public ISupplierRepository Supplier { get; private set; }
        public IPOSLogRepository POSLog { get; private set; }
        public IManufacturerRepository Manufacturer { get; private set; }
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
