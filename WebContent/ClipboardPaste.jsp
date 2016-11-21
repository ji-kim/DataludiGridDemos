<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Clipboard Paste</title>
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
        }, {
            fieldName : "active",
            dataType : "boolean"
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
            "width" : "100",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "65",
            "pasteCallback" : function(row, field, text) {
                var v = parseFloat(text);
                return isNaN(v) ? 1.0 : v;
            },
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "InterestRate"
            }
        }, {
            "name" : "OriginalAmount",
            "fieldName" : "original_amount",
            "width" : 105,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0.00"
            },
            "header" : {
                "text" : "OriginalAmount"
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
        }, {
            "name" : "Active",
            "fieldName" : "active",
            "width" : "60",
            "styles" : {
                textAlignment : "center"
            },
            "header" : "Active"
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

        grdMain.setEditOptions({
            pasteCallback : function(row, column, field, text) {
                var v;
                switch (field.fieldName()) {
                case 'country':
                    v = text && text.indexOf('X_') != 0 ? 'X_' + text : text;
                    break;
                default:
                    v = field.readValue(text);
                    break;
                }
                return v;
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
        grdMain2.setEditOptions({
            pasteDatetimeFormats : [ 'yyyy-MM-dd', 'yyyyMMdd' ],
            pasteBooleanFormat : "false,f:true,t:",
            pasteNumberChars : "$w,abcd"
        })
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

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
                    currency : true,
                    callback : function(ds) {
                        ds.updateValues(null, {
                            active : function(ds, row, field) {
                                return (Math.random() * 100) % 2 < 1;
                            }
                        }, false, false, true);
                    }
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
        $('#chkPasteEnabled').click(function() {
            var checked = $('#chkPasteEnabled').is(':checked');
            grdMain.setProperty("editOptions.pasteEnabled", checked).setFocus();
        });
        $('#chkSinglePaste').click(function() {
            var checked = $('#chkSinglePaste').is(':checked');
            grdMain.setProperty("editOptions.singlePaste", checked).setFocus();
        });
    });
</script>
</head>
<body>
    <h3>Clipboard Paste</h3>
    <div>
        <input type="checkbox" id="chkPasteEnabled" checked="checked">Paste Enabled
        <input type="checkbox" id="chkSinglePaste">Single Paste
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <p>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>