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
    public class TransactionController : BaseController
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;


        public TransactionController(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

        }
        [HttpGet]
        [Route("~/accountshead/entry_point")]
        public IActionResult Accounts_Index(string type)//E or I
        {
            string client_code = getClient();

            List<AccountsGroup> accountsGroup = _unitOfWork.AccountsGroup.GetAll(u => u.control_type == type && u.client_code == client_code).ToList();
            List<AccountsHead> acHeadMaster = new List<AccountsHead>();
            foreach (AccountsGroup ag in accountsGroup)
            {
                List<AccountsHead> accountsHead = _unitOfWork.AccountsHead.GetAll(u => u.ac_group_id == ag.ac_group_id && u.client_code == client_code).ToList();
                acHeadMaster.AddRange(accountsHead);
            }


            var Query = from ac_head in acHeadMaster select new { ac_head.ac_head_name, ac_head.ac_head_id };

            return Json(new { Query });
        }

        public class PayProp
        {
            public string payment_head { get; set; }
            public double amount { get; set; }
        }

        public class PayTrans
        {
            public DateTime payment_date { get; set; }
            public string payment_by { get; set; }
            public double total_payment { get; set; }
            public List<PayProp> pay_for { get; set; }
            public string voucher_id { get; set; }
        }


        public class receiptProp
        {
            public string receipt_head { get; set; }

            public double amount { get; set; }
        }

        public class ReceiptTrans
        {
            public DateTime receipt_date { get; set; }
            public string receipt_by { get; set; }
            public double total_payment { get; set; }
            public List<receiptProp> pay_for { get; set; }
            public string voucher_id { get; set; }
        }



        [HttpGet]
        [Route("~/~/Accounts/Payment/List")]
        public IActionResult BillPayList()
        {
            string client_code = getClient();
            string trade_code = getTrade();

            List<ProductEventInfo> peList = _unitOfWork.ProductEventInfo.GetAll(u => u.transaction_type == "PAYMENT" && u.client_code == client_code && u.trade_code == trade_code).ToList();

            List<string> UniqueTransactions = peList.Select(x => x.transaction_id).Distinct().ToList();

            List<PayTrans> payTransList = new List<PayTrans>();
            foreach (string trx in UniqueTransactions)
            {
                PayTrans pt = new PayTrans();
                List<ProductEventInfo> pe_dr_list = peList.Where(u => u.transaction_id == trx && u.trx_info == "Dr.").ToList();
                ProductEventInfo pe_cr = peList.FirstOrDefault(u => u.transaction_id == trx && u.trx_info == "Cr.");
                pt.payment_date = pe_cr.entry_date;
                pt.voucher_id = pe_cr.transaction_id;
                pt.payment_by = pe_cr.transaction_type;
                pt.total_payment = pe_cr.cr_total;
                pt.voucher_id = pe_cr.invoice;
                pt.pay_for = new List<PayProp>();

                List<Ledger> ledgerList = _unitOfWork.Ledger.GetAll(u => u.transaction_id == trx && u.trade_code == trade_code).ToList();
                foreach (Ledger ldgr_Dr in ledgerList)
                {
                    PayProp pp = new PayProp();
                    pp.payment_head = ldgr_Dr.accounts_head_name;
                    pp.amount = ldgr_Dr.dr_total;
                    pt.pay_for.Add(pp);

                }

                payTransList.Add(pt);
            }


            return Json(new { success = true, list = payTransList });
        }




        [HttpPost]
        [Route("~/Accounts/Payment/Submit")]
        public IActionResult BillPaySubmit([FromBody] PayTrans payTrans)
        {
            if (ModelState.IsValid)
            {


                if (payTrans.pay_for.Count == 0 || payTrans.pay_for == null)
                {
                    return Json(new { success = false, message = "Entry cannot be empty!" });
                }

                if (payTrans.payment_by == null)
                {
                    return Json(new { success = false, message = "Entry cannot be empty!" });
                }


                if (payTrans.payment_date == null)
                {
                    return Json(new { success = false, message = "Please set the Date!" });
                }

                string payTrx = RandomString(7);
                double total_amount = 0.00;
                //this part is for paid for (Debit)
                string client_code = getClient();
                string trade_code = getTrade();
                string user_id = GetUserId();
                string invoice = _unitOfWork.ProductStock.setInvoiceNo(trade_code);
                foreach (PayProp pp in payTrans.pay_for)
                {

                    Ledger ledger = new Ledger();
                    ledger.transaction_type = "PAYMENT";
                    ledger.transaction_id = payTrx;
                    ledger.accounts_head_id = pp.payment_head;
                    ledger.accounts_head_name = _unitOfWork.AccountsHead.GetFirstOrDefault(u => u.ac_head_id == pp.payment_head).ac_head_name;
                    ledger.invoice = invoice;
                    ledger.entry_date = payTrans.payment_date.Date;
                    ledger.dr_amount = pp.amount;
                    ledger.dr_total = pp.amount;
                    ledger.dr_discount = 0.00; ledger.cr_amount = 0.00; ledger.cr_discount = 0.00; ledger.cr_total = 0.00;
                    ledger.user_id = user_id;
                    ledger.client_code = client_code;
                    ledger.entry_time = payTrans.payment_date.Date;
                    ledger.trade_code = trade_code;
                    ledger.trx_info = "Dr.";
                    _unitOfWork.Ledger.Add(ledger);

                    total_amount += pp.amount;

                }

                ProductEventInfo productEventDr = new ProductEventInfo();
                productEventDr.transaction_id = payTrx;
                productEventDr.transaction_type = "PAYMENT";
                productEventDr.invoice = invoice;
                productEventDr.entry_date = payTrans.payment_date.Date;
                productEventDr.dr_amount = total_amount;
                productEventDr.dr_total = total_amount;
                productEventDr.dr_discount = 0.00;
                productEventDr.cr_amount = 0.00; productEventDr.cr_discount = 0.00; productEventDr.cr_total = 0.00;
                productEventDr.user_id = user_id;
                productEventDr.client_code = client_code;
                productEventDr.entry_time = payTrans.payment_date;
                productEventDr.trade_code = trade_code;
                productEventDr.trx_info = "Dr.";
                _unitOfWork.ProductEventInfo.Add(productEventDr);


                ProductEventInfo productEventCr = new ProductEventInfo();
                productEventCr.transaction_id = payTrx;
                productEventCr.transaction_type = payTrans.payment_by;
                productEventCr.invoice = invoice;
                productEventCr.entry_date = payTrans.payment_date.Date;
                productEventCr.cr_amount = total_amount;
                productEventCr.cr_total = total_amount;
                productEventCr.cr_discount = 0.00;
                productEventCr.dr_amount = 0.00; productEventCr.dr_discount = 0.00; productEventCr.dr_total = 0.00;
                productEventCr.user_id = user_id;
                productEventCr.client_code = client_code;
                productEventCr.entry_time = payTrans.payment_date;
                productEventCr.trade_code = trade_code;
                productEventCr.trx_info = "Cr.";
                _unitOfWork.ProductEventInfo.Add(productEventCr);



                _unitOfWork.Save();
               return Json(new { success = true, message = "Payment Entry Successful!", voucher_id = payTrx });

            }




            return Json(new { success = false, message = "Failed to update Entry!" });

        }







        [HttpPost]
        [Route("~/Accounts/Receipt/Submit")]
        public IActionResult RecieptSubmit([FromBody] ReceiptTrans receiptTrans)
        {
            if (ModelState.IsValid)
            {


                if (receiptTrans.pay_for.Count == 0 || receiptTrans.pay_for == null)
                {
                    return Json(new { success = false, message = "Entry cannot be empty!" });
                }

                if (receiptTrans.receipt_by == null)
                {
                    return Json(new { success = false, message = "Entry cannot be empty!" });
                }


                if (receiptTrans.receipt_date == null)
                {
                    return Json(new { success = false, message = "Please set the Date!" });
                }

                string payTrx = RandomString(7);
                double total_amount = 0.00;
                //this part is for paid for (Debit)
                string client_code = getClient();
                string trade_code = getTrade();
                string user_id = GetUserId();
                string invoice = _unitOfWork.ProductStock.setInvoiceNo(trade_code);
                foreach (receiptProp rp in receiptTrans.pay_for)
                {

                    Ledger ledger = new Ledger();
                    ledger.transaction_type = "INCOME";
                    ledger.transaction_id = payTrx;
                    ledger.accounts_head_id = rp.receipt_head;
                    ledger.accounts_head_name = _unitOfWork.AccountsHead.GetFirstOrDefault(u => u.ac_head_id == rp.receipt_head).ac_head_name;
                    ledger.invoice = invoice;
                    ledger.entry_date = receiptTrans.receipt_date.Date;
                    ledger.dr_amount = 0.00;
                    ledger.dr_total = 0.00;
                    ledger.dr_discount = 0.00; ledger.cr_amount = rp.amount; ledger.cr_discount = 0.00; ledger.cr_total = rp.amount;
                    ledger.user_id = user_id;
                    ledger.client_code = client_code;
                    ledger.entry_time = receiptTrans.receipt_date;
                    ledger.trade_code = trade_code;
                    ledger.trx_info = "Cr.";
                    _unitOfWork.Ledger.Add(ledger);

                    total_amount += rp.amount;

                }

                ProductEventInfo productEventCr = new ProductEventInfo();
                productEventCr.transaction_id = payTrx;
                productEventCr.transaction_type = "INCOME";
                productEventCr.invoice = invoice;
                productEventCr.entry_date = receiptTrans.receipt_date.Date;
                productEventCr.cr_amount = total_amount;
                productEventCr.cr_total = total_amount;
                productEventCr.cr_discount = 0.00;
                productEventCr.dr_amount = 0.00; productEventCr.dr_discount = 0.00; productEventCr.dr_total = 0.00;
                productEventCr.user_id = user_id;
                productEventCr.client_code = client_code;
                productEventCr.entry_time = receiptTrans.receipt_date;
                productEventCr.trade_code = trade_code;
                productEventCr.trx_info = "Cr.";
                _unitOfWork.ProductEventInfo.Add(productEventCr);




                ProductEventInfo productEventDr = new ProductEventInfo();
                productEventDr.transaction_id = payTrx;
                productEventDr.transaction_type =  receiptTrans.receipt_by;
                productEventDr.invoice = invoice;
                productEventDr.entry_date = receiptTrans.receipt_date.Date;
                productEventDr.dr_amount = total_amount;
                productEventDr.dr_total = total_amount;
                productEventDr.dr_discount = 0.00;
                productEventDr.cr_amount = 0.00; productEventDr.cr_discount = 0.00; productEventDr.cr_total = 0.00;
                productEventDr.user_id = user_id;
                productEventDr.client_code = client_code;
                productEventDr.entry_time = receiptTrans.receipt_date;
                productEventDr.trade_code = trade_code;
                productEventCr.trx_info = "Dr.";
                _unitOfWork.ProductEventInfo.Add(productEventDr);


                _unitOfWork.Save();
                return Json(new { success = true, message = "Receipt Entry Successful!", voucher_id = payTrx });

            }


            return Json(new { success = false, message = "Failed to update Entry!" });

        }





















    }
}
