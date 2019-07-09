using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin
{
    public partial class Groceries : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("Login.aspx");
            }
            if (!this.IsPostBack)
            {
                this.BindGrid();
            }
        }

        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            string query = "exec GetGroceries"; //
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
                {
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void Insert(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string kj = txtKJ.Text;
            string kcal = txtKcal.Text;
            string GroceryType = txtGroceryType.Text;
            string Unit = txtUnit.Text;
            string Quantity = txtQuantity.Text;
            string Enabled = txtEnabled.Text;
            txtName.Text = "";
            txtKJ.Text = "";
            txtKcal.Text = "";
            txtGroceryType.Text = "";
            txtUnit.Text = "";
            txtQuantity.Text = "";
            txtEnabled.Text = "";

            string query = "INSERT INTO Grocery VALUES(@Name, @kJ, @kcal, @IDGroceryType, @IDUnit, @Quantity, @Enabled)";
            string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@kJ", kj);
                    cmd.Parameters.AddWithValue("@kcal", kcal);

                    cmd.Parameters.AddWithValue("@IDGroceryType", GroceryType);
                    cmd.Parameters.AddWithValue("@IDUnit", Unit);
                    cmd.Parameters.AddWithValue("@Quantity", Quantity);
                    cmd.Parameters.AddWithValue("@Enabled", Enabled);

                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindGrid();
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            this.BindGrid();
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int IDUnit = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string desc = (row.FindControl("txtDesc") as TextBox).Text;
            string enb = (row.FindControl("txtEnabled") as TextBox).Text;

            string query = "UPDATE [dbo].[Unit] SET [Desc] = @Desc ,[Enabled] = @Enabled WHERE [IDUnit] = @IDUnit";
            string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    cmd.Parameters.AddWithValue("@IDUnit", IDUnit);
                    cmd.Parameters.AddWithValue("@Desc", desc);
                    cmd.Parameters.AddWithValue("@Enabled", enb);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int IDUnit = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string query = "UPDATE [dbo].[Grocery] SET [Enabled] = 0 WHERE IDGrocery=@IDGrocery";
            string constr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    cmd.Parameters.AddWithValue("@IDGrocery", IDUnit);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            this.BindGrid();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridView1.EditIndex)
            {
                (e.Row.Cells[7].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }

        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }
    }
}