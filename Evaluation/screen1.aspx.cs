using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Evaluation
{
    public partial class screen1 : System.Web.UI.Page
    {
        public List<double> Values { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Values = DBUtil.GetDetails(out List<string> names);

                // Create a list of objects that contain both the values and the names
                var data = Values.Zip(names, (value, name) => new { Value = value, Name = name }).ToList();

                // Get the index of the last displayed value from Session or initialize it
                int lastIndex = Session["LastIndex"] != null ? (int)Session["LastIndex"] : 0;

                // Select the next 5 values based on the last index
                var valuesToDisplay = data.Skip(lastIndex).Take(5).ToList();

                // Bind these values to the Repeater
                Repeater1.DataSource = valuesToDisplay;
                Repeater1.DataBind();

                // Update the last index in Session
                Session["LastIndex"] = lastIndex + 5;

                // If all values are displayed, reset the session index
                if ((int)Session["LastIndex"] >= Values.Count)
                {
                    Session["LastIndex"] = 0;
                }
            }
        }
    }
}