using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository
{
     public class LedgerRepository:Repository<Ledger>, ILedgerRepository
    {

        private readonly ApplicationDbContext _db;

        public LedgerRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

    }
}
