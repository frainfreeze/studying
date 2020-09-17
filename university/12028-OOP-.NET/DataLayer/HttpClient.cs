using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DataLayer
{
    public static class HttpClient
    {
        public static async Task<string> GetUrl(string url) {
            var client = new RestClient(url);
            var response = await client.ExecuteTaskAsync(new RestRequest());

            if (!response.IsSuccessful)
            {
                MessageBox.Show($"Error fetching url. API response: {response.StatusCode}. Please wait 15 seconds...", "API error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                System.Threading.Thread.Sleep(15000);
                response = client.Execute(new RestRequest());
            }
            return response.Content;
        }


        public static async Task<List<string>> GetCountryNames() {
            dynamic response = JsonConvert.DeserializeObject(await Task.Run(() => GetUrl(Constants.TeamsUrl)));
            List<string> country = new List<string>();
            foreach (var s in response) { country.Add((string)s.country); }
            return country;
        }


        public static async Task<string> GetCountryCode(string favoriteTeam) {
            await GetUrl(Constants.TeamsUrl);
            dynamic response = JsonConvert.DeserializeObject(await Task.Run(() => GetUrl(Constants.TeamsUrl)));

            if (response != null) { 
                foreach (var s in response)
                    if (s.country == favoriteTeam)
                        return s.fifa_code;
            } else {
                return "";
            }

            MessageBox.Show($"Cant find country with {favoriteTeam} name");
            return "";
        }


        public static async Task<int> GetPlayerYellowCardsForMatch(string playerName, string matchID, string teamCode) {
            dynamic response = await GetCountryMatches(teamCode);
            int cards = 0;

            foreach (var match in response) {
                if (match.home_team.code == teamCode) {
                    foreach (var ev in match.home_team_events) {
                        if (ev.type_of_event == "yellow-card" && ev.player == playerName)
                            ++cards; 
                    }
                    return cards;
                } else {
                    foreach (var ev in match.away_team_events) {
                        if (ev.type_of_event == "yellow-card" && ev.player == playerName)
                            ++cards;
                    }
                    return cards;
                }
            }
            return -100;
        }


        public static async Task<int> GetPlayergoalsForMatch(string playerName, string matchID, string teamCode) {
            dynamic response = await GetCountryMatches(teamCode);
            int goals = 0;

            foreach (var match in response) {
                if (match.home_team.code == teamCode) {
                    foreach (var ev in match.home_team_events) {
                        if (ev.type_of_event == "goal" && ev.player == playerName)
                            ++goals;
                    }
                    return goals;
                } else {
                    foreach (var ev in match.away_team_events){
                        if (ev.type_of_event == "goal" && ev.player == playerName)
                            ++goals;
                    }
                    return goals;
                }
            }
            return -100;
        }


        public static async Task<dynamic> GetCountryResults(string countryName) {
            dynamic response = JsonConvert.DeserializeObject(await Task.Run(() => GetUrl(Constants.ResultsUrl)));

            foreach (var s in response)
                if (s.country == countryName) return s;

            throw new ArgumentException($"Cant find results for {countryName}");
        }


        public static async Task<dynamic> GetCountryMatches(string fifa_code) {
            return JsonConvert.DeserializeObject(await Task.Run(() => GetUrl(Constants.MatchesUrl + fifa_code)));
        }


        public static async Task<List<string>> GetMatchFirstEleven(string fifa_id, string fifa_code) {
            dynamic response = JsonConvert.DeserializeObject(await Task.Run(() => GetUrl(Constants.MatchesUrl + fifa_code)));
            List<string> starting_eleven = new List<string>();

            foreach (var match in response) {
                if (match.fifa_id == fifa_id) {
                    if (match.home_team.code == fifa_code) {
                        foreach (var player in match.home_team_statistics.starting_eleven)
                            starting_eleven.Add((string)player.name);
                        return starting_eleven;
                    } else {
                        foreach (var player in match.away_team_statistics.starting_eleven)
                            starting_eleven.Add((string)player.name);
                        return starting_eleven;
                    }
                }
            }

            //todo: handle exception
            throw new ArgumentException("Couldnt fetch first eleven.");
        }


        public static Match GetMatch(Team t1, string t2) {
            foreach (Match match in t1.matches) {
                if (match.Home_team == t2) return match;
                if (match.Away_team == t2) return match;
            }

            //todo: handle exception
            throw new ArgumentException($"Match {t1.teamName} vs {t2} doesnt exist!");
        }
    }
}
