using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;


//todo: validate input strings
namespace ConsoleApp4
{
    class Program
    {
        public struct Student {
            public int student_id;
            public string name, surname;
            public int year;
            public decimal average;

            public override string ToString() {
                return $"student id: {student_id}, name: {name}, surname: {surname}, year of study: {year}, average: {average}";
            }
        }

        static void Main(string[] args)
        {
            List<Student> students = new List<Student>();
            List<String> errors = new List<String>();

            //get user iput
            Console.WriteLine("Enter Path or drag file: ");
            var dirPath = @"" + Console.ReadLine();
            dirPath.Replace("\"", "");

            try {
                if (File.Exists(dirPath)) {
                    //get user input (year)
                    Console.WriteLine("Enter year of uni: ");
                    int uniYear = int.Parse(Console.ReadLine());

                    // Read the file line by line
                    string line;
                    System.IO.StreamReader file = new System.IO.StreamReader(dirPath);
                    while ((line = file.ReadLine()) != null) {
                        //split string and build struct
                        string[] subStrings = line.Split(':');
                        var tmp = new Student();
                        tmp.student_id = Int32.Parse(subStrings[0]);
                        tmp.name = subStrings[1];
                        tmp.surname = subStrings[2];
                        tmp.year = Int32.Parse(subStrings[3]);
                        tmp.average = Decimal.Parse(subStrings[4]);

                        if(tmp.year == uniYear){
                            students.Add(tmp);
                        }
                    }
                    file.Close();
                }
                else {
                    throw new FileNotFoundException();
                }
            }
            catch (Exception e) {
                Console.WriteLine(e.Message);
            }

            // write out the students
            Console.ForegroundColor = ConsoleColor.Green;
            foreach (Student student in students) {
                System.Console.WriteLine(student);
            }
            //students.ForEach(Console.Writeline);

            //  write out the errors
            Console.ForegroundColor = ConsoleColor.Red;
            foreach (string error in errors) {
                System.Console.WriteLine(error);
            }
            Console.WriteLine("test!");
            Console.ForegroundColor = ConsoleColor.Black;
        }
    }
}
