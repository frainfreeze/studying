using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PublicSite.Models
{
    public class BrowseModel
    {
        [Required(ErrorMessage = "Required.")]
        [Display(Name = "Dates")]
        public string Dates { get; set; }
    }

    public class BrowseViewModel : BrowseModel
    {
        public List<SelectListItem> DatesM { get; set; }
    }
}