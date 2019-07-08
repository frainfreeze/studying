using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace PublicSite.App_Code
{
    public class MenuGen
    {
        public DataTable Generate(int NumMeals)
        {
            /*  query for combination info:
                select mn.[Desc],ch.PercentFat,ch.PercentCarb,ch.PercentProtein,ch.Total from CombinationHelper as ch
                inner join Combination as c on ch.IDCombination=c.IDCombination
                inner join MealName as mn on ch.IDMealName=mn.IDMealName
                where c.NumMeals = (int NumMeals)
            */

            DataTable dt = new DataTable();
            
            ////////// start constructing data table header
            dt.Clear();
            dt.Columns.Add("#");
            dt.Columns.Add("Obrok");
            dt.Columns.Add("% masti");

            //SELECT[Desc] FROM Unit

            string querystr = "select IDUSer from [User] where Username='" + Session["UserName"] + "'";
            string cs = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            using (var conn = new SqlConnection(cs))
            using (var cmd = conn.CreateCommand())
            {
                conn.Open();
                cmd.CommandText = querystr;
                Session["UserID"] = cmd.ExecuteScalar();
            }

            ////////// datatable content
            dt.Rows.Add("1", 500);
            return dt;
        }
    }
}