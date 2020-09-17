using ExamPreparation.Events;
using ExamPreparation.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamPreparation
{
    class Program
    {
        private const string DELIMITER = ",";
        static void Main(string[] args)
        {
            PersonManager personManager;
            try
            {
                personManager = new PersonManager();
            }
            catch (Exception e)
            {
                ShowMessage(e.Message, ConsoleColor.Red);
                return;
            }
            personManager.OnException += PersonManager_OnException;
            personManager.OnLoaded += PersonManager_OnLoaded;

            //first save persons and than break the file as in sample persons.txt
            SavePersons(personManager);

            personManager.GetPersonsDictionary();
        }
        private static void SavePersons(PersonManager personManager)
        {
            IList<Person> persons = new List<Person>
            {
                new Person { Oib = "01234567891", Name = "Daniel", Surname = "Bele", Email = "dnlbele@gmail.com", Phone = "01121221"},
                new Person { Oib = "0891123456", Name = "Milica", Surname = "Krmpotic", Email = "mk@gmail.com", Phone = "12122101"},
                new Person { Oib = "56789101234", Name = "Gojko", Surname = "Mrnjavcevic", Email = "gm@gmail.com", Phone = "12120121"},
                new Person { Oib = "10125678934", Name = "", Surname = "Mrnjavcevic", Email = "gm@gmail.com", Phone = "12120121"},
                new Person { Oib = "23456789101", Name = "", Surname = "", Email = "", Phone = "12120121"},
                new Person { Oib = "01234567891", Name = "", Surname = "", Email = "", Phone = ""}, //same oib puca na Dictionary
            };
            personManager.SavePersons(persons);
        }
        private static void PersonManager_OnException(object sender, OnExceptionEventArgs args) => ShowMessage(args.Exception.Message, ConsoleColor.Red);
        
        private static void PersonManager_OnLoaded(object sender, OnLoadedEventArgs args)
        {
            if (args.MissingData.Count() == 0)
            {
                ShowMessage(args.LoadedPerson.ToString(), ConsoleColor.Green);
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

//model/person.cs
using ExamPreparation.Dal;
using ExamPreparation.Events;
using System;
using System.Collections.Generic;

namespace ExamPreparation.Model
{
    public class PersonManager
    {
        public event OnExceptionEventHandler OnException;
        public event OnLoadedEventHandler OnLoaded;

        private IDictionary<string, Person> personsDictionary;
        private IRepo repo;

        public PersonManager()
        {
            repo = RepoFactory.GetRepo();
        }
        public IDictionary<string, Person> GetPersonsDictionary()
        {
            if (personsDictionary == null)
            {
                Load();
            }
            return new Dictionary<string, Person>(personsDictionary);
        }
        private void Load()
        {
            try
            {
                IList<Person> persons = repo.LoadPersons();
                FillDictionary(persons);
            }
            catch (Exception e)
            {
                OnException?.Invoke(this, new OnExceptionEventArgs
                {
                    Exception = e
                });
            }
        }

        private void FillDictionary(IList<Person> persons)
        {
            personsDictionary = new Dictionary<string, Person>();
            foreach (var person in persons)
            {
                try
                {
                    if (person.HasValidOib())
                    {
                        IList<string> missingData = new List<string>();
                        if (string.IsNullOrEmpty(person.Name))
                        {
                            missingData.Add(nameof(person.Name));
                        }
                        if (string.IsNullOrEmpty(person.Surname))
                        {
                            missingData.Add(nameof(person.Surname));
                        }
                        if (string.IsNullOrEmpty(person.Phone))
                        {
                            missingData.Add(nameof(person.Phone));
                        }
                        if (string.IsNullOrEmpty(person.Email))
                        {
                            missingData.Add(nameof(person.Email));
                        }
                        personsDictionary.Add(person.Oib, person);
                        OnLoaded?.Invoke(this, new OnLoadedEventArgs
                        {
                            LoadedPerson = person,
                            MissingData = missingData
                        });
                    }
                    else
                    {
                        throw new Exceptions.InvalidOibException($"{person.Oib} is not valid Oib");
                        //throw new InvalidOibException();
                    }
                }
                catch (Exception e)
                {
                    OnException?.Invoke(this, new OnExceptionEventArgs
                    {
                        Exception = e
                    });
                }
            }
        }
        public void SavePersons(IList<Person> persons)
        {
            try
            {
                repo.SavePersons(persons);
            }
            catch (Exception e)
            {
                OnException?.Invoke(this, new OnExceptionEventArgs
                {
                    Exception = e
                });
            }
        }
    }
}


// model/personamanger.cs
using ExamPreparation.Dal;
using ExamPreparation.Events;
using System;
using System.Collections.Generic;

namespace ExamPreparation.Model
{
    public class PersonManager
    {
        public event OnExceptionEventHandler OnException;
        public event OnLoadedEventHandler OnLoaded;

        private IDictionary<string, Person> personsDictionary;
        private IRepo repo;

        public PersonManager()
        {
            repo = RepoFactory.GetRepo();
        }
        public IDictionary<string, Person> GetPersonsDictionary()
        {
            if (personsDictionary == null)
            {
                Load();
            }
            return new Dictionary<string, Person>(personsDictionary);
        }
        private void Load()
        {
            try
            {
                IList<Person> persons = repo.LoadPersons();
                FillDictionary(persons);
            }
            catch (Exception e)
            {
                OnException?.Invoke(this, new OnExceptionEventArgs
                {
                    Exception = e
                });
            }
        }

        private void FillDictionary(IList<Person> persons)
        {
            personsDictionary = new Dictionary<string, Person>();
            foreach (var person in persons)
            {
                try
                {
                    if (person.HasValidOib())
                    {
                        IList<string> missingData = new List<string>();
                        if (string.IsNullOrEmpty(person.Name))
                        {
                            missingData.Add(nameof(person.Name));
                        }
                        if (string.IsNullOrEmpty(person.Surname))
                        {
                            missingData.Add(nameof(person.Surname));
                        }
                        if (string.IsNullOrEmpty(person.Phone))
                        {
                            missingData.Add(nameof(person.Phone));
                        }
                        if (string.IsNullOrEmpty(person.Email))
                        {
                            missingData.Add(nameof(person.Email));
                        }
                        personsDictionary.Add(person.Oib, person);
                        OnLoaded?.Invoke(this, new OnLoadedEventArgs
                        {
                            LoadedPerson = person,
                            MissingData = missingData
                        });
                    }
                    else
                    {
                        throw new Exceptions.InvalidOibException($"{person.Oib} is not valid Oib");
                        //throw new InvalidOibException();
                    }
                }
                catch (Exception e)
                {
                    OnException?.Invoke(this, new OnExceptionEventArgs
                    {
                        Exception = e
                    });
                }
            }
        }
        public void SavePersons(IList<Person> persons)
        {
            try
            {
                repo.SavePersons(persons);
            }
            catch (Exception e)
            {
                OnException?.Invoke(this, new OnExceptionEventArgs
                {
                    Exception = e
                });
            }
        }
    }
}

// exceptions/invalidoibexception.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamPreparation.Exceptions
{
    [Serializable]
    internal class InvalidOibException : Exception
    {
        public InvalidOibException() : this("Oib must be 11 digits") { }
        public InvalidOibException(string message) : base(message) { }
    }
}


// events/onexceptionevent.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamPreparation.Events
{
    public delegate void OnExceptionEventHandler(object sender, OnExceptionEventArgs args);

    public class OnExceptionEventArgs : EventArgs
    {
        public Exception Exception { get; set; }
    }
}


//events/onloadedevent.cs
using ExamPreparation.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamPreparation.Events
{
    public delegate void OnLoadedEventHandler(object sender, OnLoadedEventArgs args);

    public class OnLoadedEventArgs : EventArgs
    {
        public Person LoadedPerson { get; set; }
        public IList<string> MissingData { get; set; }
    }
}


// dal/filerepo.cs
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExamPreparation.Model;

namespace ExamPreparation.Dal
{
    class FileRepo : IRepo
    {
        private const string DIR = @"C:\Users\dnlbe\Desktop\data";
        private const string PATH = DIR + @"\persons.txt";
        public FileRepo() => CreateFileIfNotExists();
        private void CreateFileIfNotExists()
        {
            Directory.CreateDirectory(DIR);
            if (!File.Exists(PATH))
            {
                File.Create(PATH).Close();
            }
        }
        public void SavePersons(IList<Person> persons)
        {
            //string[] lines = new string[persons.Count];
            //int index = 0;
            //foreach (var p in persons)
            //{
            //    lines[index++] = p.FormatForFile();
            //}
            //File.WriteAllLines(PATH, lines);
            File.WriteAllLines(PATH, persons.Select(p => p.FormatForFileLine()));
        }
        public IList<Person> LoadPersons()
        {
            IList<Person> persons = new List<Person>();
            string[] lines = File.ReadAllLines(PATH);
            //foreach (var line in lines)
            //{
            //    persons.Add(Person.ParseFromFile(line));
            //}
            lines.ToList().ForEach(line => persons.Add(Person.ParseFromFileLine(line)));
            return persons;
        }

    }
}


//del/irepo.cs
using ExamPreparation.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamPreparation.Dal
{
    public interface IRepo
    {
        void SavePersons(IList<Person> persons);
        IList<Person> LoadPersons();
    }
}

//dal/repofactory.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamPreparation.Dal
{
    public static class RepoFactory
    {
        public static IRepo GetRepo() => new FileRepo();
    }
}
