using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
    
   public interface IPOSLogRepository : IRepository<POSLog>
    {
        public void Update(POSLog pOSLog);
        
    }
}
