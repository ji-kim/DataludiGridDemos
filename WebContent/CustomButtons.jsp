<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Custom Buttons</title>
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
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name": "LoanNumber",
            "fieldName": "loan_number",
            "width": 75,
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "LoanNumber"
            }
        }, {
            "name": "Country",
            "fieldName": "country",
            "width": 150,
            "styles": {
                "background": "#1000ff00"
            },
            "header": {
                "text": "Country"
            },
            customButtons: [{
                visibility: DataLudi.ButtonVisibility.ALWAYS,
                callback: function (index) {
                    alert('Add - ' + index.column.header().displayText());
                },
                displayCallback: function (index) {
                    return true;
                },
                enabledCallback: function (index) {
                    return true;
                },
                imageUrl: 'assets/add_up.png',
                hoverUrl: 'assets/add_up.png',
                downUrl: 'assets/add_down.png'
            }, {
                visibility: DataLudi.ButtonVisibility.DEFAULT,
                callback: function (index) {
                    alert('Delete - ' + index.column.header().displayText());
                },
                displayCallback: function (index) {
                    return true;
                },
                enabledCallback: function (index) {
                    return true;
                },
                imageUrl: 'assets/delete_up.png',
                hoverUrl: 'assets/delete_up.png',
                downUrl: 'assets/delete_down.png'
            }]
        }, {
            "name": "OriginalAmount",
            "fieldName": "original_amount",
            "width": 150,
            "styles": {
                "textAlignment": "far",
                "background": "#100088ff"
            },
            "header": {
                "text": "OriginalAmount"
            },
            customButtons: [{
                visibility: DataLudi.ButtonVisibility.ALWAYS,
                callback: function (index) {
                    alert('Delete - ' + index.column.header().displayText());
                },
                displayCallback: function (index) {
                    return true;
                },
                enabledCallback: function (index) {
                    return true;
                },
                imageUrl: 'assets/delete_up.png',
                hoverUrl: 'assets/delete_up.png',
                downUrl: 'assets/delete_down.png'
            }]
        }, {
            "name": "ProjectID",
            "fieldName": "project_id",
            "width": "70",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "ProjectID"
            }
        }, {
            "name": "InterestRate",
            "fieldName": "interest_rate",
            "width": "90",
            "button": "action",
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "InterestRate"
            }
        }, {
            "name": "Currency",
            "fieldName": "currency",
            "width": "90",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "Currency"
            }
        }, {
            "name": "CancelledAmount",
            "fieldName": "cancelled_amount",
            "width": 100,
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "CancelledAmount"
            }
        }, {
            "name": "DisbursedAmount",
            "fieldName": "disbursed_amount",
            "width": 110,
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "DisbursedAmount"
            }
        }, {
            "name": "RepaidAmount",
            "fieldName": "repaid_amount",
            "width": 110,
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "RepaidAmount"
            }
        }, {
            "name": "SoldAmount",
            "fieldName": "sold_amount",
            "width": 110,
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "SoldAmount"
            }
        },  {
            "name": "FirstDate",
            "fieldName": "first_date",
            "width": "90",
            "styles": {
                datetimeFormat: "yyyy-MM-dd",
                textAlignment: "center"
            },
            "header": {
                "text": "FirstDate"
            }
        },  {
            "name": "LastDate",
            "fieldName": "last_date",
            "width": "90",
            "styles": {
                datetimeFormat: "yyyy-MM-dd",
                textAlignment: "center"
            },
            "header": {
                "text": "LastDate"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            checkBar: false,
            footer: false,
            header: {
                height: 30,
                head: {
                    popupMenu: {
                        label: 'DataLudi Version',
                        callback: function () { alert(DataLudi.getVersion()); }
                    }
                }
            },
            edit: {
                deletable: true,
                insertable: true
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

        // grid events
        grdMain.onCellButtonClicked = function(grid, index) {
            alert(index.column.name());
        };

        // buttons
    });
</script>
</head>
<body>
    <h3>Custom Buttons</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>