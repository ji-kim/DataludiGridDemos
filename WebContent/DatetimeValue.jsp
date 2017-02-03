<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datetime Value</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> --><script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
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
        dataType: 'datetime'
    }, {
        fieldName: "field2",
        dataType: "datetime"
    }, {
        fieldName: "field3",
        dataType: "datetime"
    }, {
        fieldName: "field4",
        dataType: "datetime"
	}]);
    dsMain.setDatetimeFormat("yyyy/MM/dd HH:mm:ss");

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
        "width": "160",
        "styles": {
            "textAlignment": "center",
            "datetimeFormat": "yyyy-MM-dd HH:mm"
        },
        "header": {
            "text": "yyyy-MM-dd HH:mm"
        }
    }, {
        "name": "col2",
        "fieldName": "field2",
        "width": "160",
        "styles": {
            "textAlignment": "center",
            "datetimeFormat": "yyyy-MM-dd"
        },
        "header": {
            "text": "yyyy-MM-dd"
        }
    }, {
        "name": "col3",
        "fieldName": "field3",
        "width": "160",
        "styles": {
            "textAlignment": "center",
            "datetimeFormat": "MM-dd-yyyy"
        },
        "header": {
            "text": "MM-dd-yyyy"
        }
    }, {
        "name": "col4",
        "fieldName": "field4",
        "width": "160",
        "styles": {
            "textAlignment": "center",
            "datetimeFormat": "yy.MM.dd"
        },
        "header": {
            "text": "yy.MM.dd"
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
    grdMain2.setDataSource(dsMain);
    grdMain2.header().styles().setFontBold(false);
    grdMain2.header().head().setPopupMenu({
        label: 'DataLudi Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
  
    // connect dataset
    grdMain.setDataSource(dsMain);
    grdMain2.setDataSource(dsMain);
    dsMain.addRow([undefined, null, undefined, null]);
    dsMain.addRow(['2015/02/02', '2015/11/11', '2015/03/03', '2015/05/05']);   
    
    dsMain.getField(0).setMinimum(new Date('2015/01/01'));
    dsMain.getField(0).setMaximum(new Date('2015/12/31'));
    
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
    	var value = $('#edtMin').val();
        var fld = dsMain.getFieldByName('field1');
        fld.setMinimum(value ? new Date(value) : undefined);
    });
    $('#edtMax').change(function () {
    	var value = $('#edtMax').val();
        var fld = dsMain.getFieldByName('field1');
        fld.setMaximum(value ? new Date(value) : undefined);
    });
});
</script>
</head>
<body>
<h3>Datetime Value</h3>
<div>
    <span id="txtField1">필드 1:</span>
    <input type="text" class="helpEdit" id="edtField1" value="2015/08/01">
    <span id="txtField2">필드 2:</span>
    <input type="text" class="helpEdit" id="edtField2" value="2015/08/01">
    <span id="txtField3">필드 3:</span>
    <input type="text" class="helpEdit" id="edtField3" value="2015/08/01">
    <span id="txtField4">필드 4:</span>
    <input type="text" class="helpEdit" id="edtField4" value="2015/08/01">
</div>
<div>
    <span id="txtField11">필드 1:minimum</span>
    <input type="text" class="helpEdit" id="edtMin" value="2015/01/01">
    <span id="txtField12">필드 1:maximum</span>
    <input type="text" class="helpEdit" id="edtMax" value="2015/12/31">
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