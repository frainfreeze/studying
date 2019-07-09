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
    public class RegisterController : Controller
    {
        // GET: Register
        [HttpGet]
        public ActionResult Index()
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Browse");
            }
            else
            {
                var model = new RegisterViewModel();

                //Replace this with logic that reads entries from the database
                var ActivityLvl1 = new SelectListItem { Text = "Slaba aktivnost", Value = "1" };
                var ActivityLvl2 = new SelectListItem { Text = "Umjerena aktivnost", Value = "2" };
                var ActivityLvl3 = new SelectListItem { Text = "Intenzivna aktivnost", Value = "3" };
                model.ActivityLvlM = new List<SelectListItem> { ActivityLvl1, ActivityLvl2, ActivityLvl3 };

                var Diab1 = new SelectListItem { Text = "Tip 1", Value = "1" };
                var Diab2 = new SelectListItem { Text = "Tip 2", Value = "2" };
                model.DiabTypeM = new List<SelectListItem> { Diab1,Diab2 };

                var Gen1 = new SelectListItem { Text = "Zena", Value = "1" };
                var Gen2 = new SelectListItem { Text = "Muskarac", Value = "2" };
                model.GenderM = new List<SelectListItem> { Gen1,Gen2 };

                return View(model);
            }
        }

        [HttpPost]
        public ActionResult CreateUser(Register user)
        {
            string cs = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            int status;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("Insert_User"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Username", user.Username);
                    cmd.Parameters.AddWithValue("@Password", user.Password);
                    cmd.Parameters.AddWithValue("@Email", user.EmailAddress);

                    cmd.Parameters.AddWithValue("@Name", user.FirstName);
                    cmd.Parameters.AddWithValue("@Surname", user.LastName);
                    cmd.Parameters.AddWithValue("@DOB", user.Age.ToString("yyyy-MM-dd"));
                    cmd.Parameters.AddWithValue("@Weight", user.Weight);
                    cmd.Parameters.AddWithValue("@Height", user.Height);

                    cmd.Parameters.AddWithValue("@IDActivityLevel", user.ActivityLvl);
                    cmd.Parameters.AddWithValue("@IDDiabetesType", user.DiabType);
                    cmd.Parameters.AddWithValue("@IDGender", user.Gender);

                    cmd.Connection = con;
                    con.Open();
                    try
                    {
                        status = Convert.ToInt32(cmd.ExecuteScalar());
                    }
                    catch (Exception e)
                    {
                        System.Diagnostics.Debug.WriteLine("db exception while inserting user " + e.ToString());
                        status = -3;
                    }

                    con.Close();
                }
            }

            System.Diagnostics.Debug.WriteLine("got status: " + status);

            

            switch (status)
            {
                case -3:
                    //error
                    TempData["message"] = "Something went wrong.";
                    return RedirectToAction("Error", "Register");
                case -2:
                    TempData["message"] = "Email exists.";
                    return RedirectToAction("Error", "Register");
                case -1:
                    TempData["message"] = "Username exists.";
                    return RedirectToAction("Error", "Register");

                default: //got user id
                    return RedirectToAction("Index", "Login");
            }
        }

        // GET: Register
        [HttpGet]
        public ActionResult Error()
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Browse");
            } else
            {
                return View();
            }
        }

    }
}