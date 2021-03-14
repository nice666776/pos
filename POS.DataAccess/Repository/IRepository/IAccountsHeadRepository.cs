using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;

namespace POS.DataAccess.Repository.IRepository
{
    public interface IAccountsHeadRepository:IRepository<AccountsHead>
    {
       public void Update(AccountsHead accountsHead);
 
      public string _setAccountsHeadID(string group_id ,string client_code);
    }
}
