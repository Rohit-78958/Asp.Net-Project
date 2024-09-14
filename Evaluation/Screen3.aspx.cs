using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Evaluation
{
    public class ChartData
    {
        public List<string> DownId { get; set; }
        public List<double> DownTime { get; set; }
    }


    public partial class Screen3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "loadChart1", "$(document).ready(function () {loadPieChart(); });", true);
                ClientScript.RegisterStartupScript(this.GetType(), "loadChart2", "$(document).ready(function () {loadParetoChart(); });", true);
            }
        }


        [System.Web.Services.WebMethod]
        public static ChartData GetChartData(string fromDate="", string toDate="")
        {
            // Data to be returned to the client-side Highcharts function
            try
            {
                // Fetch data from DBUtil
                var downTime = DBUtil.ChartsDetails(out List<string> downId, fromDate, toDate);

                // Zip DownId and DownTime into a single collection for sorting
                var zippedData = downId.Zip(downTime, (id, time) => new { DownId = id, DownTime = time });

                // Sort by DownTime in descending order
                var sortedData = zippedData.OrderByDescending(item => item.DownTime).ToList();

                // Unzip sorted data back into two lists
                var sortedDownId = sortedData.Select(item => item.DownId).ToList();
                var sortedDownTime = sortedData.Select(item => item.DownTime).ToList();

                // Create and return the ChartData object with sorted lists
                var data = new ChartData
                {
                    DownId = sortedDownId,
                    DownTime = sortedDownTime
                };

                return data;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }
    }
}