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
            <div class="header" style="height: 70px">
                <img src="https://thumbs.dreamstime.com/b/fishing-boat-fish-seagull-wave-steering-wheel-circle-frame-shape-logo-icon-outline-stroke-set-dash-line-design-illustration-120756140.jpg" alt="logo" width="100" />
                <h2 style="position: absolute;left: 45%;">Andon</h2>
                <div style="display:flex;align-items:center">
                    <div class="sideHeader">
                        <h4 style="margin-bottom:0px"><%= DateTime.Now.ToString("dd-MMM-yy HH:mm") %></h4>
                        <h4 style="margin-top:10px">SHIFT-B</h4>
                    </div>
                    <img src="/Images/Rsc3.png" alt="logo" width="70" height="50" style="margin-right:10px" />
                    <img src="/Images/unnamedsc3.png" alt="logo" width="100" height="65" />
                </div>

            </div>

            <div id="container">
            </div>

            <div id="container1" style="margin-top: 20px">
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
        if (localStorage.getItem('chartData')) {
            var chartData = JSON.parse(localStorage.getItem('chartData'));
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
        }
        else {
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
                    var total = data.DownTime.reduce((a, b) => a + b, 0); // Calculate the total downtime
                    for (var i = 0; i < data.DownId.length; i++) {
                        let percentage = (data.DownTime[i] / total) * 100; // Calculate the percentage
                        chartData.push({
                            name: data.DownId[i] + " : " + data.DownTime[i] + " (" + percentage.toFixed(2) + "%)",
                            y: data.DownTime[i]
                        });
                    }

                    // Save the chart data to localStorage
                    localStorage.setItem('chartData', JSON.stringify(chartData));

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
        }

    </script>

    <script type="text/javascript">
        if (localStorage.getItem('chartData1')) {
            var data = JSON.parse(localStorage.getItem('chartData1'));

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
                    categories: data.DownId,
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
                    data: data.DownTime,
                    dataLabels: {
                        enabled: true,
                        format: '{point.y:.2f}',
                        align: 'center',
                        y: -10
                    }
                }]
            });
        }
        else {
            $.ajax({
                async: true,
                type: "POST",
                url: "Screen3.aspx/GetChartData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Extract the data from the response
                    var data = response.d;

                    // Save the chart data to localStorage
                    localStorage.setItem('chartData1', JSON.stringify(data));

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
                            categories: data.DownId,
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
                            data: data.DownTime,
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
        }
    </script>
</body>
</html>
