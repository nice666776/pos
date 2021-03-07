using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
  public interface IClientRepository:IRepository<Client>
    {
        public void Update(Client client);
        public string GetClientCode();
    }
}
