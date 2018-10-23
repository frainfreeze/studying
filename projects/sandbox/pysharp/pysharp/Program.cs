using System;
using System.IO;

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
            // get files, todo: better arg parsing
			string srcFile = args[0];
			string outFile = Path.GetFileNameWithoutExtension(args[1]);

			// process source output asm
			Console.WriteLine("Compiling '{0}' to ilasm '{1}'", srcFile, outFile + ".ilasm");
			string srcCode = System.IO.File.ReadAllText(srcFile);
			Compiler.Compile(ref srcCode);

            // exit
			Console.WriteLine("Done");
        }
	}
}