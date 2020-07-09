using WebApp.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.Models
{
    public class Vozilo
    {
        public vozilo vozilo { get; set; }
        public tip_vozila tip_vozila { get; set; }
        public List<servi> servisi { get; set; }
    }
}