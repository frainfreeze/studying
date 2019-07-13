using System.Windows;

namespace WPFWorldCup
{
    public partial class Initialsettings : Window
    {
        private MainWindow f;

        public Initialsettings(MainWindow mainWindow) {
            InitializeComponent();
            f = mainWindow;
        }

        private void Btn_fullscreen_Click(object sender, RoutedEventArgs e) {
            f.WindowState = WindowState.Maximized;
            f.windowsState = "fullscreen";
            Hide();
            f.showTeamChooser();
        }

        private void Btn_notFullscreen_Click(object sender, RoutedEventArgs e) {
            f.WindowState = WindowState.Normal;
            f.windowsState = "normal";
            Hide();
            f.showTeamChooser();
        }
    }
}
