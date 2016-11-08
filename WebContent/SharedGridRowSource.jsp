<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Shared Grid RowSource</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
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
        }, {
            fieldName : "product_name",
        }, {
            fieldName : "customer_id",
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
            "name" : "ProductID",
            "fieldName" : "product_id",
            "width" : "80",
            "styles" : {},
            "header" : {
                "text" : "ProductID"
            }
        }, {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#50008800"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "renderer" : {
                "type" : "bar",
                "minimum" : 0,
                "maximum" : 1000
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#50000088"
            },
            "header" : {
                "text" : "Quantity"
            },
            "renderer" : {
                "type" : "bar",
                "minimum" : 0,
                "maximum" : 1000,
                "origin" : "right"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "120",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        } ]);

        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns([ {
            "name" : "ProductID",
            "fieldName" : "product_id",
            "width" : "80",
            "styles" : {},
            "header" : {
                "text" : "ProductID"
            }
        }, {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#50008800"
            },
            "header" : {
                "text" : "UnitPrice"
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#50000088"
            },
            "header" : {
                "text" : "Quantity"
            },
            "filters" : [ {
                name : "Larger than 300",
                expression : "value > 300"
            } ]
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "120",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        } ]);

        //grid options
        var options = {
            "rowIndicator.stateVisible" : true,
            "checkBar.visible" : true,
            "footer.visible" : false,
            "header.head.popupMenu" : {
                label : 'DataLudi Version',
                callback : function() {
                    alert(DataLudi.getVersion());
                }
            },
            "edit" : {
                insertable : true,
                appendable : true,
                deletable : true
            }
        };
        grdMain.setOptions(options);
        grdMain2.setOptions(options);

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);

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

        // grid events
        grdMain.onDataCountChanged = function(grid, newCount) {
            $("#rowCount").css("color", "blue").text(newCount.toLocaleString());
        };
        grdMain2.onDataCountChanged = function(grid, newCount) {
            $("#rowCount2").css("color", "blue").text(newCount.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>Shared Grid RowSource</h3>
    <div id="container" style="height: 200px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div id="container2" style="height: 200px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>