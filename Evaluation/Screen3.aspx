<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Screen3.aspx.cs" Inherits="Evaluation.Screen3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/Screen3.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <script src="https://code.highcharts.com/modules/pareto.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="header" style="height: 60px">
                <img src="https://thumbs.dreamstime.com/b/fishing-boat-fish-seagull-wave-steering-wheel-circle-frame-shape-logo-icon-outline-stroke-set-dash-line-design-illustration-120756140.jpg" alt="logo" width="60" />
                <h4 style="position: absolute; left: 45%;">Andon</h4>
                <div style="display: flex; align-items: center">
                    <div class="sideHeader">
                        <h6 style="margin-bottom: 0px"><%= DateTime.Now.ToString("dd-MMM-yy HH:mm") %></h6>
                        <h6 style="margin-top: 10px">SHIFT-B</h6>
                    </div>
                    <img src="/Images/Rsc3.png" alt="logo" width="60" height="50" style="margin-right: 10px" />
                    <img src="/Images/unnamedsc3.png" alt="logo" width="140" height="60" />
                </div>

            </div>
            <div class="dates">
                From Date
            <div class="form-group">
                <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" CssClass="form-control" Text="2024-04-01"></asp:TextBox>
            </div>
                To Date
            <div class="form-group">
                <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" CssClass="form-control" Text="2024-07-01"></asp:TextBox>
            </div>
                <div class="form-group">
                    <asp:DropDownList ID="ddlcharts" runat="server" CssClass="form-control">
                        <asp:ListItem>Pie Chart</asp:ListItem>
                        <asp:ListItem>Pareto Chart</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <asp:Button ID="Button1" runat="server" Text="View" CssClass="btn btn-primary" />
            </div>


            <div id="container"></div>

            <div id="container1" style="margin-top: 20px"></div>
        </div>
    </form>

    <script type="text/javascript">

        // Function to handle button click and load the selected chart
        document.getElementById('<%= Button1.ClientID %>').addEventListener('click', function (e) {
            e.preventDefault(); // Prevent default form submission

            // Get the selected chart type from the dropdown
            var selectedChart = document.getElementById('<%= ddlcharts.ClientID %>').value;

            // Get the fromDate and toDate values
            var fromDate = document.getElementById('<%= txtFromDate.ClientID %>').value;
            var toDate = document.getElementById('<%= txtToDate.ClientID %>').value;

            if (selectedChart === "Pie Chart") {
                loadPieChart(fromDate, toDate);
            } else if (selectedChart === "Pareto Chart") {
                loadParetoChart(fromDate, toDate);
            }
        });


        // Helper function to convert minutes to HH:MM format
        function minutesToHHMM(minutes) {
            var hours = Math.floor(minutes / 60);
            var mins = Math.round(minutes % 60);
            return hours.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0');
        }

        function loadParetoChart(fromDate="", toDate="") {
            $.ajax({
                async: true,
                type: "POST",
                url: "Screen3.aspx/GetChartData",
                data: JSON.stringify({ fromDate: fromDate, toDate: toDate }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var data = response.d;

                    if (data.DownId.length === 0 || data.DownTime.length === 0) {
                        // Show 'No Data' message
                        $('#container1').html('<h3>No Data Available for Pareto chart.</h3>');
                        return;
                    }

                    Highcharts.chart('container1', {
                        credits: {
                            enabled: false  // Disable the highcharts.com link
                        },
                        chart: {
                            renderTo: 'container1',
                            type: 'column'
                        },
                        title: {
                            text: 'DownID vs DownTime'
                        },
                        tooltip: {
                            shared: true,
                            formatter: function () {
                                var points = this.points;
                                var pointsLength = points.length;
                                var tooltipMarkup = pointsLength ? '<span style="font-size: 10px">' + points[0].key + '</span><br/>' : '';
                                var index;
                                var downlownTime = points[1].y; // Get downtime value

                                for (index = 0; index < pointsLength; index += 1) {
                                    var point = points[index];
                                    var series = point.series;

                                    tooltipMarkup += '<span style="color:' + series.color + '">\u25CF</span> ' + series.name + ': ';

                                    if (series.name === 'DownTime') {
                                        tooltipMarkup += minutesToHHMM(point.y) + ' (HH:MM)<br/>';
                                    } else {
                                        tooltipMarkup += point.y.toFixed(2) + '%<br/>';
                                    }
                                }

                                return tooltipMarkup;
                            }
                        },
                        xAxis: {
                            categories: data.DownId,
                            crosshair: true
                        },
                        yAxis: [{
                            title: {
                                text: 'DownTime (HH:MM)'
                            },
                            labels: {
                                formatter: function () {
                                    return minutesToHHMM(this.value);
                                }
                            }
                        }, {
                            title: {
                                text: 'Pareto (%)'
                            },
                            minPadding: 0,
                            maxPadding: 0,
                            max: 100,
                            min: 0,
                            opposite: true,
                            labels: {
                                format: '{value}%'
                            }
                        }],
                        series: [{
                            type: 'pareto',
                            name: 'Pareto',
                            yAxis: 1,
                            zIndex: 10,
                            baseSeries: 1,
                            colorByPoint: true
                        }, {
                            name: 'DownTime',
                            type: 'column',
                            zIndex: 2,
                            data: data.DownTime,
                            dataLabels: {
                                enabled: true,
                                formatter: function () {
                                    return minutesToHHMM(this.y);
                                },
                                align: 'center',
                                y: -10
                            },
                            colorByPoint: true
                        }]
                    });
                },
                error: function (error) {
                    console.error("Error: " + error);
                }
            });
        }

        function loadPieChart(fromDate="", toDate="") {
            $.ajax({
                async: true,
                type: "POST",
                url: "Screen3.aspx/GetChartData",
                data: JSON.stringify({ fromDate: fromDate, toDate: toDate }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var data = response.d;

                    if (data.DownId.length === 0 || data.DownTime.length === 0) {
                        // Show 'No Data' message
                        $('#container').html('<h3>No Data Available for Pie chart.</h3>');
                        return;
                    }

                    var chartData = [];
                    var total = data.DownTime.reduce((a, b) => a + b, 0);
                    for (var i = 0; i < data.DownId.length; i++) {
                        let percentage = (data.DownTime[i] / total) * 100;
                        chartData.push({
                            name: data.DownId[i],
                            y: data.DownTime[i],
                            percentage: percentage
                        });
                    }

                    Highcharts.chart('container', {
                        credits: {
                            enabled: false  // Disable the highcharts.com link
                        },
                        chart: {
                            type: 'pie'
                        },
                        title: {
                            text: 'DownID vs DownTime'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: {point.downTimeFormatted}'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    format: '<b>{point.name}</b>: {point.downTimeFormatted} ({point.percentage:.1f}%)',
                                    style: {
                                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                    }
                                }
                            }
                        },
                        series: [{
                            name: 'DownTime',
                            colorByPoint: true,
                            data: chartData.map(item => ({
                                name: item.name,
                                y: item.y,
                                percentage: item.percentage,
                                downTimeFormatted: minutesToHHMM(item.y)
                            }))
                        }]
                    });
                },
                error: function (error) {
                    console.error("Error: " + error);
                }
            });
        }
    </script>
</body>
</html>
