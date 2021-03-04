using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
    public interface ITradeRepository:IRepository<Trade>
    {
        public void Update ( Trade trade );
        public string GetTradeCode(string client_code);
    }
}
