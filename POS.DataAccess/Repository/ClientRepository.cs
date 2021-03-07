﻿using POS.DataAccess.Data;
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
                string value = _db.Client
                            .OrderByDescending(p => p.id)
                            .Select(r => r.code)
                            .FirstOrDefault().ToString();

            if(value== null)
            {
                code = "01";

            }
            else
            {
              
                int code_no = Convert.ToInt32(value);
                code_no++;
                code = code_no.ToString("00");
               

            }

            return code;


        }

        public void Update(Client client)
        {
           _db.Client.Update(client);
        }
    }
}
