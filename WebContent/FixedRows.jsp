<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Fixed Rows</title>
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
            "width" : "100",
            "header" : {
                "text" : "UnitPrice"
            },
            "styles" : {
                "textAlignment" : "far"
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : "100",
            "header" : {
                "text" : "Quantity"
            },
            "styles" : {
                "textAlignment" : "far"
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
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ShipDate"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "Unit"
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
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(false);
        grdMain.displayOptions().setFixedRowCount(2);

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
        $('#btnFixedRows').click(function() {
            var n = Math.max(0, document.getElementById('edtFixedRows').value);
            grdMain.displayOptions().setFixedRowCount(n);
        });
        $('#btnMaxRows').click(function() {
            var n = Math.max(0, document.getElementById('edtMaxRows').value);
            grdMain.setMaxRowCount(n);
        });
        $('#btnBackground').click(function() {
            grdMain.body().setFixedRowStyles({
                background : "#ff00ffff"
            });
        });

        $('#btnBackground2').click(function() {
            grdMain.body().setFixedRowStyles({
                background : "#ccc"
            });
        });
        $('#btnFixedBarStyles').click(function() {
            grdMain.setBody({
                fixedRowBarHeight : 5,
                fixedRowBarStyles : {
                    background : "#ccc",
                    borderTop : "#777",
                    borderBottom : "#777"
                }
            });
        });
    });
</script>
</head>
<body>
    <h3>Fixed Rows</h3>
    <div>
        <input type="text" id="edtFixedRows" value="2">
        <button id="btnFixedRows">Fixed Col Count</button>
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="text" id="edtMaxRows" value="0">
        <button id="btnMaxRows">Max Row Count</button>
    </div>
    <div>
        <button id="btnBackground">고정행 배경색 변경</button>
        <button id="btnBackground2">고정행 배경색 변경 2</button>
        <button id="btnFixedBarStyles">고정행 구분 막대 스타일</button>
    </div>
</body>
</html>