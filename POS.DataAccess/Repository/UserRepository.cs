using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
    public class UserRepository : Repository<User>, IUserRepository
    {
        private readonly ApplicationDbContext _db;

        public UserRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }
        public void Update(User user)
        {
            User objFromDb = _db.User.FirstOrDefault(u => u.id == user.id);
            if(objFromDb! == null)
            {
                objFromDb.first_name = user.first_name;
                objFromDb.last_name = user.last_name;
 
                objFromDb.phone = user.phone;
                objFromDb.user_type = user.user_type;
                objFromDb.email = user.email;
                objFromDb.added_by = user.added_by;
                objFromDb.add_date = user.add_date;
            }
         
        }
    }
}
