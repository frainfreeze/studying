```c#
using System;
using System.Collections.Generic;
using System.Linq;

namespace zad1 {
    static class Extensions{
        public static string IntToEcts(this int value, string format) => $"{value} {format}";
    }

    interface ISinged{
        void Sign();
    }

    class Document : ISinged{
        public string Title { get; set; }
        public string MyProperty { get; set; }
        public bool IsSigned { get; protected set; }
        public void Sign() => IsSigned = true;
    }

    class Kolegij : ISinged{
        public Kolegij(int ects, string naziv, int sifra){
            Ects = ects; Naziv = naziv; Sifra = sifra;
        }
        private int ects;
        public int Ects{
            get => ects;
            set{
                if (!(value >= 20 || value <= 30)){
                    throw new Exception("Must be 20 || 30!");
                }
                if (!value.ToString().All(char.IsDigit)){
                    throw new Exception("ISBN must contain only digits!");
                }
                ects = value;
            }
        }
        public string Naziv { get; set; }
        public bool IsSigned { get; protected set; }
        public int Sifra { get; set; }
        public override string ToString() => $"Naziv: {Naziv}, Sifra: {Sifra}, ECTS: {Ects.IntToEcts(" ECTS")}, Potvrđen: {(IsSigned ? "yes" : "no")}";
        public void Sign() => IsSigned = true;
    }

    internal class SurnameAscComparer : IComparer<Student>{
        public int Compare(Student x, Student y) => x.Prezime.CompareTo(y.Prezime);
    }

    abstract class Uciliste{
        public Uciliste(string ime, string prezime){
            Ime = ime; Prezime = prezime;
        }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public override string ToString() => $"{Ime} {Prezime}";
    }

    class Dekan : Uciliste{
        public Dekan(string ime, string prezime, string titula) : base(ime, prezime){
            Titula = titula;
        }
        public string Titula { get; set; }
        public override string ToString() => $"Ime: {Ime}, Prezime: {Prezime}, Titula: {Titula}";
        public void GiveSign(ISinged signable) => signable.Sign();
    }

    class Profesor : Uciliste{
        public Profesor(string ime, string prezime, Kolegij kolegij) : base(ime, prezime){
            Kolegij = kolegij;
        }
        public Kolegij Kolegij { get; set; }
        public override string ToString() => $"Ime: {Ime}, Prezime: {Prezime}, Kolegij: {Kolegij}";
    }

    class Asistent : Uciliste{
        public Asistent(string ime, string prezime, Kolegij kolegij) : base(ime, prezime){
            Kolegij = kolegij;
        }
        public Kolegij Kolegij { get; set; }
        public override string ToString() => $"Ime: {Ime}, Prezime: {Prezime}, Kolegij: {Kolegij}";
    }

    class Student : Uciliste, IComparable<Student>{
        public enum Status{
            Vanredni, Redovni
        }
        public Student(string ime, string prezime, Status tip) : base(ime, prezime){
            Id = IdGenerator += 5; Tip = tip;
        }

        public Status Tip { get; set; }
        private int Id;
        private static int IdGenerator = 5;
        public override string ToString() => $"Ime: {Ime}\nPrezime: {Prezime}\nID: {Id}\nTip: {Tip}";

        public override bool Equals(object obj) => obj is Student other ? Id == other.Id : false;
        //{ if (obj is Student other) { return Id == other.Id; } return false; }
        public override int GetHashCode() => Id.GetHashCode();
        public int CompareTo(Student other) => -Id.CompareTo(other.Id); /// -je za padajuce (na pocetku id-a)
    }

    class Program {
        static void Main(string[] args) {
            Console.WriteLine("----- students -----");
            List<Student> students = new List<Student> {
                new Student("Milica", "Krmpotic", Student.Status.Redovni),
                new Student("Milivoj", "Krmpotic", Student.Status.Redovni),
                new Student("Jesus", "Christ", Student.Status.Vanredni)
            };
            foreach (var s in students){
                Console.WriteLine(s);
            }
            //students.ForEach(Console.WriteLine);
            Console.WriteLine("----- students desc -----");
            students.Sort();
            foreach (var s in students) {
                Console.WriteLine(s);
            }
            Console.WriteLine("----- students surname asc -----");
            students.Sort(new SurnameAscComparer());
            foreach (var s in students) {
                Console.WriteLine(s);
            }
            // ---------------------
            Console.WriteLine("----- kolegij -----");
            Kolegij k = new Kolegij(21, "OOP", 123);
            Console.WriteLine(k);
            Console.WriteLine("----- professor/assistant -----");
            Profesor p = new Profesor("Ivan", "Ivic", k);
            Asistent a = new Asistent("Ivan", "Ivic", k);
            Console.WriteLine(p);
            Console.WriteLine(a);

            Console.WriteLine("----- dean -----");
            Dekan d = new Dekan("Martin", "Dean", "Da dean!");
            Console.WriteLine(d);

            Console.WriteLine("----- list 2 -----");
            List<Uciliste> uciliste = new List<Uciliste> {
                a, p, d,
                students[0], students[1], students[2]
            };
            foreach (var s in uciliste) {
                Console.WriteLine(s);
            }
            Console.WriteLine("----- signing -----");
            List<ISinged> list = new List<ISinged> {
               k, new Document { Title = "xd" }
            };
            list.ForEach(d.GiveSign);
        }
    }
}
```