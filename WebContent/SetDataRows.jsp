<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Set DataRows</title>
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
	
	var grdMain;
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
	
	//grid
	grdMain = DataLudi.createGridView("container");
	grdMain.setColumns([{
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
	}]);
	
	// grid options
    grdMain.rowIndicator().setStateVisible(true);
    grdMain.checkBar().setVisible(false);
    grdMain.header().setHeight(30);
    grdMain.header().head().setPopupMenu({
        label: 'DataLudi Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });

    // connect dataset
    grdMain.setDataSource(dsMain);
    dsMain.setRows([
		[ 'value_10', 'value_20', '1111', 'value_30' ],
		[ 'value_11', 'value_21', '2222', 'value_31' ],
		[ 'value_12', 'value_22', '3333', 'value_32' ],
		[ 'value_13', 'value_23', '4444', 'value_33' ],
		[ 'value_14', 'value_24', '5555', 'value_34' ]
	]);

    // dataset events
	dsMain.onRowCountChanged = function (ds) {
		$("#rowCount").css("color", "blue").text(count.toLocaleString());
	};            
   
	// buttons
	$('#btnClear').click(function () {
		dsMain.clearRows();
	});
	$('#btnSetArray').click(function () {
		var rows = [
			[ 'value_101', 'value_20', '1111', 'value_30' ],
			[ 'value_111', 'value_21', '2222', 'value_31' ],
			[ 'value_121', 'value_22', '3333', 'value_32' ],
			[ 'value_131', 'value_23', '4444', 'value_33' ],
			[ 'value_141', 'value_24', '5555', 'value_34' ]
		];
		dsMain.setRows(rows);
	});
	$('#btnSetJson').click(function () {
		var rows = [
			{ field1: 'value_101', field2: 'value_20', field3: '5555', field4: 'value_30' },
			{ field1: 'value_111', field2: 'value_21', field3: '6666', field4: 'value_31' },
			{ field1: 'value_121', field2: 'value_22', field3: '7777', field4: 'value_32' },
			{ field1: 'value_131', field2: 'value_23', field3: '8888', field4: 'value_33' }
		];
		dsMain.setRows(rows, 1, 2, "created");
	});
	$('#btnSetXml').click(function () {
		var rows = "<rows><row><field1>value_777</field1><field2>value_888</field2><field3>9999</field3><field4>value_999</field4></row></rows>";
		var xml = DataLudi.parseXml(rows);
		dsMain.setXmlRows(xml.documentElement.childNodes);
	});
});
</script>
</head>
<body>
<h3>Set DataRows</h3>
<div style="margin-bottom:4px;">
	<button id="btnClear">Clear Rows</button>
	<button id="btnSetArray">Set Array Rows</button>
	<button id="btnSetJson">Set Json Rows</button>
	<button id="btnSetXml">Set Xml Rows</button>
</div>
<div id="container" style="height:550px;width:740px;min-width:500px;"></div>
<div><span id="rowCount" style="">0</span> rows.</div>
</body>
</html>