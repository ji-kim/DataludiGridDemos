<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Indicator</title>
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
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
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

        // buttons
        $('#chkIndicatorVisible').click(function() {
            var checked = document.getElementById('chkIndicatorVisible').checked;
            grdMain.rowIndicator().setVisible(checked);
        });
        $('input:radio[name=rgpDisplayValue]').click(function() {
            var value = $("input[name=rgpDisplayValue]:checked").val();
            grdMain.rowIndicator().setDisplayValue(value);
        });
        $('#edtRowBase').change(function() {
            var v = parseInt(document.getElementById('edtRowBase').value);
            !isNaN(v) && grdMain.rowIndicator().setRowIndexBase(v);
        });
        $('#edtDataBase').change(function() {
            var v = parseInt(document.getElementById('edtDataBase').value);
            !isNaN(v) && grdMain.rowIndicator().setDataIndexBase(v);
        });
        $('#edtMaxWidth').change(function() {
            var v = parseInt(document.getElementById('edtMaxWidth').value);
            !isNaN(v) && grdMain.rowIndicator().setMaxWidth(v);
        });
        $('#edtMinWidth').change(function() {
            var v = parseInt(document.getElementById('edtMinWidth').value);
            !isNaN(v) && grdMain.rowIndicator().setMinWidth(v);
        });
        $('#edtIndicatorWidth').change(function() {
            var v = parseInt(document.getElementById('edtIndicatorWidth').value);
            !isNaN(v) && grdMain.rowIndicator().setWidth(v);
        });
        $('#chkSelectable').click(function() {
            var checked = document.getElementById('chkSelectable').checked;
            grdMain.rowIndicator().setSelectable(checked);
        });
        $('#chkShapeVisible').click(function() {
            var checked = document.getElementById('chkShapeVisible').checked;
            grdMain.rowIndicator().setShapeVisible(checked);
        });
    });
</script>
</head>
<body>
    <h3>Row Indicator</h3>
    <input type="checkbox" id="chkIndicatorVisible" checked="checked">RowIndicator
    Visible
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="radio" name="rgpDisplayValue" value="none">RowIndicatorValue.NONE
        <input type="radio" name="rgpDisplayValue" value="rowIndex" checked="checked">RowIndicatorValue.ROW_INDEX 
        <input type="radio" name="rgpDisplayValue" value="dataIndex">RowIndicatorValue.DATA_INDEX
    </div>
    <div>
        <span>RowIndex Base : </span> 
        <input type="text" id="edtRowBase" value="1">
        <span>DataIndex Base : </span>
        <input type="text" id="edtDataBase" value="1">
    </div>
    <div>
        <input type="checkbox" id="chkShapeVisible" checked="checked">Shape
        Visible
    </div>
    <div>
        <span>minWidth : </span>
        <input type="text" id="edtMinWidth" value="40">
        <span>maxWidth : </span>
        <input type="text" id="edtMaxWidth" value="0">
        <span>width : </span>
        <input type="text" id="edtIndicatorWidth" value="0">
    </div>
    <div>
        <input type="checkbox" id="chkSelectable" checked="checked">selectable
    </div>
</body>
</html>