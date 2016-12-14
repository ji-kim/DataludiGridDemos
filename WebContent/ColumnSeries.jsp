<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Series</title>
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

        var grdMain, grdMain2;
        var dsMain;
        var refreshChart = function(g, c) {
            var item = (g || grdMain).headerItems().getItem(0);
            item.setChart(c || chart);
            item.refresh();
        };
        var chart = {
            type : "column",
            plotArea : {
                styles : {
                    background : "#0800ffff"
                }
            },
            xAxes : {
                firstIndent : 0.2,
                lastIndent : 0.2,
                styles : {
                    line : "#333"
                },
                tickStyles : {
                    line : "#333"
                }
            },
            yAxes : {
                baseValue : 0,
                frontGrid : {
                    baseStyles : {}
                }
            },
            series : [ {
                name : "serFemale",
                itemWidth : 0.7,
                caption : "Female",
                labelField : "year",
                valueField : "value",
                summaryMode : "aggregate",
                itemDisplayOrder : "first",
                label : {
                    position : "far",
                    verticalAlign : "bottom",
                    offsetY : 8,
                    offsetX : 0,
                    styles : {
                        color : "#fff",
                        textShadow : "#000",
                        fontSize : 15,
                        prefix : "$"
                    }
                },
                styles : {
                    border : null,
                    background : 'p(pal_color:index)'
                },
                items : [ {
                    year : '2000',
                    value : 53
                }, {
                    year : '2001',
                    value : 73
                }, {
                    year : '2002',
                    value : 83
                }, {
                    year : '2003',
                    value : 63
                }, {
                    year : '2004',
                    value : 71
                } ]
            } ]
        };

        var chart2 = {
            type : "column",
            legend : {
                visible : true,
                position : "right",
                direction : "vertical",
                marginLeft : 5,
                styles : {
                    fontItalic : true
                /*border: "#800"*/
                }
            },
            plotArea : {
                styles : {
                    background : null
                }
            },
            xAxes : {
                firstIndent : 0,
                lastIndent : 0,
                padding : 0.1,
                styles : {
                    line : "#333"
                },
                tickStyles : {
                    line : "#333"
                }
            },
            yAxes : {
                baseValue : 0,
                title : {
                    text : "Revenue"
                },
                grid : {
                    styles : {
                        line : "#ccc,1px,dotted"
                    }
                },
                styles : {
                    line : null
                }
            },
            series : [ {
                name : "serFemale",
                clusterWidth : 2,
                itemWidth : 1,
                caption : "Female",
                labelField : "year",
                valueField : "value",
                summaryMode : "aggregate",
                //labelLocation: "none",
                label : {
                    position : "far",
                    offsetY : 2,
                    offsetX : 0,
                    //horizontalAlign: "right",
                    styles : {
                        fontSize : 13
                    },
                    dynamicStyles : [ {
                        expression : "value >= 80",
                        styles : {
                            fontSize : 20,
                            color : "#fff",
                            background : "#000",
                            paddingLeft : 4,
                            paddingRight : 4,
                            paddingTop : 4,
                            paddingBottom : 4
                        }
                    } ]
                },
                styles : {
                    background : "#AFD8F8"
                },
                dynamicStyles : [ {
                    expression : "value > 80",
                    styles : {
                        background : "#f00"
                    }
                } ],
                items : [ {
                    year : '2000',
                    value : 53
                }, {
                    year : '2001',
                    value : 73
                }, {
                    year : '2002',
                    value : 83
                }, {
                    year : '2003',
                    value : 63
                }, {
                    year : '2004',
                    value : 71
                } ]
            }, {
                name : "serMale",
                caption : "Male",
                labelField : "year",
                valueField : "value",
                summaryMode : "aggregate",
                label : {
                    position : "center",
                    verticalAlign : "middle",
                    offsetY : 0,
                    styles : {
                        color : "#800",
                        fontSize : 12
                    }
                },
                styles : {
                    background : "#F6BD0F"
                },
                dynamicStyles : [ {
                    //expression: "value <= min",
                    expression : "index == 0",
                    styles : {
                    //background: "#00f"
                    }
                } ],
                items : [ {
                    year : '2000',
                    value : 25
                }, {
                    year : '2001',
                    value : 63
                }, {
                    year : '2002',
                    value : 77
                }, {
                    year : '2003',
                    value : 71
                }, {
                    year : '2004',
                    value : 55
                } ]
            } ]
        };

        // grid
        var columns = [ {
            type : "label",
            header : {
                text : "Column Series",
                popupMenu : {
                    label : "Grid Version",
                    callback : function() {
                        alert(DataLudi.getVersion());
                    }
                }
            }
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns(columns);
        grdMain2.setColumns(columns);

        //grid options
        grdMain.setOptions({
            footer : {
                visible : false
            },
            rowIndicator : {
                visible : false
            },
            checkBar : {
                visible : false
            },
            header : {
                visible : true,
                styles : {
                    background : '#fff',
                    borderRight : null,
                    borderBottom : null
                }
            },
            display : {
                fitStyle : "fill",
                emptyDataMessage : ''
            },
            headerItems : [ {
                type : "chart",
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
            grid : {
                border : "#aaa"
            },
            body : {
                borderRight : null,
                borderBottom : null
            },
            palettes : [ {
                name : "pal_color",
                fills : [ "#ee0000", "#eeaa00", "#aaee00", "#0088ee", "#bb00ee" ]
            }, {
                name : "pal_gray",
                fills : [ "#80333333", "#80555555", "#80777777", "#80999999", "#80aaaaaa" ]
            } ]
        });
        columns[0].header.text = 'Multiple Column Series';
        grdMain2.setOptions({
            footer : {
                visible : false
            },
            rowIndicator : {
                visible : false
            },
            checkBar : {
                visible : false
            },
            header : {
                visible : true,
                styles : {
                    background : '#fff',
                    borderRight : null,
                    borderBottom : null
                }
            },
            display : {
                fitStyle : "fill",
                emptyDataMessage : ''
            },
            headerItems : [ {
                type : "chart",
                minHeight : 150,
                fillHeight : 1,
                styles : {
                    borderRight : null,
                    borderBottom : null,
                    padding : 10
                },
                chart : chart2
            } ]
        });
        grdMain2.loadStyles({
            grid : {
                border : "#aaa"
            },
            body : {
                borderRight : null,
                borderBottom : null
            }
        });

        // buttons
        $('#chkGridHeader').click(function() {
            var checked = document.getElementById('chkGridHeader').checked;
            grdMain.header().setVisible(checked);
        });
        $('#selPalette').change(function() {
            var value = $('#selPalette option:selected').val();
            var series = chart.series[0];
            series.styles.background = 'p(' + value + ':index)';
            refreshChart();
        });
        $('#btnSingleColor').click(function() {
            var series = chart.series[0];
            series.styles.background = '#0088ff';
            refreshChart();
        });
        $('#btnSingleColor2').click(function() {
            var series = chart.series[0];
            series.styles.background = '#800088ff';
            refreshChart();
        });
        $('#selShape').change(function() {
            var value = $('#selShape option:selected').val();
            var series = chart.series[0];
            series.itemShape = value;
            refreshChart();
        });
        $('#selLabelPosition').change(function() {
            var value = $('#selLabelPosition option:selected').val();
            var label = chart.series[0].label;
            var s = label.styles;
            var p = label.position = value;

            switch (p) {
            case 'center':
                s.color = '#fff'
                break;
            case 'near':
                s.color = '#fff'
                break;
            case 'far':
            case 'default':
            default:
                s.color = '#000'
                label.offsetY = 2;
                break;
            }
            ;
            refreshChart();
        });
        $('#chkMaxValueLabel').click(function() {
            var checked = document.getElementById('chkMaxValueLabel').checked;
            var label = chart.series[0].label;

            if (checked) {
                label.dynamicStyles = [ {
                    expression : "value >= 80",
                    styles : {
                        fontSize : 20,
                        color : "#fff",
                        background : "#000",
                        paddingLeft : 4,
                        paddingRight : 4,
                        paddingTop : 4,
                        paddingBottom : 4
                    }
                } ];
            } else {
                label.dynamicStyles = undefined;
            }
            refreshChart();
        });
        $('#chkMaxValueStyles').click(function() {
            var checked = document.getElementById('chkMaxValueStyles').checked;
            var series = chart.series[0];
            series.dynamicStyles = checked ? [ {
                expression : "value > 80",
                styles : {
                    border : "#80000000,3px,dashed"
                }
            } ] : undefined;
            refreshChart();
        });
        $('#btnLocationRate').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                ser.locationRate += 0.02;
                refreshChart();
                if (ser.locationRate >= 1)
                    clearInterval(t);
            }, 20);
            ser.locationRate = 0;
        });
        $('#btnItemWidth').click(function() {
            var ser = chart.series[0];
            var t = setInterval(function() {
                ser.itemWidth += 0.02;
                refreshChart();
                if (ser.itemWidth >= 1.2)
                    clearInterval(t);
            }, 20);
            ser.itemWidth = 0.1;
        });
        $('#chkCategoryWidths').click(function() {
            var checked = document.getElementById('chkCategoryWidths').checked;
            var axis = chart.xAxes;
            axis.categories = checked ? [ {
                label : '2000',
                width : 1.3
            }, "2001", "2002", {
                label : "2003",
                width : 2
            }, "2004" ] : undefined;
            refreshChart();
        });
        $('input:radio[name=rgpItemDisplayOrder]').click(function() {
            var value = $('input[name=rgpItemDisplayOrder]:checked').val();
            var series = chart.series[0];
            series.itemDisplayOrder = value;
            refreshChart();
        });
        $('#btnClusterWidth').click(function() {
            var ser = chart2.series[0];
            var t = setInterval(function() {
                ser.clusterWidth += 0.02;
                refreshChart(grdMain2, chart2);
                if (ser.clusterWidth >= 2.0)
                    clearInterval(t);
            }, 20);
            ser.clusterWidth = 0.1;
        });
    });
