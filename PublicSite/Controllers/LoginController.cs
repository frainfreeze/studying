using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PublicSite.App_Code;
using PublicSite.Models;

namespace PublicSite.Controllers
{
    public class LoginController : Controller
    {
        [HttpPost]
        public ActionResult Login(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                string UserName = model.Username;
                string Password = model.Password;
                Repo repo = new Repo();
                System.Diagnostics.Debug.WriteLine(repo.ValidateUser(UserName, Password));
                switch (repo.ValidateUser(UserName, Password))
                {
                    case -1:
                        //Login1.FailureText = "Username and/or password is incorrect.";
                        //ModelState.AddModelError("", "The password provided is incorrect.");
                        System.Diagnostics.Debug.WriteLine("switch out!");
                        return RedirectToAction("Index", "Login");
                    case -2:
                    //Login1.FailureText = "Account is not admin.";
                    default:
                        System.Diagnostics.Debug.WriteLine("auth!");
                        FormsAuthentication.SetAuthCookie(UserName, false); //second parameter is remember me (true/false)
                        return RedirectToAction("Index", "Browse");
                }
            }
            return RedirectToAction("Index", "Login");
        }

        public ActionResult Logoff()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }


        // GET: Login
        public ActionResult Index()
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Browse");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Login hit!");
                return View();
            }
        }
    }
}