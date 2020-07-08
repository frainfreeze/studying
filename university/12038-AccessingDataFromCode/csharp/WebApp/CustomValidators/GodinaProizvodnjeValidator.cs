using WebApp.HELPERS;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApp.CustomValidators
{
    public class GodinaProizvodnjeValidator : ValidationAttribute
    {
        public override bool IsValid(object value)
            => (value != null && Validators.validGodina((int)value)) ? true : false;
    }
}