<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Cell Styles</title>
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
        grdMain.setColumns(columns);
        grdMain2 = DataLudi.createGridView("container2");
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

        grdMain2.checkBar().setVisible(false);
        grdMain2.header().setHeight(30);
        grdMain2.footer().setVisible(false);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // grid style
        grdMain.registerCellStyle('style01', {
            "background" : "#880000",
            "color" : "#ffffff"
        });
        grdMain.registerCellStyles([ {
            id : 'style02',
            background : "#000088",
            color : "#ffffff"
        }, {
            id : 'style03',
            background : "#ffff00",
            color : "#ff0000"
        }, {
            id : 'style04',
            background : "#008800",
            color : "#ffffff"
        } ]);

        grdMain2.registerCellStyles([ {
            id : 'style01',
            "background" : "#880000",
            "color" : "#ffffff"
        }, {
            id : 'style02',
            background : "#000088",
            color : "#ffffff"
        }, {
            id : 'style03',
            background : "#ffff00",
            color : "#ff0000"
        }, {
            id : 'style04',
            background : "#008800",
            color : "#ffffff"
        } ]);

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/loan_statement_small.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    quoted : true,
                    currency : true
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
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnSetCell').click(function() {
            grdMain.setCellStyle(0, 'country', 'style01', true);
            grdMain.setTopIndex(0);
        });
        $('#btnSetRow').click(function() {
            grdMain.setCellStyle(1, -1, 'style02', true);
            grdMain.setTopIndex(0);
        });
        $('#btnSetRows').click(function() {
            grdMain.setCellStyles([ 2, 3, 4 ], 'currency', 'style03');
            grdMain.setTopIndex(0);
        });
        $('#btnSetBlock').click(function() {
            grdMain.setCellStyles([ 5, 6, 7 ], [ 2, 3, 4 ], 'style04');
            grdMain.setTopIndex(0);
        });
        $('#btnSetArray').click(function() {
            var rows = [ [ 'style01', 'style02' ], [ 'style03', 'style04' ] ];
            grdMain2.setCellStyleRows(rows, {
                '0' : 'country',
                '1' : 'currency'
            });
            grdMain2.setTopIndex(0);
        });
        $('#btnSetJson').click(function() {
            var rows = [ {
                'style_country' : 'style02',
                'style_currency' : 'style01'
            }, {
                'style_country' : 'style03',
                'style_currency' : 'style02'
            } ];
            grdMain2.setCellStyleRows(rows, {
                'style_country' : 'country',
                'style_currency' : 'currency'
            }, 3)
            grdMain2.setTopIndex(0);
        });
    });
</script>
</head>
<body>
    <h3>Cell Styles</h3>
    <div>
        <button id="btnSetCell">Set Cell</button>붉은 바탕 흰 글자
        <button id="btnSetRow">Set Row</button>푸른 바탕 흰 글자
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnSetRows">Set Rows</button> 노란 바탕 붉은 글자
    </div>
    <div>
        <button id="btnSetBlock">Set Block</button> 초록 바탕 흰 글자
    </div>
    <p>
    <div>
        <button id="btnSetArray">Set Rows</button> 노란 바탕 붉은 글자
    </div>
    <div>
        <button id="btnSetJson">Set Block</button> 초록 바탕 흰 글자
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>