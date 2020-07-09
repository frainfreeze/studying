using WebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApp.Utils;

namespace WebApp.Controllers
{
    public class VozilaController : Controller
    {
        // GET: Vozila
        public ActionResult Index()
        {
            List<Vozilo> vvl = new List<Vozilo>();
            foreach(vozilo v in DatabaseHandler.getAllVozila())
            {
                vvl.Add(new Vozilo
                {
                    tip_vozila = DatabaseHandler.getTipVozila((int)v.tip_vozila_id),
                    vozilo = v
                });
            }

            return View(vvl);
        }

        public ActionResult Vozilo(int? id)
        {
            if (Validator.ValidateID(id))
            {
                Vozilo vsm = new Vozilo
                {
                    servisi = DatabaseHandler.getServisi(Convert.ToInt16(id)),
                    vozilo = DatabaseHandler.getVozilo(Convert.ToInt16(id)),
                    tip_vozila = DatabaseHandler.getTipVozila(Convert.ToInt16(id))
                };
                ViewBag.tipovi_vozila = Other.getTipoviVozilaList();
                return View((object)vsm);
            }
            else
            {
                return View((object)null);
            }
        }

        [HttpGet]
        public ActionResult DodajVozilo()
        {
            ViewBag.tipovi_vozila = Other.getTipoviVozilaList();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DodajVozilo(vozilo v, string tipovi_vozila)
        {
            if (ModelState.IsValid)
            {
                DatabaseHandler.insertVozilo(v.marka, Convert.ToInt16(tipovi_vozila), v.pocetni_km, v.pocetni_km, v.godina_proizvodnje);
                return RedirectToAction("Index");
            }

            ViewBag.tipovi_vozila = Other.getTipoviVozilaList();
            return View();

        }

    }
}