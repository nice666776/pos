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
    public class AccountGroupController : BaseController
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;


        public AccountGroupController(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

        }
        [HttpGet]
        [Route("~/ControlType")]
        public IActionResult CTList()
        {
            string client_code = getClient();
            IEnumerable<AccountControl> accList = _unitOfWork.AccountControl.GetAll();
            return Json(new { success = true, message = accList });
        }

        [HttpGet]
        [Route("~/AccountsGroup/List")]
        public IActionResult ACGList()
        {
            string client_code = getClient();
            List<AccountsGroup> acgList = _unitOfWork.AccountsGroup.GetAll(u => u.client_code == client_code).ToList();
            return Json(new { success = true, message = acgList });
        }

        [HttpGet]
        [Route("~/AccountsGroup/DropDown")]
        public IActionResult ACGDrop()
        {
            string client_code = getClient();
           var acgList = _unitOfWork.AccountsGroup.GetAll(u => u.client_code == client_code).Select(u=>new { u.ac_group_id, u.ac_group_name, u.ac_type });
            return Json(new { success = true, message = acgList });
        }

        [HttpPost]
        [Route("~/AccountsGroup/add")]
        public IActionResult Upsert([FromBody] AccountsGroup accountsGroup)
        {

            if (ModelState.IsValid)
            {
                if (accountsGroup.id == 0)
                {
                    string client_code = getClient();
                    accountsGroup.ac_group_id = _unitOfWork.AccountsGroup._setAccountGroupID(client_code);
                    accountsGroup.client_code = client_code;
                    _unitOfWork.AccountsGroup.Add(accountsGroup);
             

                }
                else
                {
                    _unitOfWork.AccountsGroup.Update(accountsGroup);

                }
                _unitOfWork.Save();
                return Json(new { success = true, message = accountsGroup });

            }
            else
            {
                return Json(new { success = false, message = "Add failed!!" });
            }

        }








    }
}
