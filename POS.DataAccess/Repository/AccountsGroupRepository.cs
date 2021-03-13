using POS.DataAccess.Data;
using POS.DataAccess.Repository;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
   public class AccountsGroupRepository: Repository<AccountsGroup>, IAccountsGroupRepository
    {
        private readonly ApplicationDbContext _db;

        public AccountsGroupRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }
        //public string setAccountGroupID()
        //{
        //    string accgID;
        //    AccountsGroup objFromDb = _db.Accounts_group.OrderByDescending(u => u.id).FirstOrDefault();
        //    if (objFromDb.ac_group_id == null)
        //    {
        //        accgID = "ACG001";
        //    }
        //    else
        //    {
        //        string sub = objFromDb.ac_group_id.Substring(3, 3);
        //        int c = Convert.ToInt32(sub);
        //        c++;
        //        string s = c.ToString("000");
        //       accgID = "ACG" + s;

        //    }
        //    return accgID;
        //}


        //public string _setAccountGroupID(string client_code)
        //{
        //    string accgID;
        //    AccountsGroup objFromDb = _db.Aaccounts_group.FirstOrDefault(u => u.client_Code == client_code);
        //    if(objFromDb == null)
        //    {
        //        return null;
        //    }
        //    if (objFromDb.co == null)
        //    {
        //        accgID = "01";
        //    }
        //    else
        //    {
        //        string sub = objFromDb.last_acg_id;
        //        int c = Convert.ToInt32(sub);
        //        c++;
        //        string s = c.ToString("00");
        //        accgID = s;

        //    }
        //    return accgID;
        //}
     
        //public void Update(AccountsGroup accountsGroup)
        //{
        //    var objFromDb = _db.Accounts_group.FirstOrDefault(s => s.id== accountsGroup.id);
        //    if (objFromDb != null)
        //    {
        //        objFromDb.ac_group_id = accountsGroup.ac_group_id;
        //        objFromDb.ac_group_name = accountsGroup.ac_group_name;
        //        objFromDb.ac_type = accountsGroup.ac_type;
        //        objFromDb.control_type = accountsGroup.control_type;
        //        objFromDb.description = accountsGroup.description;
        //        objFromDb.comments = accountsGroup.comments;
        //    }
        //}

    }
}
