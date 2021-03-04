using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
    public interface ICategoryRepository: IRepositoryAsync<Category>
    {
        public void Update(Category category);
        public string getCategoryCode(string client_code,string trade_code);

    }
}
