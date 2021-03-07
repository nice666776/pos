using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;

namespace POS.Controllers
{
    public class ClientController : BaseController
    {
        private readonly IUnitOfWork _unitOfWork;


        public ClientController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

        }

        [HttpPost]
        [Route("~/client/add")]
        public IActionResult Upsert([FromBody] Client client)
        {

            if (ModelState.IsValid)
            {
                if (client.id == 0)
                {
                    client.code = _unitOfWork.Client.GetClientCode();
                    _unitOfWork.Client.Add(client);
  
                }
                else
                {
                    _unitOfWork.Client.Update(client);

                }


                return Json(new { success = false, message = client });
            }
            else
            {
                return Json(new { success = false, message = "Add failed!!" });
            }

        }

    }
}
