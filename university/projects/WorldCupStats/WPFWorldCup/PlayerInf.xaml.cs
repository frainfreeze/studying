using System.Windows;

namespace WPFWorldCup
{
    /// <summary>
    /// Interaction logic for AdditionalPlayerinfo.xaml
    /// </summary>
    public partial class AdditionalPlayerinfo : Window
    {
        public AdditionalPlayerinfo() {
            InitializeComponent();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e) {
            e.Cancel = true;
            Hide();
        }
    }
}
