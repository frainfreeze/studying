using System;
using System.Text;
using System.Net;
using System.IO;
using System.Xml;

namespace ConsoleApp1
{
    class Program
    {
        static void ispisArtikala()
        {
            Console.WriteLine("Popis svih artikala:");
            Console.WriteLine("-----------------------------------------");
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create("http://localhost:50000/api/artikli");
            req.Accept = "application/xml";
            HttpWebResponse res = (HttpWebResponse)req.GetResponse();
            Stream data = res.GetResponseStream();
            XmlDocument doc = new XmlDocument();
            doc.Load(data);
            doc.Save(Console.Out);
        }

        static void ispisPoOpisu(string opis)
        {
            Console.WriteLine("\n\nIspis artikala za zadani opis:");
            Console.WriteLine("-----------------------------------------");
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create("http://localhost:50000/api/artikli/" + opis);
            req.Accept = "application/xml";
            HttpWebResponse res = (HttpWebResponse)req.GetResponse();
            Stream data = res.GetResponseStream();
            XmlDocument doc = new XmlDocument();
            doc.Load(data);
            doc.Save(Console.Out);
        }

        static void unosNovogArtikla()
        {
            //Artikl(string Naziv, string Opis, int Cijena, string Dimenzije, string Boja, int Prodanih)
            Console.WriteLine("Naziv: ");
            string naziv = Console.ReadLine();
            Console.WriteLine("Opis: ");
            string opis = Console.ReadLine();
            Console.WriteLine("Cijena: ");
            int cijena = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Dimenzije (n cm x n cm): ");
            string dimenzije = Console.ReadLine();
            Console.WriteLine("Boja: ");
            string boja = Console.ReadLine();
            Console.WriteLine("Prodanih: ");
            int prodanih = Convert.ToInt32(Console.ReadLine());

            string content = $"?naziv={naziv}&opis={opis}&cijena={cijena}&dimenzije={dimenzije}&boja={boja}&prodanih={prodanih}";

            var request = (HttpWebRequest)WebRequest.Create("http://localhost:50000/api/artikli/novi");
            var data = Encoding.ASCII.GetBytes(content);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;
            using (var stream = request.GetRequestStream())
            {
                stream.Write(data, 0, data.Length);
            }
            var response = (HttpWebResponse)request.GetResponse();
            var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
            Console.WriteLine(responseString);
        }

        static void ispisPoCijeni(string cijena)
        {
            Console.WriteLine("\n\nIspis artikala za zadanu cijenu:");
            Console.WriteLine("-----------------------------------------");
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create("http://localhost:50000/api/artikli/cijena/" + cijena);
            req.Accept = "application/xml";
            HttpWebResponse res = (HttpWebResponse)req.GetResponse();
            Stream data = res.GetResponseStream();
            XmlDocument doc = new XmlDocument();
            doc.Load(data);
            doc.Save(Console.Out);
        }

        static void Main(string[] args)
        {
            string option;
            while (true)
            {
                Console.WriteLine("\n1) Ispis svih artikala\n2) Ispis artikala po unesenom opisu\n3) Unos novog artikla\n4) Ispis artikala po unesenoj cijeni\n5) Prekid rada programa\n");
                option = Console.ReadLine();
                switch (option)
                {
                    case "1":
                        ispisArtikala();
                        continue;
                    case "2":
                        Console.WriteLine("Unesite opis: ");
                        ispisPoOpisu(Console.ReadLine());
                        continue;
                    case "3":
                        unosNovogArtikla();
                        continue;
                    case "4":
                        Console.WriteLine("Unesite cijenu: ");
                        ispisPoCijeni(Console.ReadLine());
                        continue;
                    default:
                        Environment.Exit(1);
                        break;
                }
            }
        }
    }
}
