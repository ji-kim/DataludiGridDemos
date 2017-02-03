<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Fixed Columns</title>
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
            "name" : "ProductId",
            "fieldName" : "product_id",
            "width" : 90,
            "header" : {
                "text" : "ProductId"
            }
        }, {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : 90,
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : 90,
            "header" : {
                "text" : "CustomerId"
            }
        }, {
            "name" : "CustomerName",
            "fieldName" : "customer_name",
            "width" : 90,
            "header" : {
                "text" : "CustomerName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 80,
            "header" : {
                "text" : "UnitPrice",
                "subText" : "(USD)",
                "subTextLocation" : "right",
                "subStyles" : {
                    "color" : "#a00"
                }
            },
            "styles" : {
                "textAlignment" : "far"
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 70,
            "header" : {
                "text" : "Quantity"
            },
            "styles" : {
                "textAlignment" : "far"
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : 90,
            "header" : {
                "text" : "OrderDate"
            }
        }, {
            "name" : "ShipDate",
            "fieldName" : "ship_date",
            "width" : 120,
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
            "width" : 70,
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : 90,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : 60,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(false);
        grdMain.displayOptions().setFixedColumnCount(2);
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
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnFixedCols').click(function() {
            var n = Math.max(0, Math.min(document.getElementById('edtFixedCols').value, grdMain.visibleColumnCount() - 1));
            grdMain.displayOptions().setFixedColumnCount(n);
        });
        $('#chkResizable').click(function() {
            grdMain.displayOptions().setFixedColumnResizable(document.getElementById('chkResizable').checked);
        });
        $('#chkMovable').click(function() {
            grdMain.displayOptions().setFixedColumnMovable(document.getElementById('chkMovable').checked);
        });

        $('#btnBarWidth').click(function() {
            var n = Math.max(0, Math.min(document.getElementById('edtBarWidth').value, 10));
            grdMain.body().setFixedColumnBarWidth(n);
        });
        $('#btnStyle1').click(function() {
            grdMain.body().setFixedColumnBarWidth(3);
            grdMain.loadStyles({
                body : {
                    fixedCell : {
                        background : '#e0e0e0',
                        borderRight : '#999',
                        borderBottom : '#999'
                    },
                    fixedColumnBar : {
                        background : '#ccc'
                    }
                }
            });
        });
        $('#btnStyle2').click(function() {
            grdMain.body().setFixedColumnBarWidth(3);
            grdMain.loadStyles({
                body : {
                    fixedCell : {
                        background : '#30ff9900',
                        borderRight : '#ff9900',
                        borderBottom : '#ff9900'
                    },
                    fixedColumnBar : {
                        background : '#ff9900',
                        borderRight : '#ff9900'
                    }
                }
            });
        });
        $('#btnStyleReset').click(function() {
            grdMain.body().setFixedColumnBarWidth(0);
            grdMain.loadStyles({
                body : {
                    fixedCell : {
                        background : undefined,
                        borderRight : undefined,
                        borderBottom : undefined
                    },
                    fixedColumnBar : {
                        background : undefined,
                        borderRight : undefined
                    }
                }
            });
        });
    });
</script>
</head>
<body>
    <h3>Fixed Columns</h3>
    <div>
        <input type="text" id="edtFixedCols" value="2">
        <button id="btnFixedCols">Fixed Col Count</button>
        <input type="checkbox" id="chkResizable">Fixed Columns Resizable
        <input type="checkbox" id="chkMovable">Movable
    </div>
    <div>
        <input type="text" id="edtBarWidth" value="0">
        <button id="btnBarWidth">고정 Bar 너비</button>
        <button id="btnStyle1">고정 영역 스타일 1</button>
        <button id="btnStyle2">고정 영역 스타일 2</button>
        <button id="btnStyleReset">스타일 Reset</button>
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>