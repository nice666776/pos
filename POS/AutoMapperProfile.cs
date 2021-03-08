using AutoMapper;
using POS.Models.Models;
using POS.ViewModels;

namespace POS
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap< Category , CategoryVM >();
            CreateMap<CategoryVM, Category>();
            CreateMap<ProductStockIn, ProductStock>();
            CreateMap<ProductStock, ProductStockIn>();
            CreateMap<Client, ClientVM>();
            CreateMap<ClientVM, Client>();

        }
    }
}