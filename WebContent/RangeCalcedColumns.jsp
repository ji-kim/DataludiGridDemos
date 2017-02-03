<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>계산 컬럼 누계</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
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
            "width" : 100,
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 70,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "UnitPrice"
            }
        }, {
            "name" : "UnitTotal",
            "type" : "calced",
            "cached" : true,
            "calcBounds" : "group",
            "calcRange" : "first",
            "valueType" : "number",
            "valueExpression" : "unit_price + prevval",
            "width" : 140,
            "renderer" : {
                "type" : "bar",
                "maximum" : 110000,
                "showLabel" : true
            },
            "styles" : {
                "background" : "#1000ff88",
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far",
                "shapeColor" : "#300000ff"
            },
            "header" : {
                "text" : "UnitTotal"
            },
            "footer" : {
                "summaryCallback" : function(column) {
                    var grid = column.grid();
                    var fld = grid.dataSource().getFieldIndex('unit_price');
                    var v = 0;
                    for (var i = grid.rowCount(); i--;) {
                        if (grid.getRow(i).dataIndex() >= 0) {
                            v += grid.getValueAt(i, fld);
                        }
                    }
                    return v;
                },
                "styles" : {
                    "numberFormat" : "#,##0.00",
                    "background" : "#084",
                    "color" : "#fff"
                }
            },
            "groupFooter" : {
                "summaryCallback" : function(column, group) {
                    var grid = column.grid();
                    var fld = grid.dataSource().getFieldIndex('unit_price');
                    var v = 0;
                    var r;
                    for (var i = group.count(); i--;) {
                        r = group.getItem(i);
                        if (r.dataIndex() >= 0) {
                            v += grid.getValueAt(r.index(), fld);
                        }
                    }
                    return v;
                },
                "styles" : {
                    "numberFormat" : "#,##0.00",
                    "background" : "#096",
                    "color" : "#fff"
                }
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 70,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            }
        }, {
            "name" : "QtyTotal",
            "type" : "calced",
            "valueType" : "number",
            "cached" : true,
            "calcBounds" : "grid",
            "calcRange" : "last",
            "valueCallback" : function(column, row, rows, index, values) {
                return row.getValue('quantity') + (index < rows.length - 1 ? values.get(index + 1) : 0);
                /* for first
                return row.getValue('quantity') + (index > 0 ? values.get(index - 1) : 0);
                 */
            },
            "cached" : true,
            "width" : 140,
            "renderer" : {
                "type" : "bar",
                "maximum" : 100000,
                "showLabel" : true
            },
            "styles" : {
                "background" : "#10008844",
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far",
                "shapeColor" : "#30ff0000"
            },
            "header" : {
                "text" : "QtyTotal"
            },
            "footer" : {
                "summaryCallback" : function(column) {
                    var grid = column.grid();
                    var fld = grid.dataSource().getFieldIndex('quantity');
                    var v = 0;
                    for (var i = grid.rowCount(); i--;) {
                        if (grid.getRow(i).dataIndex() >= 0) {
                            v += grid.getValueAt(i, fld);
                        }
                    }
                    return v;
                },
                "styles" : {
                    "numberFormat" : "#,##0.00",
                    "background" : "#048",
                    "color" : "#fff"
                }
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
        grdMain.setOptions({
            groupPanel : true,
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
    });
</script>
</head>
<body>
    <h3>계산 컬럼 누계</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>