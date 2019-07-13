using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using RestSharp;
using Newtonsoft.Json;
using System.Threading;

namespace DataLayer
{
    public static class Config
    {
        public static List<string> ReadConfigFile() {
            List<string> r = File.ReadAllText(Constants.ConfigPath).Split('|').ToList();
            return r;
        }

        public static void SaveDataToFile(Team t, string lng) {
            if (t == null) //dont bother saving anything
                return;

            string favPlayers = "";

            foreach (var p in t.players)
                if (p.Value.favorite)
                    favPlayers += p.Value.name + ",";

            if (favPlayers.Length > 1)
                favPlayers = favPlayers.Remove(favPlayers.Length - 1);

            using (StreamWriter sw = new StreamWriter(Constants.ConfigPath, true, Encoding.ASCII))
                sw.Write($"{lng}|{t.teamName}|{favPlayers}");
        }
    }
}