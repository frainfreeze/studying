using PublicSite.App_Code;
using PublicSite.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PublicSite.Controllers
{
    public class GenController : Controller
    {
        // GET: Gen
        public ActionResult Index()
        {
            if (!Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Login");
            }
            else
            {
                return View();
            }
        }

        public ActionResult WriteMenu(GenModel gen)
        {
            if (!Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Login");
            }
            else
            {
                string cs = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
                
                //create menu
                string querystr = "insert into Menu values (getDate()," + Convert.ToString(gen.NumMeals) + "," + Session["UserID"] + ",1)";
                using (var conn = new SqlConnection(cs))
                using (var cmd = conn.CreateCommand())
                {
                    conn.Open();
                    cmd.CommandText = querystr;
                    var result = cmd.ExecuteNonQuery();
                }
                //create menu
                querystr = "insert into Meal values (idmenu, idmealname, idgrocery, enabled)"; //times meal count
                using (var conn = new SqlConnection(cs))
                using (var cmd = conn.CreateCommand())
                {
                    conn.Open();
                    cmd.CommandText = querystr;
                    var result = cmd.ExecuteNonQuery();
                }


                return RedirectToAction("Index", "Browse");
            }
        }

        public ActionResult Confirm(GenModel gen)
        {
            if (!Request.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("browse hit, not loged in, redirecting!");
                return RedirectToAction("Index", "Login");
            }
            else
            {
                MenuGen menuGen = new MenuGen();
                gen.dt = menuGen.Generate(Convert.ToInt16(gen.NumMeals));
                return View(gen);
            }
        }
    }
}