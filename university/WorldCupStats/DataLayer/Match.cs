using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer
{
    public class Match
    {
        public string Location { get; set; }
        public string Attendance { get; set; }
        public string Home_team { get; set; }
        public string Away_team { get; set; }
        public string Winner { get; set; }
        public string Score { get; set; }
        public string Id { get; set; }
        public Dictionary<string, Player> players = new Dictionary<string, Player>();
    }
}
