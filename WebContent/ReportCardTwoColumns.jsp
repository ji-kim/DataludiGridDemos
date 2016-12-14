<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Two Columns Card</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-report.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;
        var printOptions = {
            previewUrl : "previewer.html"
        };
        var report = {
            reportHeader : {
                styles : {
                    marginTop : 10,
                    marginBottom : 10
                },
                items : [ {
                    text : "Unesco UIS Database",
                    styles : {
                        fontName : "Arial",
                        fontSize : 30,
                        borderBottom : "#333",
                        marginBottom : 20
                    }
                }, {
                    text : "2035,UN Data.",
                    right : 10,
                    bottom : 0,
                    styles : {
                        fontName : "Courier New",
                        fontSize : 18
                    }
                } ]
            },
            reportFooter : {
                styles : {},
                items : [ {
                    type : "list",
                    right : 0,
                    items : [ {
                        header : {
                            text : "수량 합계: ",
                            styles : {
                                fontSize : 14
                            }
                        },
                        type : "summary",
                        expression : "sum['quantity']",
                        styles : {
                            padding : 6,
                            fontSize : 16,
                            fontBold : true,
                            numberFormat : "#,##0"
                        }
                    } ],
                    styles : {
                        background : "#100088ff",
                        borderTop : "#aaa",
                        borderBottom : "#aaa",
                        marginTop : 10
                    }

                } ]
            },
            pageHeader : {
                styles : {
                    margin : 4,
                    background : "#f8f8f8"
                },
                items : [ {
                    left : 0,
                    text : 'Dataludi Inc.',
                    styles : {
                        fontBold : true,
                        fontItalic : true
                    }

                }, {
                    right : 0,
                    data : '$report.date'
                } ]
            },
            pageFooter : {
                styles : {
                    margin : 4,
                    background : "#f8f8f8"
                },
                items : [ {
                    type : "hbox",
                    right : 0,
                    items : [ {
                        data : '$report.pageno'
                    }, {
                        text : "/"
                    }, {
                        data : '$report.pagetotal',
                        styles : {}
                    } ]
                } ]
            },
            grid : {
                print : {
                    pageLayout : "card",
                    pageColumns : 2,
                    pageColumnLayout : DLReport.PageColumnLayout.ACROSS_THEN_DOWN,
                    card : {
                        itemStyles : {
                            border : "#777",
                            padding : 6
                        }
                    }
                },
                styles : {
                    footer : {
                        borderTop : null
                    }
                }
            }
        };

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
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : "60",
            "styles" : {},
            "header" : {
                "text" : "Customer"
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
            "width" : "125",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Phone"
            }
        }, {
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
            "width" : 50,
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
        } ]);

        //grid options
        grdMain.setOptions({
            footer : {
                visible : false
            },
            display : {
                selectStyle : DataLudi.SelectionStyle.ROWS
            }
        });
        grdMain.header().head().setPopupMenu([ {
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        }, {
            label : 'DataLudi Report Version',
            callback : function() {
                alert(DLReport.getVersion());
            }
        } ]);

        grdMain.loadStyles({
            selection : {
                background : "#11000000",
                border : "#88000000,1"
            }
        });

        // connect dataset
        function loadData(ds) {
            $.ajax({
                url : "data/orders_s.csv",
                dataType : 'text',
                success : function(data) {
                    new DataLudi.DataLoader(ds).load("csv", data, {
                        start : 1,
                        count : 20
                    });
                },
                error : function(xhr, status, error) {
                    var err = textStatus + ', ' + error;
                    alert("jQuery getJSON() Failed: " + err);
                }
            });
        };
        grdMain.setDataSource(dsMain);
        loadData(dsMain);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // button
        $('#btnPrint').click(function() {
            DLReport.preview(grdMain, report, null, printOptions, $('#chkPrint').is(':checked'));
        });
    });
</script>
</head>
<body>
    <h3>Two Columns Card</h3>
    <div>
        <button id="btnPrint">Print</button>
        <input type="checkbox" id="chkPrint" checked="checked">바로 출력    (Check하면 현재 크롬에서 출력 미리보기 창이 바로 열립니다.)
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px;"></div>
</body>
</html>