using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;

namespace POS.Controllers
{
    public class AccountsHeadController : BaseController
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;


        public AccountsHeadController(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

        }

        [HttpGet]
        [Route("~/AccountsHead/List")]
        public IActionResult ACHList()
        {
            string client_code = getClient();
            List<AccountsHead> achList = _unitOfWork.AccountsHead.GetAll(u => u.client_code == client_code).ToList();
            return Json(new { success = true, message = achList });
        }

        [HttpPost]
        [Route("~/AccountsHead/add")]
        public IActionResult Upsert([FromBody] AccountsHead accountsHead)
        {

            if (ModelState.IsValid)
            { 
                if (accountsHead.id == 0)
                {
                    string client_code = getClient();
                    accountsHead.ac_head_id = _unitOfWork.AccountsHead._setAccountsHeadID(accountsHead.ac_group_id,client_code);
                    accountsHead.client_code = client_code;
                    _unitOfWork.AccountsHead.Add(accountsHead);
             

                }
                else
                {
                    _unitOfWork.AccountsHead.Update(accountsHead);

                }
                _unitOfWork.Save();
                return Json(new { success = true, message = accountsHead });

            }
            else
            {
                return Json(new { success = false, message = "Add failed!!" });
            }

        }








    }
}
