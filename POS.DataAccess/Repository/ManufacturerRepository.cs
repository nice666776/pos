using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;
using POS.DataAccess.Repository.IRepository;
using POS.DataAccess.Data;
using System.Linq;

namespace POS.DataAccess.Repository
{
   public class ManufacturerRepository: Repository<Manufacturer>, IManufacturerRepository
    {
        private readonly ApplicationDbContext _db;

        public ManufacturerRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }


        public string getManufacturerCode()
        {
            POSLog pOSLog = _db.Pos_log.FirstOrDefault();
            string manufacturer_code;
            if (pOSLog == null)
            {
                POSLog pOSLog_new = new POSLog();
                _db.Pos_log.Add(pOSLog_new);

            }
            if (pOSLog.manufacturer_code == null)
            {
                manufacturer_code = "MAN00001";

            }

            else
            {
                string temp = pOSLog.manufacturer_code.Substring(3, 5);
                int code_no = Convert.ToInt32(temp);
                code_no++;
                string s = code_no.ToString("00000");
                manufacturer_code = "MAN" + s;

            }
            return manufacturer_code;

        }



        public void Update(Manufacturer manufacturer)
        {
            Manufacturer aManufacturer = _db.Manufacturers_info.FirstOrDefault(c => c.id == manufacturer.id);
            if (aManufacturer != null)
            {
                //aManufacturer.code = manufacturer.code;
                aManufacturer.name = manufacturer.name;
                aManufacturer.address = manufacturer.address;
                aManufacturer.contact_person = manufacturer.contact_person;
                aManufacturer.phone = manufacturer.phone;
                aManufacturer.email = manufacturer.email;
                aManufacturer.brand = manufacturer.brand;
                aManufacturer.comments = manufacturer.comments;
                aManufacturer.entry_date = manufacturer.entry_date;
                aManufacturer.entry_by = manufacturer.entry_by;
                aManufacturer.status = manufacturer.status;
            }
        }
    }
}
