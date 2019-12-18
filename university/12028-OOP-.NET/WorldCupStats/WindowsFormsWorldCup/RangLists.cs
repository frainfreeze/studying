using DataLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsWorldCup
{
    public partial class RangLists : Form
    {
        MainForm f;
        
        public RangLists(MainForm f)
        {
            InitializeComponent();
            this.f = f;
        }

        public async void prepareRankedPlayersAndMatches()
        {
            dgv_StartingElevenYellowCardsGoals.Rows.Clear();
            dgv_substitues.Rows.Clear();
            dgv_matches.Rows.Clear();
            Image i = Image.FromFile(@"..\..\..\static\player.png");

            foreach (var p in f.team.firsteleven)
            {
                dgv_StartingElevenYellowCardsGoals.Rows.Add(
                    new object[] {
                        i,
                        (f.team.players[p].captain?"C":""),
                        (f.team.players[p].favorite?"★":""),
                        f.team.players[p].name,
                        f.team.players[p].cards,
                        f.team.players[p].goals,
                    });
            }
            foreach (var p in f.team.substitutions)
            {
                dgv_substitues.Rows.Add(
                    new object[] {
                        i,
                        (f.team.players[p].captain?"C":""),
                        (f.team.players[p].favorite?"★":""),
                        f.team.players[p].name,
                        f.team.players[p].cards,
                        f.team.players[p].goals,
                    });
            }

            foreach (Match m in f.team.matches)
            {
                dgv_matches.Rows.Add(
                    new object[]
                    {
                        m.Location,
                        m.Attendance,
                        m.Home_team,
                        m.Away_team
                    });
            }

        }

        private void RangLists_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(e.CloseReason == CloseReason.UserClosing)
            {
                e.Cancel = true;
                Hide();
            }
        }
    }
}
