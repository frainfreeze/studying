using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PublicSite.App_Code
{
    public class MenuGen
    {
        public void Generate(int NumMeals)
        {
            /*  query for combination info:
                select mn.[Desc],ch.PercentFat,ch.PercentCarb,ch.PercentProtein,ch.Total from CombinationHelper as ch
                inner join Combination as c on ch.IDCombination=c.IDCombination
                inner join MealName as mn on ch.IDMealName=mn.IDMealName
                where c.NumMeals = (int NumMeals)
            */
        }
    }
}