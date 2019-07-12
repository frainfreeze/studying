using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace Admin.App_Code.BusinessLayer
{
    public class Repo
    {
        public DataSet ds { get; set; }
        private string cs = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

        public Repo()
        {
        }

        public String UsersForCSV()
        {
            var dt = new DataTable();
            //using (var da = new SqlDataAdapter("SELECT * FROM users", cs))
            //{
            //    da.Fill(dt);
            //}

            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("GetUsersForCSV", con))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                da.Fill(dt);
            }

            StringBuilder sb = new StringBuilder();

            IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().
                                              Select(column => column.ColumnName);
            sb.AppendLine(string.Join(",", columnNames));

            foreach (DataRow row in dt.Rows)
            {
                IEnumerable<string> fields = row.ItemArray.Select(field => field.ToString());
                sb.AppendLine(string.Join(",", fields));
            }

            return sb.ToString();
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