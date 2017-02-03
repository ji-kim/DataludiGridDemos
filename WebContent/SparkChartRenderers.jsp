<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Spark Chart Renderers</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2, grdMain3;
        var dsMain, dsMain2, dsMain3;
        var columnTimer;

        var loadData = function() {
            grdMain.showToast("Load data...", true);
            $.ajax({
                url : "data/eco_growth_rate.csv",
                dataType : 'text',
                success : function(data) {
                    grdMain.hideToast();
                    new DataLudi.DataLoader(dsMain).load("csv", data, {
                        start : 3
                    });
                    var rows = dsMain.getRows();
                    dsMain2.setRows(rows);
                    dsMain3.setRows(rows);
                },
                error : function(xhr, status, error) {
                    grdMain.hideToast();
                    var err = xhr + ', ' + status + ', ' + error;
                    alert("jQuery getJSON() Failed: " + err);
                },
                complete : function(data) {
                }
            });
        };

        // dataset
        var fields = [ {
            fieldName : "continent",
            dataType : "text"
        }, {
            fieldName : "country",
            dataType : "text"
        }, {
            fieldName : "2000",
            dataType : "number"
        }, {
            fieldName : "2001",
            dataType : "number"
        }, {
            fieldName : "2002",
            dataType : "number"
        }, {
            fieldName : "2003",
            dataType : "number"
        }, {
            fieldName : "2004",
            dataType : "number"
        }, {
            fieldName : "2005",
            dataType : "number"
        }, {
            fieldName : "2006",
            dataType : "number"
        }, {
            fieldName : "2007",
            dataType : "number"
        }, {
            fieldName : "2008",
            dataType : "number"
        }, {
            fieldName : "2009",
            dataType : "number"
        }, {
            fieldName : "2010",
            dataType : "number"
        } ];
        dsMain = DataLudi.createGridDataSet();
        dsMain2 = DataLudi.createGridDataSet();
        dsMain3 = DataLudi.createGridDataSet();
        dsMain.setFields(fields);
        dsMain2.setFields(fields);
        dsMain3.setFields(fields);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            fieldName : "continent",
            width : 70,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "continent"
            }
        }, {
            name : "colSeries1",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkColumn",
                highColor : "#ff0088ff",
                lowColor : "#ffff0000"
            },
            header : {
                text : "Spark Column"
            },
            styles : {
                shapeColor : "#ffbbbbbb",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            name : "colSeries2",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkColumn",
                barWidth : 0.5,
                highColor : "#ff00ff00",
                lowColor : "#ffff0000",
            },
            header : {
                text : "Spark Column"
            },
            styles : {
                background : "#000",
                shapeColor : "#ccc",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            name : "colSeries3",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkColumn",
                barWidth : 0.3,
                highColor : "#ff008800",
                lowColor : "#ffff0000",
            },
            header : {
                text : "Spark Column"
            },
            styles : {
                shapeColor : "#ff000088",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            fieldName : "country",
            width : 80,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "Country"
            }
        }, {
            fieldName : "2000",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2000"
            }
        }, {
            fieldName : "2001",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2001"
            }
        }, {
            fieldName : "2002",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2002"
            }
        }, {
            fieldName : "2003",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2003"
            }
        }, {
            fieldName : "2004",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2004"
            }
        }, {
            fieldName : "2005",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2005"
            }
        }, {
            fieldName : "2006",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2006"
            }
        }, {
            fieldName : "2007",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2007"
            }
        }, {
            fieldName : "2008",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2008"
            }
        }, {
            fieldName : "2009",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2009"
            }
        }, {
            fieldName : "2010",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2010"
            }
        } ]);

        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns([ {
            fieldName : "continent",
            width : 70,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "continent"
            }
        }, {
            name : "colSeries1",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkLine",
                lineColor : "#40ff0000",
                highColor : "#ff008800",
                lowColor : "#ffff0000",
                lastColor : "#ff888888"
            },
            header : {
                text : "Spark Line"
            },
            styles : {
                shapeColor : "#ff000088",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            name : "colSeries2",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkLine",
                highColor : "#ff008800",
                lowColor : "#ffff0000",
                lastColor : "#ff888888"
            },
            header : {
                text : "Spark Line"
            },
            styles : {
                shapeColor : "#ff000088",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            name : "colSeries3",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkLine",
                lineColor : "#fff",
                highColor : "#0f0",
                lowColor : "#f00",
                lastColor : "#fff"
            },
            header : {
                text : "Spark Line"
            },
            styles : {
                background : "#000",
                shapeColor : "#ff000088",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            fieldName : "country",
            width : 80,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "Country"
            }
        }, {
            fieldName : "2000",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2000"
            }
        }, {
            fieldName : "2001",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2001"
            }
        }, {
            fieldName : "2002",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2002"
            }
        }, {
            fieldName : "2003",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2003"
            }
        }, {
            fieldName : "2004",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2004"
            }
        }, {
            fieldName : "2005",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2005"
            }
        }, {
            fieldName : "2006",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2006"
            }
        }, {
            fieldName : "2007",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2007"
            }
        }, {
            fieldName : "2008",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2008"
            }
        }, {
            fieldName : "2009",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2009"
            }
        }, {
            fieldName : "2010",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2010"
            }
        } ]);

        grdMain3 = DataLudi.createGridView("container3");
        grdMain3.setColumns([ {
            fieldName : "continent",
            width : 70,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "continent"
            }
        }, {
            name : "colSeries1",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkWinLoss",
                baseValue : 2.0,
                belowColor : "#08f"
            },
            header : {
                text : "Spark WinLoss"
            },
            styles : {
                background : "#000",
                shapeColor : "#eee",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            name : "colSeries2",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkWinLoss",
                baseValue : 3
            },
            header : {
                text : "Spark WinLoss"
            },
            styles : {
                shapeColor : "#ff000088",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            name : "colSeries3",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkWinLoss",
                barWidth : 0.5,
                belowColor : "#f00"
            },
            header : {
                text : "Spark WinLoss"
            },
            styles : {
                shapeColor : "#08f",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            fieldName : "country",
            width : 80,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "Country"
            }
        }, {
            fieldName : "2000",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2000"
            }
        }, {
            fieldName : "2001",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2001"
            }
        }, {
            fieldName : "2002",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2002"
            }
        }, {
            fieldName : "2003",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2003"
            }
        }, {
            fieldName : "2004",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2004"
            }
        }, {
            fieldName : "2005",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2005"
            }
        }, {
            fieldName : "2006",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2006"
            }
        }, {
            fieldName : "2007",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2007"
            }
        }, {
            fieldName : "2008",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2008"
            }
        }, {
            fieldName : "2009",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2009"
            }
        }, {
            fieldName : "2010",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2010"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            checkBar : false,
            rowIndicator : {
                stateVisible : false
            },
            header : {
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            display : {
                rowHeight : 27
            }
        });
        grdMain2.setOptions({
            checkBar : false,
            rowIndicator : {
                stateVisible : false
            },
            header : {
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            display : {
                rowHeight : 27
            }
        });
        grdMain3.setOptions({
            checkBar : false,
            rowIndicator : {
                stateVisible : false
            },
            header : {
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            display : {
                rowHeight : 27
            }
        });

        // grid styles
        grdMain.loadStyles({
            body : {
                cellDynamic : {
                    expression : 'rowtag == field',
                    styles : {
                        background : '#100000ff',
                        fontBold : true
                    }
                },
                updated : {
                    background : undefined
                }
            }
        });
        grdMain2.loadStyles({
            body : {
                updated : {
                    background : undefined
                }
            }
        });
        grdMain3.loadStyles({
            body : {
                updated : {
                    background : undefined
                }
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain2);
        grdMain3.setDataSource(dsMain3);
        loadData();

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
        dsMain2.onRowCountChanged = function(ds, count) {
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };
        dsMain3.onRowCountChanged = function(ds, count) {
            $("#rowCount3").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnColumnShow').click(function() {
            columnTimer && clearInterval(columnTimer);
            columnTimer = setInterval(function() {
                var t = grdMain.topIndex();
                var cnt = grdMain.displayRowCount();
                for (var i = 0; i < cnt; i++) {
                    var row = grdMain.getRow(i + t);
                    var f = Math.floor(Math.random() * 10);
                    dsMain.setValue(row.dataIndex(), '200' + f, Math.floor(Math.random() * 100) / 10);
                    dsMain.setRowTag(row.dataIndex(), f + 2);
                }
            }, 100);
        });
        $('#btnColumnStop').click(function() {
            columnTimer && clearInterval(columnTimer);
        });
    });
</script>
</head>
<body>
    <h3>Spark Chart Renderers</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnColumnShow">Show!</button>
        <button id="btnColumnStop">Stop</button>
    </div>
    <p>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <div id="container3" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount3" style="">0</span> rows.
    </div>
</body>
</html>