
using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
    public class AccountsHeadRepository : Repository<AccountsHead>, IAccountsHeadRepository
    {

        private readonly ApplicationDbContext _db;

        public AccountsHeadRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

     

        public string _setAccountsHeadID(string group_id,string client_code)
        {
            string acchID;
            AccountsHead objFromDb = _db.Accounts_head.OrderByDescending(u => u.id).FirstOrDefault(s=>s.ac_group_id.StartsWith(group_id) && s.client_code == client_code);
            

            if (objFromDb == null || objFromDb.ac_head_id == null)
            {
                acchID = group_id + "01";
            }
         
            else
            {

                
                string sub = objFromDb.ac_head_id.Substring(2, 2);
                int c = Convert.ToInt32(sub);
                c++;
                string s = c.ToString("00");
                acchID = group_id + s;

            }
            return acchID;
        }
        public void Update(AccountsHead accountsHead)
        {
            _db.Accounts_head.Update(accountsHead);
        }

    }


}
