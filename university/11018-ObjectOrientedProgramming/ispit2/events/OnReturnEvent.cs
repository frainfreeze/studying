using System;
using System.Collections.Generic;
using TomislavKucarS2.model;

namespace TomislavKucarS2.events
{
        public delegate void OnReturnEventHandler(object sender, OnReturnEventArgs args);

        public class OnReturnEventArgs : EventArgs
        {
            public Book LoadedBook { get; set; }
            public IList<string> MissingData { get; set; }
        }
    }
}
