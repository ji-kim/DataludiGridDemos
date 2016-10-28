<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Data Row State</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
$(document).ready(function () {
    DataLudi.setDebug(true);
    DataLudi.setTrace(true);
    
    var grdMain;
    var dsMain;
    
    // dataset
    dsMain = DataLudi.createGridDataSet();
    dsMain.setFields([{
	    fieldName: "country"
	}, {
	    fieldName: "year",
	    dataType: "number"
	}, {
	    fieldName: "comm_code"
	}, {
	    fieldName: "commodity"
	}, {
	    fieldName: "flow"
	}, {
	    fieldName: "trade",
	    dataType: "number"
	}, {
	    fieldName: "weight",
	    dataType: "number"
	}, {
	    fieldName: "unit"
	}]);
    
    // grid
    grdMain = DataLudi.createGridView("container");
    grdMain.setColumns([{
        "name": "Country",
        "fieldName": "country",
        "width": "70",
        "styles": {
        },
        "header": {
            "text": "Country"
        }
    }, {
        "name": "CommCode",
        "fieldName": "comm_code",
        "width": "90",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "CommCode"
        }
    }, {
        "name": "Commodity",
        "fieldName": "commodity",
        "width": "200",
        "styles": {
        },
        "header": {
            "text": "Commodity"
        }
    }, {
        "name": "Year",
        "fieldName": "year",
        "width": "60",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Year"
        }
    }, {
        "name": "Flow",
        "fieldName": "flow",
        "width": 60,
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Flow"
        }
    }, {
        "name": "Trade",
        "fieldName": "trade",
        "width": 60,
        "styles": {
            "textAlignment": "far",
            "numberFormat": "#,##0"
        },
        "header": {
            "text": "Trade"
        },
        "groupFooter": {
            "expression": "sum",
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0"
            }
        }
    }, {
        "name": "Weight",
        "fieldName": "weight",
        "width": 70,
        "styles": {
            "textAlignment": "far",
            "numberFormat": "#,##0"
        },
        "header": {
            "text": "Weight"
        },
        "groupFooter": {
            "expression": "sum",
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0"
            }
        }
    }, {
        "name": "Unit",
        "fieldName": "unit",
        "width": 120,
        "styles": {
        },
        "header": {
            "text": "Unit"
        }
    }]);
    
    //grid options
    grdMain.setRowIndicator({
	     stateVisible: true 
	})
	.setEditOptions({
	     insertable: true,
	     appendable: true,
	     deletable: true,
	     softDelete: true
	});
    grdMain.checkBar().setDraggable(true);
    grdMain.header().head().setPopupMenu({
        label: 'DataLudi Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
    
    // connect dataset
    grdMain.setDataSource(dsMain);
    $.ajax({
        url: "data/un_comtrade_of_goods_ss.csv",
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
            alert("jQuery ajax() Failed: " + err);
        }
    });
    
    // dataset events
    dsMain.onRowCountChanged = function (ds, count) {
        $("#rowCount").css("color", "blue").text(count.toLocaleString());
    };

    // buttons
    $('#btnGetState').click(function () {
        var row = grdMain.focusedRow();
        if (row && row.dataIndex() >= 0) {
            var state = dsMain.getRowState(row.dataIndex());
            $('#txtRowState').text('"' + state + '"');
        }
    });
    $('#btnSetState').click(function () {
        var row = grdMain.focusedRow();
        if (row && row.dataIndex() >= 0) {
            var state = $("input[name='rgpRowState']:checked").val();
            dsMain.setRowState(row.dataIndex(), state);
        }
    });
    $('#btnSetStates').click(function () {
        var rows = grdMain.getCheckedRows();
        if (rows && rows.length > 0) {
            var state = $("input[name='rgpRowState3']:checked").val();
            for (var r = rows.length; r--;) rows[r] = rows[r].dataIndex();
            dsMain.setRowStates(rows, state);
        }
    });
    $('#btnClearStates').click(function () {
        dsMain.clearRowStates(null, document.getElementById('chkDeleteRows').checked);
    });
    $('#btnGetStateRows').click(function () {
        var state = $("input[name='rgpRowState2']:checked").val();
        var rows = dsMain.getStateRows(state);
        $('#txtRows').text('rows: [' + rows + ']');
        $('#txtMemo').text('상태별 행 목록 가져오기');
        document.getElementById('conMain').value = JSON.stringify(rows);
    });
    $('#btnAllStateRows').click(function () {
        var rows = dsMain.getAllStateRows();
        $('#txtMemo').text('모든 상태별 행 목록 가져오기');
        document.getElementById('conMain').value = JSON.stringify(rows);
    });
    $('#btnModifiedObjects').click(function () {
        var rows = dsMain.getModifiedRowObjects(null, null, null, ['c', 'u', 'd'], '');
        $('#txtMemo').text('상태별 변경 행들 가져오기 (' + rows.length + ' rows)');
        document.getElementById('conMain').value = JSON.stringify(rows);
    });
});
</script>
</head>
<body>
<h3>Data Row State</h3>
<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
    <button id="btnGetState">현재 행 데이터 상태 가져오기=></button>
    <span id='txtRowState'></span>
</div>
<div>
    <button id="btnSetState">현재 행 상태 설정</button>
    <input type="radio" name="rgpRowState" value="none">DataLudi.DataRowStat.NONE
    <input type="radio" name="rgpRowState" value="created">CREATED
    <input type="radio" name="rgpRowState" value="updated" checked="checked">UPDATED
    <input type="radio" name="rgpRowState" value="deleted">DELETED
    <input type="radio" name="rgpRowState" value="createAndDeleted">CREATE_AND_DELETED   
</div>
<div>
    <button id="btnSetStates">Checked 행들 상태 설정</button>
    <input type="radio" name="rgpRowState3" value="none">NONE
    <input type="radio" name="rgpRowState3" value="created">CREATED
    <input type="radio" name="rgpRowState3" value="updated" checked="checked">UPDATED
    <input type="radio" name="rgpRowState3" value="deleted">DELETED
    <input type="radio" name="rgpRowState3" value="createAndDeleted">CREATE_AND_DELETED   
</div>
<div>
    <button id="btnClearStates">행 상태 모두 지우기</button>
    <input type="checkbox" id="chkDeleteRows" value="">삭제 상태 행들 삭제
</div>
<div>
    <button id="btnGetStateRows">상태별 행 목록 가져오기</button>
    <input type="radio" name="rgpRowState2" value="created">CREATED
    <input type="radio" name="rgpRowState2" value="updated" checked="checked">UPDATED
    <input type="radio" name="rgpRowState2" value="deleted">DELETED
    <input type="radio" name="rgpRowState2" value="createAndDeleted">CREATE_AND_DELETED
    <span id="txtRows"></span>
</div>
<div>
    <button id="btnAllStateRows">모든 상태별 행 목록 가져오기</button> 
</div>
<div>
    <button id="btnModifiedObjects">상태별 변경 행들 가져오기</button>   
</div>
<div><span id="txtMemo"></span></div>
<textarea id="conMain" class="helpMemo" style="width:730px;min-height:200px;"></textarea>
</body>
</html>