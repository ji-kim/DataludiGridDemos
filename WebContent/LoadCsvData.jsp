<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Load CSV Data</title>
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
	dsMain.setFields([
		"product_id",
		"product_name",
		"customer_id",
		"customer_name",
		"country",
		"phone",
		"unit",
		"currency",
		{
			fieldName: "unit_price",
			dataType: "number"
		}, {
			fieldName: "quantity",
			dataType: "number"
		}, {
			fieldName: "order_date",
			dataType: "datetime",
			datetimeFormat: "yyyy-MM-dd"
		}, {
			fieldName: "ship_date",
			dataType: "datetime",
			datetimeFormat: "iso"
		}
	]);
	
	// grid
	var columns = [{
		"name": "ProductName",
		"fieldName": "product_name",
		"width": "90",
		"styles": {
		},
		"header": {
			"text": "ProductName"
		}
    }, {
		"name": "CustomerId",
		"fieldName": "customer_id",
		"width": "90",
		"styles": {
		},
		"header": {
			"text": "CustomerId"
		}
	}, {
		"name": "CustomerName",
		"fieldName": "customer_name",
		"width": "90",
		"styles": {
		},
		"header": {
			"text": "CustomerName"
		}
	}, {
		"name": "Phone",
		"fieldName": "phone",
		"width": "100",
		"styles": {
		},
		"header": {
			"text": "Phone"
		}
	}, {
		"name": "Currency",
		"fieldName": "currency",
		"width": "60",
		"ignoreRowDynamicStyles": true,
		"styles": {
		    "textAlignment": "center",
		    "background": "#3000ff00"
		},
		"header": {
			"text": "Currency"
		}
	}, {
		"name": "Unit",
		"fieldName": "unit",
		"width": "70",
		"styles": {
		},
		"header": {
			"text": "Unit"
		}
	}, {
		"name": "OrderDate",
		"fieldName": "order_date",
		"width": "90",
		"styles": {
		    datetimeFormat: "yyyy-MM-dd",
		    textAlignment: "center"
		},
		"header": {
			"text": "OrderDate"
		}
	},  {
		"name": "ShipDate",
		"fieldName": "ship_date",
		"width": "120",
		"styles": {
		    datetimeFormat: "yyyy-MM-dd hh:mm",
		    textAlignment: "center"
		},
		"header": {
			"text": "ShipDate"
		}
	}, {
		"name": "UnitPrice",
		"fieldName": "unit_price",
		"width": "100",
		"styles": {
			"textAlignment": "far"
		},
		"header": {
			"text": "UnitPrice"
		},
		"footer": {
			"styles": {
				"textAlignment": "far",
				"numberFormat": "0,000",
				"postfix": " $",
				"font": "Arial,12"
			},
			"text": "SUM",
			"expression": "sum",
			/*"expression": "sum[4]",*/
            "dynamicStyles": [{
                "criteria": "value > 10000",
                "styles": "color=#ff0000"
            }]
		}
	}, {
		"name": "Quantity",
		"fieldName": "quantity",
		"width": "100",
		"styles": {
			"textAlignment": "far"
		},
		"header": {
			"text": "Quantity"
		},
		"footer": {
			"styles": {
				"textAlignment": "far",
				"numberFormat": "0,000",
				"postfix": " $",
				"font": "Arial,12"
			},
			"text": "SUM",
			"expression": "sum",
			/*"expression": "sum[4]",*/
            "dynamicStyles": [{
                "criteria": "value > 10000",
                "styles": "color=#ff0000"
            }]
		}
	}];

	grdMain = DataLudi.createGridView("container");
	grdMain.setColumns(columns);
	grdMain2 = DataLudi.createGridView("container2");
	grdMain2.setColumns(columns);
	
	//grid options
	grdMain.checkBar().setVisible(false);
	grdMain.header().head().setPopupMenu({
	    label: 'DataLudi Version',
	    callback: function () { alert(DataLudi.getVersion()); }
	});
	
    grdMain2.checkBar().setVisible(false);   
    grdMain2.header().head().setPopupMenu({
        label: 'DataLudi Grid Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
	
	// grid styles
	grdMain2.loadStyles({
		grid: {
			border: '#f00,2px'
		},
		body: {
			rowDynamic: [{
				expression: "state == 'c'",
				styles: {
					background: "#1000ff00"
				}
			}, {
				expression: "state == 'u'",
				styles: {
					background: "#10ff0000"
				}
			}]
		}
	});

	// connect dataset
	grdMain.setDataSource(dsMain);
	grdMain2.setDataSource(dsMain);
	$.ajax({
		url: "data/orders.csv",
		dataType: 'text',
		success: function (data) {
			new DataLudi.DataLoader(dsMain).load("csv", data, {
				start: 1,
				count: 500
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
		$("#rowCount2").css("color", "blue").text(count.toLocaleString());
	};

	// buttons
	$('#btnInsert').click(function () {
		$.ajax({
			url: "data/orders.csv",
			dataType: 'text',
			success: function (data) {
				var row = grdMain2.focusedIndex().rowIndex;
				if (row < 0) row = 0;
				
				new DataLudi.DataLoader(dsMain).load("csv", data, {
					start: 1,
					count: 5,
					fillMode: 'insert',
					fillPos: row
				});
			},
			error: function (xhr, status, error) {
				var err = status + ', ' + error;
				alert("jQuery ajax() Failed: " + err);
			}
		});
	});
	$('#btnAppend').click(function () {
		$.ajax({
			url: "data/orders.csv",
			dataType: 'text',
			success: function (data) {
				new DataLudi.DataLoader(dsMain).load("csv", data, {
					start: 1,
					count: 5,
					fillMode: 'append'
				});
				grdMain2.setFocusedRow(grdMain2.rowCount() - 1, true);
			},
			error: function (xhr, status, error) {
				var err = status + ', ' + error;
				alert("jQuery ajax() Failed: " + err);
			}
	 	});
	});
	$('#btnUpdate').click(function () {
		$.ajax({
			url: "data/orders.csv",
			dataType: 'text',
			success: function (data) {
				var row = grdMain2.focusedIndex().rowIndex;
				if (row < 0) row = 0;
				new DataLudi.DataLoader(dsMain).load("csv", data, {
					start: 1,
					count: 5,
					fillMode: 'update',
					fillPos: row
				});
			},
			error: function (xhr, status, error) {
				var err = status + ', ' + error;
				alert("jQuery ajax() Failed: " + err);
			}
		});
	});
});
</script>
</head>
<body>
<h3>Load CSV Data</h3>
<div id="container"	style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
	<span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
	<button id="btnInsert">Load and Insert</button>
	<button id="btnAppend">Load and Append</button>
	<button id="btnUpdate">Load and Update</button>	
</div>
<div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
	<span id="rowCount2" style="">0</span> rows.
</div>
</body>
</html>