﻿using DataLayer;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace WPFWorldCup
{
    public partial class MainWindow : Window
    {
        public string lng;
        public string favTeamName;
        public string fifa_id;
        public string enemyFifa_id;
        public string enemyTeamName;
        public Team team;
        public Team awayTeam;
        public Match match = new Match();
        public string windowsState = "";
        public List<string> teams = new List<string>();

        public ChooseLanguage chooseLanguageForm;
        public Initialsettings initialSettingsForm;
        public TeamChooser teamChooser;
        public EnemyTeamChooser enemyTeamChooser;
        public Loading0 loading0 = new Loading0();
        public Loading1 loading1 = new Loading1();
        public TeamInfo teaminfo;
        public AdditionalPlayerinfo additionalPlayerinfo = new AdditionalPlayerinfo();

        public MainWindow()
        {
            InitializeComponent();
            run();
        }

        public async void run()
        {
            Hide();

            chooseLanguageForm = new ChooseLanguage(this);
            initialSettingsForm = new Initialsettings(this);
            teamChooser = new TeamChooser(this);
            enemyTeamChooser = new EnemyTeamChooser(this);
            teaminfo = new TeamInfo(this);

            try
            {
                List<string> config = Config.ReadConfigFile();
                lng = config[0];
                favTeamName = config[1];
                fifa_id = await HttpClient.GetCountryCode(favTeamName);

                if (lng == "ENG")
                    await changeLanguageToENG();
                else
                    await changeLanguageToCRO();

                chooseLanguageForm.first = false;
                await CreateTeam(favTeamName);
                await teaminfo.SetUp();
                await fillEnemyTeamChooser(team);
            }
            catch (FileNotFoundException)
            {
                chooseLanguageForm.Show();
            }
        }

        public async void ShowMain()
        {
            Show();
        }

        public async Task changeLanguageToENG()
        {
            initialSettingsForm.btn_fullscreen.Content = "Fullscreen";
            initialSettingsForm.btn_notFullscreen.Content = "Normal";
            enemyTeamChooser.lbl_chooseEnemyTeam.Content = "Choose enemy team";
            enemyTeamChooser.btn_chooseEnemyTeam.Content = "Apply";
            teamChooser.lbl_chooseTeam.Content = "Choose your favorite team";
            teamChooser.btn_applyFavoriteTeam.Content = "Apply";
            teaminfo.lbl_diference.Content = "Difference:";
            teaminfo.lbl_draws.Content = "Draws:";
            teaminfo.lbl_goals.Content = "Goals:";
            teaminfo.lbl_goalsRecived.Content = "Recived goals:";
            teaminfo.lbl_losses.Content = "Losses:";
            teaminfo.lbl_played.Content = "Played:";
            teaminfo.lbl_wins.Content = "Wins:";
            additionalPlayerinfo.lbl_captain.Content = "Captain(C-yes,X-no):";
            additionalPlayerinfo.lbl_cards.Content = "Cards:";
            additionalPlayerinfo.lbl_goals.Content = "Goals:";
            additionalPlayerinfo.lbl_position.Content = "Position:";
            additionalPlayerinfo.lbl_shirtNumber.Content = "Shirt number:";
            btn_changeLanguage.Content = "Settings";
            btn_applyFavoriteTeam.Content = "Change";
        }

        public async Task changeLanguageToCRO()
        {
            initialSettingsForm.btn_fullscreen.Content = "Puni zaslon";
            initialSettingsForm.btn_notFullscreen.Content = "Normalni prozor";
            enemyTeamChooser.lbl_chooseEnemyTeam.Content = "Odaberite protivnicki tim";
            enemyTeamChooser.btn_chooseEnemyTeam.Content = "Odaberi";
            teamChooser.lbl_chooseTeam.Content = "Odaberite omiljeni tim";
            teamChooser.btn_applyFavoriteTeam.Content = "Odaberi:";
            teaminfo.lbl_diference.Content = "Razlika:";
            teaminfo.lbl_draws.Content = "Nerjeseno:";
            teaminfo.lbl_goals.Content = "Golovi:";
            teaminfo.lbl_goalsRecived.Content = "Primljeni golovi:";
            teaminfo.lbl_losses.Content = "Izgubljene:";
            teaminfo.lbl_played.Content = "Odigrane:";
            teaminfo.lbl_wins.Content = "Pobjede:";
            additionalPlayerinfo.lbl_captain.Content = "Kapetan(C-da,X-ne):";
            additionalPlayerinfo.lbl_cards.Content = "Kartoni:";
            additionalPlayerinfo.lbl_goals.Content = "Golovi:";
            additionalPlayerinfo.lbl_position.Content = "Pozicija:";
            additionalPlayerinfo.lbl_shirtNumber.Content = "Broj:";
            btn_changeLanguage.Content = "Postavke";
            btn_applyFavoriteTeam.Content = "Promjeni";
        }


        public async void fillComboBox()
        {
            foreach (var i in teams)
            {
                cb_teams.Items.Add(i);
            }
            cb_teams.SelectedItem = favTeamName;
        }

        private async void Btn_applyFavoriteTeam_Click(object sender, RoutedEventArgs e)
        {
            await ShowLoading();
            fifa_id = await HttpClient.GetCountryCode(cb_teams.Text);
            favTeamName = cb_teams.Text;
            await CreateTeam(favTeamName);
            Thread.Sleep(1000);
            await teaminfo.SetUp();
            await HideLoading();
            await fillEnemyTeamChooser(team);
        }


        public async Task fillEnemyTeamChooser(Team t)
        {
            enemyTeamChooser.cb_enemyTeamChooser.Items.Clear();
            string n = "";
            foreach (var m in t.matches)
            {
                if (m.Home_team == t.teamName)
                {
                    enemyTeamChooser.cb_enemyTeamChooser.Items.Add(m.Away_team);
                    n = m.Away_team;
                }
                else
                {
                    enemyTeamChooser.cb_enemyTeamChooser.Items.Add(m.Home_team);
                }
            }
            enemyTeamChooser.cb_enemyTeamChooser.SelectedItem = n;
            showChooseEnemyTeam();
        }

        public async void showTeamChooser()
        {
            teamChooser.Show();
        }

        public async void showChooseEnemyTeam()
        {
            enemyTeamChooser.Show();
        }

        public async Task CreateTeam(string teamName)
        {
            team = new Team(teamName, fifa_id);
            await team.SetUp();
            await SetHomeTeamLabels(team);
        }

        public async Task CreateEnemyTeam(string teamName)
        {
            awayTeam = new Team(teamName, enemyFifa_id);
            await awayTeam.SetUp();
            await SetAwayTeamLabels(awayTeam);
            await SetMatchLabels();
            await ShowLoading1();
            Thread.Sleep(500);
            await HideLoading1();
            teaminfo.Show();
            fillComboBox();
            Show();
        }

        public async Task SetHomeTeamLabels(Team homeTeam)
        {
            await showHomeTeamField();
            int defender = 0;
            int midfielder = 0;
            int forward = 0;
            List<Player> firstElevenWithMoreInfo = new List<Player>();

            foreach (var p in homeTeam.firsteleven)
            {
                firstElevenWithMoreInfo.Add(homeTeam.players[p]);
                switch (homeTeam.players[p].position)
                {
                    case "Defender": defender++; break;
                    case "Midfield": midfielder++; break;
                    case "Forward": forward++; break;
                }
            }

            int defCounter = 0;
            int midCounter = 0;
            int forCounter = 0;

            foreach (var i in firstElevenWithMoreInfo)
            {
                switch (i.position)
                {
                    case "Defender":
                        switch (defender)
                        {
                            case 3:
                                switch (defCounter++)
                                {
                                    case 0: lbl_defenderHome4.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_defenderHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_defenderHome2.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_defenderHome0.Visibility = Visibility.Hidden;
                                lbl_defenderHome3.Visibility = Visibility.Hidden;
                                box_homeDefender0.Visibility = Visibility.Hidden;
                                box_homeDefender3.Visibility = Visibility.Hidden;
                                lbl_midfieldHome5.Visibility = Visibility.Hidden;
                                box_homeMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 4:
                                switch (defCounter++)
                                {
                                    case 0: lbl_defenderHome0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_defenderHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_defenderHome2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_defenderHome3.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_defenderHome4.Visibility = Visibility.Hidden;
                                box_homeDefender4.Visibility = Visibility.Hidden;
                                lbl_midfieldHome5.Visibility = Visibility.Hidden;
                                box_homeMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 5:
                                switch (defCounter++)
                                {
                                    case 0: lbl_defenderHome0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_defenderHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_defenderHome2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_defenderHome3.Content = (i.name + " " + i.shirt_number); break;
                                    case 4: lbl_defenderHome4.Content = (i.name + " " + i.shirt_number); break;
                                }
                                break;
                        }
                        break;
                    case "Midfield":
                        switch (midfielder)
                        {
                            case 2:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldHome2.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_midfieldHome0.Visibility = Visibility.Hidden;
                                lbl_midfieldHome3.Visibility = Visibility.Hidden;
                                lbl_midfieldHome4.Visibility = Visibility.Hidden;
                                box_homeMidfield0.Visibility = Visibility.Hidden;
                                box_homeMidfield3.Visibility = Visibility.Hidden;
                                box_homeMidfield4.Visibility = Visibility.Hidden;
                                lbl_midfieldHome5.Visibility = Visibility.Hidden;
                                box_homeMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 3:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldHome4.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_midfieldHome2.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_midfieldHome0.Visibility = Visibility.Hidden;
                                lbl_midfieldHome3.Visibility = Visibility.Hidden;
                                box_homeMidfield0.Visibility = Visibility.Hidden;
                                box_homeMidfield3.Visibility = Visibility.Hidden;
                                lbl_midfieldHome5.Visibility = Visibility.Hidden;
                                box_homeMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 4:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldHome0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_midfieldHome2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_midfieldHome3.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_midfieldHome4.Visibility = Visibility.Hidden;
                                box_homeMidfield4.Visibility = Visibility.Hidden;
                                lbl_midfieldHome5.Visibility = Visibility.Hidden;
                                box_homeMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 5:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldHome0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_midfieldHome2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_midfieldHome3.Content = (i.name + " " + i.shirt_number); break;
                                    case 4: lbl_midfieldHome4.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_midfieldHome5.Visibility = Visibility.Hidden;
                                box_homeMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 6:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldHome0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_midfieldHome2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_midfieldHome3.Content = (i.name + " " + i.shirt_number); break;
                                    case 4: lbl_midfieldHome4.Content = (i.name + " " + i.shirt_number); break;
                                    case 5: lbl_midfieldHome5.Content = (i.name + " " + i.shirt_number); break;
                                }
                                break;
                        }
                        break;
                    case "Forward":
                        switch (forward)
                        {
                            case 1:
                                lbl_forwardHome0.Content = (i.name + " " + i.shirt_number);
                                lbl_forwardHome1.Visibility = Visibility.Hidden;
                                lbl_forwardHome2.Visibility = Visibility.Hidden;
                                lbl_forwardHome3.Visibility = Visibility.Hidden;
                                box_homeForward1.Visibility = Visibility.Hidden;
                                box_homeForward2.Visibility = Visibility.Hidden;
                                box_homeForward3.Visibility = Visibility.Hidden;
                                break;
                            case 2:
                                switch (forCounter++)
                                {
                                    case 0: lbl_forwardHome2.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_forwardHome1.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_forwardHome0.Visibility = Visibility.Hidden;
                                box_homeForward0.Visibility = Visibility.Hidden;
                                lbl_forwardHome3.Visibility = Visibility.Hidden;
                                box_homeForward3.Visibility = Visibility.Hidden;
                                break;
                            case 3:
                                switch (forCounter++)
                                {
                                    case 0: lbl_forwardHome0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_forwardHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_forwardHome2.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_forwardHome3.Visibility = Visibility.Hidden;
                                box_homeForward3.Visibility = Visibility.Hidden;
                                break;
                            case 4:
                                switch (forCounter++)
                                {
                                    case 0: lbl_forwardHome0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_forwardHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_forwardHome2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_forwardHome3.Content = (i.name + " " + i.shirt_number); break;
                                }
                                break;
                        }
                        break;
                    case "Goalie":
                        lbl_goalieHome.Content = (i.name + " " + i.shirt_number);
                        break;
                }
            }
        }

        public async Task SetAwayTeamLabels(Team awayTeam)
        {
            await showAwayTeamField();
            int defender = 0;
            int midfielder = 0;
            int forward = 0;
            List<Player> firstElevenWithMoreInfo = new List<Player>();

            foreach (var p in awayTeam.firsteleven)
            {
                firstElevenWithMoreInfo.Add(awayTeam.players[p]);
                switch (awayTeam.players[p].position)
                {
                    case "Defender": defender++; break;
                    case "Midfield": midfielder++; break;
                    case "Forward": forward++; break;
                }
            }

            int defCounter = 0;
            int midCounter = 0;
            int forCounter = 0;

            foreach (var i in firstElevenWithMoreInfo)
            {
                switch (i.position)
                {
                    case "Defender":
                        switch (defender)
                        {
                            case 3:
                                switch (defCounter++)
                                {
                                    case 0: lbl_defenderAway4.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_defenderAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_defenderAway2.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_defenderAway0.Visibility = Visibility.Hidden;
                                lbl_defenderAway3.Visibility = Visibility.Hidden;
                                box_awayDefender0.Visibility = Visibility.Hidden;
                                box_awayDefender3.Visibility = Visibility.Hidden;
                                break;
                            case 4:
                                switch (defCounter++)
                                {
                                    case 0: lbl_defenderAway0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_defenderAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_defenderAway2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_defenderAway3.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_defenderAway4.Visibility = Visibility.Hidden;
                                box_awayDefender4.Visibility = Visibility.Hidden;
                                break;
                            case 5:
                                switch (defCounter++)
                                {
                                    case 0: lbl_defenderAway0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_defenderAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_defenderAway2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_defenderAway3.Content = (i.name + " " + i.shirt_number); break;
                                    case 4: lbl_defenderAway4.Content = (i.name + " " + i.shirt_number); break;
                                }
                                break;
                        }
                        break;
                    case "Midfield":
                        switch (midfielder)
                        {
                            case 2:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldHome1.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldHome2.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_midfieldAway0.Visibility = Visibility.Hidden;
                                lbl_midfieldAway3.Visibility = Visibility.Hidden;
                                lbl_midfieldAway4.Visibility = Visibility.Hidden;
                                box_awayMidfield0.Visibility = Visibility.Hidden;
                                box_awayMidfield3.Visibility = Visibility.Hidden;
                                box_awayMidfield4.Visibility = Visibility.Hidden;
                                lbl_midfieldAway5.Visibility = Visibility.Hidden;
                                box_awayMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 3:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldAway4.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_midfieldAway2.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_midfieldAway0.Visibility = Visibility.Hidden;
                                lbl_midfieldAway3.Visibility = Visibility.Hidden;
                                box_awayMidfield0.Visibility = Visibility.Hidden;
                                box_awayMidfield3.Visibility = Visibility.Hidden;
                                lbl_midfieldAway5.Visibility = Visibility.Hidden;
                                box_awayMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 4:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldAway0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_midfieldAway2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_midfieldAway3.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_midfieldAway4.Visibility = Visibility.Hidden;
                                box_awayMidfield4.Visibility = Visibility.Hidden;
                                lbl_midfieldAway5.Visibility = Visibility.Hidden;
                                box_awayMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 5:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldAway0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_midfieldAway2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_midfieldAway3.Content = (i.name + " " + i.shirt_number); break;
                                    case 4: lbl_midfieldAway4.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_midfieldAway5.Visibility = Visibility.Hidden;
                                box_awayMidfield5.Visibility = Visibility.Hidden;
                                break;
                            case 6:
                                switch (midCounter++)
                                {
                                    case 0: lbl_midfieldAway0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_midfieldAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_midfieldAway2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_midfieldAway3.Content = (i.name + " " + i.shirt_number); break;
                                    case 4: lbl_midfieldAway4.Content = (i.name + " " + i.shirt_number); break;
                                    case 5: lbl_midfieldAway5.Content = (i.name + " " + i.shirt_number); break;
                                }
                                break;
                        }
                        break;
                    case "Forward":
                        switch (forward)
                        {
                            case 1:
                                lbl_forwardAway0.Content = (i.name + " " + i.shirt_number);
                                lbl_forwardAway1.Visibility = Visibility.Hidden;
                                lbl_forwardAway2.Visibility = Visibility.Hidden;
                                lbl_forwardAway3.Visibility = Visibility.Hidden;
                                box_awayForward1.Visibility = Visibility.Hidden;
                                box_awayForward2.Visibility = Visibility.Hidden;
                                box_awayForward3.Visibility = Visibility.Hidden;
                                break;
                            case 2:
                                switch (forCounter++)
                                {
                                    case 0: lbl_forwardAway2.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_forwardAway1.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_forwardAway0.Visibility = Visibility.Hidden;
                                lbl_forwardAway3.Visibility = Visibility.Hidden;
                                box_awayForward0.Visibility = Visibility.Hidden;
                                box_awayForward3.Visibility = Visibility.Hidden;
                                break;
                            case 3:
                                switch (forCounter++)
                                {
                                    case 0: lbl_forwardAway0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_forwardAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_forwardAway2.Content = (i.name + " " + i.shirt_number); break;
                                }
                                lbl_forwardAway3.Visibility = Visibility.Hidden;
                                box_awayForward3.Visibility = Visibility.Hidden;
                                break;
                            case 4:
                                switch (forCounter++)
                                {
                                    case 0: lbl_forwardAway0.Content = (i.name + " " + i.shirt_number); break;
                                    case 1: lbl_forwardAway1.Content = (i.name + " " + i.shirt_number); break;
                                    case 2: lbl_forwardAway2.Content = (i.name + " " + i.shirt_number); break;
                                    case 3: lbl_forwardAway3.Content = (i.name + " " + i.shirt_number); break;
                                }
                                break;

                        }
                        break;
                    case "Goalie": lbl_goalieAway.Content = (i.name + " " + i.shirt_number); break;
                }
            }
        }

        public async Task SetMatchLabels()
        {
            match = HttpClient.GetMatch(team, awayTeam.teamName);
            if (match.Home_team == team.teamName)
            {
                lbl_homeTeam.Content = match.Home_team;
                lbl_homeTeamScore.Content = match.Score.Split(':')[0];
                lbl_awayTeam.Content = match.Away_team;
                lbl_awayTeamScore.Content = match.Score.Split(':')[1];
            }
            else
            {
                lbl_homeTeam.Content = match.Away_team;
                lbl_homeTeamScore.Content = match.Score.Split(':')[1];
                lbl_awayTeam.Content = match.Home_team;
                lbl_awayTeamScore.Content = match.Score.Split(':')[0];
            }
        }

        private async Task showAwayTeamField()
        {
            /*labels forward*/
            lbl_forwardAway0.Visibility = Visibility.Visible;
            lbl_forwardAway1.Visibility = Visibility.Visible;
            lbl_forwardAway2.Visibility = Visibility.Visible;
            /*labels midfield*/
            lbl_midfieldAway0.Visibility = Visibility.Visible;
            lbl_midfieldAway1.Visibility = Visibility.Visible;
            lbl_midfieldAway2.Visibility = Visibility.Visible;
            lbl_midfieldAway3.Visibility = Visibility.Visible;
            lbl_midfieldAway4.Visibility = Visibility.Visible;
            /*labels defender*/
            lbl_defenderAway0.Visibility = Visibility.Visible;
            lbl_defenderAway1.Visibility = Visibility.Visible;
            lbl_defenderAway2.Visibility = Visibility.Visible;
            lbl_defenderAway3.Visibility = Visibility.Visible;
            lbl_defenderAway4.Visibility = Visibility.Visible;
            /*box forward*/
            box_awayForward0.Visibility = Visibility.Visible;
            box_awayForward1.Visibility = Visibility.Visible;
            box_awayForward2.Visibility = Visibility.Visible;
            /*box midfield*/
            box_awayMidfield0.Visibility = Visibility.Visible;
            box_awayMidfield1.Visibility = Visibility.Visible;
            box_awayMidfield2.Visibility = Visibility.Visible;
            box_awayMidfield3.Visibility = Visibility.Visible;
            box_awayMidfield4.Visibility = Visibility.Visible;
            /*box defender*/
            box_awayDefender0.Visibility = Visibility.Visible;
            box_awayDefender1.Visibility = Visibility.Visible;
            box_awayDefender2.Visibility = Visibility.Visible;
            box_awayDefender3.Visibility = Visibility.Visible;
            box_awayDefender4.Visibility = Visibility.Visible;
        }

        private async Task showHomeTeamField()
        {
            /*labels forward*/
            lbl_forwardHome0.Visibility = Visibility.Visible;
            lbl_forwardHome1.Visibility = Visibility.Visible;
            lbl_forwardHome2.Visibility = Visibility.Visible;
            /*labels midfield*/
            lbl_midfieldHome0.Visibility = Visibility.Visible;
            lbl_midfieldHome1.Visibility = Visibility.Visible;
            lbl_midfieldHome2.Visibility = Visibility.Visible;
            lbl_midfieldHome3.Visibility = Visibility.Visible;
            lbl_midfieldHome4.Visibility = Visibility.Visible;
            /*labels defender*/
            lbl_defenderHome0.Visibility = Visibility.Visible;
            lbl_defenderHome1.Visibility = Visibility.Visible;
            lbl_defenderHome2.Visibility = Visibility.Visible;
            lbl_defenderHome3.Visibility = Visibility.Visible;
            lbl_defenderHome4.Visibility = Visibility.Visible;
            /*box forward*/
            box_homeForward0.Visibility = Visibility.Visible;
            box_homeForward1.Visibility = Visibility.Visible;
            box_homeForward2.Visibility = Visibility.Visible;
            /*box midfield*/
            box_homeMidfield0.Visibility = Visibility.Visible;
            box_homeMidfield1.Visibility = Visibility.Visible;
            box_homeMidfield2.Visibility = Visibility.Visible;
            box_homeMidfield3.Visibility = Visibility.Visible;
            box_homeMidfield4.Visibility = Visibility.Visible;
            /*box defender*/
            box_homeDefender0.Visibility = Visibility.Visible;
            box_homeDefender1.Visibility = Visibility.Visible;
            box_homeDefender2.Visibility = Visibility.Visible;
            box_homeDefender3.Visibility = Visibility.Visible;
            box_homeDefender4.Visibility = Visibility.Visible;
        }



        public async Task ShowLoading()
        {
            loading1.Show();
        }

        public async Task HideLoading()
        {
            loading1.Hide();
        }

        public async Task ShowLoading1()
        {
            loading0.Show();

        }

        public async Task HideLoading1()
        {
            loading0.Hide();
        }



        public static List<T> GetLogicalChildCollection<T>(object parent) where T : DependencyObject
        {
            List<T> logicalCollection = new List<T>();
            GetLogicalChildCollection(parent as DependencyObject, logicalCollection);
            return logicalCollection;
        }

        private static void GetLogicalChildCollection<T>(DependencyObject parent, List<T> logicalCollection) where T : DependencyObject
        {
            IEnumerable children = LogicalTreeHelper.GetChildren(parent);
            foreach (object child in children)
            {
                if (child is DependencyObject)
                {
                    DependencyObject depChild = child as DependencyObject;
                    if (child is T)
                    {
                        logicalCollection.Add(child as T);
                    }

                    GetLogicalChildCollection(depChild, logicalCollection);
                }
            }
        }


        private async Task showMorePlayerInfo(string name, string h)
        {
            await ShowLoading();
            Player p = new Player();

            try
            {
                foreach (Match m in (h == "home" ? team.matches : awayTeam.matches))
                {
                    if (m.Id == match.Id)
                    {
                        p.cards = m.players[name].cards;
                        p.name = m.players[name].name;
                        p.goals = m.players[name].goals;
                    }
                }
            }
            catch (KeyNotFoundException)
            {
                p = new Player { goals = 0, cards = 0, name = name };
            }

            additionalPlayerinfo.lbl_captainV.Content = (h == "home" ? (team.players[name].captain ? "C" : "X") : (awayTeam.players[name].captain ? "C" : "X"));
            additionalPlayerinfo.lbl_cardsV.Content = p.cards;
            additionalPlayerinfo.lbl_goalsV.Content = p.goals;
            additionalPlayerinfo.lbl_playerName.Content = name;
            additionalPlayerinfo.lbl_positionV.Content = (h == "home" ? team.players[name].position : awayTeam.players[name].position);
            additionalPlayerinfo.lbl_shirtNumberV.Content = (h == "home" ? team.players[name].shirt_number : awayTeam.players[name].shirt_number);

            Thread.Sleep(300);
            await HideLoading();

            additionalPlayerinfo.Show();
        }

        private async void Box_homeGoalie_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_goalieHome.Content, "home"); }
        private async void Box_homeDefender0_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderHome0.Content, "home"); }
        private async void Box_homeDefender1_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderHome1.Content, "home"); }
        private async void Box_homeDefender2_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderHome2.Content, "home"); }
        private async void Box_homeDefender3_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderHome3.Content, "home"); }
        private async void Box_homeDefender4_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderHome4.Content, "home"); }
        private async void Box_homeMidfield0_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldHome0.Content, "home"); }
        private async void Box_homeMidfield1_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldHome1.Content, "home"); }
        private async void Box_homeMidfield2_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldHome2.Content, "home"); }
        private async void Box_homeMidfield3_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldHome3.Content, "home"); }
        private async void Box_homeMidfield4_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldHome4.Content, "home"); }
        private async void Box_homeMidfield5_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldHome5.Content, "home"); }
        private async void Box_homeForward0_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_forwardHome0.Content, "home"); }
        private async void Box_homeForward1_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_forwardHome1.Content, "home"); }
        private async void Box_homeForward2_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_forwardHome2.Content, "home"); }
        private async void Box_homeForward3_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_forwardHome3.Content, "home"); }
        private async void Box_goalieAway_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_goalieAway.Content, "away"); }
        private async void Box_awayDefender0_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderAway0.Content, "away"); }
        private async void Box_awayDefender1_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderAway1.Content, "away"); }
        private async void Box_awayDefender2_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderAway2.Content, "away"); }
        private async void Box_awayDefender3_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderAway3.Content, "away"); }
        private async void Box_awayDefender4_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_defenderAway4.Content, "away"); }
        private async void Box_awayMidfield0_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldAway0.Content, "away"); }
        private async void Box_awayMidfield1_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldAway1.Content, "away"); }
        private async void Box_awayMidfield2_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldAway2.Content, "away"); }
        private async void Box_awayMidfield3_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldAway3.Content, "away"); }
        private async void Box_awayMidfield4_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldAway4.Content, "away"); }
        private async void Box_awayMidfield5_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_midfieldAway5.Content, "away"); }
        private async void Box_awayForward0_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_forwardAway0.Content, "away"); }
        private async void Box_awayForward1_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_forwardAway1.Content, "away"); }
        private async void Box_awayForward2_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_forwardAway2.Content, "away"); }
        private async void Box_awayForward3_MouseDown(object sender, MouseButtonEventArgs e) { await showMorePlayerInfo((string)lbl_forwardAway3.Content, "away"); }


        private void Lbl_changeLanguage_Click(object sender, RoutedEventArgs e)
        {
            chooseLanguageForm.Show();
            chooseLanguageForm.BringIntoView();
        }


        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            Config.SaveDataToFile(team, lng);
            e.Cancel = MessageBox.Show("Are you sure?", "Exit", MessageBoxButton.YesNo, MessageBoxImage.Question, MessageBoxResult.No) == MessageBoxResult.No;
            Application.Current.Shutdown();
        }
    }
}
