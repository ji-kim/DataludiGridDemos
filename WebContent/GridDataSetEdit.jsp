<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>GridDataSet Edit</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script>
$(document).ready(function () {
    DataLudi.setDebug(true);
    DataLudi.setTrace(true);
    
    var grdMain, grdMain2, grdMain3;
    var dsMain;
    
    // dataset
    dsMain = DataLudi.createGridDataSet();
    dsMain.setFields([{
        fieldName: "field1"
    }, {
        fieldName: "field2"
    }, {
        fieldName: "field3",
        dataType: "number"
    }, {
        fieldName: "field4"
    }]);
    
    // grid
    var columns = [{
        "name": "col1",
        "fieldName": "field1",
        "width": "130",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Field1"
        }
    }, {
        "name": "col2",
        "fieldName": "field2",
        "width": "130",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Field2"
        }
    }, {
        "name": "col3",
        "fieldName": "field3",
        "width": "130",
        "styles": {
            "textAlignment": "far",
            "numberFormat": "#,##0"
        },
        "header": {
            "text": "Field3"
        },
        "footer": {
            "expression": "sum",
            "styles": {
                "fontBold": true,
                "textAlignment": "far",
                "numberFormat": "#,##0"
            }
        }
    }, {
        "name": "col4",
        "fieldName": "field4",
        "width": "130",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Field4"
        }
    }];

    grdMain = DataLudi.createGridView("container");
    grdMain.setColumns(columns);
    grdMain2 = DataLudi.createGridView("container2");
    grdMain2.setColumns(columns);
    grdMain3 = DataLudi.createGridView("container3");
    grdMain3.setColumns(columns);
    
    //grid options
    grdMain.checkBar().setVisible(false);    
    grdMain2.checkBar().setVisible(false);
    grdMain3.checkBar().setDraggable(true);
    grdMain3.setColumns(columns);
    grdMain3.loadStyles({
        body: {
            checked: {
                background: '#1000ff88'
            }
        }
    });
    grdMain.header().head().setPopupMenu({
        label: 'DataLudi Grid Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
    grdMain2.header().head().setPopupMenu({
        label: 'DataLudi Grid Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
    grdMain3.header().head().setPopupMenu({
        label: 'DataLudi Grid Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
    
    // connect dataset
    grdMain.setDataSource(dsMain);
    grdMain2.setDataSource(dsMain);
    grdMain3.setDataSource(dsMain);    
    var rows = [
        [ 'value_10', 'value_20', '1111', 'value_30' ],
        [ 'value_11', 'value_21', '2222', 'value_31' ],
        [ 'value_12', 'value_22', '3333', 'value_32' ],
        [ 'value_13', 'value_23', '4444', 'value_33' ],
        [ 'value_14', 'value_24', '5555', 'value_34' ]
    ];
    dsMain.setRows(rows);
    
    // dataset events
    dsMain.onRowCountChanged = function (ds, count) {
        $("#rowCount").css("color", "blue").text(count.toLocaleString());
    };    
    dsMain.onRowInserted = function (ds, row) {
        alert(row + '행 위치에 새로운 행이 추가됐습니다');  
    };
    dsMain.onRowUpdated = function (ds, row) {
        alert(row + '행의 값들이 변경됐습니다.');  
    };
    dsMain.onRowsInserted = function (ds, row, count) {
        alert(row + '행 위치에 ' + count + '개의 새로운 행들이 추가됐습니다');  
    };   

    // buttons
    $('#btnInsertRow').click(function () {
        var row = Math.max(grdMain.focusedDataIndex(), 0);
        /* 배열로 추가한다. */
        dsMain.insertRow(row, ['v1', 'v2', 123, 'v4']);   
        /* Json 객체로 추가한다. */
        dsMain.insertRow(row + 1, {
            'field1': 'w1', 
            'field2': 'w2', 
            'field3': 321, 
            'field4': 'w4'
        });   
    });
    $('#btnAppendRow').click(function () {
        dsMain.appendRow(['v1', 'v2', 123, 'v4']);   
    });
    $('#btnUpdateRow').click(function () {
        var row = grdMain2.focusedDataIndex();
        if (row >= 0) {
            dsMain.updateRow(row, ['xxx', 'yyy', 777, 'zzz']);
        } else {
            alert('수정할 행을 선택하세요.');
        }
    });
    $('#btnInsertRows').click(function () {
        var row = Math.max(grdMain3.focusedDataIndex(), 0);
        /* 배열로 추가한다. */
        var rows = [
            ['v1', 'v2', 123, 'v4'],
            ['w1', 'w2', 456, 'w4']
        ];
        dsMain.insertRows(row, rows);   
        /* Json 객체로 추가한다. */
        rows = [
            { 'field1': 'x1', 'field2': 'x2', 'field3': 777,  'field4': 'x4' },
            { 'field1': 'y1', 'field2': 'y2', 'field3': 888,  'field4': 'y4'}
        ]
        dsMain.insertRows(row + 2, rows);   
    });
    $('#btnAppendRows').click(function () {
		dsMain.appendRows([
			['v1', 'v2', 123, 'v4'],
			['v11', 'v22', 123123, 'v44']
		]);   
    });
    $('#btnUpdateRows').click(function () {
        var row = grdMain3.focusedDataIndex();
        if (row >= 0) {
            dsMain.updateRows(row, [
                ['xxx', 'yyy', 777, 'zzz'],
                ['aaa', 'bbb', 111, 'ccc']
            ]);
        } else {
            alert('수정할 행을 선택하세요.');
        }
    });
    $('#btnDeleteRow').click(function () {
        var row = grdMain3.focusedDataIndex();
        if (row >= 0) {
            dsMain.deleteRow(row);
        } else {
            alert('삭제할 행을 선택하세요.');
        }
    });
    $('#btnDeleteRows').click(function () {
        var rows = [];
        var checkedRows = [];
        
        for (var i = grdMain3.rowCount(); i--;) {
            var row = grdMain3.getRow(i);
            if (grdMain3.isChecked(row) && row.dataIndex() >= 0) {
                checkedRows.push(row.dataIndex());
            }
        }
        
        if (checkedRows.length > 0) {
            dsMain.deleteRows(checkedRows);
        } else {
            alert('삭제할 행들을 Check 하세요.');
        }
    });
});
</script>
</head>
<body>
<h3>GridDataSet Edit</h3>
<div>
    <button id="btnInsertRow">Insert Row</button>
    <button id="btnAppendRow">Append Row</button>
    <button id="btnUpdateRow">Update Row</button>
</div>
<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
    <button id="btnInsertRows">Insert Rows</button>
    <button id="btnAppendRows">Append Rows</button>
    <button id="btnUpdateRows">Update Rows</button>
</div>
<div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
<p>
<div>
    <button id="btnDeleteRow">Delete Row</button>
    <button id="btnDeleteRows">Delete Rows</button>
</div>
<div id="container3" style="height: 550px; width: 740px; min-width: 500px"></div>
</body>
</html>