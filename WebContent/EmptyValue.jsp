<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Empty Value</title>
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
        dataType: "number",
        nanValue: -1
    }, {
        fieldName: "unit"
    }]);
    dsMain2 = DataLudi.createGridDataSet();
    dsMain2.setFields([{
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
        dataType: "number",
        nanValue: "-"
    }, {
        fieldName: "unit"
    }]);
    
    // grid
    grdMain = DataLudi.createGridView("container");
    grdMain.setColumns([{
        "name": "Country",
        "fieldName": "country",
        "width": 70,
        "defaultValue": "Japan",
        "styles": {
        },
        "header": {
            "text": "Country"
        }
    }, {
        "name": "CommCode",
        "fieldName": "comm_code",
        "width": 90,
        "defaultExpression": "rand 1000000",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "CommCode"
        }
    }, {
        "name": "Commodity",
        "fieldName": "commodity",
        "width": 200,
        "styles": {
        },
        "header": {
            "text": "Commodity"
        }
    }, {
        "name": "Year",
        "fieldName": "year",
        "width": 60,
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
            "background": "#100088ff",
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
            "background": "#250088ff",
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

    grdMain2 = DataLudi.createGridView("container2");
    grdMain2.setColumns([{
        "name": "Country",
        "fieldName": "country",
        "width": 70,
        "defaultValue": "Japan",
        "styles": {
        },
        "header": {
            "text": "Country"
        }
    }, {
        "name": "CommCode",
        "fieldName": "comm_code",
        "width": 90,
        "defaultExpression": "rand 1000000",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "CommCode"
        }
    }, {
        "name": "Commodity",
        "fieldName": "commodity",
        "width": 200,
        "styles": {
        },
        "header": {
            "text": "Commodity"
        }
    }, {
        "name": "Year",
        "fieldName": "year",
        "width": 60,
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
        "nanText": "-",
        "styles": {
            "background": "#100088ff",
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
            "background": "#250088ff",
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

    // grid options
	grdMain.editOptions().setInsertable(true).setAppendable(true);
	grdMain.header().setHeight(0);
	grdMain.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	grdMain.footer().setVisible(false);
	grdMain.vscrollBar().setBarWidth(12);
	grdMain.hscrollBar().setBarWidth(12);
	grdMain.loadStyles({
	    body: {
	        updated: {
	            background: '#10ff0000'
	        }
	    }
	})
	
	grdMain2.editOptions().setInsertable(true).setAppendable(true);
	//grdMain2.setDisplayOptions({ nanText : '<nan>' });
	grdMain2.displayOptions().setNanText('<nan>');
	grdMain2.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	grdMain2.footer().setVisible(false);
	grdMain2.vscrollBar().setBarWidth(12);
	grdMain2.hscrollBar().setBarWidth(12);
  
    // connect dataset
    grdMain.setDataSource(dsMain);
    $.ajax({
        url: "data/un_comtrade_of_goods_ss.csv",
        dataType: 'text',
        success: function (data) {
            new DataLudi.DataLoader(dsMain).load("csv", data, {
                start: 1,
                count: 10,
                quoted: true,
                currency: true
            });
        },
        error: function (xhr, status, error) {
            var err = status + ', ' + error;
            alert("jQuery ajax() Failed: " + err);
        }
    });
    grdMain2.setDataSource(dsMain2);
	$.ajax({
	    url: "data/un_comtrade_of_goods_ss.csv",
	    dataType: 'text',
	    success: function (data) {
	        new DataLudi.DataLoader(dsMain2).load("csv", data, {
	            start: 1,
	            count: 10,
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
    dsMain.onRowCountChanged = function (ds, count) {
        $("#rowCount2").css("color", "blue").text(count.toLocaleString());
    };
    
    // buttons
    $('#btnSetNaN').click(function () {
		var row = grdMain.focusedRow();
		if (row) {
		    dsMain.setValue(row.dataIndex(), 'trade', NaN);
		    dsMain.setValue(row.dataIndex(), 'weight', NaN);
		}
    });
    $('#btnDataNanValue').click(function () {
        dsMain.setNanValue(Number($('#edtNanValue')[0].value));
    });
    $('#btnFieldNanValue').click(function () {
        dsMain.getFieldByName('weight').setNanValue(Number($('#edtFieldNanValue')[0].value));
    });
    $('#btnFieldEmptyValue').click(function () {
        var s = $('#edtFieldEmptyValue')[0].value;
        dsMain.getFieldByName('trade').setEmptyValue($('#chkUndefined')[0].checked ? undefined : Number(s));
    });
    $('#btnGetObject').click(function () {
        var row = grdMain.focusedRow();
        if (row) {
            var obj = dsMain.getRowObject(row.dataIndex());
            document.getElementById('conMain').value = JSON.stringify(obj);
        }
    });
    $('#btnSetNaN2').click(function () {
		var row = grdMain2.focusedRow();
		if (row) {
		    dsMain2.setValue(row.dataIndex(), 'trade', NaN);
		    dsMain2.setValue(row.dataIndex(), 'weight', NaN);
		}
    });
    $('#btnNanText').click(function () {
        grdMain2.displayOptions().setNanText($('#edtNanText')[0].value);    	
    });
    $('#btnColumnNanText').click(function () {
        grdMain2.columnByField('trade').setNanText($('#edtColumnNanText')[0].value);
    });
});
</script>
</head>
<body>
<h3>Empty Value</h3>
<div>
    <button id="btnSetNaN">Set NaN Value</button>
    <span>포커스 행의 '거래액','거래량'의 값을 NaN으로 변경</span>
</div>
<div>
    <button id="btnDataNanValue">DataSet nanValue</button>
    <input type="text" id="edtNanValue" value="0">데이터셋의 nanValue 설정
</div>
<div>
    <button id="btnFieldNanValue">DataField nanValue</button>
    <input type="text" id="edtFieldNanValue" value="-1">거래량 필드의 nanValue 설정
</div>
<div id="container" style="height: 500px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
    <button id="btnSetEmpty">Set Empty Value</button>
</div>
<div>
    <button id="btnFieldEmptyValue">DataField empty value</button>
    <input type="checkbox" id="chkUndefined" checked="checked">undefined
    <input type="text" id="edtFieldEmptyValue" value="0">거래량 필드의 emptyValue 설정
</div>
<div>
    <button id="btnGetObject">Get Row Object</button>
    <span>현재 행을 json 객체로 리턴한다.</span>
</div>
<textarea id="conMain" class="helpMemo" style="width:740px;min-height:200px;"></textarea>
<p>
<div>
    <button id="btnSetNaN2">Set NaN Value</button>
    <span>포커스 행의 거래액, 거래량의 값을 NaN으로 변경한다.</span>
</div>
<div>
    <button id="btnNanText">DisplayOptions nanText</button>
    <input type="text" id="edtNanText" value="<nan>">DisplayOptions.nanText를 설정한다.
</div>
<div>
    <button id="btnColumnNanText">DataColumn nanText</button>
    <input type="text" id="edtColumnNanText" value="-1">거래액 필드의 DataColumn.nanText 설정
</div>
<div id="container2" style="height: 500px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount2" style="">0</span> rows.
</div>
</body>
</html>