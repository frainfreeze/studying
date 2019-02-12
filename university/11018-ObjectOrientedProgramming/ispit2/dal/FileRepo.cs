using System.Collections.Generic;
using System.IO;
using System.Linq;
using TomislavKucarS2.model;

namespace TomislavKucarS2.dal
{
    class FileRepo : IRepo
    {
        private const string DIR = @"E:\Radna-mapa\TomislavKucarS2\TomislavKucarS2";
        private const string PATH = DIR + @"\posudbe.txt";
        public FileRepo() => CreateFileIfNotExists();

        private void CreateFileIfNotExists()
        {
            Directory.CreateDirectory(DIR);
            if (!File.Exists(PATH))
            {
                File.Create(PATH).Close();
            }
        }

        public void SaveBooks(IList<Book> books)
        {
            File.WriteAllLines(PATH, books.Select(p => p.FormatForFileLine()));
        }

        public IList<Book> LoadBooks()
        {
            IList<Book> books = new List<Book>();
            string[] lines = File.ReadAllLines(PATH);
            lines.ToList().ForEach(line => books.Add(Book.ParseFromFileLine(line)));
            return books;
        }

    }
}