using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PublicSite.Models
{
    public class Register
    {

        [Required(ErrorMessage = "Required.")]
        [Display(Name = "Username")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Required.")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required(ErrorMessage = "Required.")]
        [DataType(DataType.EmailAddress)]
        public string EmailAddress { get; set; }

        //----------------------------------
        [Required(ErrorMessage = "Required.")]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "Required.")]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "Required.")]
        [Display(Name = "Age")]
        public DateTime Age { get; set; }

        [Required(ErrorMessage = "Required.")]
        [Display(Name = "Weight")]
        public int Weight { get; set; }

        [Required(ErrorMessage = "Required.")]
        [Display(Name = "Height")]
        public int Height { get; set; }

        [Required(ErrorMessage = "Required.")]
        [Display(Name = "ActivityLvl")]
        public int ActivityLvl { get; set; }

        [Required(ErrorMessage = "Required.")]
        [Display(Name = "DiabType")]
        public int DiabType { get; set; }

        [Required(ErrorMessage = "Required.")]
        [Display(Name = "Gender")]
        public int Gender { get; set; }
    }

    public class RegisterViewModel : Register
    {
        public List<SelectListItem> ActivityLvlM { get; set; }
        public List<SelectListItem> DiabTypeM { get; set; }
        public List<SelectListItem> GenderM { get; set; }
    }
}