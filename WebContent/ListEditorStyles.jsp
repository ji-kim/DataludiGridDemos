<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>List Editor Styles & Items</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2, grdMain3;
        var dsMain, dsMain3;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "country"
        }, {
            fieldName : "year",
            dataType : "number"
        }, {
            fieldName : "comm_code"
        }, {
            fieldName : "commodity"
        }, {
            fieldName : "flow"
        }, {
            fieldName : "trade",
            dataType : "number"
        }, {
            fieldName : "weight",
            dataType : "number"
        }, {
            fieldName : "unit"
        } ]);

        dsMain3 = DataLudi.createGridDataSet();
        dsMain3.setFields([ {
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
            "name" : "Country",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Value"
            },
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "default",
                "displayLabels" : false,
                "values" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
                "labels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ]
            }
        }, {
            "name" : "Country2",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Label"
            },
            "lookupValues" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
            "lookupLabels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "default",
                "displayLabel" : true
            }
        }, {
            "name" : "Country3",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Value-Label"
            },
            "lookupValues" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
            "lookupLabels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "valueLabel"
            }
        }, {
            "name" : "Country4",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Label-Value"
            },
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "labelValue",
                "values" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
                "labels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ]
            }
        } ]);

        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "100",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Flow",
            "fieldName" : "flow",
            "width" : 60,
            "lookupDisplay" : true,
            "lookupLabels" : [ "in", "out" ],
            "lookupValues" : [ "Import", "Export" ],
            "editor" : {
                "type" : "list",
                "domainOnly" : true
            },
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Flow"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            },
            "editor" : {
                "type" : "list",
                "itemsCallback" : function(index) {
                    var items = {
                        values : [],
                        labels : []
                    }
                    if (index.getRow().getValue('flow') == 'Import') {
                        items.values.push('500001', '500002', '500003', '500004', '500005');
                        items.labels.push('import 1', 'import 2', 'import 3', 'import 4', 'import 5');
                    } else {
                        items.values.push('900001', '900002', '900003', '900004', '900005');
                        items.labels.push('export 1', 'export 2', 'export 3', 'export 4', 'export 5');
                    }
                    return items;
                }
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            }
        }, {
            "name" : "Trade",
            "fieldName" : "trade",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Trade"
            },
            "groupFooter" : {
                "expression" : "sum",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Weight",
            "fieldName" : "weight",
            "width" : 70,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Weight"
            },
            "groupFooter" : {
                "expression" : "sum",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : 120,
            "styles" : {},
            "header" : {
                "text" : "Unit"
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
            "lookupDisplay" : true,
            "lookupSourceId" : "prodCustomers",
            "lookupKeyFields" : [ "product_id", "customer_id" ],
            "editor" : {
                "type" : "list"
            },
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
        grdMain.editOptions().setInsertable(true).setAppendable(true);
        grdMain.rowIndicator().setStateVisible(true);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.editOptions().setInsertable(true).setAppendable(true);
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

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_ss.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 7,
                    quoted : true,
                    currency : true
                });
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery ajax() Failed: " + err);
            }
        });

        grdMain3.setDataSource(dsMain3);
        grdMain3.addLookupSource({
            id : "prodCustomers",
            levels : 2,
            keys : [ 
                [ 'PR_001', 'AAPL' ],
                [ 'PR_001', 'BAPL' ],
                [ 'PR_001', 'CAPL' ],
                [ 'PR_002', 'MSFT' ],
                [ 'PR_002', 'AMZN' ],
                [ 'PR_002', 'DMZN' ],
                [ 'PR_002', 'EMXX' ],
                [ 'PR_002', 'FZAB' ], 
                [ 'PR_003', 'GOOG' ],
                [ 'PR_003', 'FB' ],
                [ 'PR_003', 'YAHO' ]
            ],
            values : [ 
               "PR_001_Apple", 
               "PR_001_Bapple", 
               "PR_001_Capple", 
               "PR_002_Microsoft",
               "PR_002_Amazon",
               "PR_002_Damazon",
               "PR_002_Emaxx",
               "PR_002_Finzab",
               "PR_003_Google",
               "PR_003_Facebook",
               "PR_003_Yahoo" 
           ]
        });

        dsMain3.appendRows([ 
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
        };
        dsMain3.onRowCountChanged = function(ds, count) {
            $("#rowCount3").css("color", "blue").text(count.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>List Editor Styles & Items</h3>
    <h4>1. DropDownList Item Styles</h4>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <p>
    <h4>2. Items Callback</h4>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <h4>3. Lookup Tree</h4>
    <div id="container3" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount3" style="">0</span> rows.
    </div>
</body>
</html>