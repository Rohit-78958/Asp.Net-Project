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

        }


        [System.Web.Services.WebMethod]
        public static ChartData GetChartData()
        {
            // Data to be returned to the client-side Highcharts function
            try
            {
                var downTime = DBUtil.ChartsDetails(out List<string> downId);

                var data = new ChartData
                {
                    DownId = downId,
                    DownTime = downTime
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