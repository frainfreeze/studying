using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace PublicSite.Controllers
{
    public class BrowseController : Controller
    {
        // GET: Browse
        public ActionResult Index()
        {
            if (!Request.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("browse hit, not loged in, redirecting!");
                return RedirectToAction("Index", "Login");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("browse hit, loged in, rendering!");
                return View();
            }
        }
    }
}