<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Popup Menu</title>
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
            "width" : "90",
            "button" : "popup",
            "popupMenu" : "menu01",
            "buttonVisibility" : DataLudi.ButtonVisibility.ALWAYS,
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "90",
            "button" : "popup",
            "popupMenu" : "menu03",
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
            "button" : "popup",
            "popupMenuCallback" : function(index) {
                if (index.rowIndex < 10) {
                    return 'menu02';
                } else {
                    return 'menu03';
                }
            },
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
        grdMain.footer().setVisible(false);
        grdMain.setEditOptions({
            deletable : true,
            insertable : true
        })
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

        grdMain.registerPopupMenu('menu03', [ {
            label : "Add Row",
            callback : function() {
                grdMain.insert();
                grdMain.setFocus();
            }
        }, {
            label : "Delete Rows",
            callback : function() {
                grdMain.deleteSelection();
            }
        }, {
            label : "-" /* menu separator */
        }, {
            label : "Excel Export",
            callback : function() {
                new DataLudi.GridExcelExporter().export(grdMain, {
                    url : "/envelope",
                    fileName : "dlgrid.xlsx"
                });
            },
            tag : 'excel'
        } ]);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events

        // buttons
        $('input:radio[name=rgpVisibility]').click(function() {
            var value = $("input[name=rgpVisibility]:checked").val();
            var col = grdMain.columnByName('InterestRate');
            if (col) {
                col.setButtonVisibility(value);
            }
        });
    });
</script>
</head>
<body>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <span>Button Visibility : </span>
        <input type="radio" name="rgpVisibility" value="always">DataLudi.ButtonVisibility.ALWAYS
        <input type="radio" name="rgpVisibility" value="default" checked="checked">DEFAULT
        <input type="radio" name="rgpVisibility" value="visible">VISIBLE
        <input type="radio" name="rgpVisibility" value="hidden">HIDDEN
    </div>
</body>
</html>