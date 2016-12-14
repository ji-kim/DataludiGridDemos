<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Report Cell Merging</title>
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
            reportFooter : {
                items : [ {
                    type : "list",
                    right : 0,
                    items : [ {
                        type : "summary",
                        expression : "sum['weight']",
                        styles : {
                            padding : 6,
                            fontSize : 16,
                            fontBold : true,
                            numberFormat : "#,##0"
                        },
                        header : {
                            text : "거래량 합계: ",
                            styles : {
                                fontSize : 14
                            }
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
                        data : '$report.pages'
                    } ]
                } ]
            },
            grid : {
                display : {
                    fitStyle : "even"
                }
            }
        };

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

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 80,
            "mergeExpression" : "value",
            "styles" : {
                "background" : "#1000ff00"
            },
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : "70",
            "mergeCallback" : function(item, column) {
                return column.grid().getValueAt(item, column) + grdMain.getValueAt(item, 'flow');
            },
            "styles" : {
                "background" : "#10ffff00",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Country2",
            "fieldName" : "country",
            "width" : "50",
            "mergeCallback" : function(item, column) {
                return column.grid().getValueAt(item, column).substr(0, 1);
            },
            "mergeValueCallback" : function(item, column, value) {
                return value.substr(0, 1);
            },
            "styles" : {
                "background" : "#100000ff",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Country_2"
            }
        }, {
            "name" : "Flow",
            "fieldName" : "flow",
            "width" : 60,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Flow"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "100",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "65",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            }
        }, {
            "name" : "Trade",
            "fieldName" : "trade",
            "width" : 70,
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
            "width" : 110,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
        grdMain.footer().setVisible(false);
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
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_s.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 200,
                    quoted : true,
                    currency : true
                });
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });
        grdMain.orderByFields([ 'comm_code' ]);

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
    <h3>Report Cell Merging</h3>
    <div>
        <button id="btnPrint">Print</button>
        <input type="checkbox" id="chkPrint" checked="checked">바로 출력    (Check하면 현재 크롬에서 출력 미리보기 창이 바로 열립니다.)
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px;"></div>
</body>
</html>