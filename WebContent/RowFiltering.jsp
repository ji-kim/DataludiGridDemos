<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Filtering</title>
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
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "RowNo",
            "type" : "calced",
            "width" : 30,
            "valueExpression" : "datarow + 1",
            "header" : "No",
            "styles" : {
                "background" : "#1000ff88",
                "textAlignment" : "center"
            }
        }, {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "80",
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "60",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : "55",
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "55",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "CustomerName",
            "fieldName" : "customer_name",
            "width" : "80",
            "styles" : {},
            "header" : {
                "text" : "CustomerName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 60,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "footer" : {
                "expression" : "avg",
                "styles" : {
                    "numberFormat" : "#,##0.00"
                }
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : "85",
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
            "width" : "85",
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ShipDate"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            rowIndicator : {
                stateVisible : true
            },
            footer : {
                visible : true
            }
        });
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // grid styles
        grdMain.loadStyles({
            body : {
                updated : {
                    background : "#10ff8800"
                }
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
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnClearFilter').click(function() {
            grdMain.setRowFilter({
                expression : null,
                callback : null
            });
        });
        $('#btnTopRows').click(function() {
            grdMain.setRowFilter({
                callback : null,
                expression : "row < 10"
            });
        });
        $('#btnBottomRows').click(function() {
            grdMain.setRowFilter({
                callback : null,
                expression : "row >= rowcount - 10"
            });
        });

        $('#btnUpdateRows').click(function() {
            for (var i = dsMain.rowCount(); i--;) {
                if (Math.round(Math.random() * 100) % 2) {
                    dsMain.setValue(i, 'currency', dsMain.getValue(i, 'currency') + "_X");
                }
            }
        });
        $('#btnDirtyRows').click(function() {
            grdMain.setRowFilter({
                expression : "state == 'u'",
                callback : null
            });
        });
        $('#btnToggleFilter').click(function() {
            grdMain.rowFilter().setActive(!grdMain.rowFilter().active());
        });
    });
</script>
</head>
<body>
    <h3>Row Filtering</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnTopRows">상위 10 데이터행 가져오기</button>
    </div>
    <div>
        <button id="btnBottomRows">하위 10 데이터행 가져오기</button>
    </div>
    <div>
        <button id="btnUpdateRows">행들 수정하기</button>
        <button id="btnDirtyRows">수정된 행들만 가져오기</button>
    </div>
    <div>
        <button id="btnClearFilter">Clear Row Filter</button>
        <button id="btnToggleFilter">Toggle Row Filter Active</button>
    </div>
</body>
</html>