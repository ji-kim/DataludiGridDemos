<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Grid Default Styles</title>
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
            "header" : {
                "text" : "ProductId"
            }
        }, {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "90",
            "styles" : {
                "color" : "#00f"
            },
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : "90",
            "header" : {
                "text" : "CustomerId"
            }
        }, {
            "name" : "CustomerName",
            "fieldName" : "customer_name",
            "width" : "90",
            "header" : {
                "text" : "CustomerName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : "90",
            "styles" : {
                "textAlignment" : "far",
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "footer" : {
                "expression" : "avg",
                "styles" : {
                    "fontName" : "Arial",
                    "fontBold" : true,
                    "numberFormat" : "#,##0.00"
                }
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : "90",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Amount",
            "type" : "calced",
            "expression" : "Values['unit_price'] * Values['quantity']",
            "width" : "90",
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "##0.0"
            },
            "header" : {
                "text" : "Amount"
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : "90",
            "header" : {
                "text" : "OrderDate"
            }
        }, {
            "name" : "ShipDate",
            "fieldName" : "ship_date",
            "width" : "120",
            "header" : {
                "text" : "ShipDate"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : "90",
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "60",
            "header" : {
                "text" : "Currency"
            }
        } ]);

        //grid options
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
        $('#btnFontName').click(function() {
            grdMain.setDefaultStyles({
                fontName : "Courier New"
            });
        });
        $('#btnResetFont').click(function() {
            grdMain.setDefaultStyles({
                fontName : undefined
            });
        });
        $('#btnTextColor').click(function() {
            grdMain.setDefaultStyles({
                color : "#f00"
            });
        });
        $('#btnResetColor').click(function() {
            grdMain.setDefaultStyles({
                color : undefined
            });
        });
        $('#btnSetBorder').click(function() {
            grdMain.setStyles({
                border : "#00f,3px"
            });
        });
        $('#btnSetBorder2').click(function() {
            grdMain.setStyles({
                border : "#f00,2px,dashed"
            });
        });
        $('#btnSetBorder3').click(function() {
            grdMain.setStyles({
                border : null
            });
        });
    });
</script>
</head>
<body>
    <h3>Grid Default Styles</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnFontName">폰트 변경</button>
        <button id="btnResetFont">폰트 리셋</button>
        <button id="btnTextColor">텍스트 색</button>
        <button id="btnResetColor">색상 리셋</button>
    </div>
    <p>
    <div>
        <button id="btnSetBorder">굵은 경계선</button>
        <button id="btnSetBorder2">대시 경계선</button>
        <button id="btnSetBorder3">경계선 없애기</button>
    </div>
</body>
</html>