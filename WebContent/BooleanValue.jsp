<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boolean Value</title>
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
    
    var grdMain, grdMain2;
    var dsMain;
    
    // dataset
    dsMain = DataLudi.createGridDataSet();
    dsMain.setFields([{
        fieldName: "field1",
        dataType: "boolean"
    }, {
        fieldName: "field2",
        dataType: "boolean"
    }, {
        fieldName: "field3",
        dataType: "boolean"
    }, {
        fieldName: "field4",
        dataType: "boolean"
	}]);
    
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
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Field4"
        }
    }]);

    grdMain2 = DataLudi.createGridView("container2");
    grdMain2.setColumns([{
        "name": "col1",
        "fieldName": "field1",
        "width": "130",
        "styles": {
            "textAlignment": "center",
            "booleanFormat": "아니오;예;-"
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
            "booleanFormat": "남성;여성"
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
            "booleanFormat": "미지급;지급;유보"
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
            "booleanFormat": "불합격;합격"
        },
        "header": {
            "text": "format4"
        }
    }]);

    // grid options
	grdMain.checkBar().setVisible(false);
	grdMain.footer().setVisible(false);
	grdMain.setDataSource(dsMain);
	grdMain.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	
    grdMain2.checkBar().setVisible(false);
    grdMain2.footer().setVisible(false);
    grdMain2.setDataSource(dsMain);
    grdMain2.body().setCellDynamicStyles([{
        expression: "value",
        styles: { background: "#3000ff00" }
    }]);
    grdMain2.header().head().setPopupMenu({
        label: 'DataLudi Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
  
    // connect dataset
    grdMain.setDataSource(dsMain);
    dsMain.addRow([undefined, null, undefined, null]);
    dsMain.addRow([false, true, false, true]);
    dsMain.addRow([true, false, false, false]);
    
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
		
		if ($('#chkBoolean').is(':checked')) {
		    for (var f in row) {
		        row[f] = Boolean(row[f]);
		    }                
		}
		
		dsMain.addRow(row);
    });
});
</script>
</head>
<body>
<h3>Boolean Value</h3>
<div>
    <span id="txtField1">필드 1:</span>
    <input type="text" class="helpEdit" id="edtField1">
    <span id="txtField2">필드 2:</span>
    <input type="text" class="helpEdit" id="edtField2">
    <span id="txtField3">필드 3:</span>
    <input type="text" class="helpEdit" id="edtField3">
    <span id="txtField4">필드 4:</span>
    <input type="text" class="helpEdit" id="edtField4">
    <input type="checkbox" id="chkBoolean">Boolean()
    <button id="btnAddRow">Add Row</button>
</div>
<div id="container" style="height: 200px; width: 600px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div id="container2" style="height: 200px; width: 600px; min-width: 500px"></div>
<div>
    <span id="rowCount2" style="">0</span> rows.
</div>
</body>
</html>