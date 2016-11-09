<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Check Bar</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
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
        dsMain.setSoftDelete(true);

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
        grdMain.header().setHeight(30);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain.body().setRowDynamicStyles([ {
            expression : "checked",
            styles : {
                background : "#1000ff88"
            }
        } ]);
        grdMain.displayOptions().setRowHoverMask(true);

        grdMain2.header().setHeight(30);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain2.body().setRowDynamicStyles([ {
            expression : "checked",
            styles : {
                background : "#100000ff"
            }
        } ]);
        grdMain2.displayOptions().setRowHoverMask({
            visible : true,
            styles : {
                background : "#150088ff"
            }
        });
        grdMain2.loadStyles({
            checkBar : {
                shapeName : 'rectangle',
                shapeColor : '#f00',
                head : {
                    shapeName : 'rectangle',
                    shapeColor : '#f00'
                }
            }
        })

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
        $('#chkCheckBarVisible').click(function() {
            var checked = document.getElementById('chkCheckBarVisible').checked;
            grdMain.checkBar().setVisible(checked);
        });
        $('#chkCheckable').click(function() {
            var checked = document.getElementById('chkCheckable').checked;
            grdMain.editOptions().setCheckable(checked);
        });
        $('#chkCheckDraggable').click(function() {
            var checked = document.getElementById('chkCheckDraggable').checked;
            grdMain.checkBar().setDraggable(checked);
        });
        $('#chkExclusive').click(function() {
            var checked = document.getElementById('chkExclusive').checked;
            grdMain.checkBar().setExclusive(checked);
        });

        $('#btnApplyCheckedStyle').click(function() {
            grdMain.body().setRowDynamicStyles([ {
                expression : 'checked',
                styles : {
                    background : '#3000ff00'
                }
            } ]);
        });
        $('#btnDeleteCheckedRows').click(function() {
            var rows = grdMain.getCheckedRows();
            grdMain.deleteRows(rows, true);
        });
        $('#btnIsChecked').click(function() {
            var row = grdMain2.focusedRow();
            if (row) {
                alert(grdMain2.isChecked(row) ? 'Checked' : 'Not checked');
            } else {
                alert(strings["IsCheck"]);
            }
        });
        $('#btnCheckRow').click(function() {
            var row = grdMain2.focusedRow();
            if (row) {
                grdMain2.setChecked(row, true);
            } else {
                alert(strings["CheckRow"]);
            }
        });
        $('#btnCheckRowExclusive').click(function() {
            var row = grdMain2.focusedRow();
            if (row) {
                grdMain2.setChecked(row, true, true);
            } else {
                alert(strings["CheckRow"]);
            }
        });
        $('#btnUncheckRow').click(function() {
            var row = grdMain2.focusedRow();
            if (row) {
                grdMain2.setChecked(row, false);
            } else {
                alert("UncheckRow");
            }
        });
        $('#btnCheckAll').click(function() {
            grdMain2.checkAll(true);
            grdMain2.setAllChecked(true);
        });
        $('#btnUncheckAll').click(function() {
            grdMain2.checkAll(false);
            grdMain2.setAllChecked(false);
        });
        $('#btnCheckSelected').click(function() {
            var rows = grdMain2.getSelectedRows();
            grdMain2.checkRows(rows, true);
        });
        $('#chkCheckAllExpr').click(function(ev) {
            var checked = document.getElementById()
            grdMain2.checkBar().setCheckAllExpression(ev.target.checked ? "values['interest_rate'] > 4" : null);
        });
    });
</script>
</head>
<body>
    <h3>Check Bar</h3>
    <div>
        <input type="checkbox" id="chkCheckBarVisible" checked="checked">CheckBar Visible
        <input type="checkbox" id="chkCheckable" checked="checked">Checkable
        <input type="checkbox" id="chkCheckDraggable">CheckBar Draggable
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkExclusive">Exclusive
    </div>
    <div>
        <button id="btnApplyCheckedStyle">Apply Style</button>
    </div>
    <div>
        <button id="btnDeleteCheckedRows">Checked 행들 삭제</button>
    </div>
    <p>
    <div>
        <button id="btnIsChecked">Is Checked?</button>
        <button id="btnCheckRow">Check Row</button>
        <button id="btnCheckRowExclusive">Check Row Exclusively</button>
        <button id="btnUncheckRow">Uncheck Row</button>
        <button id="btnCheckAll">Check All</button>
        <button id="btnUncheckAll">Uncheck All</button>
        <button id="btnCheckSelected">Check Selected Rows</button>
    </div>
    <div>
        <input type="checkbox" id="chkCheckAllExpr">Check All Expression
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>