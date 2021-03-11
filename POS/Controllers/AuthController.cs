using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using POS.DataAccess.Repository.IRepository;
using POS.Models.Models;
using POS.Models.Models.Authentication;
using POS.ViewModels;

namespace POS.Controllers
{
    public class AuthController : BaseController
    {

        private readonly UserManager<ApplicationUser> userManager;
        private readonly IConfiguration _configuration;
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly IUnitOfWork _unitOfWork;

        public AuthController(IUnitOfWork unitOfWork, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager, IConfiguration configuration)
        {
            this.userManager = userManager;
            this.roleManager = roleManager;
            _configuration = configuration;
            _unitOfWork = unitOfWork;
        }





        [Authorize(Roles = UserRoles.SYSADMIN)]
        [HttpPost]
        [Route("~/Pos/Admin/Update")]
        public async Task<IActionResult> Admin_Update([FromBody] Registration registration)
        {

            try
            {
                ApplicationUser user = await userManager.FindByIdAsync(registration.user_id);

                user.Email = registration.email;
                user.UserName = registration.phone;
                user.PhoneNumber = registration.phone;
                user.PasswordHash = userManager.PasswordHasher.HashPassword(user, registration.password);
                var result = await userManager.UpdateAsync(user);

                if (!result.Succeeded)
                {
                    return Json(new { success = false, message = "Invalid Input!" });
                }

                User TUser = _unitOfWork.User.GetFirstOrDefault(u => u.user_id == user.Id);
                TUser.first_name = registration.first_name.ToUpper();
                TUser.last_name = registration.last_name.ToUpper();
                TUser.phone = registration.phone;
                TUser.user_type = registration.user_type;
                TUser.status = registration.status;
                TUser.email = registration.email;
                TUser.status = registration.status;
                TUser.add_date = DateTime.Now;




                _unitOfWork.User.Update(TUser);

                _unitOfWork.Save();
                if (result.Succeeded)
                {
                   
                    return Json(new { success = true, message = TUser });
                }
                return Json(new { success = false, message = "Update Failed" });

            }
            catch
            {
                return Json(new { success = false, message = "Admin Update failed!!" });
            }


        }



        [Authorize(Roles = UserRoles.SYSADMIN + "," + UserRoles.ADMIN)]
        [HttpGet]
        [Route("~/Pos/userlist/")]
        public IActionResult UserList()
        {
            string client_code = getClient();
            if(client_code == null)
            {
                return Json(new { sucess = false });
            }
            List<User> userList = _unitOfWork.User.GetAll(u => u.client_code == client_code && u.user_type!= "SYSADMIN").ToList();
            List<Trade> tradeList = _unitOfWork.Trade.GetAll(u => u.client_code == client_code).ToList();
            List<UserTrade> userTrades = _unitOfWork.UserTrade.GetAll(u => u.client_code == client_code).ToList();
            var users = (from c in userList
                         select (new
                         {
                             id = c.id,
                             first_name = c.first_name,
                             last_name = c.last_name,
                             email = c.email,
                             user_type = c.user_type,
                             phone = c.phone,
                             status = c.status,
                             user_id = c.user_id,
                             added_by = c.added_by,
                             add_date = c.add_date,
                             client_code = c.client_code,
                             trade_code = c.trade_code,
                             trade_list = from tl in tradeList
                                          join ut in userTrades
                                          on new { X1 = tl.code, X2 = c.user_id } equals new { X1 = ut.trade_code, X2 = ut.user_id }
                                          select tl
                                          //from lc in ListC.DefaultIfEmpty()
                                          //select lc ?? lb;



                         })).ToList();
            if (userList.Count == 0)
            {
                return Json(new { sucess = false, message = "No User found!" });
            }

            return Json(new { success = true, message = users });
        
        
        
        
        }





