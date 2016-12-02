<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Dynamic Styles Exporting</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName: "product_id",
            dataType: "text",
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
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name": "ProductName",
            "fieldName": "product_name",
            "width": "90",
            "styles": {
            },
            "header": {
                "text": "ProductName"
            }
    	}, {
            "name": "UnitPrice",
            "fieldName": "unit_price",
            "width": 60,
            "styles": {
                "numberFormat": "#,##0.00",
                "textAlignment": "far"
            },
            "dynamicStyles": [{
                "expression": "value > 500",
                "styles": {
                    "background": "#10000000"
                }
            }, {
                "expression": "value > 700",
                "styles": {
                    "background": "#20000000"
                }
            }, {
                "expression": "value > 800",
                "styles": {
                    "background": "#30000000"
                }
            }],
            "header": {
                "text": "UnitPrice"
            }
    	}, {
            "name": "Quantity",
            "fieldName": "quantity",
            "width": 60,
            "renderer": {
                "type": "shape"
            },
            "styles": {
            	"textAlignment": "far"
            },
            "dynamicStyles": [{
                "expressions": [
                    "value > 700", 
                    "value > 500",
                    "value > 300"
                ],
                "styles": [
                    {
                        "shapeColor": "#ff0000"
                    }, {
                        "shapeColor": "#0000ff"
                    }, {
                        "shapeColor": "#008800"
                    }
                ]
            }],
            "header": {
            	"text": "Quantity"
            }
    	},  {
            "name": "OrderDate",
            "fieldName": "order_date",
            "width": "90",
            "styles": {
                "datetimeFormat": "yyyy-MM-dd",
                "textAlignment": "center"
            },
            "dynamicStyles": [{
                "expression": "value >= date('2015-01-01')",
                "styles": {
                    "background": "#100000ff",
                    "color": "#ff000088"
                }
            }],
            "header": {
            	"text": "OrderDate"
            }
    	},  {
            "name": "ShipDate",
            "fieldName": "ship_date",
            "width": "120",
            "styles": {
            "datetimeFormat": "yyyy-MM-dd",
            "textAlignment": "center"
            },
            "header": {
            	"text": "ShipDate"
            }
    	}, {
            "name": "Country",
            "fieldName": "country",
            "width": "70",
            "styles": {
            },
            "dynamicStyles": {
                "expressions": "value in ()",
                "styles": {
                    "fontBold": true
                }
            },
            "header": {
            	"text": "Country"
            }
    	}, {
            "name": "Unit",
            "fieldName": "unit",
            "width": "90",
            "styles": {
            },
            "header": {
            	"text": "Unit"
            }
    	}, {
            "name": "Currency",
            "fieldName": "currency",
            "width": "60",
            "styles": {
                "textAlignment": "center",
                "background": "#10ff0000"
            },
            "header": {
            	"text": "Currency"
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
        } ]);
        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns([{
            "name": "ProductId",
            "fieldName": "product_id",
            "width": "90",
            "styles": {
            },
            "header": {
            	"text": "ProductId"
            }
        }, {
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
                "background": "#1000ff00"
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
            "name": "UnitPrice",
            "fieldName": "unit_price",
            "width": "100",
            "styles": {
                "color": "#000088",
                "fontBold": true,
                "prefix": "Curr",
                "numberFormat": "#,##0.00",
            	"textAlignment": "far"
            },
            "header": {
            	"text": "UnitPrice"
            }
        }, {
            "name": "Quantity",
            "fieldName": "quantity",
            "width": "100",
            "styles": {
                "background": "#1000ffff",
                "color": "#80000000",
            	"textAlignment": "far"
            },
            "header": {
            	"text": "Quantity"
            }
        },  {
            "name": "OrderDate",
            "fieldName": "order_date",
            "width": "90",
            "styles": {
                "datetimeFormat": "yyyy-MM-dd",
                "textAlignment": "center"
            },
            "header": {
            	"text": "OrderDate"
            }
        },  {
            "name": "ShipDate",
            "fieldName": "ship_date",
            "width": "120",
            "styles": {
            "datetimeFormat": "yyyy-MM-dd",
            "textAlignment": "center"
            },
            "header": {
            	"text": "ShipDate"
            }
        }, {
            "name": "Country",
            "fieldName": "country",
            "width": "70",
            "styles": {
            },
            "header": {
            	"text": "Country"
            }
        }, {
            "name": "Unit",
            "fieldName": "unit",
            "width": "90",
            "styles": {
            },
            "header": {
            	"text": "Unit"
            }
        }, {
            "name": "Currency",
            "fieldName": "currency",
            "width": "60",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
            	"text": "Currency"
            }
        }]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(false);

        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });

        grdMain2.checkBar().setVisible(false);
        grdMain2.footer().setVisible(false);
        
        grdMain2.header().head().setPopupMenu({
            label: 'DataLudi Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });
        grdMain2.body().setRowRangeStyles({
            '0': { background: '#10ff0000' },
            '1': { background: '#20ff0000' },
            '2': { background: '#30ff0000' },
            'rows': [{
                'range': 'row % 2 == 1',
                'styles': {
                    'background': '#08000000'
                }
            }, {
            }] 
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
       	$.ajax({
            url: "data/orders_s.csv",
            dataType: 'text',
            success: function (data) {
            	new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start:1
            	});
            },
            error: function (xhr, status, error) {
            	var err = status + ', ' + error;
            	alert("jQuery getJSON() Failed: " + err);
            }
    	});

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnSave').click(function() {
            DataLudi.exportToExcel(grdMain, {
                target: "local",
                fileName: "dlgrid.xlsx",
                applyDynamicStyles: document.getElementById("chkApplyDynamics").checked,
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd"
            });
        });
        $('#btnUpload').click(function() {
            DataLudi.exportToExcel(grdMain, {
                url:  "/envelope",
                fileName: "dlgrid.xlsx",
                applyDynamicStyles: document.getElementById("chkApplyDynamics").checked,
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd"
            });
        });
        $('#btnSave2').click(function() {
            DataLudi.exportToExcel(grdMain2, {
                target: "local",
                fileName: "dlgrid.xlsx",
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd",
                applyDynamicStyles: document.getElementById("chkApplyDynamics2").checked,
                styledText: document.getElementById("chkStyledText").checked
            });
        });
        $('#btnUpload2').click(function() {
            DataLudi.exportToExcel(grdMain2, {
                url:  "/envelope",
                fileName: "dlgrid.xlsx",
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd",
                applyDynamicStyles: document.getElementById("chkApplyDynamics2").checked,
                styledText: document.getElementById("chkStyledText").checked
            });
        });
    });
</script>
</head>
<body>
    <h3>Dynamic Styles Exporting</h3>
    <div>
    	<button id="btnSave">Save to Local</button>
    	<button id="btnUpload">Upload to Server</button>
        <input type="checkbox" id="chkApplyDynamics" checked="checked">Apply Dynamic Styles
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
	<p>
    <div>
    	<button id="btnSave2">Save to Local</button>
    	<button id="btnUpload2">Upload to Server</button>
        <input type="checkbox" id="chkApplyDynamics2" checked="checked">Apply Dynamic Styles
        <input type="checkbox" id="chkStyledText">Styled Text
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>