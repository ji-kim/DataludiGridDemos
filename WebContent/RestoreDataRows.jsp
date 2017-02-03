<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Restore Updated Rows</title>
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
    
    // grid options
	grdMain.setOptions({
	    checkBar: false,
	    rowIndicator: {
	        stateVisible: true
	    },
	    header: {
	        heade: {
	            popupMenu: {
	                label: 'DataLudi Version',
	                callback: function () { alert(DataLudi.getVersion()); }
	            }
	        }
	    }
	});
	grdMain.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	
	// grid styles
	grdMain.loadStyles({
	    body: {
	        updated: {
	            background: "#15000088",
	            fontBold: true
	        }
	    }
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
    $('#btnUpdateRows').click(function () {
        var rows = [1, 3, 5, 7];
        for (var r in rows) {
            var v = dsMain.getValue(rows[r], 'country');
            dsMain.setValue(rows[r], 'country', v + '_' + rows[r]);
        }
    });
    $('#btnRestoreAll').click(function () {
        dsMain.restoreUpdatedRows();
    });
    $('#btnRestoreSelected').click(function () {
        var rows = grdMain.getSelectedDataIndices()
        dsMain.restoreUpdatedRows(rows);
    });
    $("input:radio[name=rgpRestoreMode]").click(function () {
    	var value = $("input[name='rgpRestoreMode']:checked").val();
        dsMain.setRestoreMode(value);
    });
});
</script>
</head>
<body>
<h3>Restore Updated Rows</h3>
<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
    <input type="radio" name="rgpRestoreMode" value="none" checked="checked">DataLudi.DataRestoreMode.NONE
    <input type="radio" name="rgpRestoreMode" value="auto">AUTO
    <input type="radio" name="rgpRestoreMode" value="explicit">EXPLICIT
</div>
<p>
<div>
    <button id="btnUpdateRows">1,3,5,7행 수정</button>
    <button id="btnRestoreAll">수정된 모든 행 복원</button>
    <button id="btnRestoreSelected">선택된 수정 행들 복원</button>
</div>
</body>
</html>