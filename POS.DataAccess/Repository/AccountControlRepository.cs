using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
   public class AccountControlRepository:Repository<AccountControl>,IAccountControlRepository
    {
        private readonly ApplicationDbContext _db;


        public AccountControlRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }


    }
}
