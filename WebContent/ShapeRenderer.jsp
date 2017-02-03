<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Shape Cell Renderers</title>
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

        var grdMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "product_id",
            dataType : "text",
        }, {
            fieldName : "product_name"
        }, {
            fieldName : "customer_id"
        }, {
            fieldName : "customer_name",
        }, {
            fieldName : "country",
        }, {
            fieldName : "phone",
        }, {
            fieldName : "unit",
        }, {
            fieldName : "currency",
        }, {
            fieldName : "unit_price",
            dataType : "number"
        }, {
            fieldName : "quantity",
            dataType : "number"
        }, {
            fieldName : "order_date",
            dataType : "datetime",
            datetimeFormat : "yyyy-MM-dd"
        }, {
            fieldName : "ship_date",
            dataType : "datetime",
            datetimeFormat : "iso"
        } ]);

        // grid        
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([{
            "name" : "ProductId",
            "fieldName" : "product_id",
            "width" : 70,
            "dynamicStyles" : [ {
                "expression" : "value like '%a%'",
                "styles" : {
                    "textDecoration" : "lineThrough"
                }
            } ],
            "header" : {
                "text" : "ProductId"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 120,
            "renderer" : {
                "type" : "shape"
            },
            "styles" : {
                "shapeSize" : 12,
                "paddingLeft" : 6,
                "textAlignment" : "center",
                "paddingLeft" : 4,
                "paddingRight" : 4
            },
            "dynamicStyles" : [ {
                "expression" : "value like 'I%'",
                "styles" : {
                    "shapeName" : "rectangle",
                    "shapeColor" : "#ff44f5",
                    "shapeRotate" : 25
                }
            }, {
                "expression" : "value like 'P%'",
                "styles" : {
                    "shapeName" : "plus",
                    "shapeColor" : "#1122ff",
                    "shapeRotate" : -25
                }
            }, {
                "expression" : "value like 'S%' || value like 'R%'",
                "styles" : {
                    "shapeName" : "minus",
                    "shapeColor" : "#118822",
                    "shapeRotate" : 30,
                    "shapeLocation" : "right"
                }
            } ],
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : "90",
            "renderer" : {
                "type" : "shape"
            },
            "styles" : {
                "shapeName" : "triangle",
                "shapeSize" : 9,
                "shapeColor" : "#00aaff",
                "shapePadding" : 6,
                "shapeLocation" : "rightSide",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : "100",
            "renderer" : {
                "type" : "shape"
            },
            "styles" : {
                "textAlignment" : "far",
                "shapeName" : "uparrow",
                "shapeSize" : "50%",
                "paddingLeft" : 4
            },
            "dynamicStyles" : [ {
                "expression" : "value < 300",
                "styles" : {
                    "shapeColor" : "#ff0000ff",
                    "color" : "#ff0000ff",
                    "shapeName" : "invertedtriangle"
                }
            }, {
                "expression" : "value < 200",
                "styles": {
                    "background": "#110000ff",
                    "shapeColor": "#ff0000ff",
                    "color": "#ff0000ff",
                    "shapeName": "downarrow"
                }
            }, {
                "expression": "value >= 600",
                "styles" : {
                    "shapeColor" : "#ffff0000",
                    "color" : "#ffff0000",
                    "shapeName" : "triangle"
                }
            }, {
                "expression" : "value > 800",
                "styles" : {
                    "background" : "#11ff0000",
                    "shapeColor" : "#ffff0000",
                    "color" : "#ffff0000",
                    "shapeName" : "uparrow"
                }
            } ],
            "header" : {
                "text" : "UnitPrice"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "80",
            "renderer" : {
                "type" : "shape"
            },
            "styles" : {
                "textAlignment" : "center",
                "shapeRotate" : 45
            },
            "dynamicStyles" : [ {
                "expression" : "value like '%R%' || value like '%B%'",
                "styles" : {
                    "shapeName" : "star",
                    "shapeColor" : "#ffffcc00",
                    "shapeLocation" : "center",
                    "shapeBorder" : "#800"
                }
            } ],
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 70,
            "header" : {
                "text" : "Quantity"
            },
            "renderer" : {
                "type" : "shape",
                "scaleX" : 1.0,
                "scaleY" : 0.6
            },
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#300000ff"
            },
            "dynamicStyles" : [ {
                "expression" : "value > 600",
                "styles" : {
                    "shapeName" : "star",
                    "shapeColor" : "#ff00ccaa",
                    "shapeLocation" : "center"
                }
            } ],
        }, {
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "CustomerId"
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : "90",
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "OrderDate"
            }
        }, {
            "name" : "ShipDate",
            "fieldName" : "ship_date",
            "width" : "120",
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd hh:mm",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ShipDate"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            checkBar : {
                visible : false
            },
            autoFill : {
                enabled : false
            },
            display : {
                rowHeight : 35,
                rowResizable : true
            }
        })
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/orders_s.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1
                });
                $("#rowCount").css("color", "blue").text(ds.rowCount().toLocaleString()).show();
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('input:radio[name=rgpLocation]').click(function() {
            var value = $("input[name=rgpLocation]:checked").val();
            var column = grdMain.columnByName('Unit');
            column && column.styles().setShapeLocation(value);
        });
        $('#btnRotateStar').click(function() {
            var col = grdMain.columnByName('Currency');
            if (col) {
                var scale = 1;
                var delta = -0.1;

                setInterval(function() {
                    var r = col.styles().shapeRotate();
                    col.styles().setShapeRotate(r + 10);

                    if (scale >= 2)
                        delta = -0.1;
                    else if (scale <= 0.5)
                        delta = 0.1;
                    scale += delta;

                    col.setRenderer({
                        type : "shape",
                        scaleX : scale,
                        scaleY : scale
                    });
                }, 100);
            }
        });
    });
</script>
</head>
<body>
    <h3>Shape Cell Renderers</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <span>'단위' 컬럼 Shape 위치: </span> <input type="radio" name="rgpLocation"
            value="leftSide" checked="checked">IconLocation.LEFT_SIDE <input
            type="radio" name="rgpLocation" value="left">LEFT <input
            type="radio" name="rgpLocation" value="rightSide">RIGHT_SIDE
        <input type="radio" name="rgpLocation" value="right">RIGHT <input
            type="radio" name="rgpLocation" value="top">TOP <input
            type="radio" name="rgpLocation" value="bottom">BOTTOM <input
            type="radio" name="rgpLocation" value="center">CENTER <input
            type="radio" name="rgpLocation" value="none">NONE
    </div>
    <div>
        <button id="btnRotateStar">Rotate Star</button>
    </div>
</body>
</html>