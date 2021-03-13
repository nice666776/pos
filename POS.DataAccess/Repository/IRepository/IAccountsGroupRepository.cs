using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
    public interface IAccountsGroupRepository: IRepository<AccountsGroup>
    {
        //public string _setAccountGroupID(int school_id);
        //void Update(AccountsGroup accountsGroup);
    }
}
