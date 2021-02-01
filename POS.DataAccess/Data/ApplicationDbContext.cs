using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using POS.Models;
using POS.Models.Models;


namespace POS.DataAccess.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {


        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
        }
        public DbSet<Supplier> Suppliers_info { get; set; }
        public DbSet<Manufacturer> Manufacturers_info { get; set; }
        public DbSet<POSLog> Pos_log { get; set; }
        public DbSet<Category> Category_info { get; set; }
        public DbSet<Product> Product_info { get; set; }
        public DbSet<Unit> Z_unit_info { get; set; }
    }
}
