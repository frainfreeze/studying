using WebApp.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApp.Controllers
{
    public class VozaciController : Controller
    {
        // GET: Vozaci
        public ActionResult Index()
        {
            return View((object)DatabaseHandler.getAllVozaci());
        }

        public ActionResult Vozac(int? id)
        {
            if (Validator.ValidateID(id))
            {
                return View((object)DatabaseHandler.getVozac((int)id));
            }
            else
            {
                return View((object)null);
            }
        }

        [HttpGet]
        public ActionResult DodajVozaca()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DodajVozaca(vozac v)
        {
            if (ModelState.IsValid)
            {
                DatabaseHandler.insertVozac(v.ime, v.prezime, v.broj_mobitela, v.broj_vozacke);
                return RedirectToAction("Index");
            }
            return View();

        }
    }
}