using DataLayer;
using System.Windows;

namespace WPFWorldCup
{
    public partial class EnemyTeamChooser : Window
    {
        MainWindow f;

        public EnemyTeamChooser(MainWindow f) {
            InitializeComponent();
            this.f = f;
        }

        private async void Btn_chooseEnemyTeam_Click(object sender, RoutedEventArgs e) {
            f.ShowLoading();
            f.enemyFifa_id = await HttpClient.GetCountryCode(cb_enemyTeamChooser.Text);
            f.HideLoading();
            f.enemyTeamName = cb_enemyTeamChooser.Text;

            await f.CreateEnemyTeam(f.enemyTeamName);
            await f.SetAwayTeamLabels(f.awayTeam);
            Hide();
        }
    }
}
