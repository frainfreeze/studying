using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace WebApp.Utils
{
    public static class Validator
    {
        public static bool ValidateID(int? ID)
        {
            return (ID == null || !Regex.IsMatch(ID.ToString(), @"^[1-9]([0-9]?)+$")) ? false : true;
        }

        public static bool ValidateVozackaID(string broj_vozacke)
        {
            return (!Regex.IsMatch(broj_vozacke, @"^\d{7,16}$")) ? false : true;
        }

        public static bool ValidatePhoneNum(string broj_mobitela)
        {
            return (!Regex.IsMatch(broj_mobitela, @"(^(\+?385)\d{9}$)|(^(09)\d{8}$)")) ? false : true;
        }

        public static bool ValidateYear(int? godina_proizvodnje)
        {
            return (godina_proizvodnje != null && godina_proizvodnje > 1886 && (godina_proizvodnje <= DateTime.Now.Year)) ? true : false;
        }

        public static bool ValidateDistance(decimal? km)
        {
            return km != null && km > 0 && (km <= 3000000) ? true : false;
        }
    }
}