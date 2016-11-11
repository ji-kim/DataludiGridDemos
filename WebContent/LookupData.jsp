<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Lookup Data</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2, grdMain3;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "product_id"
        }, {
            fieldName : "customer_id"
        }, {
            fieldName : "unit_price",
            dataType : "number"
        }, {
            fieldName : "quantity",
            dataType : "number"
        }, {
            fieldName : "customer_label"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "colProduct",
            "fieldName" : "product_id",
            "width" : 100,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProductID"
            }
        }, {
            "name" : "colProductName",
            "fieldName" : "product_id",
            "width" : 150,
            "lookupDisplay" : true,
            "lookupValues" : [ "PR_001", "PR_002", "PR_003", "PR_004" ],
            "lookupLabels" : [ "Product_001", "Product_002", "Product_003", "Product_004" ],
            "styles" : {
                "background" : "#100000ff",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "colCustID",
            "fieldName" : "customer_id",
            "width" : 100,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CustomerID"
            }
        }, {
            "name" : "colPrice",
            "fieldName" : "unit_price",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "fontBold" : true,
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "colQuantity",
            "fieldName" : "quantity",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "fontBold" : true,
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        } ]);

        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns([ {
            "name" : "colProduct",
            "fieldName" : "product_id",
            "width" : 100,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProductID"
            }
        }, {
            "name" : "colCustID",
            "fieldName" : "customer_id",
            "width" : 100,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CustomerID"
            }
        }, {
            "name" : "colCustName",
            "fieldName" : "customer_id",
            "width" : 120,
            "labelField" : "customer_label",
            "styles" : {
                "background" : "#1000ff00",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CustomerName"
            }
        }, {
            "name" : "colPrice",
            "fieldName" : "unit_price",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "fontBold" : true,
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "colQuantity",
            "fieldName" : "quantity",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "fontBold" : true,
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        } ]);

        grdMain3 = DataLudi.createGridView("container3");
        grdMain3.setColumns([ {
            "name" : "colProduct",
            "fieldName" : "product_id",
            "width" : 100,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProductID"
            }
        }, {
            "name" : "colCustID",
            "fieldName" : "customer_id",
            "width" : 100,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CustomerID"
            }
        }, {
            "name" : "colProductCustomer",
            "fieldName" : "customer_id",
            "width" : 160,
            "lookupSourceId" : "prodCustomers",
            "lookupKeyFields" : [ "product_id", "customer_id" ],
            "styles" : {
                "background" : "#10ff0000",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProductCustomer"
            }
        }, {
            "name" : "colPrice",
            "fieldName" : "unit_price",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "fontBold" : true,
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "colQuantity",
            "fieldName" : "quantity",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "fontBold" : true,
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.checkBar().setVisible(false);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain3.checkBar().setVisible(false);
        grdMain3.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain3.setDataSource(dsMain);

        grdMain3.addLookupSource({
            id : "prodCustomers",
            levels : 2,
            keys : [ [ 'PR_001', 'AAPL' ], [ 'PR_002', 'MSFT' ], [ 'PR_002', 'AMZN' ], [ 'PR_003', 'GOOG' ], [ 'PR_003', 'FB' ] ],
            values : [ "PR_001_Apple", "PR_002_Microsoft", "PR_002_Amazon", "PR_003_Google", "PR_003_Facebook" ]
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        grdMain3.setDataSource(dsMain);

        dsMain.appendRows([
            [ 'PR_001', 'AAPL', 10000, 101, 'Apple Inc' ],
            [ 'PR_002', 'MSFT', 9000, 202, 'Microsoft Corp' ],
            [ 'PR_002', 'AMZN', 8000, 234, 'Amazon.com Inc' ],
            [ 'PR_003', 'GOOG', 7000, 311, 'GOGGLE C-C' ],
            [ 'PR_003', 'FB', 6000, 355, 'FACEBOOK' ] 
        ]);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
            $("#rowCount3").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#chkLookupDisplay').click(function() {
            var checked = document.getElementById('chkLookupDisplay').checked;
            var col = grdMain.columnByName('colProductName');
            if (col) {
                col.setLookupDisplay(checked);
            }
        });
        $('#chkLookupDisplay2').click(function() {
            var checked = document.getElementById('chkLookupDisplay2').checked;
            var col = grdMain2.columnByName('colCustName');
            if (col) {
                col.setLookupDisplay(checked);
            }
        });
        $('#chkLookupDisplay3').click(function() {
            var checked = document.getElementById('chkLookupDisplay3').checked;
            var col = grdMain3.columnByName('colProductCustomer');
            if (col) {
                col.setLookupDisplay(checked);
            }
        });
    });
</script>
</head>
<body>
    <h3>Lookup Data</h3>
    <div>
        <input type="checkbox" id="chkLookupDisplay" checked="checked">Lookup Display
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <p>
    <div>
        <input type="checkbox" id="chkLookupDisplay2">Lookup Display
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <p>
    <div>
        <input type="checkbox" id="chkLookupDisplay3">Lookup Display
    </div>
    <div id="container3" style="height: 550px; width: 740px; min-width: 500px"></div>
</body>
</html>