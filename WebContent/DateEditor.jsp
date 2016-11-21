<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Date Editor</title>
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
            "width" : "100",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "FirstDate",
            "fieldName" : "first_date",
            "width" : "120",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "FirstDate"
            },
            "editor" : {
                "type" : "date",
                "holidays" : [ {
                    "type" : "day",
                    "days" : [ "일" ],
                    "color" : "#ff0000",
                    "description" : "휴일"
                }, {
                    "type" : "date",
                    "dates" : [ "2016/05/05", "2016/05/14" ],
                    "color" : "#00ff00",
                } ]
            }
        }, {
            "name" : "LastDate",
            "fieldName" : "last_date",
            "width" : "120",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "LastDate"
            },
            "editor" : {
                "type" : "date",
                "yearNavigation" : true,
                "holidays" : [ {
                    "type" : "range",
                    "startDate" : "2016/12/31",
                    "color" : "#cccccc"
                }, {
                    "type" : "range",
                    "endDate" : "2000/01/01",
                    "color" : "#cccccc"
                }, {
                    "type" : "base",
                    "baseDate" : "2016/09/15",
                    "prevDays" : 1,
                    "nextDays" : 1,
                    "color" : "#ff0000",
                    "description" : "추석"
                } ]
            }
        }, {
            "name" : "LastDate",
            "fieldName" : "last_date",
            "width" : "120",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "LastDate2"
            },
            "editor" : {
                "type" : "date",
                "yearNavigation" : true,
                "minDate" : new Date(1965, 0, 1),
                "maxDate" : new Date(1975, 11, 31)
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
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
        grdMain.footer().setVisible(false);
        grdMain.rowIndicator().setStateVisible(true);
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
        $('#chkShowToday').click(function() {
            var checked = $('#chkShowToday').is(':checked');
            var col = grdMain.columnByName('FirstDate');
            col.setEditor({
                showToday : checked
            });
        });
        $('#chkYearNavigation').click(function() {
            var checked = $('#chkYearNavigation').is(':checked');
            var col = grdMain.columnByName('FirstDate');
            col.setEditor({
                yearNavigation : checked
            });
        });
        $('#chkTextReadOnly').click(function() {
            var checked = $('#chkTextReadOnly').is(':checked');
            var col = grdMain.columnByName('FirstDate');
            col.setEditor({
                textReadOnly : checked
            });
        });
        $('#chkButtonVisible').click(function() {
            var checked = $('#chkButtonVisible').is(':checked');
            var col = grdMain.columnByName('FirstDate');
            col.setEditorButtonVisibility(checked ? DataLudi.ButtonVisibility.DEFAULT : DataLudi.ButtonVisibility.HIDDEN);
        });
    });
</script>
</head>
<body>
    <h3>Date Editor</h3>
    <div>
        <input type="checkbox" id="chkShowToday" checked="checked">Show Today
        <br>
        <input type="checkbox" id="chkYearNavigation">Year Navigation
        <br>
        <input type="checkbox" id="chkTextReadOnly">Text ReadOnly
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkButtonVisible" checked="checked">Editor Button Visible
        <span>"최초상환일" 컬럼의 편집기 버튼 표시 여부</span>
    </div>
</body>
</html>