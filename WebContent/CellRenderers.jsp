<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Cell Renderers</title>
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
        grdMain.setColumns([ {
            "name" : "ProductId",
            "fieldName" : "product_id",
            "width" : "90",
            "styles" : {
                color : "#008"
            },
            "header" : {
                "text" : "ProductId"
            }
        }, {
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : "90",
            "styles" : {
                background : "#2000ff00"
            },
            "header" : {
                "text" : "CustomerId"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "styles" : {},
            "renderer" : {
                "showTooltip" : true
            },
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
                "shapeSize" : 11,
                "shapeColor" : "#008800",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "80",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : "100",
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#20ff0000"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "renderer" : {
                "type" : "bar",
                "showLabel" : true,
                "minimum" : 0,
                "maximum" : 1000
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : "100",
            "header" : {
                "text" : "Quantity"
            },
            "styles" : {
                "textAlignment" : "center",
                "shapeColor" : "#300000ff",
            },
            "renderer" : {
                "type" : "bar",
                "showLabel" : true,
                "minimum" : 0,
                "maximum" : 1000,
                "origin" : "right"
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
        grdMain.checkBar().setVisible(false);
        grdMain.autoFill().setEnabled(true);
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
        $('input:radio[name=rgpBarOrigin]').click(function() {
            var value = $("input[name=rgpBarOrigin]:checked").val();
            var column = grdMain.columnByName('UnitPrice');
            column && column.setRenderer({
                "type" : "bar",
                "showLabel" : true,
                "minimum" : 0,
                "maximum" : 1000,
                "origin" : value
            });
        });
    });
</script>
</head>
<body>
    <h3>Cell Renderers</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="radio" name="rgpLocation" value="left" checked="checked">IconLocation.LEFT
        <input type="radio" name="rgpLocation" value="right">IconLocation.RIGHT
        <input type="radio" name="rgpLocation" value="center">IconLocation.CENTER
        <input type="radio" name="rgpLocation" value="none">IconLocation.NONE
    </div>
    <div>
        <input type="radio" name="rgpBarOrigin" value="left" checked="checked">left
        <input type="radio" name="rgpBarOrigin" value="right">right
        <input type="radio" name="rgpBarOrigin" value="top">top
        <input type="radio" name="rgpBarOrigin" value="bottom">bottom
    </div>
</body>
</html>