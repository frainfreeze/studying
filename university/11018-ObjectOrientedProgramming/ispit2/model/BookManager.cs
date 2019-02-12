using System;
using System.Collections.Generic;
using TomislavKucarS2.dal;
using TomislavKucarS2.events;

namespace TomislavKucarS2.model
{
    public class BookManager
    {
        public event OnExceptionEventHandler OnException;
        public event OnReturnEventHandler OnLoaded;

        private IDictionary<string, Book> booksDictionary;
        private IRepo repo;

        public BookManager()
        {
            repo = RepoFactory.GetRepo();
        }
        public IDictionary<string, Book> GetBooksDictionary()
        {
            if (booksDictionary == null)
            {
                Load();
            }
            return new Dictionary<string, Book>(booksDictionary);
        }
        private void Load()
        {
            try
            {
                IList<Book> books = repo.LoadBooks();
                FillDictionary(books);
            }
            catch (Exception e)
            {
                OnException?.Invoke(this, new OnExceptionEventArgs
                {
                    Exception = e
                });
            }
        }

        private void FillDictionary(IList<Book> books)
        {
            booksDictionary = new Dictionary<string, Book>();
            foreach (var book in books)
            {
                try
                {
                    if (book.HasValidISBN())
                    {
                        //IList<string> missingData = new List<string>();
                        //if (string.IsNullOrEmpty(person.Name))
                        //{
                        //    missingData.Add(nameof(person.Name));
                        //}
                        //if (string.IsNullOrEmpty(person.Surname))
                        //{
                        //    missingData.Add(nameof(person.Surname));
                        //}
                        //if (string.IsNullOrEmpty(person.Phone))
                        //{
                        //    missingData.Add(nameof(person.Phone));
                        //}
                        //if (string.IsNullOrEmpty(person.Email))
                        //{
                        //    missingData.Add(nameof(person.Email));
                        //}
                        //booksDictionary.Add(book.Oib, book);
                        //OnLoaded?.Invoke(this, new OnLoadedEventArgs
                        //{
                        //    LoadedBook = book,
                        //    MissingData = missingData
                        //});
                    }
                    else
                    {
                        throw new exceptions.DuplicateRecordException();
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
        public void SaveBooks(IList<Book> books)
        {
            try
            {
                repo.SaveBooks(books);
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
