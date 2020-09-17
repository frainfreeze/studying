using System;

namespace TomislavKucarS2.events
{
    public delegate void OnExceptionEventHandler(object sender, OnExceptionEventArgs args);

    public class OnExceptionEventArgs : EventArgs
    {
        public Exception Exception { get; set; }
    }
}