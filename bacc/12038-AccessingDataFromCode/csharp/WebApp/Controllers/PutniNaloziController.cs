using WebApp.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApp.Controllers
{
    public class PutniNaloziController : Controller
    {
        // GET: PutniNalozi
        public ActionResult Index()
        {
            return View((object)DatabaseHandler.getAllPutniNalozi());
        }

        public ActionResult PutniNalog(int? id)
        {
            return View((object)DatabaseHandler.getPutniNalog((int)id));
        }

        [HttpGet]
        public ActionResult DodajNalog()
        {
            ViewBag.vozila = ViewBagHelper.getVozilaList();
            ViewBag.vozaci = ViewBagHelper.getVozaciList();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DodajNalog(DateTime datum_pocetka, DateTime datum_zavrsetka, string vozaci, string vozila)
        {
            DatabaseHandler.insertPutniNalog(datum_pocetka, datum_zavrsetka, Convert.ToInt16(vozaci), Convert.ToInt16(vozila));
            return RedirectToAction("Index");
        }
    }
}