using WebApp.Utils;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApp.CustomValidators
{
    public class BrojVozackeValidator : ValidationAttribute
    {
        public override bool IsValid(object value)
            => (value != null && Utils.Validator.ValidateVozackaID(value.ToString())) ? true : false;
    }
}