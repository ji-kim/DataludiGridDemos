<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Report Two Columns</title>
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
                items : [ {
                    text : "Order List",
                    styles : {
                        paddingTop : 10,
                        paddingBottom : 20,
                        fontName : "Arial",
                        fontSize : 30,
                        fontUnderline : true
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
                        data : '$report.pages'
                    } ]
                } ]
            },
            grid : {
                print : {
                    pageColumns : 2,
                    pageColumnLayout : DLReport.PageColumnLayout.ACROSS_THEN_DOWN
                },
                display : {
                    fitStyle : "even"
                },
                styles : {
                    header : {
                        background : "#f0f0f0",
                        borderTop : "#ddd"
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
            "width" : "110",
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : "68",
            "styles" : {},
            "header" : {
                "text" : "Customer",
                "styles" : {
                    "background" : "#bbffdd",
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
                    "numberFormat" : "#,##0",
                    "fontName" : "Arial",
                    "fontSize" : 13
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
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(true);
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

        // connect dataset
        function loadData(ds) {
            $.ajax({
                url : "data/orders_s.csv",
                dataType : 'text',
                success : function(data) {
                    new DataLudi.DataLoader(ds).load("csv", data, {
                        start : 1
                    });
                    $("#rowCount").css("color", "blue").text(ds.rowCount().toLocaleString());
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
            report.grid.print.pageColumnLayout = $("input[name='rgpPageColumnLayout']:checked").val();
            DLReport.preview(grdMain, report, null, printOptions, $('#chkPrint').is(':checked'));
        });
    });
</script>
</head>
<body>
    <div>
        <button id="btnPrint">Print</button>        
        <input type="checkbox" id="chkPrint" checked="checked">바로 출력    (Check하면 현재 크롬에서 출력 미리보기 창이 바로 열립니다.)
        <br>
        <input type="radio" name="rgpPageColumnLayout" value="downThenAcross" checked="checked">DLReport.PageColumnLayout.DOWN_THEN_ACROSS
        <input type="radio" name="rgpPageColumnLayout" value="acrossThenDown">ACROSS_THEN_DOWN
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px;"></div>
</body>
</html>