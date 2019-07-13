using DataLayer;
using System.Threading.Tasks;
using System.Windows;

namespace WPFWorldCup
{
    public partial class TeamChooser : Window
    {
        MainWindow f;
        
        public TeamChooser(MainWindow mainWindow) {
            InitializeComponent();
            f = mainWindow;

            FillComboBox();
        }

        public async void FillComboBox() {
            f.ShowLoading();
            f.teams = await Task.Run(() => HttpClient.GetCountryNames());
            f.HideLoading();

            foreach (var i in f.teams) {
                cb_teams.Items.Add(i);
            }

            cb_teams.SelectedItem = f.teams[0];
        }

        private async void Btn_applyFavoriteTeam_Click(object sender, RoutedEventArgs e) {
            f.ShowLoading();
            f.fifa_id = await HttpClient.GetCountryCode(cb_teams.Text);
            f.HideLoading();

            f.favTeamName = cb_teams.Text;
            await f.CreateTeam(f.favTeamName);
            Hide();
            await f.teaminfo.SetUp();
            await f.fillEnemyTeamChooser(f.team);
        }
    }
}
