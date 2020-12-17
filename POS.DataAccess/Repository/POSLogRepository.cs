using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
  
    public class POSLogRepository : Repository<POSLog>, IPOSLogRepository
    {
        private readonly ApplicationDbContext _db;

        public POSLogRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

        public void Update(POSLog pOSLog)
        {
            POSLog aPOSLog = _db.Pos_log.FirstOrDefault(c => c.id == pOSLog.id);
            if(aPOSLog != null)
            {
                aPOSLog = pOSLog;
            }

        }

    }
}
