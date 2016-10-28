<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계산필드 & RowTag</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
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
        fieldName: "qty_tag",
        dataType: "number",
        expression: "quantity + (numz tag)"
    }];
    dsMain.setFields(fields, calcedFields);

    // grid
    grdMain = DataLudi.createGridView("container");
    grdMain.setColumns([                {
        "name": "ProductName",
        "fieldName": "product_name",
        "width": 200,
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
        "width": 100,
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
        "name": "QtyTag",
        "fieldName": "qty_tag",
        "width": 111,
        "styles": {
            "background": "#1000ff88",
            "numberFormat": "#,##0.00",
            "textAlignment": "far"
        },
        "dynamicStyles": {
            "expression": "value > 10000",
            "styles": {
                "color": "#00f",
                "fontBold": true
            }
        },
        "header": {
            "text": "QtyTag"
        },
        "footer": {
            "expression": "sum",
            "styles": {
                "background": "#2000ff88",
                "color": "#000088",
                "numberFormat": "#,##0.00"
            }
        }
    }]);

    // grid options
    grdMain.setOptions({
        checkBar: false,
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
            rowDynamic: {
                expression: "numz tag > 0",
                styles: {
                    background: "#10ff0000"
                }
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
            $("#rowCount").css("color", "blue").text(ds.rowCount().toLocaleString());
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
    
    // buttons
    $('#btnSetTag').click(function () {
        var row = grdMain.focusedDataIndex();
        if (row >= 0) {
            dsMain.setRowTag(row, '20000');
        }
    });
    $('#btnUnsetTag').click(function () {
        var row = grdMain.focusedDataIndex();
        if (row >= 0) {
            dsMain.unsetRowTags(row);
        }
    });
    $('#btnCalcRow').click(function () {
        var row = grdMain.focusedDataIndex();
        if (row >= 0) {
            dsMain.recalcRows(row);
        }
    });
    $('#btnSetTags').click(function () {
        var rows = grdMain.getSelectedDataIndices();
        if (rows && rows.length > 0) {
            dsMain.setRowTags(rows, '20000');
        }
    });
    $('#btnUnsetTags').click(function () {
        var rows = grdMain.getSelectedDataIndices();
        if (rows && rows.length > 0) {
            dsMain.unsetRowTags(rows);
        }
    });
    $('#btnCalcRows').click(function () {
        var rows = grdMain.getSelectedDataIndices();
        if (rows && rows.length > 0) {
            dsMain.recalcRows(rows);
        }
    });
    $('#btnSetTagAll').click(function () {
        dsMain.setRowTags(null, '20000');
    });
    $('#btnUnsetTagAll').click(function () {
        dsMain.unsetRowTags();
    });
    $('#btnCalcRowAll').click(function () {
        dsMain.recalcRows();
    });
});
</script>
</head>
<body>
<h3>계산필드 & RowTag</h3>
<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
<span id="rowCount" style="">0</span> rows.
<div>
    <button id="btnSetTag">Set Row Tag</button>
    <span>포커스행에 rowTag '10000'을 설정한다. (클릭 후 아래 재계산을 실행한다.)</span>
</div>
<div>
    <button id="btnUnsetTag">Unset Row Tag</button>
    <span>포커스행의 rowTag를 제거한다. (클릭 후 아래 재계산을 실행한다.)</span>
</div>
<div>
    <button id="btnCalcRow">Recalculate Row</button>
    <span>포커스행의 계산 필드를 다시 계산한다.</span>
</div>
<div>
    <button id="btnSetTags">Set Rows Tag</button>
    <span>text: 선택 행들의 rowTag를 '20000'으로 설정한다. (클릭 후 아래 재계산을 실행한다.)</span>
</div>
<div>
    <button id="btnUnsetTags">Unset Rows Tag</button>
    <span>선택 행들의 rowTag를 제거한다. (클릭 후 아래 재계산을 실행한다.)</span>
</div>
<div>
    <button id="btnCalcRows">Recalculate Rows</button>
    <span>선택 행들의 계산 필드를 다시 계산한다.</span>
</div>
<div>
    <button id="btnSetTagAll">Set All Rows Tag</button>
    <span>모든 행들의 rowTag를 '20000'으로 설정한다. (클릭 후 아래 재계산을 실행한다.)</span>
</div>
<div>
    <button id="btnUnsetTagAll">Unset All Rows Tag</button>
    <span>모든 행들의 rowTag를 제거한다. (클릭 후 아래 재계산을 실행한다.)</span>
</div>
<div>
    <button id="btnCalcRowAll">Recalculate All Rows</button>
    <span>모든 행들의 계산 필드를 다시 계산한다.</span>
</div>
</body>
</html>