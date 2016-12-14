<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Linear Gauge Renderer</title>
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
        var _updateTimer;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            "fieldName" : "region"
        }, {
            "fieldName" : "subregion"
        }, {
            "fieldName" : "country"
        }, {
            "fieldName" : "city_station"
        }, {
            "fieldName" : "pm10",
            "dataType" : "number"
        }, {
            "fieldName" : "pm25",
            "dataType" : "number"
        }, {
            "fieldName" : "stations"
        }, {
            "fieldName" : "description"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "grpRegions",
            "width" : 130,
            "header" : "Regions",
            "childHeadersVisible" : false,
            "childFootersVisible" : false,
            "columns" : [ {
                "name" : "colLabels",
                "layout" : "vertical",
                "width" : 60,
                "columns" : [ {
                    "type" : "label",
                    "text" : "Region",
                    "styles" : {
                        "textAlignment" : "far",
                        "fontSize" : 11,
                        "fontItalic" : true,
                        "paddingRight" : 5,
                        "background" : "#08000000"
                    }
                }, {
                    "type" : "label",
                    "text" : "Subregion",
                    "styles" : {
                        "textAlignment" : "far",
                        "fontSize" : 11,
                        "fontItalic" : true,
                        "paddingRight" : 5,
                        "background" : "#08000000"
                    }
                }, {
                    "type" : "label",
                    "text" : "Country",
                    "styles" : {
                        "textAlignment" : "far",
                        "fontSize" : 11,
                        "fontItalic" : true,
                        "paddingRight" : 5,
                        "background" : "#08000000"
                    }
                } ]
            }, {
                "name" : "colRegions",
                "layout" : "vertical",
                "width" : 70,
                "columns" : [ {
                    "fieldName" : "region",
                    "styles" : {}
                }, {
                    "fieldName" : "subregion",
                    "styles" : {}
                }, {
                    "fieldName" : "country",
                    "styles" : {}
                } ]
            } ]
        }, {
            "name" : "colCity",
            "fieldName" : "city_station",
            "header" : "City/Station",
            "width" : 80,
            "styles" : {
                "textWrap" : "normal"
            }
        }, {
            "name" : "comPm25",
            "fieldName" : "pm25",
            "width" : 170,
            "styles" : {
                "textAlignment" : "far",
                "fontSize" : 14,
                "color" : "#008",
                "shapeInactiveColor" : "#10000000",
                "shapeColor" : "#80000088",
                "padding" : 4,
                "numberFormat" : "#,##0.0"
            },
            "dynamicStyles" : [ {
                "expressions" : [ "value > 40", "value > 20" ],
                "styles" : [ {
                    "shapeColor" : "#a0aa0000",
                    "color" : "#800"
                }, {
                    "shapeColor" : "#a000aa00",
                    "color" : "#080"
                } ]
            } ],
            "header" : {
                "text" : "PM 2.5"
            },
            "footer" : {
                "expression" : "avg",
                "styles" : {
                    "fontSize" : 14,
                    "numberFormat" : "#,##0.0"
                },
                "dynamicStyles" : [ {
                    "expressions" : [ "value > 40", "value > 20" ],
                    "styles" : [ {
                        "borderLeft" : null,
                        "background" : "#40ff0000",
                        "color" : "#080"
                    }, {
                        "borderLeft" : null,
                        "background" : "#4000ff00",
                        "color" : "#008"
                    } ]
                } ]
            },
            "renderer" : {
                "type" : "linearGauge",
                "startValue" : 0,
                "endValue" : 80,
                "thickness" : 9,
                "valueThickness" : 0.5,
                "valueLocation" : "top",
                "ranges" : [ {
                    "label" : "good",
                    "endValue" : 20,
                    "background" : "#30000000"
                }, {
                    "label" : "normal",
                    "startValue" : 20,
                    "endValue" : 40,
                    "background" : "#20000000"
                }, {
                    "label" : "bad",
                    "startValue" : 40,
                    "endValue" : 80,
                    "background" : "#10000000"
                } ],
                "scale" : {
                    "ticks" : [ 0, 20, 40, 80 ],
                    "tickLength" : 0,
                    "lineStroke" : null
                }
            },
            "animations" : [ {
                "property" : "value",
                "duration" : 1000
            } ]
        }, {
            "name" : "colPm10",
            "fieldName" : "pm10",
            "width" : 170,
            "styles" : {
                "textAlignment" : "far",
                "fontSize" : 14,
                "color" : "#008",
                "shapeInactiveColor" : "#ffffff",
                "shapeColor" : "#a00000aa",
                "padding" : 4,
                "numberFormat" : "#,##0.0"
            },
            "dynamicStyles" : [ {
                "expressions" : [ "value > 70", "value > 40" ],
                "styles" : [ {
                    "shapeColor" : "#a0aa0000",
                    "color" : "#800"
                }, {
                    "shapeColor" : "#a000aa00",
                    "color" : "#080"
                } ]
            } ],
            "header" : {
                "text" : "PM 10"
            },
            "footer" : {
                "expression" : "avg",
                "styles" : {
                    "fontSize" : 14,
                    "numberFormat" : "#,##0.0"
                },
                "dynamicStyles" : [ {
                    "expressions" : [ "value > 70", "value > 40" ],
                    "styles" : [ {
                        "shapeColor" : "#a0aa0000",
                        "color" : "#800"
                    }, {
                        "shapeColor" : "#a000aa00",
                        "color" : "#080"
                    } ]
                } ]
            },
            "renderer" : {
                "type" : "linearGauge",
                "startValue" : 0,
                "endValue" : 130,
                "thickness" : 17,
                "valueThickness" : 0.33,
                "ranges" : [ {
                    "label" : "good",
                    "endValue" : 40,
                    "background" : "#10000000"
                }, {
                    "label" : "normal",
                    "startValue" : 40,
                    "endValue" : 70,
                    "background" : "#20000000"
                }, {
                    "label" : "bad",
                    "startValue" : 70,
                    "endValue" : 130,
                    "background" : "#30000000"
                } ],
                "scale" : {
                    "ticks" : [ 0, 40, 70, 130 ],
                    "tickLength" : 0,
                    "lineStroke" : null
                }
            },
            "animations" : [ {
                "property" : "value",
                "duration" : 1000
            } ]
        }, {
            "name" : "colStations",
            "fieldName" : "stations",
            "header" : "Monitoring Stations",
            "width" : 150,
            "styles" : {
                "textWrap" : "normal"
            }
        }, {
            "name" : "colDescription",
            "fieldName" : "description",
            "header" : "Air Quality",
            "width" : 300,
            "styles" : {
                "textWrap" : "normal"
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.effectOptions().setAnimationEnabled(true);
        grdMain.autoFill().setEnabled(true);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain.loadStyles({
            selection : {
                background : "#11000000",
                border : "#88000000,1"
            }
        });

        // connect dataset
        function loadData(ds) {
            $.ajax({
                url : "data/ambient_air_pollution_who_2014.csv",
                dataType : 'text',
                success : function(data) {
                    new DataLudi.DataLoader(ds).load("csv", data, {
                        start : 1,
                        quoted : true
                    });
                },
                error : function(xhr, status, error) {
                    var err = status + ', ' + error;
                    alert("jQuery ajax() Failed: " + err);
                }
            });
        }
        grdMain.setDataSource(dsMain);
        loadData(dsMain);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events

        // buttons
        $('#btnRestart').click(function() {
            grdMain.requestLoadAnimation();
        });
        $('#btnUpdateData').click(function() {
            clearInterval(_updateTimer);
            _updateTimer = setInterval(function() {
                for (var i = 0; i < 5; i++) {
                    var r = Math.max(0, Math.min(dsMain.rowCount() - 1, Math.floor(Math.random() * 5) + grdMain.topIndex()));
                    var c = "pm10";
                    var v = dsMain.getValue(r, c);
                    v = Math.max(20, Math.min(130, v + Math.random() * 100) - 50);
                    dsMain.setValue(r, c, v);
                    c = "pm25";
                    v = dsMain.getValue(r, c);
                    v = Math.max(10, Math.min(70, v + Math.random() * 70) - 35);
                    dsMain.setValue(r, c, v);
                }
            }, 1500);
        });
        $('#btnStopUpdate').click(function() {
            clearInterval(_updateTimer);
        });
        $('#btnStop').click(function() {
            grdMain.effectOptions().setAnimationEnabled(false);
        });
    });
</script>
</head>
<body>
    <h3>Linear Gauge Renderer</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnRestart">Restart Animation</button>
        <button id="btnUpdateData">Start Update Data</button>
        <button id="btnStopUpdate">Stop Update Data</button>
        <button id="btnStop">Stop Animation</button>
    </div>
</body>
</html>