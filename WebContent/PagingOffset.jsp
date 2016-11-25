<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Paging - Row Offset</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;

        function loadData(start) {
            dsMain.clearRows();

            $.ajax({
                url : "data/loan_statement_small.csv",
                dataType : 'text',
                success : function(data) {
                    new DataLudi.DataLoader(dsMain).load("csv", data, {
                        start : 1 + start,
                        count : 10,
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
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
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
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
        grdMain.footer().setVisible(false);
        grdMain.setEditOptions({
            updatable : true,
            insertable : true,
            appendable : true,
            deletable : true
        })
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grids Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        loadData(0);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid initialize
        // $('#pagePanel').hide();        
        var checkButtons = function() {
            var count = grdMain.pageCount();
            var page = grdMain.pageIndex();

            $('#btnFirst').prop('disabled', page <= 0);
            $('#btnPrev').prop('disabled', page <= 0);
            $('#btnNext').prop('disabled', page >= count - 1);
            $('#btnLast').prop('disabled', page >= count - 1);
        };
        grdMain.setPaging(true, 10, 6);

        // grid events
        grdMain.onPaged = function(grid, paged) {
            checkButtons();
        };
        grdMain.onPageCountChanged = function(grid, newCount, oldCount) {
            checkButtons();
        };
        grdMain.onPageIndexChanging = function(grid, newPage, oldPage) {
            console.log('### Page index changed: ' + oldPage + ' -> ' + newPage);
        };
        grdMain.onPageIndexChanged = function(grid, newPage, oldPage) {
            $('#edtPage').val(newPage);
            checkButtons();
            if ($('#chkEventData').is(':checked')) {
                loadData(grdMain.pageSize() * newPage);
            }
        };
        function setPage(page) {
            var size = grdMain.pageSize();
            // 항상 첫 번째 행부터 표시한다.
            grdMain.setPageAndOffset(page, -page * size);
            if (!$('#chkEventData').is(':checked')) {
                loadData(page * size);
            }
        };
        // buttons
        $('#btnFirst').click(function() {
            setPage(0);
        });
        $('#btnLast').click(function() {
            setPage(grdMain.pageCount() - 1);
        });
        $('#btnPrev').click(function() {
            setPage(grdMain.pageIndex() - 1);
        });
        $('#btnNext').click(function() {
            setPage(grdMain.pageIndex() + 1);
        });
        $('#btnGoto').click(function() {
            setPage($('#edtPage').val());
        });
    });
</script>
</head>
<body>
    <h3>Paging - Row Offset</h3>
    <div>
        <input type="checkbox" id="chkEventData">In Event check하면 grid.onPageIndexChanged 에서 데이터 로드.
        <br>
        <input type="checkbox" id="chkDataIndex">DataIndex Indicator check하면 RowIndicator에 ROW_INDEX 대신 DATA_INDEX 표시.
    </div>
    <div id="pagePanel">
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
</body>
</html>