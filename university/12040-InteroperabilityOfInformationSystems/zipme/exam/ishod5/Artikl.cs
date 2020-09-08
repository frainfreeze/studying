using System;
using System.Runtime.Serialization;

namespace WebApplication1.Models
{
    [DataContract]
    public class Artikl
    {
        [DataMember(Order = 0)]
        public string Naziv { get; set; }

        [DataMember(Order = 1)]
        public string Opis { get; set; }

        [DataMember(Order = 2)]
        public int Cijena { get; set; }

        [DataMember(Order = 3)]
        public string Dimenzije { get; set; }

        [DataMember(Order = 4)]
        public string Boja { get; set; }

        [DataMember(Order = 5)]
        public int Prodanih { get; set; }

        [DataMember(Order = 6)]
        public string Proizvodac { get; set; }

        [DataMember(Order = 7)]
        public DateTime DatumProizvodnje { get; set; }

        public Artikl(string Naziv, string Opis, int Cijena, string Dimenzije, string Boja, int Prodanih)
        {
            this.Naziv = Naziv;
            this.Opis = Opis;
            this.Cijena = Cijena;
            this.Dimenzije = Dimenzije;
            this.Boja = Boja;
            this.Prodanih = Prodanih;
            this.Proizvodac = "Tomislav Kucar";
            this.DatumProizvodnje = DateTime.Now;
        }
    }
}
