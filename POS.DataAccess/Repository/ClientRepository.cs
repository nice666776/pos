using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace POS.DataAccess.Repository
{
   public class ClientRepository:Repository<Client>,IClientRepository
    {

        private readonly ApplicationDbContext _db;

        public ClientRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

        public string GetClientCode()
        {
            string code;
            
            Client client = _db.Client.OrderByDescending(p => p.id).FirstOrDefault();
            if (client== null)
            {
                code = "01";

            }
            else
            {
              
                int code_no = Convert.ToInt32(client.code);
                code_no++;
                code = code_no.ToString("00");
               

            }

            return code;


        }


        public User GetFirstAdmin(string client_code)
        {
            

            User user = _db.User.OrderBy(p => p.id).FirstOrDefault(u=>u.client_code== client_code && u.user_type == "ADMIN" );

            return user;
           

        }


        public void Update(Client client)
        {
            
                _db.Client.Update(client);
        }
    }
}
