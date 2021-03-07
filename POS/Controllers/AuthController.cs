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



       [Authorize(Roles = UserRoles.SYSADMIN+","+UserRoles.ADMIN)]
        [HttpPost]
        [Route("~/Pos/Registration/")]
        public async Task<IActionResult> Register([FromBody] Registration registration)
        {
           



            try
            {
                registration.client_code = getClient();
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
                        expires: DateTime.Now.AddHours(3),
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
