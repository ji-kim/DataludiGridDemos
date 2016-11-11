<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Alternate Row Colors</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2, grdMain3, grdMain4, grdMain5;
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
            "styles" : {
            /*"background": "#1000ff00"*/
            },
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
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : "90",
            "styles" : {
                "color" : "#000088",
                "fontBold" : true,
                "prefix" : "Curr",
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "UnitPrice"
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : "80",
            "ignoreRowDynamicStyles" : true,
            "ignoreDefaultDynamicStyles" : true,
            "styles" : {
                "background" : "#20006060",
                "color" : "#000",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : "90",
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "OrderDate"
            }
        }, {
            "name" : "ShipDate",
            "fieldName" : "ship_date",
            "width" : "120",
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ShipDate"
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
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain2 = DataLudi.createGridView("container2");
        grdMain3 = DataLudi.createGridView("container3");
        grdMain4 = DataLudi.createGridView("container4");
        grdMain5 = DataLudi.createGridView("container5");
        grdMain.setColumns(columns);
        grdMain2.setColumns(columns);
        grdMain3.setColumns(columns);
        grdMain4.setColumns(columns);
        grdMain5.setColumns(columns);

        //grid options
        var options = {
            "checkBar.visible" : false,
            "footer.visible" : false,
            "header.head.popupMenu" : [ {
                label : 'DataLudi Grid Version',
                callback : function() {
                    alert(DataLudi.getVersion());
                }
            } ]
        };
        grdMain.setProperties(options);
        grdMain.body().setRowDynamicStyles([ {
            expression : 'row % 2',
            styles : {
                background : '#080000ff'
            }
        } ]);

        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.setProperties(options);
        grdMain2.body().setCellDynamicStyles([ {
            expression : 'row % 2',
            styles : {
                background : '#080000ff'
            }
        } ]);

        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain3.setProperties(options);
        grdMain3.loadPalettes([ {
            name : 'p01',
            fills : [ null, '#080000ff' ]
        } ]);
        grdMain3.body().setRowStyles({
            background : 'p(p01:row)'
        });

        grdMain3.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain4.setProperties(options);
        grdMain4.body().setRowRangeStyles({
            'row % 2' : {
                background : '#10000080'
            }
        });
        grdMain4.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain5.setProperties(options);
        grdMain5.body().setRowRangeStyles({
            '(row div 3) % 2' : {
                background : '#10000080'
            }
        });
        grdMain5.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        grdMain3.setDataSource(dsMain);
        grdMain4.setDataSource(dsMain);
        grdMain5.setDataSource(dsMain);
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
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
            $("#rowCount3").css("color", "blue").text(count.toLocaleString());
            $("#rowCount4").css("color", "blue").text(count.toLocaleString());
            $("#rowCount5").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#chkIgnoreRowDynamicStylers').click(function() {
            var checked = document.getElementById('chkIgnoreRowDynamicStylers').checked;
            grdMain.columnByName('Quantity').setIgnoreRowDynamicStyles(checked);
        });
        $('#chkIgnoreDefaultDynamicStyles').click(function() {
            var checked = document.getElementById('chkIgnoreDefaultDynamicStyles').checked;
            grdMain2.columnByName('Quantity').setIgnoreDefaultDynamicStyles(checked);
        });
    });
</script>
</head>
<body>
    <h3>Alternate Row Colors</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkIgnoreRowDynamicStylers" checked="checked">수량 컬럼.ignoreRowDynamicStyles
    </div>
    <p>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkIgnoreDefaultDynamicStyles" checked="checked">수량 컬럼.ignoreDefaultDynamicStyles
    </div>
    <p>
    <div id="container3" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount3" style="">0</span> rows.
    </div>
    <p>
    <div id="container4" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount4" style="">0</span> rows.
    </div>
    <p>
    <div id="container5" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount5" style="">0</span> rows.
    </div>
</body>
</html>