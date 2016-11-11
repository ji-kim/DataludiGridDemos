<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Bar Cell Renderers</title>
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
        }, {
            fieldName : "product_name",
        }, {
            fieldName : "customer_id",
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
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#50008800"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "renderer" : {
                "type" : "bar",
                "minimum" : 0,
                "maximum" : 1000
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#50000088"
            },
            "header" : {
                "text" : "Quantity"
            },
            "renderer" : {
                "type" : "bar",
                "minimum" : 0,
                "maximum" : 1000,
                "origin" : "right"
            }
        }, {
            "name" : "UnitPrice2",
            "fieldName" : "unit_price",
            "width" : 90,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far",
                "shapeColor" : "#10008800",
                "color" : "#008800"
            },
            "header" : {
                "text" : "UnitPrice2"
            },
            "renderer" : {
                "type" : "bar",
                "minimum" : 0,
                "maximum" : 1000,
                "showLabel" : true
            }
        }, {
            "name" : "Quantity2",
            "fieldName" : "quantity",
            "width" : 90,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far",
                "shapeColor" : "#10000088",
                "color" : "#000088"
            },
            "header" : {
                "text" : "Quantity2"
            },
            "renderer" : {
                "type" : "bar",
                "minimum" : 0,
                "maximum" : 1000,
                "origin" : "right",
                "showLabel" : true
            }
        }, {
            "name" : "UnitPrice3",
            "fieldName" : "unit_price",
            "width" : 120,
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "linear #555 #fff"
            },
            "header" : {
                "text" : "UnitPrice3"
            },
            "renderer" : {
                "type" : "bar",
                "minimum" : 0,
                "maximum" : 1200,
                "showLabel" : true
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
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        } ]);

        //grid options
        grdMain.footer().setVisible(false);
        grdMain.displayOptions().setFocusBorder('#00c,2px');
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
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

        // grid
        grdMain.onFilteringChanged = function() {
            $("#rowCount").css("color", "blue").text(grdMain.rowCount().toLocaleString());
        };

        // buttons
        $('#chkBorder').click(function() {
            var border = document.getElementById('chkBorder').checked;
            for (var i = 0; i < grdMain.visibleColumnCount(); i++) {
                var column = grdMain.getVisibleColumn(i);
                column.styles().setShapeBorder(border ? "#505050" : null);
            }
        });
        $('#btnSize').click(function() {
            var size = 0;
            var changeSize = function() {
                size += 5;
                if (size <= 100) {
                    for (var i = 0; i < grdMain.visibleColumnCount(); i++) {
                        var column = grdMain.getVisibleColumn(i);
                        column.styles().setShapeSize(size + '%');
                    }
                }
                if (size < 100) {
                    setTimeout(changeSize, 150);
                }
            };
            changeSize();
        });
        $('#btnMax').click(function() {
            var max = 10000;
            var changeMax = function() {
                max -= 500;
                if (max >= 1000) {
                    for (var i = 0; i < grdMain.visibleColumnCount(); i++) {
                        var column = grdMain.getVisibleColumn(i);
                        var renderer = column.rendererObj();
                        if (renderer instanceof DataLudi.BarCellRenderer) {
                            renderer.setMaximum(max);
                        }
                    }
                }
                if (max > 1000) {
                    setTimeout(changeMax, 100);
                } else if (max > 500) {
                    max = 1000;
                    changeMax()
                }
            };
            changeMax();
        });
    });
</script>
</head>
<body>
    <h3>Bar Cell Renderers</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkBorder">경계선 그리기
        <button id="btnSize">Bar 폭 변경하기</button>
        <button id="btnMax">Maximum 변경하기</button>
    </div>
</body>
</html>