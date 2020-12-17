using POS.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DataAccess.Repository.IRepository
{
    public interface IManufacturerRepository:IRepository<Manufacturer>
    {
        public void Update(Manufacturer manufacturer);
        public string getManufacturerCode();
    }
}
