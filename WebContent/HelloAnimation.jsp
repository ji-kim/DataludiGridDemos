<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Hello Animation</title>
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
            "fieldName": "check_id"
        },{
            "fieldName": "factory1",
            "dataType": "number"
        }, {
            "fieldName": "factory2",
            "dataType": "number"
        }, {
            "fieldName": "factory3",
            "dataType": "number"
        }, {
            "fieldName": "factory4",
            "dataType": "number"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name": "colCheck",
            "fieldName": "check_id",
            "header": "CHK #",
            "width": 60,
            "styles": {
                "background": "#08000000",
                "textAlignment": "center"
            }
        },{
            "name": "ProductGroup1",
            "width": "180",
            /*"header": "Factory #1",*/
            /*"childHeadersVisible": false,*/
            "header": false,
            "headerDelegate": "UnitPrice1",
            "footerDelegate": "UnitPrice1",
            "columns": [{
                "name": "Labels",
                "layout": "vertical",
                "width": 60,
                "childFootersVisible": false,
                "childHeadersVisible": false,
                "header": "구분",
                "columns": [{
                    "type": "label",
                    "text": "MAX.",
                    "styles": {
                        "textAlignment": "far",
                        "background": "#08000000"
                    }
                }, {
                    "type": "label",
                    "text": "1,000",
                    "styles": {
                        "textAlignment": "far"
                    }
                }, {
                    "type": "label",
                    "text": "CURR.",
                    "styles": {
                        "textAlignment": "far",
                        "background": "#08000000"
                    }
                }, {
                    "fieldName": "factory1",
                    "styles": {
                        "textAlignment": "far",
                        "numberFormat": "#,##0.0"
                    }
                }]
            }, {
                "name": "UnitPrice1",
                "fieldName": "factory1",
                "width": 120,
                "styles": {
                    "textAlignment": "far",
                    "fontSize": 18,
                    "color": "#080",
                    "shapeInactiveColor": "#10000000",
                    "shapeColor": "#80008800",
                    "padding": 4,
                    "numberFormat": "#,##0.0"
                },
                "header": {
                    /*"text": "Value",*/
                    "text": "Factory #1"
                },
                "footer": {
                    "expression": "avg",
                    "styles": {
                        "numberFormat": "#,##0.0",
                        "fontBold": true,
                        "fontSize": 14,
                        "color": "#008"
                    }
                },
                "renderer": {
                    "type": "circleGauge",
                    "minValue": 0,
                    "maxValue": 1000
                },
                "animations": [{
                    "property": "value",
                    "duration": 1000
                }]
            }]
        }, {
            "name": "ProductGroup2",
            "width": "180",
            /* "header": "Factory #2", */
            /* "childHeadersVisible": false,*/
            "header": false,
            "headerDelegate": "UnitPrice2",
            "footerDelegate": "UnitPrice2",
            "columns": [{
                "name": "Labels",
                "layout": "vertical",
                "width": 60,
                "childFootersVisible": false,
                "childHeadersVisible": false,
                "header": "구분",
                "columns": [{
                    "type": "label",
                    "text": "MAX.",
                    "styles": {
                        "textAlignment": "far",
                        "background": "#08000000"
                    }
                }, {
                    "type": "label",
                    "text": "1,000",
                    "styles": {
                        "textAlignment": "far"
                    }
                }, {
                    "type": "label",
                    "text": "CURR.",
                    "styles": {
                        "textAlignment": "far",
                        "background": "#08000000"
                    }
                }, {
                    "fieldName": "factory2",
                    "styles": {
                        "textAlignment": "far",
                        "numberFormat": "#,##0.0"
                    }
                }]
            }, {
                "name": "UnitPrice2",
                "fieldName": "factory2",
                "width": 120,
                "styles": {
                    "textAlignment": "far",
                    "fontSize": 18,
                    "color": "#080",
                    "shapeInactiveColor": "#10000000",
                    "shapeColor": "#80008800",
                    "padding": 4,
                    "numberFormat": "#,##0.0"
                },
                "header": {
                    /* "text": "Value"*/
                    "text": "Factory #2"
                },
                "footer": {
                    "expression": "avg",
                    "styles": {
                        "numberFormat": "#,##0.0",
                        "fontBold": true,
                        "fontSize": 14,
                        "color": "#008"
                    }
                },
                "renderer": {
                    "type": "circleGauge",
                    "minValue": 0,
                    "maxValue": 1000
                },
                "animations": [{
                    "property": "value",
                    "duration": 1000
                }]
            }]
        }, {
            "name": "ProductGroup3",
            "width": "180",
            /* "header": "Factory #3", */
            /* "childHeadersVisible": false, */
            "header": false,
            "headerDelegate": "UnitPrice3",
            "footerDelegate": "UnitPrice3",
            "columns": [{
                "name": "Labels",
                "layout": "vertical",
                "width": 60,
                "childFootersVisible": false,
                "childHeadersVisible": false,
                "header": "구분",
                "columns": [{
                    "type": "label",
                    "text": "MAX.",
                    "styles": {
                        "textAlignment": "far",
                        "background": "#08000000"
                    }
                }, {
                    "type": "label",
                    "text": "1,000",
                    "styles": {
                        "textAlignment": "far"
                    }
                }, {
                    "type": "label",
                    "text": "CURR.",
                    "styles": {
                        "textAlignment": "far",
                        "background": "#08000000"
                    }
                }, {
                    "fieldName": "factory3",
                    "styles": {
                        "textAlignment": "far",
                        "numberFormat": "#,##0.0"
                    }
                }]
            }, {
                "name": "UnitPrice3",
                "fieldName": "factory3",
                "width": 120,
                "styles": {
                    "textAlignment": "far",
                    "fontSize": 18,
                    "color": "#080",
                    "shapeInactiveColor": "#10000000",
                    "shapeColor": "#80008800",
                    "padding": 4,
                    "numberFormat": "#,##0.0"
                },
                "header": {
                    /* "text": "Value" */
                    "text": "Factory #3"
                },
                "footer": {
                    "expression": "avg",
                    "styles": {
                        "numberFormat": "#,##0.0",
                        "fontBold": true,
                        "fontSize": 14,
                        "color": "#008"
                    }
                },
                "renderer": {
                    "type": "circleGauge",
                    "minValue": 0,
                    "maxValue": 1000
                },
                "animations": [{
                    "property": "value",
                    "duration": 1000
                }]
            }]
        }, {
            "name": "ProductGroup4",
            "width": "180",
            /* "header": "Factory #4", */
            /* "childHeadersVisible": false, */
            "header": false,
            "headerDelegate": "UnitPrice3",
            "footerDelegate": "UnitPrice3",
            "columns": [{
                "name": "Labels",
                "layout": "vertical",
                "width": 60,
                "childFootersVisible": false,
                "childHeadersVisible": false,
                "header": "구분",
                "columns": [{
                    "type": "label",
                    "text": "MAX.",
                    "styles": {
                        "textAlignment": "far",
                        "background": "#08000000"
                    }
                }, {
                    "type": "label",
                    "text": "1,000",
                    "styles": {
                        "textAlignment": "far"
                    }
                }, {
                    "type": "label",
                    "text": "CURR.",
                    "styles": {
                        "textAlignment": "far",
                        "background": "#08000000"
                    }
                }, {
                    "fieldName": "factory4",
                    "styles": {
                        "textAlignment": "far",
                        "numberFormat": "#,##0.0"
                    }
                }]
            }, {
                "name": "UnitPrice4",
                "fieldName": "factory4",
                "width": 120,
                "styles": {
                    "textAlignment": "far",
                    "fontSize": 18,
                    "color": "#080",
                    "shapeInactiveColor": "#10000000",
                    "shapeColor": "#80008800",
                    "padding": 4,
                    "numberFormat": "#,##0.0"
                },
                "header": {
                    /* "text": "Value" */
                    "text": "Factory #4"
                },
                "footer": {
                    "expression": "avg",
                    "styles": {
                        "numberFormat": "#,##0.0",
                        "fontBold": true,
                        "fontSize": 14,
                        "color": "#008"
                    }
                },
                "renderer": {
                    "type": "circleGauge",
                    "minValue": 0,
                    "maxValue": 1000
                },
                "animations": [{
                    "property": "value",
                    "duration": 1000
                }]
            }]
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(true);
        grdMain.effectOptions().setAnimationEnabled(true);
        grdMain.autoFill().setEnabled(true);
        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });
        
        grdMain.loadStyles({
            selection: {
                background: "#11000000",
                border: "#88000000,1"
            },
            body: {
                cellDynamic: [{
                    expression: "value >= 700",
                    styles: {
                        color: "#b0880000",
                        shapeColor: "#80880000"
                    }
                }]
            }
        });


        // connect dataset
        function loadData(ds) {
            var rows = [];
            var id = 1000;
            for (var r = 0; r < 1000; r++) {
                var row = [];
        
                id += 1 + Math.floor(Math.random() * 3);
                row.push("#" + id);
        
                for (var f = 0; f < 4; f++) {
                    var v = 50 + Math.random() * 950;
                    row.push(v);
                }
                rows.push(row);
            }
            ds.setRows(rows);
        }
        grdMain.setDataSource(dsMain);
        loadData(dsMain);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events

        // buttons
        $('#btnRestart').click(function (ev) {
            grdMain.requestLoadAnimation();
        });
        $('#btnUpdateData').click(function (ev) {
            clearInterval(_updateTimer);
            _updateTimer = setInterval(function() {
                for (var i = 0; i < 5; i++) {
                    var r = Math.max(0, Math.min(dsMain.rowCount() - 1, Math.floor(Math.random() * 5) + grdMain.topIndex()));
                    var c = "factory" + (1 + Math.floor(Math.random() * 3));
                    var v = Math.random() * 1000;
                    dsMain.setValue(r, c, v);
                }
            }, 1500);
        });
        $('#btnStopUpdate').click(function (ev) {
            clearInterval(_updateTimer);
        });
        $('#btnStop').click(function (ev) {
            grdMain.effectOptions().setAnimationEnabled(false);
        });
     });
</script>
</head>
<body>
    <h3>Hello Animation</h3>
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