using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using POS.Models.Models.Authentication;

namespace POS.Controllers
{
    public class AuthController : Controller
    {

        private readonly UserManager<ApplicationUser> userManager;
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly IUnitOfWork _unitOfWork;

        public AuthController(IUnitOfWork unitOfWork, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            this.userManager = userManager;
            this.roleManager = roleManager;
            _unitOfWork = unitOfWork;
        }


        

        [HttpPost]
        [Route("~/Pos/Registration/")]
        public async Task<IActionResult> Register([FromBody] Registration registration)
        {


            registration.client_code = "CL799";
            registration.date_added = DateTime.Now.Date;

            if (registration.phone.Contains("[a-zA-Z]+") || registration.phone.Length <11)
            {
                return Json(new { success = false, message = "Phone No. Invalid!" });
            }
                //int index = registration.email.IndexOf('@');
                //string _userName = registration.email.Substring(0, index);
                var userExist = await userManager.FindByEmailAsync(registration.email);
            if (userExist != null)
                return Json(new { success = false, message = "User of same email already exists" });
            userExist = await userManager.FindByNameAsync(registration.phone);
            if (userExist != null)
                return Json(new { success = false, message = "User of same phone no. already exists" });

            ApplicationUser user = new ApplicationUser()
            {
                Email = registration.email,
                SecurityStamp = Guid.NewGuid().ToString(),
                UserName = registration.phone,
                PhoneNumber = registration.phone

            };

            var result = await userManager.CreateAsync(user, registration.password);
            if (!result.Succeeded)
            {
                return Json(new { success = false, message = "Invalid Input!" });
            }
            if (registration.user_type == "ADMIN")
            {

                if (!await roleManager.RoleExistsAsync(UserRoles.Admin))
                    await roleManager.CreateAsync(new IdentityRole(UserRoles.Admin));

                if (await roleManager.RoleExistsAsync(UserRoles.Admin))
                {
                    await userManager.AddToRoleAsync(user, UserRoles.Admin);
                }


            }

            if (registration.user_type == "ACCOUNTS")
            {
             

                if (!await roleManager.RoleExistsAsync(UserRoles.Accounts))
                    await roleManager.CreateAsync(new IdentityRole(UserRoles.Accounts));


                if (await roleManager.RoleExistsAsync(UserRoles.Accounts))
                {
                    await userManager.AddToRoleAsync(user, UserRoles.Accounts);
                }


            }


            if (registration.user_type == "SALES")
            {
               

                if (!await roleManager.RoleExistsAsync(UserRoles.Sales))
                    await roleManager.CreateAsync(new IdentityRole(UserRoles.Sales));

                if (await roleManager.RoleExistsAsync(UserRoles.Sales))
                {
                    await userManager.AddToRoleAsync(user, UserRoles.Sales) ;
                }


            }
            



            var CreatedUser = await userManager.FindByEmailAsync(registration.email);
            User NewUSer = new User()
            {
                first_name = registration.first_name,
                last_name = registration.last_name,
                email = registration.email,
                phone = registration.phone,
                status = registration.status,
                user_type = registration.user_type,
                user_id = CreatedUser.Id,
                add_date = DateTime.Now.Date,


            };
            _unitOfWork.User.Add(NewUSer);
            _unitOfWork.Save();
   
            return Json(new { success = true, message = NewUSer });


        }

    }
}
