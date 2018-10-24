﻿using System;
using System.IO;
using System.Diagnostics;

namespace Pysharp
{
    public static class Compiler
    {
        /// <summary>
        /// Lex the specified source.
        /// </summary>
        /// <returns>token</returns>
        /// <param name="source">Source.</param>
		static string Lexer(ref string source)
        {
			return "token";
        }
        
        /// <summary>
        /// Parse the specified source.
        /// </summary>
        /// <returns>The parser.</returns>
        /// <param name="source">Source.</param>
		static string Parser(ref string source)
		{
			return "parsed source";
        }
		/// <summary>
        /// Generate CIL from the specified source.
        /// </summary>
        /// <returns>The generator.</returns>
        /// <param name="source">Source.</param>
        static string Generator(ref string source)
        {
            return "";
        }

        /// <summary>
        /// Assembles the IL asm.
        /// </summary>
        /// <param name="srcFile">Source file.</param>
        /// <param name="outFile">Out file.</param>
        static void AssembleILasm(string srcFile, string outFile)
        {
            ProcessStartInfo startInfo = new ProcessStartInfo
            {
                CreateNoWindow = false,
                UseShellExecute = false,
                FileName = "ilasm",
                WindowStyle = ProcessWindowStyle.Hidden,
                Arguments = srcFile + " " + "/output:" + outFile
            };

            try
            {
                using (Process exeProcess = Process.Start(startInfo))
                {
                    exeProcess.WaitForExit();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred");
                Console.WriteLine(ex.GetType().Name);
                Console.WriteLine(ex.Message);
            }
        }

        /// <summary>
        /// Verifies the build.
        /// </summary>
        /// <param name="outFile">Out file.</param>
		static void VerifyBuild(string outFile)
		{
            Console.WriteLine("Verifying build...");
			ProcessStartInfo startInfo = new ProcessStartInfo
            {
                CreateNoWindow = false,
                UseShellExecute = false,
				FileName = "peverify",
                WindowStyle = ProcessWindowStyle.Hidden,
				Arguments = outFile
            };

            try
            {
                using (Process exeProcess = Process.Start(startInfo))
                {
                    exeProcess.WaitForExit();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred");
                Console.WriteLine(ex.GetType().Name);
                Console.WriteLine(ex.Message);
            }
		}

        /// <summary>
        /// Compile the specified source.
        /// </summary>
        /// <param name="source">Source.</param>
        /// <param name="outfile">Outfile.</param>
        public static void Compile(ref string source, string outfile)
        {
			// preprocess source //
			source = Cleaners.StripCComments(source);
			source = Cleaners.RemoveAfterDelimiter(source, "#");
			source = Cleaners.RemoveEmptyLines(source);

			// lex and parse

			// generate

			// write and assemble source
			string newOutfile = Path.GetFileNameWithoutExtension(outfile) + ".ilasm";
			System.IO.File.WriteAllText(newOutfile, source);
			AssembleILasm(newOutfile, outfile);
			VerifyBuild(outfile); // todo: make build verifying optional
        }
	}
}