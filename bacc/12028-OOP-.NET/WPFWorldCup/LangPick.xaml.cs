using System.Windows;

namespace WPFWorldCup
{
    public partial class ChooseLanguage : Window
    {
        private MainWindow f;
        public bool first = true;
        public ChooseLanguage(MainWindow f) {
            InitializeComponent();
            this.f = f;
        }

        private async void Btn_languageENG_Click(object sender, RoutedEventArgs e) {
            f.lng ="ENG";
            Hide();
            await f.changeLanguageToENG();
            if (first) {
                f.initialSettingsForm.Show();
                first = false;
            }
        }

        private async void Btn_languageCRO_Click(object sender, RoutedEventArgs e) {
            f.lng = "CRO";
            Hide();
            await f.changeLanguageToCRO();
            if (first) {
                f.initialSettingsForm.Show();
                first = false;
            }
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e) {
            e.Cancel = true;
            Hide();
        }
    }
}
