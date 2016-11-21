<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Number Editor</title>
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
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "75",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "InterestRate",
                "subText" : "positiveOnly",
                "subStyles" : {
                    "color" : "#800",
                    "selectedColor" : "#f00",
                    "fontBold" : false
                }
            },
            "editor" : {
                "type" : "number",
                "emptyValue" : 0,
                "positiveOnly" : true
            }
        }, {
            "name" : "OriginalAmount",
            "fieldName" : "original_amount",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "OriginalAmount",
                "subText" : "maxDigits = 0",
                "subStyles" : {
                    "color" : "#800",
                    "selectedColor" : "#f00",
                    "fontBold" : false
                }
            },
            "editor" : {
                "type" : "number",
                "emptyValue" : 0,
                "positiveOnly" : true,
                "maxDigits" : 0
            }
        }, {
            "name" : "CancelledAmount",
            "fieldName" : "cancelled_amount",
            "width" : 95,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "CancelledAmount",
                "subText" : "minValue = 100",
                "subStyles" : {
                    "color" : "#800",
                    "selectedColor" : "#f00",
                    "fontBold" : false
                }
            },
            "editor" : {
                "type" : "number",
                "positiveOnly" : true,
                "maxDigits" : 2,
                "minValue" : 100
            }
        }, {
            "name" : "DisbursedAmount",
            "fieldName" : "disbursed_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "DisbursedAmount",
                "subText" : "maxValue = 1000",
                "subStyles" : {
                    "color" : "#800",
                    "selectedColor" : "#f00",
                    "fontBold" : false
                }
            },
            "editor" : {
                "type" : "number",
                "maxDigits" : 2,
                "maxValue" : 1000
            }
        }, {
            "name" : "RepaidAmount",
            "fieldName" : "repaid_amount",
            "width" : 120,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "RepaidAmount",
                "subText" : "100<=value<=1000",
                "subStyles" : {
                    "color" : "#800",
                    "selectedColor" : "#f00",
                    "fontBold" : false
                }
            },
            "editor" : {
                "type" : "number",
                "minValue" : 100,
                "maxValue" : 1000
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
        } ]);

        //grid options
        grdMain.setOptions({
            checkBar : false,
            header : {
                height : 33,
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            footer : false,
            rowIndicator : {
                stateVisible : true
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
        $('#chkCheckMaxValue').click(function() {
            var checked = $('#chkCheckMaxValue').is(':checked');
            var col = grdMain.columnByName('DisbursedAmount');
            col.setEditor({
                checkMaxValue : checked
            });
        });
    });
</script>
</head>
<body>
    <h3>Number Editor</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkCheckMaxValue" checked="checked">DisbursedAmount checkMaxValue
    </div>
</body>
</html>