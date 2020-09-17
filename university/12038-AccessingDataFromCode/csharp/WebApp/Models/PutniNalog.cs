using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;



namespace WebApp.Models
{
    public class PutniNalog
    {
        public putni_nalog putni_nalog { get; set; }
        public vozac vozac { get; set; }
        public vozilo vozilo { get; set; }
        public string status { get; set; }
        public string tip { get; set; }
        public List<servi> servisi { get; set; }
    }
}