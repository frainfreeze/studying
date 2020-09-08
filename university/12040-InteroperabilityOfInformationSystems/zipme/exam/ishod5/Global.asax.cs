using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using WebApplication1.Models;

namespace WebApplication1
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        public static List<Artikl> artikli;

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            artikli = new List<Artikl>();
            //Artikl(string Naziv, string Opis, string Cijena, string Dimenzije, string Boja, int Prodanih)
            Artikl a = new Artikl("Cipele", "Kvalitetne kozne cipele", 120, "12cm x 21cm", "plava", 12);
            Artikl b = new Artikl("Papuce", "Kvalitetne kozne papuce", 20, "12cm x 21cm", "bijela", 121);
            artikli.Add(a);
            artikli.Add(b);
        }
    }
}
