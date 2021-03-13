using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using BarcodeLib;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;

namespace POS.Controllers
{
    public class BarcodeController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;


        public BarcodeController(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

        }


        [Route("~/Barcode/")]
        public IActionResult GenerateBarcode()
        {
            Barcode barcode = new Barcode();
            Image img = barcode.Encode(TYPE.CODE39, "TANJILUL ANWAR", Color.Black, Color.White,1200, 200);
            var data = ConvertImagetoBytes(img);
            return File(data, "image/jpeg");
        }

        private byte[] ConvertImagetoBytes(Image img)
        {
            using(MemoryStream ms = new MemoryStream())
            {
                img.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                return ms.ToArray();
            }
        }

    }
}
