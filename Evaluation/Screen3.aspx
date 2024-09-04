<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Screen3.aspx.cs" Inherits="Evaluation.Screen3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/Screen3.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="header">
                <img src="https://thumbs.dreamstime.com/b/fishing-boat-fish-seagull-wave-steering-wheel-circle-frame-shape-logo-icon-outline-stroke-set-dash-line-design-illustration-120756140.jpg" alt="logo" width="100" />
                <h2>Andon</h2>

                <img src="https://lh4.googleusercontent.com/proxy/9b83RQ-kKbWb7Y_JL8We9IxDGgWgHoIlseLox_99ywF3sapKoWsT7cu4n06i2xykxhsa7YQ3jUS3surMzW7kzpTuJFAHLB8" alt="logo" width="200" height="95" />
            </div>

            <div id="container">

            </div>
            
            <div id="container1" style="margin-top:20px">

            </div>
        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
     <script src="https://code.highcharts.com/modules/pareto.js"></script>

    <script type="text/javascript">
        $.ajax({
            async: true,
            type: "POST",
            url: "Screen3.aspx/GetChartData",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                // Extract the data from the response
                var data = response.d;

                // Create an array of objects for the Highcharts data
                var chartData = [];
                var total = data.downtime.reduce((a, b) => a + b, 0); // Calculate the total downtime
                for (var i = 0; i < data.downid.length; i++) {
                    let percentage = (data.downtime[i] / total) * 100; // Calculate the percentage
                    chartData.push({
                        name: data.downid[i] + " : " + data.downtime[i] + " (" + percentage.toFixed(2) + "%)", 
                        y: data.downtime[i]
                    });
                }


                // Render the Highcharts chart with the fetched data
                Highcharts.chart('container', {
                    chart: {
                        type: 'pie'
                    },
                    title: {
                        text: 'DownID vs DownTime'
                    },
                    plotOptions: {
                        series: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: [{
                                enabled: true,
                                distance: 20
                                },
                                {
                                enabled: true,
                                distance: -40,
                                format: '{point.percentage:.1f}%',
                                style: {
                                    fontSize: '1.2em',
                                    textOutline: 'none',
                                    opacity: 0.7
                                },
                                filter: {
                                    operator: '>',
                                    property: 'percentage',
                                    value: 10
                                }
                            }]
                        }
                    },
                    series: [
                        {
                            name: 'DownTime',
                            colorByPoint: true,
                            data: chartData
                        }
                    ]
                });
            },
            error: function (error) {
                console.error("Error: " + error);
            }
        });

    </script>

    <script type="text/javascript">
        $.ajax({
            async: true,
            type: "POST",
            url: "Screen3.aspx/GetChartData",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                // Extract the data from the response
                var data = response.d;
                Highcharts.chart('container1', {
                    chart: {
                        renderTo: 'container1',
                        type: 'column'
                    },
                    title: {
                        text: 'DownID vs DownTime'
                    },
                    tooltip: {
                        shared: true
                    },
                    xAxis: {
                        categories: data.downid,
                        crosshair: true
                    },
                    yAxis: [{
                        title: {
                            text: ''
                        }
                    }, {
                        title: {
                            text: ''
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
                        tooltip: {
                            valueDecimals: 2,
                            valueSuffix: '%'
                        },
                        dataLabels: {
                            enabled: true,
                            format: '{point.y:.2f}%',
                            align: 'center',
                            y: -10
                        }
                    }, {
                        name: 'DownTime',
                        type: 'column',
                        zIndex: 2,
                        data: data.downtime,
                        dataLabels: {
                            enabled: true,
                            format: '{point.y:.2f}',
                            align: 'center',
                            y: -10
                        }
                    }]
                });
            },
            error: function (error) {
                console.error("Error: " + error);
            }
        });
    </script>
</body>
</html>
