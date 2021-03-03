using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using POS.ViewModels;

namespace POS.Controllers
{
    public class TradeController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;


        public TradeController(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

        }


        [HttpPost]
        [Route("~/Category/add")]
        public IActionResult Upsert( Trade trade)
        {

            if (ModelState.IsValid)
            {
                trade.code = "03";
                trade.client_code = "CL799";

                return Json(new { success = true, message = "Trade Updated!!" });
            }
            else
            {
                return Json(new { success = false, message = "Add failed!!" });
            }

        }
    }
}
