<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Focused Cell</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
	$(document).ready(function() {
		DataLudi.setDebug(true);
		DataLudi.setTrace(true);

		var dsMain;
		var grdMain;
		var grdMain2;

		//dataset
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
			"name" : "ProductName",
			"fieldName" : "product_name",
			"width" : "90",
			"styles" : {},
			"header" : {
				"text" : "ProductName"
			}
		}, {
			"name" : "CustomerGroup",
			"width" : 310,
			"layout" : "vertical",
			"columns" : [ {
				"name" : "Country",
				"fieldName" : "country",
				"width" : "70",
				"styles" : {},
				"header" : {
					"text" : "Country"
				}
			}, {
				"name" : "ChildGroup",
				"layout" : "horizontal",
				"columns" : [ {
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
					"name" : "Phone",
					"fieldName" : "phone",
					"width" : "100",
					"styles" : {},
					"header" : {
						"text" : "Phone"
					}
				} ]
			} ]
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
			"name" : "Unit",
			"fieldName" : "unit",
			"width" : "70",
			"styles" : {},
			"header" : {
				"text" : "Unit"
			}
		}, {
			"name" : "DateGroup",
			"type" : "group",
			"width" : "200",
			"columns" : [ {
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
			} ]
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
		} ]);

		// grid2
		grdMain2 = DataLudi.createGridView("container2");
		grdMain2.setColumns([ {
			"name" : "ProductName",
			"fieldName" : "product_name",
			"width" : "90",
			"styles" : {},
			"header" : {
				"text" : "ProductName"
			}
		}, {
			"name" : "CustomerGroup",
			"width" : 310,
			"layout" : "vertical",
			"columns" : [ {
				"name" : "Country",
				"fieldName" : "country",
				"width" : "70",
				"styles" : {},
				"header" : {
					"text" : "Country"
				}
			}, {
				"name" : "ChildGroup",
				"layout" : "horizontal",
				"columns" : [ {
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
					"name" : "Phone",
					"fieldName" : "phone",
					"width" : "100",
					"styles" : {},
					"header" : {
						"text" : "Phone"
					}
				} ]
			} ]
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
			"name" : "Unit",
			"fieldName" : "unit",
			"width" : "70",
			"styles" : {},
			"header" : {
				"text" : "Unit"
			}
		}, {
			"name" : "DateGroup",
			"type" : "group",
			"width" : "200",
			"columns" : [ {
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
			} ]
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
		} ]);

		// grid options
		grdMain.setOptions({
			checkBar : false,
			header : {
				head : {
					popupMenu : {
						label : 'DataLudi Version',
						callback : function() {
							alert(DataLudi.getVersion());
						}
					}
				}
			}
		});
		grdMain2.setOptions({
			checkBar : false,
			header : {
				head : {
					popupMenu : {
						label : 'DataLudi Version',
						callback : function() {
							alert(DataLudi.getVersion());
						}
					}
				}
			},
			edit : {
				editable : false
			}
		})

		// connect dataset
		grdMain.setDataSource(dsMain);
		grdMain2.setDataSource(dsMain);
		$.ajax({
			url : "data/orders_s.csv",
			dataType : 'text',
			success : function(data) {
				new DataLudi.DataLoader(dsMain).load("csv", data, {
					start : 1
				});
			},
			error : function(xhr, status, error) {
				var err = textStatus + ', ' + error;
				alert("jQuery getJSON() Failed: " + err);
			}
		});

		// dataset events
		dsMain.onRowCountChanged = function(ds, count) {
			$("#rowCount").css("color", "green").text(
					count.toLocaleString());
		};

		// grid events
		var _currCount = 0;
		var _currRowCount = 0;

		grdMain.onCurrentChanged = function(grid, newIndex) {
			$('#txtCurrent').text("(" + newIndex.rowIndex + ", " + newIndex.column.name() + ") " + ++_currCount + "events.");
		};
		grdMain.onCurrentRowChanged = function(grid, newRow, oldRow) {
			$('#txtCurrentRow').text('DataRow: ' + oldRow + ' -> ' + newRow + ", " + ++_currRowCount + "events.");
		};
		grdMain2.onDataCellClicked = function(grid, index) {
			$('#txtClicked').text("(" + index.rowIndex + ", " + index.column.name()	+ ") " + " clicked.");
		};
		grdMain2.onDataCellDblClicked = function(grid, index) {
			$('#txtClicked').text("(" + index.rowIndex + ", " + index.column.name()	+ ") " + " double clicked.");
		};

		// buttons
		$('#btnChangeFocus').click(function() {
			var index = grdMain.focusedIndex();
			index.rowIndex++;
			grdMain.setFocusedIndex(index, true);
		});
	});
</script>
</head>
<body>
	<h3>Focused Cell</h3>
	<div style="margin-bottom: 4px;">
		<button id="btnChangeFocus">Change Focus</button>
		<span id='txtCurrent'>0</span>
		<span id='txtCurrentRow'>0</span>
	</div>
	<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
	<p>
	<div style="margin-bottom: 4px;">
		<span id='txtClicked'>0</span>
	</div>
	<div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
	<div>
		<span id="rowCount" style="">0</span> rows.
	</div>
</body>
</html>