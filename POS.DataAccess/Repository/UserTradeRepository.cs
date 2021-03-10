using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
    public class UserTradeRepository:Repository<UserTrade>, IUserTradeRepository

    {

        private readonly ApplicationDbContext _db;

        public UserTradeRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }
      
    }
}