        [Authorize(Roles = UserRoles.SYSADMIN+","+UserRoles.ADMIN)]
        [HttpPost]
        [Route("~/Pos/Registration/")]
        public async Task<IActionResult> Register([FromBody] Registration registration)
        {
           
            try
            {

                string userId = GetUserId();
                if(registration.client_code == null) { registration.client_code = getClient(); }
             //   if (registration.trade_code == null) { registration.trade_code = getTrade(); }
                registration.date_added = DateTime.Now.Date;

                if (registration.phone.Contains("[a-zA-Z]+") || registration.phone.Length < 11)
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

                    if (!await roleManager.RoleExistsAsync(UserRoles.ADMIN))
                        await roleManager.CreateAsync(new IdentityRole(UserRoles.ADMIN));

                    if (await roleManager.RoleExistsAsync(UserRoles.ADMIN))
                    {
                        await userManager.AddToRoleAsync(user, UserRoles.ADMIN);
                    }


                }

                if (registration.user_type == "ACCOUNTS")
                {


                    if (!await roleManager.RoleExistsAsync(UserRoles.ACCOUNTS))
                        await roleManager.CreateAsync(new IdentityRole(UserRoles.ACCOUNTS));


                    if (await roleManager.RoleExistsAsync(UserRoles.ACCOUNTS))
                    {
                        await userManager.AddToRoleAsync(user, UserRoles.ACCOUNTS);
                    }


                }

                if (registration.user_type == "TEST")
                {


                    if (!await roleManager.RoleExistsAsync(UserRoles.TEST))
                        await roleManager.CreateAsync(new IdentityRole(UserRoles.TEST));


                    if (await roleManager.RoleExistsAsync(UserRoles.TEST))
                    {
                        await userManager.AddToRoleAsync(user, UserRoles.TEST);
                    }


                }


                if (registration.user_type == "SALES")
                {


                    if (!await roleManager.RoleExistsAsync(UserRoles.SALES))
                        await roleManager.CreateAsync(new IdentityRole(UserRoles.SALES));

                    if (await roleManager.RoleExistsAsync(UserRoles.SALES))
                    {
                        await userManager.AddToRoleAsync(user, UserRoles.SALES);
                    }


                }


                if (registration.user_type == "INVENTORY")
                {


                    if (!await roleManager.RoleExistsAsync(UserRoles.INVENTORY))
                        await roleManager.CreateAsync(new IdentityRole(UserRoles.INVENTORY));

                    if (await roleManager.RoleExistsAsync(UserRoles.INVENTORY))
                    {
                        await userManager.AddToRoleAsync(user, UserRoles.INVENTORY);
                    }


                }
                //if (registration.user_type == "SYSADMIN")
                //{


                //    if (!await roleManager.RoleExistsAsync(UserRoles.SYSADMIN))
                //        await roleManager.CreateAsync(new IdentityRole(UserRoles.SYSADMIN));

                //    if (await roleManager.RoleExistsAsync(UserRoles.SYSADMIN))
                //    {
                //        await userManager.AddToRoleAsync(user, UserRoles.SYSADMIN);
                //    }


                //}
             
                var CreatedUser = await userManager.FindByEmailAsync(registration.email);
                foreach (Trade t in registration.trade_list)
                {
                    UserTrade ut = new UserTrade()
                    {
                        user_id = CreatedUser.Id,
                        trade_code = t.code,
                        client_code = registration.client_code
                    };
                    _unitOfWork.UserTrade.Add(ut);

                }
                User NewUSer = new User()
                {
                    first_name = registration.first_name.ToUpper(),
                    last_name = registration.last_name.ToUpper(),
                    email = registration.email,
                    phone = registration.phone,
                    status = registration.status,
                    user_type = registration.user_type,
                    user_id = CreatedUser.Id,
                    add_date = DateTime.Now.Date,
                    added_by = userId,
                    client_code = registration.client_code,
                    trade_code = registration.trade_code
               

                };
                _unitOfWork.User.Add(NewUSer);
                _unitOfWork.Save();

                return Json(new { success = true, message = NewUSer });
            }
            catch
            {
                return Json(new { success = false, message = "This service has encountered an error!" });
            }

          


        }


