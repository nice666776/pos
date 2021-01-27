using POS.DataAccess.Data;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using System;
using System.Linq;

namespace POS.DataAccess.Repository
{
   public class CategoryRepository: RepositoryAsync<Category>, ICategoryRepository
    {
        private readonly ApplicationDbContext _db;

        public CategoryRepository(ApplicationDbContext db) : base(db)
        {
            _db = db;
        }

        public string getCategoryCode()
        {
            POSLog pOSLog = _db.Pos_log.FirstOrDefault();
            string category_code;
            if (pOSLog == null)
            {
                POSLog pOSLog_new = new POSLog();
                _db.Pos_log.Add(pOSLog_new);

            }
            if (pOSLog.category_code == null)
            {
                category_code = "0001";

            }

            else
            {

                int code_no = Convert.ToInt32(pOSLog.category_code);
                code_no++;
                string s = code_no.ToString("0000");
                category_code = s;

            }
            return category_code;
        }
        public void Update(Category category)
        {
            //Category ACategory = _db.Category_info.FirstOrDefault(c => c.id == category.id);
            //if(ACategory!= null)
            //{
            //    ACategory.name = category.name;
            //    ACategory.description = category.description;
            //}

            _db.Category_info.Update(category);

        }


    }
}
