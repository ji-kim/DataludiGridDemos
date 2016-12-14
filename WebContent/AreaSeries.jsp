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
        var chart = {
            type : "area",
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
                    background : "#0800ffff"
                }
            },
            xAxes : {
                /*
                //baseValue: null,
                //firstIndent: -0.5,
                //lastIndent: -0.5,
                 */
                styles : {
                    line : "#999"
                },
                tickStyles : {
                    line : "#999"
                }
            },
            yAxes : {
                padding : 0.1,
                frontGrid : {
                    baseStyles : {
                    /*line: "#f00,2px"*/
                    }
                },
                styles : {
                    line : null
                },
                indicators : [ {
                    type : "line",
                    front : true,
                    series : "serFemale",
                    value : "avg",
                    label : "Average:${value}",
                    styles : {
                        line : "#600000ff,1px,dotted",
                        color : "#e00000ff",
                        fontSize : 10,
                        fontBold : true,
                        textAlignment : "near",
                        numberFormat : "#,##0"
                    }
                }, {
                    type : "line",
                    front : true,
                    series : "serMale",
                    value : "avg",
                    label : "Average:${value}",
                    styles : {
                        line : "#80ff0000,1px,dashed",
                        color : "#e0800000",
                        fontSize : 10,
                        fontBold : true,
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    }
                } ]
            },
            series : [ {
                name : "serFemale",
                clusterWidth : 1,
                itemWidth : 1,
                caption : "Female",
                labelField : "year",
                valueField : "value",
                summaryMode : "aggregate",
                /*labelLocation: "none",*/
                styles : {
                    background : "#30AFA8AF",
                    shapeName : "diamond",
                    shapeColor : "#7F787F"
                },
                dynamicStyles : [ {
                    expression : "value > 80",
                    styles : {
                        background : "#f00"
                    }
                } ],
                items : [ {
                    year : '2000',
                    value : 33
                }, {
                    year : '2001',
                    value : 57
                }, {
                    year : '2002',
                    value : 63
                }, {
                    year : '2003',
                    value : 57
                }, {
                    year : '2004',
                    value : 51
                }, {
                    year : '2005',
                    value : 61
                }, {
                    year : '2006',
                    value : 53
                }, {
                    year : '2007',
                    value : 45
                }, {
                    year : '2008',
                    value : 130
                } ]
            }, {
                name : "serMale",
                caption : "Male",
                labelField : "year",
                valueField : "value",
                summaryMode : "aggregate",
                lineType : "curved",
                styles : {
                    background : "#3046aDFF",
                    shapeName : "itriangle",
                    shapeColor : "#ff46aDFF"
                },
                dynamicStyles : [ {
                    expression : "index == 0",
                    styles : {}
                } ],
                items : [ {
                    year : '2000',
                    value : 45
                }, {
                    year : '2001',
                    value : 51
                }, {
                    year : '2002',
                    value : 67
                }, {
                    year : '2003',
                    value : 71
                }, {
                    year : '2004',
                    value : 65
                }, {
                    year : '2005',
                    value : 75
                }, {
                    year : '2006',
                    value : 63
                }, {
                    year : '2007',
                    value : 57
                }, {
                    year : '2008',
                    value : 67
                } ],
                label : {
                    offsetX : 0,
                    offsetY : 0
                }
            } ]
        };

        // grid
        var columns = [ {
            type : "label",
            header : {
                text : "Area 시리즈",
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
        $('#btnLocationRate').click(function() {
            var item = grdMain.headerItems().getItem(0);
            var ser = chart.series[0];
            var t = setInterval(function() {
                ser.locationRate += 0.02;
                item.setChart(chart);
                item.refresh();
                if (ser.locationRate >= 1)
                    clearInterval(t);
            }, 20);
            ser.locationRate = 0;

            var ser2 = chart.series[1];
            var t2 = setInterval(function() {
                ser2.locationRate += 0.02;
                item.setChart(chart);
                item.refresh();
                if (ser2.locationRate >= 1)
                    clearInterval(t2);
            }, 30);
            ser2.locationRate = 0;
        });
        $('#btnLabelOffsetY').click(function() {
            var item = grdMain.headerItems().getItem(0);
            var label = chart.series[1].label;
            var t = setInterval(function() {
                label.offsetY += 2;
                item.setChart(chart);
                item.refresh();
                if (label.offsetY >= 100)
                    clearInterval(t);
            }, 20);
            label.offsetY = 0;
        });
        $('#btnAxisIndents').click(function() {
            var item = grdMain.headerItems().getItem(0);
            var axis = chart.xAxes;
            var t = setInterval(function() {
                axis.firstIndent = axis.lastIndent -= 0.01;
                item.setChart(chart);
                item.refresh();
                if (axis.firstIndent <= -0.5)
                    clearInterval(t);
            }, 20);
            axis.firstIndent = axis.lastIndent = 0;
        });
        $('#btnReset').click(function() {
            var item = grdMain.headerItems().getItem(0);
            var axis = chart.xAxes;
            axis.firstIndent = axis.lastIndent = 0;
            chart.series[0].locationRate = 1;
            chart.series[1].locationRate = 1;
            chart.series[1].label.offsetY = 0;
            item.setChart(chart);
            item.refresh();
        });
    });
</script>
</head>
<body>
    <h3>Column Series</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <button id="btnLocationRate">Location Rate</button>
    <br>
    <button id="btnLabelOffsetY">Label OffsetY</button>
    <br>
    <button id="btnAxisIndents">Axis Indents</button>
    <br>
    <button id="btnReset">Reset Chart</button>
</body>
</html>