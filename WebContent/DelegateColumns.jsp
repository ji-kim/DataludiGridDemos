<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Delegate Columns</title>
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
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "CustomerGroup",
            "headerDelegate" : "CustomerId",
            "width" : 250,
            "columns" : [ {
                "name" : "CustomerId",
                "fieldName" : "customer_id",
                "width" : "60",
                "styles" : {},
                "header" : {
                    "text" : "Customer",
                    "styles" : {
                        "background" : "#bbffdd",
                    }
                }
            }, {
                "name" : "CustomerName",
                "fieldName" : "customer_name",
                "width" : "70",
                "styles" : {},
                "header" : {
                    "text" : "CustomerName"
                }
            }, {
                "name" : "Phone",
                "fieldName" : "phone",
                "width" : "100",
                "styles" : {
                    "textAlignment" : "center"
                },
                "header" : {
                    "text" : "Phone"
                }
            } ],
            "header" : false
        }, {
            "name" : "CountryGroup",
            "layout" : "vertical",
            "childFootersVisible" : false,
            "footerDelegate" : "Quantity",
            "columns" : [ {
                "name" : "Country",
                "fieldName" : "country",
                "width" : "70",
                "styles" : {},
                "header" : {
                    "text" : "Country"
                },
                "footer" : {
                    "text" : "xxx",
                    "styles" : {
                        "background" : "#888888"
                    }
                }
            }, {
                "name" : "Quantity",
                "fieldName" : "quantity",
                "width" : "60",
                "styles" : {
                    "textAlignment" : "far"
                },
                "header" : {
                    "text" : "Quantity"
                },
                "footer" : {
                    "expression" : "sum",
                    "styles" : {
                        "background" : "#bbddff",
                        "color" : "#00f",
                        "numberFormat" : "#,##0",
                        "fontName" : "Arial",
                        "fontBold" : true,
                        "fontSize" : 14
                    }
                }
            } ],
            "header" : false
        }, {
            "name" : "DateGroup",
            "footerDelegate" : "OrderGroup",
            "width" : "200",
            "columns" : [ {
                "name" : "OrderGroup",
                "layout" : "vertical",
                "footerDelegate" : "ShipDate",
                "columns" : [ {
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
                    "width" : "90",
                    "styles" : {
                        "datetimeFormat" : "yyyy-MM-dd",
                        "textAlignment" : "center"
                    },
                    "header" : {
                        "text" : "ShipDate"
                    },
                    "footer" : {
                        "text" : "ShipDate",
                        "styles" : {
                            "background" : "#bbffdd"
                        }
                    }
                } ],
                "header" : {
                    "visible" : false
                }
            }, {
                "name" : "ShipDate",
                "fieldName" : "ship_date",
                "width" : "90",
                "styles" : {
                    "datetimeFormat" : "yyyy-MM-dd",
                    "textAlignment" : "center"
                },
                "header" : {
                    "text" : "ShipDate"
                }
            } ],
            "header" : {
                "text" : "Date"
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
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
                var err = textStatus + ', ' + error;
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
    <h3>Delegate Columns</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>