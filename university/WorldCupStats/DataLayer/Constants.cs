using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer
{
    class Constants
    {
        public const string TeamsUrl   = "https://world-cup-json-2018.herokuapp.com/teams";
        public const string MatchesUrl = "https://world-cup-json-2018.herokuapp.com/matches/country?fifa_code=";
        public const string ResultsUrl = "https://world-cup-json-2018.herokuapp.com/teams/results";

        public const string ConfigPath = @"..\..\..\config.txt";
    }
}
