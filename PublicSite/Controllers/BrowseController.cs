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

                string querystr = "select Convert(date, m.Created) from menu as m inner join [User] as u on m.IDUSer=u.IDUser where u.IDUser='" + Session["UserID"] + "'";
                System.Diagnostics.Debug.WriteLine(querystr);
                using (SqlConnection c = new SqlConnection(cs))
                {
                    if (c.State == ConnectionState.Closed)
                        c.Open();

                    using (SqlCommand cmd = new SqlCommand(querystr, c))
                    {
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                string tmp = Convert.ToString(rdr.GetDateTime(0)); //as string ?? String.Empty;
                                list.Add(new SelectListItem
                                {
                                    Text = tmp,
                                    Value = tmp
                                });
                            }
                        }
                    }
                }

                model.DatesM = list;

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