using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
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
        public string GetTradeCode(string client_code)
        {
            string trade_code;
            POSLog pOSLog = _db.Pos_log.OrderByDescending(u=>u.id).FirstOrDefault(u => u.client_code == client_code);
            if(pOSLog == null)
            {
                trade_code = client_code +"01";
            }
            else
            {
                string temp = pOSLog.trade_code.Substring(2,2);
                int code_no = Convert.ToInt32(temp);
                code_no++;
                string s = code_no.ToString("00");
                trade_code = client_code + s;
            }

            return trade_code;
        
        }

        public void Update(Trade trade)
        {
            _db.Trade.Update(trade);
        }
    }
}
