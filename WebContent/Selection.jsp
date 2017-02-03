<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Selection</title>
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
        } ]);

        //grid options
        grdMain.header().setHeight(30);
        grdMain.footer().setVisible(false);

        grdMain.header().head().setPopupMenu({
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
                    quoted : true,
                    currency : true
                });
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

        // grid events
        grdMain.onSelectionEnded = function(grid) {
            var rows = grid.getSelectedRows();
            var fld = dsMain.getFieldIndex('original_amount');
            var sum = 0;
            for (var i = rows.length; i--;) {
                var r = rows[i].dataIndex();
                if (r >= 0) {
                    sum += dsMain.getValue(r, fld);
                }
            }
            $('#txtTotal').text(sum);
        };

        // buttons
        $('input:radio[name=rgpSelectStyle]').click(function() {
            var value = $("input[name=rgpSelectStyle]:checked").val();
            grdMain.displayOptions().setSelectStyle(value);
        });
        $('#chkIndicatorSelectable').click(function() {
            var checked = document.getElementById('chkIndicatorSelectable').checked;
            grdMain.rowIndicator().setSelectable(checked);
        });
        $('#chkHeaderSelectable').click(function() {
            var checked = document.getElementById('chkHeaderSelectable').checked;
            grdMain.header().setSelectable(checked);
        });
        $('#chkMoveInSelection').click(function() {
            var checked = document.getElementById('chkMoveInSelection').checked;
            grdMain.editOptions().setMoveInSelection(checked);
        });
        $('#btnStyle1').click(function() {
            grdMain.body().setSelectionStyles({
                background : "#100000ff",
                border : "#dd0000ff,2px"
            });
        });
        $('#btnStyle2').click(function() {
            grdMain.body().setSelectionStyles({
                background : "#1ff00000",
                border : "#eeff0000"
            });
        });
    });
</script>
</head>
<body>
    <h3>Selection</h3>
    <div>
        <input type="radio" name="rgpSelectStyle" value="block" checked="checked">SelectionStyle.BLOCK
        <input type="radio" name="rgpSelectStyle" value="rows">ROWS 
        <input type="radio" name="rgpSelectStyle" value="columns">COLUMNS
        <input type="radio" name="rgpSelectStyle" value="singleRow">SINGLE_ROW
        <input type="radio" name="rgpSelectStyle" value="singleColumn">SINGLE_COLUMN
        <input type="radio" name="rgpSelectStyle" value="single">SINGLE
        <input type="radio" name="rgpSelectStyle" value="none">NONE
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkIndicatorSelectable" checked="checked">RowIndicator Selectable
    </div>
    <div>
        <input type="checkbox" id="chkHeaderSelectable" checked="checked">Header Selectable
    </div>
    <div>
        <input type="checkbox" id="chkMoveInSelection" checked="checked">Move in Selection
    </div>
    <div>
        <button id="btnStyle1">Selection Style 1</button>
        <button id="btnStyle2">Selection Style 2</button>
    </div>
</body>
</html>