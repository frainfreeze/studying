using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class ArtiklController : ApiController
    {
        [Route("api/artikli")]
        public List<Artikl> Get()
        {
            return WebApiApplication.artikli;
        }

        [Route("api/artikli/{opis}")]
        public List<Artikl> Get(string opis)
        {
            List<Artikl> temp = WebApiApplication.artikli.Where(artikl => artikl.Opis.Contains(opis)).ToList();
            return temp;
        }

        [Route("api/artikli/novi")]
        public bool Post(Artikl noviArtikl)
        {
            try
            {
                WebApiApplication.artikli.Add(noviArtikl);
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                return false;
            }
        }

        [Route("api/artikli/cijena/{zadana_cijena}")]
        public List<Artikl> Get(int zadana_cijena)
        {
            List<Artikl> temp = WebApiApplication.artikli.Where(artikl => artikl.Cijena < zadana_cijena).ToList();
            return temp;
        }

    }
}
