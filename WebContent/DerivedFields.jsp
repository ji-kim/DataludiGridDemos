<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Derived Fields</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> --><script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
$(document).ready(function() {
    DataLudi.setDebug(true);
    DataLudi.setTrace(true);

    var dsMain;
    var grdMain;

    //dataset
    dsMain = DataLudi.createGridDataSet();
    var fields = [
        "product_id",
        "product_name",
        "customer_id",
        "customer_name",
        "country",
        "phone",
        "unit",
        "currency",
        {
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
        }
    ];
    var calcedFields = [{
        fieldName: "amount",
        dataType: "number",
        expression: "unit_price * quantity"
    }, {
        fieldName: "amount2",
        dataType: "number",
        callback: function (ds, fld, row, values) {
            return values[8] * values[9];
        }
    }];
    dsMain.setFields(fields, calcedFields);

    // grid
    grdMain = DataLudi.createGridView("container");
    grdMain.setColumns([{
        "name": "ProductName",
        "fieldName": "product_name",
        "width": 140,
        "styles": {
        },
        "header": {
            "text": "ProductName"
        },
        "footer": {
            "spanNext": 4,
            "text": "SUM (expression, callback)",
            "styles": { 
                "textAlignment": "far", 
                "paddingRight": 12,
                "fontItalic": true
            }
        }
    }, {
        "name": "Country",
        "fieldName": "country",
        "width": 70,
        "styles": {
        },
        "header": {
            "text": "Country"
        }
    }, {
        "name": "Currency",
        "fieldName": "currency",
        "width": 60,
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Currency"
        }
    }, {
        "name": "UnitPrice",
        "fieldName": "unit_price",
        "width": 70,
        "styles": {
            "numberFormat": "#,##0.00",
            "textAlignment": "far"
        },
        "header": {
            "text": "UnitPrice"
        }
    }, {
        "name": "Quantity",
        "fieldName": "quantity",
        "width": 70,
        "styles": {
            "numberFormat": "#,##0.00",
            "textAlignment": "far"
        },
        "header": {
            "text": "Quantity"
        }
    }, {
        "name": "Amount",
        "fieldName": "amount",
        "width": 111,
        "styles": {
            "background": "#1000ff88",
            "numberFormat": "#,##0.00",
            "textAlignment": "far"
        },
        "header": {
            "text": "Amount"
        },
        "footer": {
            "expression": "sum",
            "styles": {
                "background": "#2000ff88",
                "color": "#000088",
                "numberFormat": "#,##0.00"
            }
        }
    }, {
        "name": "Amount2",
        "fieldName": "amount2",
        "width": 111,
        "styles": {
            "background": "#10008844",
            "numberFormat": "#,##0.00",
            "textAlignment": "far"
        },
        "header": {
            "text": "Amount2"
        },
        "footer": {
            "expression": "sum",
            "styles": {
                "background": "#88008844",
                "color": "#ffffff",
                "numberFormat": "#,##0.00"
            }
        }
    }]);

    // grid options
    grdMain.setOptions({
        checkBar: false,
        rowIndicator: {
            stateVisibl: false
        },
        footer: true,
        dsiplay: {
            columnMovalbe: false
        },
        edit: {
            insertable: true,
            appendable: true,
            deletable: true
        },
        autoFill: true,
        header: {
            head: {
                popupMenu: {
                    label: 'DataLudi Version',
                    callback: function () { alert(DataLudi.getVersion()); }
                }
            }
        }
    });
    
    // grid styles
    grdMain.loadStyles({
        body: {
            updated: {
                background: "#0f0000ff"
            },
            created: {
                background: "#0f0088ff"
            }
        }
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
        $("#rowCount").css("color", "green").text(count.toLocaleString());
    };
});
</script>
</head>
<body>
    <h3>Derived Fields</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <span id="rowCount" style="">0</span> rows.
</body>
</html>