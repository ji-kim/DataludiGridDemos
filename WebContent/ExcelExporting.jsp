<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Excel Exporting</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
        	fieldName: "product_id",
        	dataType: "text"
        }, {
        	fieldName: "product_name"
        }, {
        	fieldName: "customer_id"
        }, {
        	fieldName: "customer_name",
        }, {
        	fieldName: "country",
        }, {
        	fieldName: "phone",
        }, {
        	fieldName: "unit",
        }, {
        	fieldName: "currency",
        }, {
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
        } ]);
        dsMain.setSoftDelete(true);

        // grid
        var columns = [ {
    		"name": "ProductName",
    		"fieldName": "product_name",
    		"width": "90",
    		"styles": {
    		},
    		"header": {
    			"text": "ProductName"
    		}
        }, {
            "name": "CustomerGroup",
            "width": 200,
            "columns": [{
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
                    	}
                    ]
    	}, {
    		"name": "Currency",
    		"fieldName": "currency",
    		"width": "60",
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
    	    "name": "DateGroup",
    	    "type": "group",
    	    "width": "200",
    	    "columns": [
        	    {
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
            	}
        	]
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
                "dynamicStyles": [{
                    "criteria": "value > 10000",
                    "styles": "color=#ff0000"
                }]
    		}
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);

        //grid options
        grdMain.checkBar().setVisible(false);
        
        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
    	$.ajax({
			url: "data/orders_s.csv",
			dataType: 'text',
			success: function (data) {
				new DataLudi.DataLoader(dsMain).load("csv", data, {
					start:1
				});
			},
			error: function (xhr, status, error) {
				var err = textStatus + ', ' + error;
				alert("jQuery getJSON() Failed: " + err);
			}
    	});

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events
        grdMain.onCurrentChanged = function (grid, newIndex) {
            $('#txtCurrent').text("(" + newIndex.rowIndex + ", " + newIndex.column.name() + ")");  
        };
        
        // buttons
        $('#btnSave').click(function() {
            DataLudi.exportToExcel(grdMain, {
                target: "local",
                fileName: "dlgrid.xlsx",
                rowIndicator: document.getElementById("chkIndicator").checked ? "default" : "hidden",
                header: document.getElementById("chkHeader").checked ? "default" : "hidden",
                footer: document.getElementById("chkFooter").checked ? "default" : "hidden",
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd"
            });
        });
        $('#btnUpload').click(function() {
            DataLudi.exportToExcel(grdMain, {
                url:  "/envelope",
                fileName: "dlgrid.xlsx",
                rowIndicator: document.getElementById("chkIndicator").checked ? "default" : "hidden",
                header: document.getElementById("chkHeader").checked ? "default" : "hidden",
                footer: document.getElementById("chkFooter").checked ? "default" : "hidden",
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd"
            });
        });
        $('#btnLinearize').click(function() {
            grdMain.linearizeColumns();
        });
    });
</script>
</head>
<body>
    <h3>Excel Exporting</h3>
    <div>
    	<button id="btnSave">Save to Local</button>
    	<button id="btnUpload">Upload to Server</button>
    	<button id="btnLinearize">Linearize Columns</button>
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkHeader" checked="checked">Header
        <input type="checkbox" id="chkFooter" checked="checked">Footer
        <input type="checkbox" id="chkIndicator" checked="checked">RowIndicator
        <button id="btnSave">Save to Local</button>
        <button id="btnUpload">Upload to Server</button>
    </div>
</body>
</html>