using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
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
                string timeInterval = ConfigurationManager.AppSettings["Interval"];
                int timerInterval;
                if (int.TryParse(timeInterval, out timerInterval))
                {
                    Timer1.Interval = timerInterval;
                }
                else
                {
                    Timer1.Interval = 10000;
                }
                ContentUpdate();
            }
        }

        protected void ContentUpdate()
        {
            try
            {
                Values = DBUtil.GetDetails();

                List<string> names = new List<string>()
                {
                    "Cumulative Target Qty.",
                    "Cumulative Production Qty.",
                    "ShortFall Qty.",
                    "Rejection Qty.",
                    "Rework Qty."
                };

                // Create a list of objects that contain both the values and the names
                var data = Values.Zip(names, (value, name) => new { Value = value, Name = name }).ToList();

                // Get the index of the last displayed value from Session or initialize it
                int lastIndex = Session["LastIndex"] != null ? (int)Session["LastIndex"] : 0;

                // Select the next 5 values based on the last index
                var valuesToDisplay = data.Skip(lastIndex).Take(5).ToList();

                // Bind these values to the Repeater
                listview.DataSource = valuesToDisplay;
                listview.DataBind();

                // Update the last index in Session
                Session["LastIndex"] = lastIndex + 5;

                // If all values are displayed, reset the session index
                if ((int)Session["LastIndex"] >= Values.Count)
                {
                    Session["LastIndex"] = 0;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            ContentUpdate();
        }
    }
}