</script>
</head>
<body>
    <h3>Column Series</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <input type="checkbox" id="chkGridHeader" checked="checked">그리드 헤더 표시
    <br>
    <select id="selShape">
        <option value="default">default</option>
        <option value="triangle">triangle</option>
    </select>
    <br>
    <select id="selPalette">
        <option value="pal_color">pal_color</option>
        <option value="pal_gray">pal_gray</option>
    </select>
    <button id="btnSingleColor">Single Color</button>
    <button id="btnSingleColor2">Single Color 2</button>
    <br>
    <select id="selLabelPosition">
        <option value="default">ChartLabelPosition.DEFAULT</option>
        <option value="far">FAR</option>
        <option value="center">CENTER</option>
        <option value="near">NEAR</option>
    </select>
    <br>
    <input type="checkbox" id="chkMaxValueLabel">최대값 label 스타일 구분
    <br>
    <input type="checkbox" id="chkMaxValueStyles">최대값 item 스타일 구분
    <br>
    <button id="btnLocationRate">Inc Location Rate</button>locationRage를 0에서 1까지 증가
    <br>
    <button id="btnItemWidth">Inc Item Width</button>itemWidth를 0.1에서 * 1.2까지 증가
    <br>
    <input type="checkbox" id="chkCategoryWidths">Variable Category Widths X축 카테고리들의 너비를 다르게 설정
    <br>
    <span>아이템 표시순서 : </span>
    <input type="radio" name="rgpItemDisplayOrder" value="first" checked="checked">ChartItemDisplayOrder.FIRST
    <input type="radio" name="rgpItemDisplayOrder" value="last">LAST
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <button id="btnClusterWidth">Inc Cluster Width</button>Female 시리즈의 clusterWidth를 0.1에서 2.0까지 증가.
</body>
</html>