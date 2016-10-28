<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Number Value</title>
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
    var dsMain;
    
    // dataset
    dsMain = DataLudi.createGridDataSet();
    dsMain.setFields([{
        fieldName: "field1",
        dataType: 'number',
        nanValue: 1
    }, {
        fieldName: "field2",
        dataType: "number"
    }, {
        fieldName: "field3",
        dataType: "number"
    }, {
        fieldName: "field4",
        dataType: "number"
	}]);
    dsMain.setNanValue(0);
    
    // grid
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
            "textAlignment": "center"
        },
        "header": {
            "text": "Field3"
        }
    }, {
        "name": "col4",
        "fieldName": "field4",
        "width": "130",
        "nanText": "<NaN>",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Field4"
        },
        "editor": {
            "emptyValue": 77
        }
    }]);

    grdMain2 = DataLudi.createGridView("container2");
    grdMain2.setColumns([{
        "name": "col1",
        "fieldName": "field1",
        "width": "130",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "format1"
        }
    }, {
        "name": "col2",
        "fieldName": "field2",
        "width": "130",
        "styles": {
            "textAlignment": "center",
            "numberFormat": "#,##0.00",
            "background": "#1000ff00",
            "fontBold": true
        },
        "header": {
            "text": "format2"
        }
    }, {
        "name": "col3",
        "fieldName": "field3",
        "width": "130",
        "styles": {
            "textAlignment": "center",
            "prefix": "$"
        },
        "header": {
            "text": "format3"
        }
    }, {
        "name": "col4",
        "fieldName": "field4",
        "width": "130",
        "styles": {
            "textAlignment": "center",
            "suffix": "%"
        },
        "header": {
            "text": "format4"
        }
    }]);

    // grid options
	grdMain.checkBar().setVisible(false);
	grdMain.footer().setVisible(false);
	grdMain.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	
    grdMain2.checkBar().setVisible(false);
    grdMain2.footer().setVisible(false);
    grdMain2.header().head().setPopupMenu({
        label: 'DataLudi Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
  
    // connect dataset
    grdMain.setDataSource(dsMain);
    grdMain2.setDataSource(dsMain);
    dsMain.addRow([undefined, null, undefined, 'abc']);
    dsMain.addRow([31415.92, 2718281, 1.4141592, 0]);
    
    // dataset events
    dsMain.onRowCountChanged = function (ds, count) {
        $("#rowCount").css("color", "blue").text(count.toLocaleString());
        $("#rowCount2").css("color", "blue").text(count.toLocaleString());
    };
    
    // buttons
    $('#btnAddRow').click(function () {
        var row = {
		    'field1': $('#edtField1').val(),
		    'field2': $('#edtField2').val(),
		    'field3': $('#edtField3').val(),
		    'field4': $('#edtField4').val()
		};	
		dsMain.addRow(row);
    });
    
    // texts
    $('#edtMin').change(function () {
        var fld = dsMain.getFieldByName('field1');
        fld.setMinimum($(this).val() ? Number($(this).val()) : undefined);
    });
    $('#edtMax').change(function () {
        var fld = dsMain.getFieldByName('field1');
        fld.setMaximum($(this).val() ? Number($(this).val()) : undefined);
    });
   $('#edtFormat').change(function () {
        var col = grdMain2.columnByName('col2');
        col.setStyles({ numberFormat: $(this).val() });
    });
    $('#edtPrefix').change(function () {
        var col = grdMain2.columnByName('col3');
        col.setStyles({ prefix: $(this).val() });
    });
    $('#edtSuffix').change(function () {
        var col = grdMain2.columnByName('col4');
        col.setStyles({ suffix: $(this).val() });
    });
});
</script>
</head>
<body>
<h3>Number Value</h3>
<div>
    <span id="txtField1">필드 1:</span>
    <input type="text" class="helpEdit" id="edtField1" value="55">
    <span id="txtField2">필드 2:</span>
    <input type="text" class="helpEdit" id="edtField2" value="222aa">
    <span id="txtField3">필드 3:</span>
    <input type="text" class="helpEdit" id="edtField3" value="1234">
    <span id="txtField4">필드 4:</span>
    <input type="text" class="helpEdit" id="edtField4" value="555">
</div>
<div>
    <span id="txtField11">필드 1:minimum</span>
    <input type="text" class="helpEdit" id="edtMin" value="100">
    <span id="txtField12">필드 1:maximum</span>
    <input type="text" class="helpEdit" id="edtMax" value="999">
    <button id="btnAddRow">Add Row</button>
</div>
<div id="container" style="height: 200px; width: 600px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
    <span id="txtFormat">Field2: numberFormat:</span>
    <input type="text" class="helpEdit" id="edtFormat" value="#,##0.00">
</div>
<div>
    <span id="txtPrefix">Field 3: prefix</span>
    <input type="text" class="helpEdit" id="edtPrefix" value="$">
    <span id="txtSuffix">Field 4: suffix</span>
    <input type="text" class="helpEdit" id="edtSuffix" value="%">
</div>
<div id="container2" style="height: 200px; width: 600px; min-width: 500px"></div>
<div>
    <span id="rowCount2" style="">0</span> rows.
</div>
</body>
</html>