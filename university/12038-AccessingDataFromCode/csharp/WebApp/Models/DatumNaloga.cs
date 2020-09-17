using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApp.Models
{
    public class DatumNaloga
    {
        public DateTime datum { get; set; }
        public DateTime datum_pocetka { get; set; }
        public DateTime datum_zavrsetka { get; set; }
    }
}