using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TomislavKucarS2.model;

/* zadatak 3 (i4, i5, i6)
 * Kreirajte sustav za upravljanje knjigama u jedinstvenoj aplikaciji koja simulira
 * posudbe u knjiznici. implementirajte slijedece zahtjeve
 *  [] svaka knjiga je definirana: jedinstveni ISBN, Naslov, Autor, Kategorija, Datum posudbe, Datum vracanja, Identifikator posuditelja
 *  [] moguce su kategorije roman, zbirka prica, drama
 *  [] vrijednost datuma posudbe mora biti prije datuma vracanja
 *  [] u kolekciji knjiga ne smiju postojati 2 knjige sitog isbna 
 * 
 * Funkcijska specifikacija (drugi dio)
*  1. kreiranje nove posudbe
*       Prilikom kreiranja posudbe osigurajte mehanizam koji provjerava dali je knjiga sa isbn brojem koji se unosi vec 
*       postojeca u kolekciji. ako postoji, aplikacija mora baciti, ali i uloviti gresku DuplicateRecordException koji
*       ima predefiniranu poruku "Knjiga sa ISBN brojem je vec posudena". Nadalje bitno je osigurati pravilan unos svih
*       podataka - naziv i autor moraju biti specificirani, kategorija mora biti postojeca, datum posudbe mora biti 
*       ispravnog formata (dd/mm/yyyy), identifikator posuditelja mora biti broj. aplikacija mora inyistirati na pravilnom 
*       unosu prije povratka u meni
*  2. unos datuma vracanja za pojedini isbn broj
*       prilikom unosa datuma vracanja bitno je unijeti isbn broj knjige za koju se pritom ispisuju detalji. potom se unosi
*       datum vracanja koji mira biti ispravnog formata (dd/mm/yyyy) i vremenski nakon datuma posudbe.
*       aplikacija mora inzistirati na pravilnom unosu prije povratka u meni.
*  3. ispis svih posudbi
*       aplikacija mora ispisati sve posudbe sortiranje prema isbn broju, rastuce
*  4. ispis posudbi po kategoriji
*       aplikacija trazi unos ispravne kategorije i mora ispisati sve posudbe za unesenu kategoriju
*  5. provjera posudbi
*       aplikacija koristi event managment sustav za provjeru dali je knjiga vracena, na temelju datuma vracanja. ako ne
*       postoji datum vracanja, publisher obavjestava subscribera o detaljima doticne knjige. subscriber ispisuje detalje 
*       nevracenih knjiga u konzoli crvenim slovima
*  6. izlaz
*       prilikom izlaska iz aplikacije sve knjige iz memorije moraju se zapisati u datoteku posudbe.txt, tako da ponovni
*       start aplikacije u memoriju ucita predhodno stanje
*       
* Aplikacija mora imati jasno definirane odgovornosti hvatanja mogucih pogresaka, stoga aplikacija nit u jednom momentu nesmije baciti gresku.  
 */

namespace TomislavKucarS2
{

    /*  Funkcijska specifikacija (prvi dio):
     *  Prilikom starta aplikacija provjerava dali postoji datoteka (posudbe.txt). ako datoteka postoji, aplikacija ucitava
     *  podatke u memoriju i drzi ju u sortiranoj kolekciji po isbn broju rastuce. kolekcija mora biti implementiran koristenjem 
     *  repository obrasca. */

    /*  U glavnom Programu kreirajte meni sa slijedecim opcijama:
     *  1. kreiranje nove posudbe
     *  2. unos datuma vracanja za pojedini isbn broj
     *  3. ispis svih posudbi
     *  4. ispis posudbi po kategoriji
     *  5. provjera posudbi
     *  6. izlaz */

    class Program
    {
        private const string DELIMITER = ",";
        static void Main(string[] args)
        {
            BookManager bookManager;
            try
            {
                bookManager = new BookManager();
            }
            catch (Exception e)
            {
                ShowMessage(e.Message, ConsoleColor.Red);
                return;
            }
            bookManager.OnException += BookManager_OnException;
            bookManager.OnReturn += BookManager_OnReturn;

            SaveBooks(bookManager);
            bookManager.GetBooksDictionary();
        }
        private static void SaveBooks(BookManager bookManager)
        {
            IList<Book> books = new List<Book>
            {
                new Book { ISBN = "123456789", Naslov = "Demian", Autor = "Herman Hesse", Kategorija = "roman(enum?)", DatumPosudbe = "12/02/2019", DatumVracanja = "", IndikatorPosuditelja = "KK001" },
                new Book { ISBN = "123456789", Naslov = "Zabusavanje i izbjegavanje obveza", Autor = "Tomislav Kucar", Kategorija = "drama", DatumPosudbe = "12/02/2018", DatumVracanja = "12/02/2019", IndikatorPosuditelja = "TK007" }
            };
            bookManager.SaveBooks(books);
        }
        private static void BookManager_OnException(object sender, OnExceptionEventArgs args) => ShowMessage(args.Exception.Message, ConsoleColor.Red);

        private static void BookManager_OnReturn(object sender, OnReturnEventArgs args)
        {
            if (args.MissingData.Count() == 0)
            {
                ShowMessage(args.LoadedBook.ToString(), ConsoleColor.Green);
            }
            else
            {
                string report = string.Join(DELIMITER, args.MissingData);
                ShowMessage(report, ConsoleColor.Magenta);
            }
        }
        private static void ShowMessage(string message, ConsoleColor color)
        {
            Console.ForegroundColor = color;
            Console.WriteLine(message);
            Console.ResetColor();
        }
    }
}