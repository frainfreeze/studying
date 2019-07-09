using PublicSite.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.Security;
using WebMatrix.Data;

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
                var model = new BrowseViewModel();

                var list = new List<SelectListItem>();

                string cs = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

                using (SqlConnection c = new SqlConnection(cs))
                {
                    if (c.State == ConnectionState.Closed)
                        c.Open();

                    using (SqlCommand cmd = new SqlCommand("select Convert(date, Created) from menu", c))
                    {
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                list.Add(new SelectListItem
                                {
                                    Text = rdr.GetString(0),
                                    Value = rdr.GetString(0)
                                });
                            }
                        }
                    }
                }
                
                return View(model);
            }
        }

        public ActionResult GetDate(BrowseModel browse)
        {
            if (!Request.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("browse hit, not loged in, redirecting!");
                return RedirectToAction("Index", "Login");
            }
            else
            {
                TempData["message"] = browse.Dates;
                System.Diagnostics.Debug.WriteLine("browse hit, loged in, rendering!" + browse.Dates);
                return RedirectToAction("Browse", "Browse");
            }
        }

        public ActionResult Browse(BrowseModel browse)
        {
            if (!Request.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("browse hit, not loged in, redirecting!");
                return RedirectToAction("Index", "Login");
            }
            else
            {
                string DatesToUse = browse.Dates;
                System.Diagnostics.Debug.WriteLine("browse hit, loged in, rendering!" + browse.Dates);
                return View(browse);
            }
        }
    }
}

//Get-Project -All | Install-Package Microsoft.AspNet.WebPages.Data