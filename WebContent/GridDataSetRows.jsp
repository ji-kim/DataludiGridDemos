<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>GridDataSet Rows</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
$(document).ready(function () {
    DataLudi.setDebug(true);
    DataLudi.setTrace(true);
    
    var grdMain, grdMain2;
    var dsMain, dsMain2;
    
    // dataset
    var fields = [{
        fieldName: "loan_number"
    }, {
        fieldName: "country"
    }, {
        fieldName: "interest_rate",
        dataType: "number"
    }, {
        fieldName: "currency"
    }, {
        fieldName: "project_id"
    }, {
        fieldName: "original_amount",
        dataType: "number"
    }, {
        fieldName: "cancelled_amount",
        dataType: "number"
    }, {
        fieldName: "disbursed_amount",
        dataType: "number"
    }, {
        fieldName: "repaid_amount",
        dataType: "number"
    }, {
        fieldName: "sold_amount",
        dataType: "number"
    }, {
        fieldName: "first_date",
        dataType: "datetime",
        datetimeFormat: "MM/dd/yyyy"
    }, {
        fieldName: "last_date",
        dataType: "datetime",
        datetimeFormat: "MM/dd/yyyy"
    }];
    dsMain = DataLudi.createGridDataSet();
    dsMain.setFields(fields);
    dsMain2 = DataLudi.createGridDataSet();
    dsMain2.setFields(fields);
    
    // grid
    var columns = [{
        "name": "LoanNumber",
        "fieldName": "loan_number",
        "width": "70",
        "styles": {
            textAlignment: "center"
        },
        "header": {
            "text": "LoanNumber"
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
        "name": "InterestRate",
        "fieldName": "interest_rate",
        "width": "65",
        "styles": {
            "textAlignment": "far"
        },
        "header": {
            "text": "InterestRate"
        }
    }, {
        "name": "Currency",
        "fieldName": "currency",
        "width": "90",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Currency"
        }
    }, {
        "name": "ProjectID",
        "fieldName": "project_id",
        "width": "70",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "ProjectID"
        }
    }, {
        "name": "OriginalAmount",
        "fieldName": "original_amount",
        "width": 105,
        "styles": {
            "textAlignment": "far"
        },
        "header": {
            "text": "OriginalAmount"
        }
    }, {
        "name": "CancelledAmount",
        "fieldName": "cancelled_amount",
        "width": 100,
        "styles": {
            "textAlignment": "far"
        },
        "header": {
            "text": "CancelledAmount"
        }
    }, {
        "name": "DisbursedAmount",
        "fieldName": "disbursed_amount",
        "width": 110,
        "styles": {
            "textAlignment": "far"
        },
        "header": {
            "text": "DisbursedAmount"
        }
    }, {
        "name": "RepaidAmount",
        "fieldName": "repaid_amount",
        "width": 110,
        "styles": {
            "textAlignment": "far"
        },
        "header": {
            "text": "RepaidAmount"
        }
    }, {
        "name": "SoldAmount",
        "fieldName": "sold_amount",
        "width": 110,
        "styles": {
            "textAlignment": "far"
        },
        "header": {
            "text": "SoldAmount"
        }
    },  {
        "name": "FirstDate",
        "fieldName": "first_date",
        "width": "90",
        "styles": {
            datetimeFormat: "yyyy-MM-dd",
            textAlignment: "center"
        },
        "header": {
            "text": "FirstDate"
        }
    },  {
        "name": "LastDate",
        "fieldName": "last_date",
        "width": "90",
        "styles": {
            datetimeFormat: "yyyy-MM-dd",
            textAlignment: "center"
        },
        "header": {
            "text": "LastDate"
        }
    }];

    grdMain = DataLudi.createGridView("container");
    grdMain.setColumns(columns);
    grdMain2 = DataLudi.createGridView("container2");
    grdMain2.setColumns(columns);
    
    //grid options
	grdMain.header().setHeight(30);
	grdMain.footer().setVisible(false);
	grdMain.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
    
    grdMain2.header().setHeight(30);
    grdMain2.footer().setVisible(false);
    grdMain2.header().head().setPopupMenu({
        label: 'DataLudi Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
    
    // connect dataset
    grdMain.setDataSource(dsMain);
    grdMain2.setDataSource(dsMain2);
    $.ajax({
        url: "data/loan_statement_small.csv",
        dataType: 'text',
        success: function (data) {
            new DataLudi.DataLoader(dsMain).load("csv", data, {
                start: 1,
                quoted: true,
                currency: true
            });
        },
        error: function (xhr, status, error) {
            var err = status + ', ' + error;
            alert("jQuery getJSON() Failed: " + err);
        }
    });
    
    // dataset events
    dsMain.onRowCountChanged = function (ds, count) {
        $("#rowCount").css("color", "blue").text(count.toLocaleString());
    };
    dsMain2.onRowCountChanged = function (ds, count) {
        $("#rowCount2").css("color", "blue").text(count.toLocaleString());
    };

    // buttons
    $('#btnGetValue').click(function () {
        var index = grdMain.focusedIndex();
        if (grdMain.isValidCell(index)) {
            var v = dsMain.getValue(index.getDataIndex(grdMain), index.dataField());
            var row = {};
            row[dsMain.getFieldName(index.dataField())] = v;
            $('#comment').text("GetValue");
            dsMain2.appendRow(row);
        } else {
            alert('값을 가져올 셀을 선택하세요');  
        }
    });
    $('#btnGetValues').click(function () {
        var r = grdMain.focusedDataIndex();
        if (r >= 0) {
            var row = dsMain.getValues(r);
            document.getElementById('conMain').value = JSON.stringify(row, null, 2);
            $('#comment').text("GetRow");
            dsMain2.appendRow(row);
        } else {
            alert('값을 가져올 행을 선택하세요');  
        }
    });
    $('#btnGetObject').click(function () {
        var r = grdMain.focusedDataIndex();
        if (r >= 0) {
            var row = dsMain.getRowObject(r);
            document.getElementById('conMain').value = JSON.stringify(row, null, 2);
            $('#comment').text("GetObject");            
            dsMain2.appendRow(row);
        } else {
            alert('값을 가져올 행을 선택하세요');  
        }
    });
    $('#btnGetRows').click(function () {
        var r = grdMain.focusedDataIndex();
        if (r >= 0) {
            var rows = dsMain.getRows(r, 2);
            document.getElementById('conMain').value = JSON.stringify(rows, null, 2);
            $('#comment').text("GetRows");
            dsMain2.appendRows(rows);
        } else {
            alert('값을 가져올 시작 행을 선택하세요');  
        }
    });
    $('#btnGetObjects').click(function () {
        var r = grdMain.focusedDataIndex();
        if (r >= 0) {
            var rows = dsMain.getRowObjects(r, 2);
            document.getElementById('conMain').value = JSON.stringify(rows, null, 2);
            $('#comment').text("GetObjects");
            dsMain2.appendRows(rows);
        } else {
            alert('값을 가져올 시작 행을 선택하세요');  
        }
    });
    $('#btnGetAll').click(function () {
        var rows = dsMain.getRows();
        document.getElementById('conMain').value = JSON.stringify(rows.slice(0, 10), null, 2);
        $('#comment').text("GetAllRows (top 20 rows)");
        dsMain2.setRows(rows);
    });    
});
</script>
</head>
<body>
<h3>GridDataSet Rows</h3>
<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
    <button id="btnGetValue">Get Value</button>
    <button id="btnGetValues">Get Values</button>
    <button id="btnGetObject">Get Object</button>
    <button id="btnGetRows">Get Rows</button>
    <button id="btnGetObjects">Get Objects</button>
    <button id="btnGetAll">Get All Rows</button>      
</div>
<div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount2" style="">0</span> rows.
</div>
<p>
<div>
    <span id="comment" style=""></span>
</div>
<textarea id="conMain" class="helpMemo" style="width:730px;min-height:200px;"></textarea>
</body>
</html>