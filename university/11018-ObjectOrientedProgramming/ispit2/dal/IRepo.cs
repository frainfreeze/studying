using System.Collections.Generic;
using TomislavKucarS2.model;

namespace TomislavKucarS2.dal
{
    public interface IRepo
    {
        void SaveBooks(IList<Book> books);
        IList<Book> LoadBooks();
    }
}