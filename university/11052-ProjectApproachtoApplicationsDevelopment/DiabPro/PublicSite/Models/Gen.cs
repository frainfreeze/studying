using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PublicSite.Models
{
    public class GenModel
    {
        [Required(ErrorMessage = "Obavezno.")]
        [Display(Name = "Broj jela")]
        public string NumMeals { get; set; }

        public int test = 1;

        public DataTable dt = new DataTable("TestTable");
}
}