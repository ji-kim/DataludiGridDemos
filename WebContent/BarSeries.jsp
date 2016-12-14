<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        var refreshChart = function(ev) {
            var item = grdMain.headerItems().getItem(0);
            item.setChart(chart);
            item.refresh();
        };
        var chart = {
            type : "bar",
            plotArea : {
                styles : {
                //background: "#0800ffff"
                }
            },
            yAxes : {
                firstIndent : 0.2,
                lastIndent : 0.2,
                styles : {
                    line : "#333"
                },
                tickStyles : {
                    line : "#333"
                }
            },
            xAxes : {
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
                    offsetY : 0,
                    offsetX : 15,
                    styles : {
                        fontSize : 16,
                        suffix : "%"
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

        // grid
        var columns = [ {
            type : "label",
            header : {
                text : "Bar Series",
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
            footer : false,
            rowIndicator : false,
            checkBar : false,
            header : {
                visible : true,
                styles : {
                    borderRight : null
                }
            },
            display : {
                fitStyle : "fill",
                emptyDataMessage : ''
            },
            headerItems : [ {
                type : "chart",
                displayLevels2 : "*",
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
            grid : {
                border : "#aaa"
            },
            body : {
                borderRight : null,
                borderBottom : null
            },
            palettes : [ {
                name : "pal_color",
                fills : [ "#8E9E82", "#CACCB6", "#F2F0DF", "#A9C1D9", "#607890" ]
            }, {
                name : "pal_gray",
                fills : [ "#80333333", "#80555555", "#80777777", "#80999999", "#80aaaaaa" ]
            } ]
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
            var axis = chart.yAxes;
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
    <button id="btnLocationRate">Inc Location Rate</button> locationRage를 0에서 1까지 증가
    <br>
    <button id="btnItemWidth">Inc Item Width</button>itemWidth를 0.1에서 * 1.2까지 증가
    <br>
    <input type="checkbox" id="chkCategoryWidths">Variable Category Widths X축 카테고리들의 너비를 다르게 설정
    <br>
    <span>아이템 표시순서 : </span>
    <input type="radio" name="rgpItemDisplayOrder" value="first" checked="checked">ChartItemDisplayOrder.FIRST
    <input type="radio" name="rgpItemDisplayOrder" value="last">LAST
</body>
</html>