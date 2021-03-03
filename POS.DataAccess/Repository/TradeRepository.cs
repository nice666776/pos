using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository
{
    public class TradeRepository:Repository<Trade>, ITradeRepository

    {

        private readonly ApplicationDbContext _db;

        public TradeRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

        public void Update(Trade trade)
        {
            _db.Trade.Update(trade);
        }
    }
}
