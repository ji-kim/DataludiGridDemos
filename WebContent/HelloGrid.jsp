<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hello, Grid</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script>
	$(document).ready(function() {
		DataLudi.setDebug(true);
		DataLudi.setTrace(true);

		var grdMain;
		var dsMain;

		// dataset
		dsMain = DataLudi.createGridDataSet();
		dsMain.setFields([ {
			fieldName : "product_id",
			dataType : "text",
		}, {
			fieldName : "product_name"
		}, {
			fieldName : "customer_id"
		}, "customer_name", "country", "phone", "unit", "currency", {
			fieldName : "unit_price",
			dataType : "number"
		}, {
			fieldName : "quantity",
			dataType : "number"
		}, {
			fieldName : "order_date",
			dataType : "datetime",
			datetimeFormat : "yyyy-MM-dd"
		}, {
			fieldName : "ship_date",
			dataType : "datetime",
			datetimeFormat : "iso"
		} ]);

		// grid
		grdMain = DataLudi.createGridView("container");
		grdMain.setColumns([ {
			"name" : "ProductId",
			"fieldName" : "product_id",
			"width" : "90",
			"styles" : {},
			"header" : {
				"text" : "ProductId"
			}
		}, {
			"name" : "ProductName",
			"fieldName" : "product_name",
			"width" : "90",
			"styles" : {},
			"header" : {
				"text" : "ProductName"
			}
		}, {
			"name" : "CustomerId",
			"fieldName" : "customer_id",
			"width" : "90",
			"styles" : {},
			"header" : {
				"text" : "CustomerId"
			}
		}, {
			"name" : "CustomerName",
			"fieldName" : "customer_name",
			"width" : "90",
			"styles" : {},
			"header" : {
				"text" : "CustomerName"
			}
		}, {
			"name" : "Country",
			"fieldName" : "country",
			"width" : "70",
			"styles" : {},
			"header" : {
				"text" : "Country"
			}
		}, {
			"name" : "Phone",
			"fieldName" : "phone",
			"width" : "100",
			"styles" : {},
			"header" : {
				"text" : "Phone"
			}
		}, {
			"name" : "Unit",
			"fieldName" : "unit",
			"width" : "90",
			"styles" : {},
			"header" : {
				"text" : "Unit"
			}
		}, {
			"name" : "Currency",
			"fieldName" : "currency",
			"width" : "60",
			"styles" : {
				"textAlignment" : "center"
			},
			"header" : {
				"text" : "Currency"
			}
		}, {
			"name" : "UnitPrice",
			"fieldName" : "unit_price",
			"width" : "100",
			"styles" : {
				"textAlignment" : "far"
			},
			"header" : {
				"text" : "UnitPrice"
			},
			"footer" : {
				"styles" : {
					"textAlignment" : "far",
					"numberFormat" : "0,000",
					"postfix" : " $",
					"font" : "Arial,12"
				},
				"text" : "SUM",
				"expression" : "sum",
				/*"expression": "sum[4]",*/
				"dynamicStyles" : [ {
					"criteria" : "value > 10000",
					"styles" : "color=#ff0000"
				} ]
			}
		}, {
			"name" : "Quantity",
			"fieldName" : "quantity",
			"width" : "100",
			"styles" : {
				"textAlignment" : "far"
			},
			"header" : {
				"text" : "Quantity"
			},
			"footer" : {
				"styles" : {
					"textAlignment" : "far",
					"numberFormat" : "0,000",
					"postfix" : " $",
					"font" : "Arial,12"
				},
				"text" : "SUM",
				"expression" : "sum",
				/*"expression": "sum[4]",*/
				"dynamicStyles" : [ {
					"criteria" : "value > 10000",
					"styles" : "color=#ff0000"
				} ]
			}
		}, {
			"name" : "OrderDate",
			"fieldName" : "order_date",
			"width" : "90",
			"styles" : {
				datetimeFormat : "yyyy-MM-dd",
				textAlignment : "center"
			},
			"header" : {
				"text" : "OrderDate"
			}
		}, {
			"name" : "ShipDate",
			"fieldName" : "ship_date",
			"width" : "120",
			"styles" : {
				datetimeFormat : "yyyy-MM-dd hh:mm",
				textAlignment : "center"
			},
			"header" : {
				"text" : "ShipDate"
			}
		} ]);

		// grid options
		grdMain.checkBar().setVisible(false);
		grdMain.header().head().setPopupMenu({
			label : 'DataLudi Grid Version',
			callback : function() {
				alert(DataLudi.getVersion());
			}
		});

		// connect dataset
		grdMain.setDataSource(dsMain);
		$.ajax({
			url : "data/orders_s.csv",
			dataType : 'text',
			success : function(data) {
				new DataLudi.DataLoader(dsMain).load("csv", data, {
					start : 1
				});
			},
			error : function(xhr, status, error) {
				var err = status + ', ' + error;
				alert("jQuery getJSON() Failed: " + err);
			}
		});

		// dataset events
		dsMain.onRowCountChanged = function(ds, count) {
			$("#rowCount").css("color", "green").text(count.toLocaleString());
		};

		// grid events
		grdMain.onDataCellClicked = function(grid, index) {
			if (index && index.dataColumn() && index.getDataIndex(grid) >= 0) {
				var v = dsMain.getValue(index.getDataIndex(grid), index.dataField());
				$('#txtMessage').text('onDataCellClicked: ' + v);
			}
		};
		grdMain.onColumnHeaderDblClicked = function(grid, column) {
			$('#txtMessage').text('onColumnHeaderDblClicked: ' + column.name());
		};

		// buttons
		$("#btnHello").click(function() {
			alert("hello");
		});
	});
</script>
</head>
<body>
	<h3>Hello Grid</h3>
	<div style="margin-bottom: 4px;">
		<button id="btnHello">hello</button>
	</div>
	<div id="container"
		style="height: 550px; width: 95%; min-width: 500px;"></div>
	<div>
		<span id="rowCount" style="">0</span> rows.
	</div>
</body>
</html>