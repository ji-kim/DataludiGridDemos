<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Set Row Count</title>
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
	var dsMain, dsMain2, dsMain3;
	
	// dataset
	var fields = [{
		fieldName: "field1",
		defaultValue: "fldDef1"
	}, {
		fieldName: "field2",
		defaultValue: "fldDef2"
	}, {
		fieldName: "field3",
		dataType: "number",
		defaultValue: 2345
	}, {
		fieldName: "field4",
		defaultValue: "fldDef4"		
	}];
	dsMain = DataLudi.createGridDataSet();
	dsMain.setFields(fields);
	dsMain2 = DataLudi.createGridDataSet();
	dsMain2.setFields(fields);
	dsMain3 = DataLudi.createGridDataSet();
	dsMain3.setFields(fields);
	
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
	grdMain.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	
	grdMain2.checkBar().setVisible(false);
	grdMain2.rowIndicator().setStateVisible(true);
	grdMain2.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	
	grdMain3.displayOptions().setRowHeight(5);
	grdMain3.displayOptions().setRowResizable(true);
	grdMain3.checkBar().setVisible(false);
	grdMain3.rowIndicator().setStateVisible(true);
	grdMain3.body().setCellDynamicStyles([{
	    expression: 'values["field3"] >= 0',
	    styles: { background: '#3000ff00' }
	}])
	grdMain3.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	
	// connect dataset
	grdMain.setDataSource(dsMain);
	grdMain2.setDataSource(dsMain2);
	grdMain3.setDataSource(dsMain3);
	dsMain.setRowCount(5);
	dsMain.updateRow(0, [ 'value_10', 'value_20', '1111', 'value_30' ]);
	dsMain.updateRow(2, [ 'value_12', 'value_22', '3333', 'value_32' ]);
	dsMain.updateRow(4, [ 'value_14', 'value_24', '5555', 'value_34' ]);
	
	// dataset events
	dsMain.onRowCountChanged = function (ds, count) {
		$("#rowCount").css("color", "blue").text(count.toLocaleString());
	};
	dsMain2.onRowCountChanged = function (ds, count) {
		$("#rowCount2").css("color", "blue").text(count.toLocaleString());
	};
	dsMain3.onRowCountChanged = function (ds, count) {
		$("#rowCount3").css("color", "blue").text(count.toLocaleString());
	};
	
	// buttons
	$('#btnCheckRow').click(function () {
		var row = grdMain.focusedDataIndex();
		if (row >= 0) {
		    alert(dsMain.hasData(row) ? '값 존재' : '값 없음');
		} else {
		    alert('검사할 행을 먼저 선택하세요.');
		}
	});
	$('#btnAddCount').click(function () {
	    var chkDefaults = document.getElementById('chkFieldDefaults').checked;
	    var chkValues = document.getElementById('chkDefaultValues').checked;
	    var chkStates = document.getElementById('chkSetStates').checked;
	    var state = chkStates ? document.getElementById('selState').value : "none";
	    var values;
	    
	    if (chkValues) {
	        values = [ 'def_10', undefined, 7878, 'def_30' ];
	    }
	    dsMain2.setRowCount(dsMain2.rowCount() + 2, chkDefaults, values, state);
	});
	$('#btnCheckRow2').click(function () {
	    var row = grdMain2.focusedDataIndex();
	    if (row >= 0) {
	        alert(dsMain2.hasData(row) ? '값 존재' : '값 없음');
	    } else {
	        alert('검사할 행을 먼저 선택하세요.');
	    }
	});
	$('#btnRun').click(function () {
	    var scroll = document.getElementById('chkAutoScroll').checked;
	    
	    dsMain3.clearRows();
	    dsMain3.setRowCount(1000);
	    
	    for (var i = 0; i < 200; i++) {
	        (function (start) {
	            setTimeout(function () {
	                var rows = [];
	                for (var r = 0; r < 5; r++) {
	                    rows.push(['aaa', 'bbb', start + r, 'ccc']);
	                }
	                dsMain3.updateRows(start, rows);
	                scroll && grdMain3.setTopIndex(start);
	                
	                if (start == 199 * 5) {
	                    grdMain3.displayOptions().setRowHeight(15);
	                }
	            }, Math.random() * 10000);
	        })(i * 5);
	    }
	});
});
</script>
</head>
<body>
<h3>Set RowCount</h3>
<div style="margin-bottom:4px;">
	<button id="btnCheckRow">Check Row Data</button>
</div>
<div id="container" style="height:550px;width:740px;min-width:500px;"></div>
<div><span id="rowCount" style="">0</span> rows.</div>
<p>
<div>
	<input type="checkbox" id="chkFieldDefaults" value="true">Use Field Defaults
	<input type="checkbox" id="chkDefaultValues" value="true">Set Default Values
	<input type="checkbox" id="chkSetStates" value="true">Set Row States
	<select id="selState">
		<option value="none">DataRowState.NONE</option>
		<option value="created">DataRowState.CREATED</option>
		<option value="updated">DataRowState.UPDATED</option>
	</select>
</div>
<div>
	<button id="btnAddCount">Add Row Count</button>
	<button id="btnCheckRow2">Has Data?</button>
</div>
<div id="container2" style="height:550px;width:740px;min-width:500px;"></div>
<div><span id="rowCount2" style="">0</span> rows.</div>
<p>
<div>
	<button id="btnRun">실행</button>	
	<input type="checkbox" id="chkAutoScroll" value="true">자동 스크롤
</div>
<div id="container3" style="height:550px;width:740px;min-width:500px;"></div>
<div><span id="rowCount3" style="">0</span> rows.</div>
</body>
</html>