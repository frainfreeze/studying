using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Admin.App_Code.BusinessLayer;

namespace Admin
{
    public partial class _Default : Page
    {
        Repo repo = new Repo();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string s = repo.UsersForCSV();

            Response.Clear();
            Response.AddHeader("content-disposition", "attachment; filename=testfile.csv");
            Response.AddHeader("content-type", "text/plain");

            using (StreamWriter writer = new StreamWriter(Response.OutputStream))
            {
                writer.WriteLine(s);
            }
            Response.End();
        }
    }
}