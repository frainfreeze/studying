using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TomislavKucarS2.dal;
using TomislavKucarS2.events;

namespace TomislavKucarS2.model
{
    public class Book
    {
        public object ISBN { get; internal set; }
        public string Naslov { get; internal set; }
        public string Autor { get; internal set; }
        public string Kategorija { get; internal set; }
        public string DatumPosudbe { get; internal set; }
        public string DatumVracanja { get; internal set; }
        public string IndikatorPosuditelja { get; internal set; }

        internal string FormatForFileLine()
        {
            throw new NotImplementedException();
        }

        internal static Book ParseFromFileLine(string line)
        {
            throw new NotImplementedException();
        }

        internal bool HasValidISBN()
        {
            throw new NotImplementedException();
        }
    }
}
