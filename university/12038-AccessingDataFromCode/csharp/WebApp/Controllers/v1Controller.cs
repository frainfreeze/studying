using WebApp.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;


namespace WebApp.Controllers
{
    public class v1Controller : System.Web.Http.ApiController
    {
        [HttpGet]
        public HttpResponseMessage vozac(int? id, string ime, string prezime, string broj_mobitela, string broj_vozacke)
        {
            DatabaseHandler.updateVozac((int)id, ime, prezime, broj_mobitela, broj_vozacke);
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            string fullyQualifiedUrl = Request.RequestUri.GetLeftPart(UriPartial.Authority) + $"/Vozaci/Vozac/{id}";
            response.Headers.Location = new Uri(fullyQualifiedUrl);
            return response;

        }

        [HttpPost]
        public HttpResponseMessage vozac(int? id)
        {
            DatabaseHandler.deleteVozac((int)id);
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            string fullyQualifiedUrl = Request.RequestUri.GetLeftPart(UriPartial.Authority) + "/Vozaci";
            response.Headers.Location = new Uri(fullyQualifiedUrl);
            return response;
        }

        [HttpGet]
        public HttpResponseMessage vozilo(int? id, string marka, int tipovi_vozila, decimal pocetni_km, decimal trenutni_km, int godina_proizvodnje)
        {
            DatabaseHandler.updateVozilo((int)id, marka, tipovi_vozila, pocetni_km, trenutni_km, godina_proizvodnje);
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            string fullyQualifiedUrl = Request.RequestUri.GetLeftPart(UriPartial.Authority) + $"/Vozila/Vozilo/{id}";
            response.Headers.Location = new Uri(fullyQualifiedUrl);
            return response;
        }

        [HttpPost]
        public HttpResponseMessage vozilo(int? id)
        {
            DatabaseHandler.deleteVozilo((int)id);
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            string fullyQualifiedUrl = Request.RequestUri.GetLeftPart(UriPartial.Authority) + "/Vozila";
            response.Headers.Location = new Uri(fullyQualifiedUrl);
            return response;
        }

        [HttpGet]
        public HttpResponseMessage servis(string mjesto, DateTime datum, decimal cijena, string info, int vozilo_id)
        {
            DatabaseHandler.insertServis(mjesto, datum, cijena, info, vozilo_id);
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            string fullyQualifiedUrl = Request.RequestUri.GetLeftPart(UriPartial.Authority) + "/Vozila/";
            response.Headers.Location = new Uri(fullyQualifiedUrl);
            return response;
        }

        [HttpGet]
        public HttpResponseMessage servis(int id, string mjesto, DateTime datum, decimal cijena, string info, int vozilo_id)
        {
            DatabaseHandler.updateServis(id, mjesto, datum, cijena, info);
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            string fullyQualifiedUrl = Request.RequestUri.GetLeftPart(UriPartial.Authority) + $"/Vozila/Vozilo/{vozilo_id}";
            response.Headers.Location = new Uri(fullyQualifiedUrl);
            return response;
        }

        [HttpPost]
        public HttpResponseMessage servis(int? id, int vozilo_id)
        {
            DatabaseHandler.deleteServis(id);
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            string fullyQualifiedUrl = Request.RequestUri.GetLeftPart(UriPartial.Authority) + $"/Vozila/Vozilo/{vozilo_id}";
            response.Headers.Location = new Uri(fullyQualifiedUrl);
            return response;
        }

        [HttpPost]
        public HttpResponseMessage putniNalog(int? id)
        {
            DatabaseHandler.deletePutniNalog((int)id);
            var response = Request.CreateResponse(HttpStatusCode.Moved);
            string fullyQualifiedUrl = Request.RequestUri.GetLeftPart(UriPartial.Authority) + "/PutniNalozi";
            response.Headers.Location = new Uri(fullyQualifiedUrl);
            return response;
        }

        [HttpPost]
        public HttpResponseMessage obrisiRutu(int? id)
        {
            DatabaseHandler.deleteRuta((int)id);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        public HttpResponseMessage obrisiRute(int? id)
        {
            DatabaseHandler.deleteRute((int)id);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}
