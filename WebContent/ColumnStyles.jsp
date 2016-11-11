<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Styles</title>
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
            fieldName: "product_id",
            dataType: "text",
        }, {
            fieldName: "product_name"
        }, {
            fieldName: "customer_id"
        }, {
            fieldName: "customer_name",
        }, {
            fieldName: "country",
        }, {
            fieldName: "phone",
        }, {
            fieldName: "unit",
        }, {
            fieldName: "currency",
        }, {
            fieldName: "unit_price",
            dataType: "number"
        }, {
            fieldName: "quantity",
            dataType: "number"
        }, {
            fieldName: "order_date",
            dataType: "datetime",
            datetimeFormat: "yyyy-MM-dd"
        }, {
            fieldName: "ship_date",
            dataType: "datetime",
            datetimeFormat: "iso"
        } ]);

        // grid        
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name": "ProductId",
            "fieldName": "product_id",
            "width": "90",
            "styles": {
                "background": "#3000ff00"
            },
            "header": {
                "text": "ProductId"
            }
        }, {
            "name": "ProductName",
            "fieldName": "product_name",
            "width": "90",
            "styles": {
            },
            "header": {
                "text": "ProductName"
            }
        }, {
            "name": "CustomerId",
            "fieldName": "customer_id",
            "width": "90",
            "styles": {
                "background": "#300000ff"
            },
            "header": {
                "text": "CustomerId"
            }
        }, {
            "name": "CustomerName",
            "fieldName": "customer_name",
            "width": "90",
            "styles": {
            },
            "header": {
                "text": "CustomerName"
            }
        }, {
            "name": "UnitPrice",
            "fieldName": "unit_price",
            "width": "90",
            "styles": {
                "color": "#880000",
                "prefix": "Curr",
                "numberFormat": "#,##0.00",
                "textAlignment": "far"
            },
            "header": {
                "text": "UnitPrice"
            }
        }, {
            "name": "Quantity",
            "fieldName": "quantity",
            "width": "90",
            "styles": {
                "background": "#555",
                "color": "#fff",
                "textAlignment": "far"
            },
            "header": {
                "text": "Quantity"
            }
        }, {
            "name": "Amount",
            "type": "calced",
            "expression": "Values['unit_price'] * Values['quantity']",
            "width": "90",
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0.00"
            },
            "header": {
                "text": "Amount"
            }
        },  {
            "name": "OrderDate",
            "fieldName": "order_date",
            "width": "90",
            "styles": {
                "datetimeFormat": "yyyy-MM-dd",
                "textAlignment": "center"
            },
            "header": {
                "text": "OrderDate"
            }
        },  {
            "name": "ShipDate",
            "fieldName": "ship_date",
            "width": "120",
            "styles": {
            "datetimeFormat": "yyyy-MM-dd",
            "textAlignment": "center"
            },
            "header": {
                "text": "ShipDate"
            }
        }, {
            "name": "Country",
            "fieldName": "country",
            "width": "70",
            "styles": {
            },
            "header": {
                "text": "Country"
            }
        }, {
            "name": "Unit",
            "fieldName": "unit",
            "width": "90",
            "styles": {
            },
            "header": {
                "text": "Unit"
            }
        }, {
            "name": "Currency",
            "fieldName": "currency",
            "width": "60",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "Currency"
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(false);
        
        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url: "data/orders_s.csv",
            dataType: 'text',
            success: function (data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start:1
                });
            },
            error: function (xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
        
        // buttons
        $('#btnFontBold').click(function() {
            var column = grdMain.focusedIndex().column;
            if (!column) alert('Please choose a column !')
            column && column.styles().setFontBold(true);
        });
        $('#btnFontNormal').click(function() {
            var column = grdMain.focusedIndex().column;
            if (!column) alert('Please choose a column !')
            column && column.styles().setFontBold(false);
        });
        $('#btnFontLarger').click(function() {
            var column = grdMain.focusedIndex().column;
            var size = column.styles().fontSize();
            if (!column) alert('Please choose a column !')
            column && column.styles().setFontSize(Math.min(20, size + 1));
        });
        $('#btnFontSmaller').click(function() {
            var column = grdMain.focusedIndex().column;
            var size = column.styles().fontSize();
            if (!column) alert('Please choose a column !')
            column && column.styles().setFontSize(Math.max(5, size - 1));
        });
    });
</script>
</head>
<body>
    <h3>Column Styles</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnFontBold">굵은 글씨로</button>
        <button id="btnFontNormal">보통 글씨로</button>
        <button id="btnFontLarger">큰 폰트로</button>
        <button id="btnFontSmaller">작은 폰트로</button>
    </div>
</body>
</html>