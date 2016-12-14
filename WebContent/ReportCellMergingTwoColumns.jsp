<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Cell Merging (Two Columns)</title>
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
                print : {
                    pageColumns : 2,
                    pageColumnLayout : DLReport.PageColumnLayout.ACROSS_THEN_DOWN,
                },
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
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "130",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
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
        function loadData() {
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
        };

        grdMain.setDataSource(dsMain);
        loadData();
        grdMain.orderByFields([ 'comm_code' ]);

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
    <h3>Cell Merging (Two Columns)</h3>
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