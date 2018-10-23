using System.Text.RegularExpressions;

namespace Pysharp
{
    public class Cleaners
    {
        /// <summary>
        /// Strips the tabs and spaces.
        /// </summary>
        /// <returns>Clean string</returns>
        /// <param name="str">String containing tabs and spaces</param>
        public static string StripTabsAndSpaces(string str)
        {
            const string reduceMultiSpace = @"[ ]{2,}";
            return Regex.Replace(str.Replace("\t", "@"), reduceMultiSpace, "@");
        }

        /// <summary>
        /// Removes the delimiter and everything after it on that line.
        /// </summary>
        /// <returns>Clean string</returns>
        /// <param name="str">String.</param>
        /// <param name="delimiter">Delimiter.</param>
        public static string RemoveAfterDelimiter(string str, string delimiter)
        {
            //regular expression to find a character (delimiter) and 
            //      replace it and everything following it with an empty string.
            //.Trim() will remove all beginning and ending white space.
            return Regex.Replace(str, delimiter + ".+", string.Empty).Trim();
        }

        /// <summary>
        /// Strips the C style comments.
        /// </summary>
        /// <returns>Clean string</returns>
        /// <param name="str">String without comments</param>
        public static string StripCComments(string str)
        {
            var re = @"(@(?:""[^""]*"")+|""(?:[^""\n\\]+|\\.)*""|'(?:[^'\n\\]+|\\.)*')|//.*|/\*(?s:.*?)\*/";
            return Regex.Replace(str, re, "$1");
        }

        /// <summary>
        /// Removes the empty lines.
        /// </summary>
		/// <returns>String without newlines</returns>
        /// <param name="str">String.</param>
		public static string RemoveEmptyLines(string str)
        {
			return Regex.Replace(str, @"^\s+$[\r\n]*", string.Empty, RegexOptions.Multiline);
        }
    }
}
