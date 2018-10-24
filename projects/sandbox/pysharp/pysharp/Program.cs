using System;

namespace Pysharp
{
    class MainClass
    {
        /// <summary>
        /// The entry point of the program, where the program control starts and ends.
        /// </summary>
		/// <param name="args">The command-line arguments; input and output file.</param>
        public static void Main(string[] args)
        {
			var watch = System.Diagnostics.Stopwatch.StartNew();

            // get files, todo: better arg parsing
			string srcFile = args[0];
			string outFile = args[1];

			// compile. todo: handle file read and compiler errors
			string srcCode = System.IO.File.ReadAllText(srcFile);
			Console.WriteLine("Compiling '{0}' to '{1}'.", srcFile, outFile);
			Compiler.Compile(ref srcCode, outFile);

            // exit
			watch.Stop();
			Console.WriteLine("Done in {0} ms.", watch.ElapsedMilliseconds);
        }
	}
}