        [Authorize(Roles = UserRoles.SYSADMIN + "," + UserRoles.ADMIN)]
        [HttpPost]
        [Route("~/Pos/UpdateByAdmin/")]
        public async Task<IActionResult> UpdateByAdmin([FromBody] UpdateModel updateModel)
        {

            try
            {

                string adminID = GetUserId();
               string client_code = getClient();
               
                    ApplicationUser user = await userManager.FindByIdAsync(updateModel.user_id);

                    user.Email = updateModel.email;
                    if (updateModel.password != null)
                    {
                        user.PasswordHash = userManager.PasswordHasher.HashPassword(user, updateModel.password);
                    }
         
                    var result = await userManager.UpdateAsync(user);

                    if (!result.Succeeded)
                    {
                        return Json(new { success = false, message = "Invalid Input!" });
                    }

                    User TUser = _unitOfWork.User.GetFirstOrDefault(u => u.user_id == user.Id);
                    TUser.first_name = updateModel.first_name.ToUpper();
                    TUser.last_name = updateModel.last_name.ToUpper();
                    TUser.status = updateModel.status;
                    TUser.email = updateModel.email;
                    TUser.status = updateModel.status;
                    TUser.add_date = DateTime.Now;
                    TUser.added_by = adminID;
                _unitOfWork.User.Update(TUser);

                var tradeRemove = _unitOfWork.UserTrade.GetAll(u => u.user_id == updateModel.user_id);
                _unitOfWork.UserTrade.RemoveRange(tradeRemove);
                foreach (Trade t in updateModel.trade_list)
                {
                    UserTrade ut = new UserTrade()
                    {
                        user_id = updateModel.user_id,
                        trade_code = t.code,
                        client_code =client_code
                    };
                    _unitOfWork.UserTrade.Add(ut);

                }

                _unitOfWork.Save();

                return Json(new { success = true, message = updateModel });
            }
            catch
            {
                return Json(new { success = false, message = "This service has encountered an error!" });
            }




        }











        [HttpPost]
        [Route("~/Pos/Login")]
        public async Task<IActionResult> Login([FromBody] LoginModel loginModel)
        {

           
            try
            {
                var user = await userManager.FindByNameAsync(loginModel.UserName);
                if (user != null && await userManager.CheckPasswordAsync(user, loginModel.Password))
                {
                    var userRoles = await userManager.GetRolesAsync(user);
                    var authClaims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name,user.UserName),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim("UserID",user.Id)

                };
                    foreach (var userRole in userRoles)
                    {
                        authClaims.Add(new Claim(ClaimTypes.Role, userRole));
                    }

                    var authSigninKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Secret"]));
                    var token = new JwtSecurityToken(
                        issuer: _configuration["JWT:ValidIssuer"],
                        audience: _configuration["JWT:ValidAudience"],
                        expires: DateTime.Now.AddHours(24),
                        claims: authClaims,
                        signingCredentials: new SigningCredentials(authSigninKey, SecurityAlgorithms.HmacSha256)
                        );
                    User thisUser = _unitOfWork.User.GetFirstOrDefault(u => u.user_id == user.Id);

                    return Ok(new
                    {
                        success = true,
                        token = new JwtSecurityTokenHandler().WriteToken(token)
                        //  userid = user.Id,
                        //  userrole = userRoles[0],
                        // name = thisUser.first_name+" "+thisUser.last_name,
                        //   client_code = thisUser.client_code,
                        // trade_code = thisUser.trade_code



                    }); ;
                }
                return Unauthorized();
            }
            catch
            {
                return Json(new { success = false, message = "This service has encountered an error!" });
            }

          


        }


        [HttpGet]
        [Route("~/Pos/Token")]
        public IActionResult GetByToken()
        {
            //try
            //{

            //}
            //catch
            //{
            //    return Json(new { success = false, message = "This service has encountered an error!" });
            //}
            try
            {
                //var userID = User.Claims.Where(a => a.Type == ClaimTypes.NameIdentifier).FirstOrDefault().Value;
                //var userID = User.Claims.FirstOrDefault(i => i.Type == "UserID").Value;
                var userID = GetUserId();
                var userRole = GetUserRole();
                if (userID == null)
                {
                    return Unauthorized();
                }
                //  var user = await userManager.FindByIdAsync(userID);
                User user = _unitOfWork.User.GetFirstOrDefault(u => u.user_id == userID);
                if (user == null)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Invalid user!"

                    });
                }
                return Ok(new
                {
                    success = true,
                    role = userRole,
                    name = user.first_name + " " + user.last_name,
                    user_id= user.user_id,
                    client_code = user.client_code,
                    trade_code = user.trade_code,
                    phone = user.phone



                });

            }
            catch
            {
                return Json(new { success = false, message = "This service has encountered an error!" });
            }
           
        }


    }
}
