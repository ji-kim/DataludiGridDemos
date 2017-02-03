<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Paging - Page Rows</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "loan_number"
        }, {
            fieldName : "country"
        }, {
            fieldName : "interest_rate",
            dataType : "number"
        }, {
            fieldName : "currency"
        }, {
            fieldName : "project_id"
        }, {
            fieldName : "original_amount",
            dataType : "number"
        }, {
            fieldName : "cancelled_amount",
            dataType : "number"
        }, {
            fieldName : "disbursed_amount",
            dataType : "number"
        }, {
            fieldName : "repaid_amount",
            dataType : "number"
        }, {
            fieldName : "sold_amount",
            dataType : "number"
        }, {
            fieldName : "first_date",
            dataType : "datetime",
            datetimeFormat : "MM/dd/yyyy"
        }, {
            fieldName : "last_date",
            dataType : "datetime",
            datetimeFormat : "MM/dd/yyyy"
        } ]);

        // grid
        var columns = [ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "70",
            "styles" : {
                textAlignment : "center"
            },
            "header" : {
                "text" : "LoanNumber"
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
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "65",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "InterestRate"
            },
            "footer" : {
                "expression" : "avg",
                "styles" : {
                    "prefix" : "Average" + ": ",
                    "numberFormat" : "#,##0.00"
                }
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "ProjectID",
            "fieldName" : "project_id",
            "width" : "70",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProjectID"
            },
            "footer" : {
                "text" : "Sum",
                "styles" : {
                    "textAlignment" : "far"
                }
            }
        }, {
            "name" : "OriginalAmount",
            "fieldName" : "original_amount",
            "width" : 105,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "OriginalAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0",
                    "background" : "#777",
                    "color" : "#fff",
                    "borderTop" : "#ddd"
                }
            }
        }, {
            "name" : "CancelledAmount",
            "fieldName" : "cancelled_amount",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "CancelledAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "DisbursedAmount",
            "fieldName" : "disbursed_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "DisbursedAmount"
            },
            "footer" : {
                "expression" : "varp",
                "text" : "분산",
                "styles" : {
                    "prefix" : "분산=>$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "RepaidAmount",
            "fieldName" : "repaid_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "RepaidAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "SoldAmount",
            "fieldName" : "sold_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "SoldAmount"
            },
            "footer" : {
                "styles" : {
                    "prefix" : "$",
                    "textAlignment" : "far",
                    "numberFormat" : "0,000",
                    "postfix" : " $",
                    "font" : "Arial,12"
                },
                "text" : "SUM",
                "expression" : "sum",
                /*"expression": "sum[4]",*/
                "dynamicStyles" : [ {
                    "criteria" : "value > 10000",
                    "styles" : "color=#ff0000"
                } ]
            }
        }, {
            "name" : "FirstDate",
            "fieldName" : "first_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "FirstDate"
            }
        }, {
            "name" : "LastDate",
            "fieldName" : "last_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "LastDate"
            }
        } ];

        grdMain = DataLudi.createGridView("container");
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns(columns);
        grdMain2.setColumns(columns);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
        grdMain.footer().setVisible(false);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.setDataSource(dsMain);
        grdMain2.checkBar().setVisible(false);
        grdMain2.header().setHeight(30);
        grdMain2.footer().setVisible(false);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/loan_statement_small.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 57,
                    quoted : true,
                    currency : true
                });
                grdMain.setPaging(true, 10, -1);
                grdMain2.setPaging(true, 10, -1);
                grdMain2.setPageAndRows(0, [ 0, 1, 2, 3, 4 ]);
                $("#rowCount").css("color", "blue").text(ds.rowCount().toLocaleString());
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

        // grid initialize                
        var checkButtons = function() {
            var count = grdMain.pageCount();
            var page = grdMain.pageIndex();

            $('#btnFirst').prop('disabled', page <= 0);
            $('#btnPrev').prop('disabled', page <= 0);
            $('#btnNext').prop('disabled', page >= count - 1);
            $('#btnLast').prop('disabled', page >= count - 1);
        };
        var checkButtons2 = function() {
            var count = grdMain2.pageCount();
            var page = grdMain2.pageIndex();

            $('#btnFirst2').prop('disabled', page <= 0);
            $('#btnPrev2').prop('disabled', page <= 0);
            $('#btnNext2').prop('disabled', page >= count - 1);
            $('#btnLast2').prop('disabled', page >= count - 1);
        };

        // grid events
        grdMain.onPaged = function(grid, paged) {
            checkButtons();
        };
        grdMain.onPageCountChanged = function(grid, newCount, oldCount) {
            checkButtons();
        };
        grdMain.onPageIndexChanging = function(grid, newPage, page) {
        };
        grdMain.onPageIndexChanged = function(grid, newPage, oldPage) {
            $('#edtPage').val(newPage);
            checkButtons();

            var rows = [];
            if (dsMain.rowCount() > 0) {
                while (rows.length < 5) {
                    var r = parseInt(Math.random() * dsMain.rowCount());
                    if (rows.indexOf(r) < 0) {
                        rows.push(r);
                    }
                }
            }
            grid.setPageRows(rows);
        };

        grdMain2.onPaged = function(grid, paged) {
            checkButtons2();
        };
        grdMain2.onPageCountChanged = function(grid, newCount, oldCount) {
            checkButtons2();
        };
        grdMain2.onPageIndexChanged = function(grid, newPage, oldPage) {
            $('#edtPage2').val(newPage);
            checkButtons2();
        };

        // buttons
        $('#btnFirst').click(function() {
            grdMain.setPageIndex(0);
        });
        $('#btnLast').click(function() {
            grdMain.setPageIndex(grdMain.pageCount() - 1);
        });
        $('#btnPrev').click(function() {
            grdMain.setPageIndex(grdMain.pageIndex() - 1);
        });
        $('#btnNext').click(function() {
            grdMain.setPageIndex(grdMain.pageIndex() + 1);
        });
        $('#btnGoto').click(function() {
            grdMain.setPageIndex($('#edtPage').val());
        });
        $('#btnFirst2').click(function() {
            var p = grdMain2.pageIndex() * 10;
            grdMain2.setPageAndRows(0, [ p + 2, p + 4, p + 3, p + 5, p + 7 ]);
        });
        $('#btnLast2').click(function() {
            var p = grdMain2.pageIndex() * 10;
            grdMain2.setPageAndRows(grdMain2.pageCount() - 1, [ p + 2, p + 4, p + 9, p + 5, p + 7 ]);
        });
        $('#btnPrev2').click(function() {
            var p = grdMain2.pageIndex() * 10;
            grdMain2.setPageAndRows(grdMain2.pageIndex() - 1, [ p + 2, p + 4, p + 9, p + 5, p + 7 ]);
        });
        $('#btnNext2').click(function() {
            var p = grdMain2.pageIndex() * 10;
            grdMain2.setPageAndRows(grdMain2.pageIndex() + 1, [ p + 2, p + 4, p + 3, p + 5, p + 7 ]);
        });
        $('#btnGoto2').click(function() {
            var p = grdMain2.pageIndex() * 10;
            grdMain2.setPageAndRows($('#edtPage2').val(), [ p + 2, p + 4, p + 3, p + 5, p + 7 ]);
        });
    });
</script>
</head>
<body>
    <h3>Paging - Page Rows</h3>
    <div>
        <button id="btnFirst">First</button>
        <button id="btnPrev">&lt;</button>
        <button id="btnNext">&gt;</button>
        <button id="btnLast">Last</button>
        <input type="text" id="edtPage" value="0">
        <button id="btnGoto">Go to</button>
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnFirst2">First</button>
        <button id="btnPrev2">&lt;</button>
        <button id="btnNext2">&gt;</button>
        <button id="btnLast2">Last</button>
        <input type="text" id="edtPage2" value="0">
        <button id="btnGoto2">Go to</button>
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>