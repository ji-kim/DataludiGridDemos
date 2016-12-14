<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Single Chart</title>
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
        var chart;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName: "term"
        }, {
            fieldName: "ie",
            dataType: "number",
            header: "IE",
        }, {
            fieldName: "firefox",
            dataType: "number",
            header: "Firefox"
        }, {
            fieldName: "chrome",
            dataType: "number",
            header: "Chrome"
        }, {
            fieldName: "safari",
            dataType: "number",
            header: "Safari"
        }, {
            fieldName: "opera",
            dataType: "number",
            header: "Opera"
        }, {
            fieldName: "gecko",
            dataType: "number",
            header: "Gecko"
        }, {
            fieldName: "netscape",
            dataType: "number",
            header: "Netscape"
        } ]);

        // chart
        chart = {
            type: "column",
            legend: {
                visible: true,
                position: "right",
                direction: "vertical",
                marginLeft: 10,
                styles: {
                    /*border: "#800"*/
                }
            },
            plotArea: {
                styles: {
                    background: "#0800ffff"
                }
            },
            xAxes: {
                padding: 0.1,
                margin: 0.2,
                styles: {
                    line: "#333"
                },
                tickStyles: {
                    line: "#333"
                }
            },
            yAxes: {
                baseValue: 0, /*NaN,*/
                frontGrid: {
                    baseStyles: {
                        /*line: "#f00,2px"*/
                    }
                },
                indicators: [{
                    type: "line",
                    front: true,
                    series: "serFemale",
                    value: "avg",
                    label: "Average:${value}",
                    styles: {
                        line: "#600000ff,1px,dotted",
                        color: "#e00000ff",
                        fontSize: 10,
                        fontBold: true,
                        textAlignment: "far",
                        numberFormat: "#,##0"
                    }
                }, {
                    type: "line",
                    front: true,
                    series: "serMale",
                    value: "avg",
                    label: "Average:${value}",
                    styles: {
                        line: "#80ff0000,1px,dashed",
                        color: "#e0800000",
                        fontSize: 10,
                        fontBold: true,
                        textAlignment: "near",
                        numberFormat: "#,##0"
                    }
                }]
            },
            series: [{
                name: "serFemale",
                clusterWidth: 1,
                itemWidth: 1,
                caption: "Female",
                labelField: "year",
                valueField: "value",
                summaryMode: "aggregate",
                labelLocation: "none",
                styles: {
                    background: "#AFD8F8"
                },
                dynamicStyles: [{
                    expression: "value > 80",
                    styles: {
                        background: "#f00"
                    }
                }],
                items: [{
                    year: '2000',
                    value: 53
                }, {
                    year: '2001',
                    value: 73
                }, {
                    year: '2002',
                    value: 83
                }, {
                    year: '2003',
                    value: 63
                }, {
                    year: '2004',
                    value: 71
                }]
            }, {
                name: "serMale",
                caption: "Male",
                labelField: "year",
                valueField: "value",
                summaryMode: "aggregate",
                styles: {
                    background: "#F6BD0F"
                },
                dynamicStyles: [{
                    expression: "value <= min",
                    /*expression: "index == 0",*/
                    styles: {
                        background: "#40F6BD0F",
                        border: "#F6BD0F"
                    }
                }],
                items: [{
                    year: '2000',
                    value: -15
                }, {
                    year: '2001',
                    value: 63
                }, {
                    year: '2002',
                    value: 77
                }, {
                    year: '2003',
                    value: 71
                }, {
                    year: '2004',
                    value: 55
                }]
            }]
        };
        
        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            type: "label",
            header: {
                text: "Column Chart",
                popupMenu: {
                    label: "Grid Version",
                    callback: function () {
                        alert(DataLudi.getVersion());
                    }
                }
            }
        } ]);

        //grid options
        grdMain.setOptions({
            footer: {
                visible: false
            },
            checkBar: {
                visible: false
            },
            display: {
                fitStyle: "fill",
                emptyDataMessage: ''
            },
            headerItems: [{
                type: "chart",
                /*displayLevels: "*",*/
                displayCallback: function (group) {
                    return group.level() == grid.rowGroupLevels();
                },
                minHeight: 150,
                fillHeight: 1,
                styles: {
                    borderRight: null,
                    borderBottom: null,
                    padding: 10
                },
                chart: chart
            }]
        });
                
        grdMain.loadStyles({
            body: {
                borderRight: null
            },
            header: {
                borderRight: null
            }
        });
    });
</script>
</head>
<body>
    <h3>Single Chart</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
</body>
</html>