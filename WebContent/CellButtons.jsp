<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>DataCell Buttons</title>
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
            "width" : 75,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "LoanNumber"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 100,
            "button" : "popup",
            "popupMenu" : "menu01",
            "buttonVisibility" : DataLudi.ButtonVisibility.ALWAYS,
            "buttonDisplayCallback" : function(index) {
                return index.rowIndex % 2;
            },
            "styles" : {
                "background" : "#1000ff00"
            },
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "OriginalAmount",
            "fieldName" : "original_amount",
            "width" : 105,
            "button" : "popup",
            "popupMenu" : "menu01",
            "popupMenuCallback" : function(index) {
                if (index.rowIndex % 2) {
                    return 'menu01'
                } else {
                    return 'menu02'
                }
            },
            "buttonVisibility" : DataLudi.ButtonVisibility.ALWAYS,
            "styles" : {
                "textAlignment" : "far",
                "background" : "#1000ff00"
            },
            "header" : {
                "text" : "OriginalAmount"
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
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "90",
            "button" : "action",
            "styles" : {
                "textAlignment" : "far",
                "background" : "#100088ff"
            },
            "header" : {
                "text" : "InterestRate"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "90",
            "button" : "action",
            "buttonVisibility" : "always",
            "styles" : {
                "textAlignment" : "center",
                "background" : "#100088ff"
            },
            "header" : {
                "text" : "Currency"
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
        grdMain.setOptions({
            checkBar : false,
            footer : false,
            header : {
                height : 30,
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            edit : {
                deletable : true,
                insertable : true
            }
        })

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

        // grid events
        grdMain.onCellButtonClicked = function(grid, index) {
            alert(index.column.name());
        };

        // add Popup menu
        var menuCallback = function(data) {
            alert(data.label);
        };
        grdMain.registerPopupMenu('menu01', [ {
            type : 'check',
            label : 'menu1_1',
            checked : true,
            callback : menuCallback
        }, {
            label : '-'
        }, {
            label : 'menu1_2',
            callback : menuCallback
        }, {
            label : 'menu1_3',
            callback : menuCallback
        } ]);

        var menu2 = [ {
            label : 'menu2_1',
            callback : menuCallback
        }, {
            label : 'menu2_2',
            callback : menuCallback
        }, {
            label : '-'
        }, {
            label : 'menu2_3',
            callback : menuCallback,
            children : [ {
                label : 'menu2_3_1',
                children : [ {
                    type : 'radio',
                    group : 'group',
                    checked : true,
                    label : 'menu2_3_1_1',
                    callback : menuCallback
                }, {
                    type : 'radio',
                    group : 'group',
                    label : 'menu2_3_1_2',
                    callback : menuCallback
                } ]
            }, {
                label : 'menu2_3_2',
                callback : menuCallback,
                enabled : false
            }, {
                label : 'menu2_3_3',
                callback : menuCallback
            } ]
        } ];
        grdMain.registerPopupMenu('menu02', menu2);

        // buttons
        $('input:radio[name=rgpVisibility]').click(function() {
            var value = $("input[name=rgpVisibility]:checked").val();
            var col = grdMain.columnByName('Country');
            if (col) {
                col.setButtonVisibility(value);
            }
        });
    });
</script>
</head>
<body>
    <h3>DataCell Buttons</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <input type="radio" name="rgpVisibility" value="always">DataLudi.ButtonVisibility.ALWAYS
    <input type="radio" name="rgpVisibility" value="default"
        checked="checked">DEFAULT
    <input type="radio" name="rgpVisibility" value="visible">VISIBLE
    <input type="radio" name="rgpVisibility" value="hidden">HIDDEN
</body>
</html>