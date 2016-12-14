<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Pie Series</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;
        var refreshChart = function(ev) {
            var item = grdMain.headerItems().getItem(0);
            item.setChart(chart);
            item.refresh();
        };
        var chart = {
            type : "pie",
            legend : {
                visible : true,
                position : "right",
                direction : "vertical",
                marginLeft : 10,
                styles : {
                /*border: "#800"*/
                }
            },
            plotArea : {
                styles : {
                    background : "#0800ffff",
                    border : '#800000ff,1px,dashed'
                }
            },
            series : [ {
                name : "serFemale",
                caption : "Female",
                labelField : "year",
                valueField : "value",
                summaryMode : "aggregate",
                labelLocation : "none",
                styles : {
                    background : "#AFD8F8",
                    border : "#fff,2px"
                },
                dynamicStyles : [ {
                    expression : "value > 80",
                    styles : {
                        background : "#f00"
                    }
                } ],
                items : [ {
                    year : '2000',
                    value : 43
                }, {
                    year : '2001',
                    value : 65
                }, {
                    year : '2002',
                    value : 83,
                    sliced : true
                }, {
                    year : '2003',
                    value : 57
                }, {
                    year : '2004',
                    value : 71
                } ]
            } ]
        };

        // grid
        var columns = [ {
            type : "label",
            header : {
                text : "Pie 시리즈",
                popupMenu : {
                    label : "Grid Version",
                    callback : function() {
                        alert(DataLudi.getVersion());
                    }
                }
            }
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);

        //grid options
        grdMain.setOptions({
            footer : {
                visible : false
            },
            checkBar : {
                visible : false
            },
            display : {
                fitStyle : "fill",
                emptyDataMessage : ''
            },
            headerItems : [ {
                type : "chart",
                /*displayLevels: "*",*/
                displayCallback : function(group) {
                    return group.level() == grid.rowGroupLevels();
                },
                minHeight : 150,
                fillHeight : 1,
                styles : {
                    borderRight : null,
                    borderBottom : null,
                    padding : 10
                },
                chart : chart
            } ]
        });

        grdMain.loadStyles({
            body : {
                borderRight : null
            },
            header : {
                borderRight : null
            }
        });

        // buttons
        $('#btnChangeRadius').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.radius += 0.01;
                item.setChart(chart);
                item.refresh();
                if (ser.radius >= 0.8)
                    clearInterval(t);
            }, 40);
            ser.radius = 0.3;
        });
        $('#btnChangeInnerRadius').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.innerRadius += 0.01;
                item.setChart(chart);
                item.refresh();
                if (ser.innerRadius >= 0.95)
                    clearInterval(t);
            }, 40);
            ser.innerRadius = 0;
        });
        $('#btnStartAngle').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.startAngle += 10;
                item.setChart(chart);
                item.refresh();
                if (ser.startAngle >= 360)
                    clearInterval(t);
            }, 40);
            ser.startAngle = 0;
        });
        $('#btnTotalAngle').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.totalAngle += 10;
                item.setChart(chart);
                item.refresh();
                if (ser.totalAngle >= 360)
                    clearInterval(t);
            }, 40);
            ser.totalAngle = 0;
        });
        $('#btnLabelOffset').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.labelOffset++;
                item.setChart(chart);
                item.refresh();
                if (ser.labelOffset >= 30)
                    clearInterval(t);
            }, 40);
            ser.labelOffset = 0;
        });
        $('#btnTickLength').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.tickLength++;
                item.setChart(chart);
                item.refresh();
                if (ser.tickLength >= 50)
                    clearInterval(t);
            }, 40);
            ser.tickLength = 0;
        });
        $('#btnOffsetRight').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.offsetX += 0.02;
                item.setChart(chart);
                item.refresh();
                if (ser.offsetX >= start + 0.3)
                    clearInterval(t);
            }, 40);
            if (isNaN(ser.offsetX))
                ser.offsetX = 0;
            var start = ser.offsetX;
        });
        $('#btnOffsetLeft').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.offsetX -= 0.02;
                item.setChart(chart);
                item.refresh();
                if (ser.offsetX <= start - 0.3)
                    clearInterval(t);
            }, 40);
            if (isNaN(ser.offsetX))
                ser.offsetX = 0;
            var start = ser.offsetX;
        });
        $('#btnOffsetBottom').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.offsetY += 0.02;
                item.setChart(chart);
                item.refresh();
                if (ser.offsetY >= start + 0.3)
                    clearInterval(t);
            }, 40);
            if (isNaN(ser.offsetY))
                ser.offsetY = 0;
            var start = ser.offsetY;
        });
        $('#btnOffsetTop').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.offsetY -= 0.02;
                item.setChart(chart);
                item.refresh();
                if (ser.offsetY <= start - 0.3)
                    clearInterval(t);
            }, 40);
            if (isNaN(ser.offsetY))
                ser.offsetY = 0;
            var start = ser.offsetY;
        });
        $('#btnRadiusRateInc').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.radiusRate += 0.01;
                item.setChart(chart);
                item.refresh();
                if (ser.radiusRate >= start + 0.3)
                    clearInterval(t);
            }, 40);
            if (isNaN(ser.radiusRate))
                ser.radiusRate = 1;
            var start = ser.radiusRate;
        });
        $('#btnRadiusRateDec').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                var item = grdMain.headerItems().getItem(0);
                ser.radiusRate -= 0.01;
                item.setChart(chart);
                item.refresh();
                if (ser.radiusRate <= start - 0.3)
                    clearInterval(t);
            }, 40);
            if (isNaN(ser.radiusRate))
                ser.radiusRate = 1;
            var start = ser.radiusRate;
        });
        $('#btnReset').click(function() {
            var item = grdMain.headerItems().getItem(0);
            var ser = chart.series[0];

            ser.tickLength = 7;
            ser.labelOffset = 7;
            ser.slicedOffset = 10;
            ser.radius = 0.6;
            ser.innerRadius = 0;
            ser.radiusRate = 1;
            ser.offsetX = ser.offsetY = 0;

            item.setChart(chart);
            item.refresh();
        });
    });
</script>
</head>
<body>
    <h3>Column Series</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <button id="btnChangeRadius">Change Radius</button>
    <br>
    <button id="btnChangeInnerRadius">Change Inner Radius</button>
    <br>
    <button id="btnStartAngle">Start Angle</button>
    <br>
    <button id="btnTotalAngle">Total Angle</button>
    <br>
    <button id="btnLabelOffset">Label Offset</button>
    <br>
    <button id="btnTickLength">Tick Length</button>
    <br>
    <button id="btnOffsetRight">Offset Right</button>
    <button id="btnOffsetLeft">Offset Left</button>
    <br>
    <button id="btnOffsetBottom">Offset Bottom</button>
    <button id="btnOffsetTop">Offset Top</button>
    <br>
    <button id="btnRadiusRateInc">Inc Radius Rate</button>
    <button id="btnRadiusRateDec">Dec Radius Rate</button>
    <br>
    <button id="btnReset">Reset Chart</button>
</body>
</html>