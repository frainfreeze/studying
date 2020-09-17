using System;

namespace TomislavKucarS2.exceptions
{
    [Serializable]
    internal class DuplicateRecordException : Exception
    {
        public DuplicateRecordException() : this("Knjiga sa ISBN brojem je vec posudena") { }
        public DuplicateRecordException(string message) : base(message) { }
    }
}