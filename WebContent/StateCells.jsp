<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>State Cells</title>
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

        grdMain.registerImageList({
            name : 'stateIcons',
            root : "assets/",
            items : [ 'data_created.png', 'data_updated.png', 'data_deleted.png' ]
        });

        //grid options
        grdMain.setOptions({
            rowIndicator : {
                stateVisible : true
            },
            checkBar : false,
            header : {
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
                updatable : true,
                insertable : true,
                deletable : true
            }
        });

        grdMain2.setOptions({
            rowIndicator : {
                stateVisible : true
            },
            checkBar : false,
            header : {
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
                updatable : true,
                insertable : true,
                deletable : true
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
        $('#chkStateVisible').click(function() {
            var checked = document.getElementById('chkStateVisible').checked;
            grdMain.rowIndicator().setStateVisible(checked);
        });
        $('#edtCreatedBackground').change(function() {
            var value = document.getElementById('edtCreatedBackground').val();
            var styles = grdMain.rowIndicator().createdStyles();
            styles.setBackground(value);
            document.getElementById('edtCreatedBackground').style.background = styles.background().css();
        });
        $('#edtUpdatedBackground').change(function() {
            var value = document.getElementById('edtUpdatedBackground').val();
            var styles = grdMain.rowIndicator().updatedStyles();
            styles.setBackground(value);
            document.getElementById('edtUpdatedBackground').style.background = styles.background().css();
        });
        $('#edtDeletedBackground').change(function() {
            var value = document.getElementById('edtDeletedBackground').val();
            var styles = grdMain.rowIndicator().deletedStyles();
            styles.setBackground(value);
            document.getElementById('edtDeletedBackground').style.background = styles.background().css();
        });
        $('#btnSetShapes').click(function() {
            grdMain.setRowIndicator({
                stateWidth : 15,
                stateStyles : {
                    background : "#f8f8f8"
                },
                createdStyles : {
                    shapeName : "plus",
                    shapeColor : "#f00"
                },
                updatedStyles : {
                    shapeName : "circle",
                    shapeColor : "#00f",
                    shapeSize : "70%"
                },
                deletedStyles : {
                    shapeName : "minus",
                    shapeColor : "#333"
                }
            });
        });
        $('#btnSetIcons').click(function() {
            grdMain.setRowIndicator({
                stateWidth : 15,
                stateImageList : "stateIcons",
                stateStyles : {
                    background : "#f8f8f8"
                },
                createdStyles : {
                    iconIndex : '0'
                },
                updatedStyles : {
                    iconIndex : '1'
                },
                deletedStyles : {
                    iconIndex : '2'
                }
            });
        });
        $('#btnSetLabels').click(function() {
            grdMain2.setRowIndicator({
                stateWidth : 15,
                stateStyles : {
                    background : "#f8f8f8"
                },
                createdLabel : "C",
                updatedLabel : "U",
                deletedLabel : "D"
            });
        });
        var indicator = grdMain.rowIndicator();
        $('#edtCreatedBackground').val(indicator.createdStyles().background().toText());
        $('#edtCreatedBackground').css('background', indicator.createdStyles().background().css());
        $('#edtUpdatedBackground').val(indicator.updatedStyles().background().toText());
        $('#edtUpdatedBackground').css('background', indicator.updatedStyles().background().css());
        $('#edtDeletedBackground').val(indicator.deletedStyles().background().toText());
        $('#edtDeletedBackground').css('background', indicator.deletedStyles().background().css());
    });
</script>
</head>
<body>
    <h3>State Cells</h3>
    <input type="checkbox" id="chkStateVisible" checked="checked">RowIndicator.stateVisible
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <span>DataRowState.CREATED</span>
        <input type="text" id="edtCreatedBackground" value="#600099ff">
        <span>UPDATED</span>
        <input type="text" id="edtUpdatedBackground" value="#20000000">
        <span>DELETED</span>
        <input type="text" id="edtDeletedBackground" value="#80000000">
    </div>
    <div>
        <button id="btnSetShapes">상태별 Shape 지정하기</button>
    </div>
    <div>
        <button id="btnSetIcons">상태별 icon 지정하기</button>
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <div>
        <button id="btnSetLabels">상태별 label 지정하기</button>
    </div>
</body>
</html>