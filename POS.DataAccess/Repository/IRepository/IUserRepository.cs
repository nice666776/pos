
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
    public interface IUserRepository:IRepository<User>
    {
        public void Update(User user);
    }
}
