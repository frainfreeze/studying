using System.Threading.Tasks;
using System.Windows;

namespace WPFWorldCup
{
    public partial class TeamInfo : Window
    {
        private MainWindow f;

        public TeamInfo(MainWindow f) {
            InitializeComponent();
            this.f = f;
        }

        public async Task SetUp(){
            lbl_teamName.Content = f.team.teamName;
            lbl_teamTag.Content = f.team.teamCode;

            lbl_drawsV.Content = f.team.draws;
            lbl_goalsV.Content = f.team.goals_for;
            lbl_goalsRecivedV.Content = f.team.goals_against;
            lbl_diferenceV.Content = f.team.goals_difference;
            lbl_lossesV.Content = f.team.losses;
            lbl_playedV.Content = (int.Parse(f.team.losses)+ int.Parse(f.team.wins) + int.Parse(f.team.draws));
            lbl_winsV.Content = f.team.wins;
        }
    }
}