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
    public class TradeController : BaseController
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;


        public TradeController(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

        }
  


        [HttpGet]
        [Route("~/trade")]
        public IActionResult TradeList()
        {
            string client_code = getClient();
            List<Trade> tradeList = _unitOfWork.Trade.GetAll(u => u.client_code == client_code).ToList();
            return Json(new { success = true, message = tradeList });
        }

        [HttpPost]
        [Route("~/trade/add")]
        public IActionResult Upsert([FromBody] Trade trade)
        {

            if (ModelState.IsValid)
            {
                if(trade.id == 0)
                {
                    string client_code = getClient();
                    trade.code = _unitOfWork.Trade.GetTradeCode(client_code);
                    trade.client_code = client_code;
                    _unitOfWork.Trade.Add(trade);
                    POSLog pOSLog = new POSLog();
                    pOSLog.client_code = client_code;
                    pOSLog.trade_code = trade.code;
                    _unitOfWork.POSLog.Add(pOSLog);
                    
                }
                else
                {
                    _unitOfWork.Trade.Update(trade);
                   
                }
                _unitOfWork.Save();
                return Json(new { success = true, message = trade });

            }
            else
            {
                return Json(new { success = false, message = "Add failed!!" });
            }

        }
    }
}
