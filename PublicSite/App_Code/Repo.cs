using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace PublicSite.App_Code
{
    public class Repo
    {
        private string cs = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

        public Repo()
        {
        }

        public int ValidateUser(object usr, object pwd)
        {
            int userId = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("Validate_User"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", usr);
                    cmd.Parameters.AddWithValue("@Password", pwd);
                    cmd.Connection = con;
                    con.Open();
                    userId = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                }
                return userId;
            }
        }
    }
}