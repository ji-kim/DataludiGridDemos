<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Column Layout</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> --><script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2;
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
        }, {
            fieldName : "customer_name",
        }, {
            fieldName : "country",
        }, {
            fieldName : "phone",
        }, {
            fieldName : "unit",
        }, {
            fieldName : "currency",
        }, {
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
        var columns = [ {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "CustomerGroup",
            "width" : 320,
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
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);
        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns(columns);

        // grid options
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

        grdMain.registerColumnLayouts([ {
            name : "product",
            columns : [ "ProductName", "Currency", "OrderDate", "CustomerName" ]
        }, {
            name : "customer",
            columns : [ "ProductName", "CustomerName", "Country", "Phone", {
                "header" : "Flow",
                "layout" : "horizontal",
                "width" : 300,
                "columns" : [ "OrderDate", "ShipDate" ]
            } ]
        } ]);

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
            $("#rowCount").css("color", "blue").text(ds.rowCount().toLocaleString());
            $("#rowCount2").css("color", "blue").text(ds.rowCount().toLocaleString());
        };

        // buttons
        $("#btnRestore").click(function() {
            grdMain.restoreColumns(true);
        });
        $("#btnSetLayout").click(function() {
            grdMain.setColumnLayout([ 'ProductName', {
                header : 'Customers',
                layout : 'horizontal',
                width : 250,
                columns : [ 'CustomerId', 'CustomerName' ]
            }, 'OrderDate' ]);
        });
        $("#btnSetLayout2").click(function() {
            grdMain.setColumnLayout([ {
                name : 'ProductName',
                width : 150
            }, {
                name : 'Country',
                width : 150
            }, {
                name : 'OrderDate',
                width : 150
            }, {
                header : 'Dates',
                layout : 'horizontal',
                width : 200,
                columns : [ 'OrderDate', 'ShipDate' ]
            } ]);
        });
        $("#btnSelect").click(function() {
            grdMain.setColumnLayout($('#selLayout').val());
        });
        $('#btnLinearize').click(function() {
            /* 컬럼 헤더 텍스트로 정렬한다. */
            grdMain.linearizeColumns([ 'header.text' ], $('#chkReverse').is(':checked'));
        });
        $('#btnSave').click(function() {
            _layout = grdMain2.saveColumnLayout();
        });
        $('#btnLoad').click(function() {
            _layout && grdMain2.setColumnLayout(_layout);
        });
        $('#btnLinear2').click(function() {
            grdMain2.linearizeColumns();
        });
    });
</script>
</head>
<body>
    <h3>Column Layout</h3>
    <div style="margin-bottom: 4px;">
        <button id="btnRestore">Restore</button>
        <input type="checkbox" id="chkRestoreSize">Restore Size
        <button id="btnSetLayout">Layout 1</button>
        <button id="btnSetLayout2">Layout 2</button>
        <span>Layouts:</span> <select id="selLayout">
            <option value="product">product</option>
            <option value="customer">customer</option>
        </select>
        <button id="btnSelect">Select</button>
    </div>
    <div id="container"
        style="height: 550px; width: 95%; min-width: 500px;"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnLinearize">Linearize</button>
        <input type="checkbox" id="chkReverse">Reverse
    </div>
    <p>
        <button id="btnSave">Save Layout</button>
        <button id="btnLinear2">Linearize</button>
        <button id="btnLoad">Load Layout</button>
    <div id="container2"
        style="height: 550px; width: 95%; min-width: 500px;"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>