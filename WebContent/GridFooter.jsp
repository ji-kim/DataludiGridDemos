<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Grid Footer</title>
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
        var columns = [ {
            "name": "LoanNumber",
            "fieldName": "loan_number",
            "width": "70",
            "styles": {
                textAlignment: "center"
            },
            "header": {
                "text": "LoanNumber"
            }
        }, {
            "name": "Country",
            "fieldName": "country",
            "width": "70",
            "styles": {
            },
            "header": {
                "text": "Country"
            }
        }, {
            "name": "InterestRate",
            "fieldName": "interest_rate",
            "width": "65",
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "InterestRate"
            },
            "footer": {
                "expression": "avg",
                "styles": {
                    "prefix": "Average" + ": ",
                    "numberFormat": "#,##0.00"
                }
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
            "name": "ProjectID",
            "fieldName": "project_id",
            "width": "70",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "ProjectID"
            },
            "footer": {
                "text": "Sum",
                "styles": {
                    "textAlignment": "far"
                }
            }
        }, {
            "name": "OriginalAmount",
            "fieldName": "original_amount",
            "width": 105,
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "OriginalAmount"
            },
            "footer": {
                "expression": "sum",
                "styles": {
                    "prefix": "$",
                    "numberFormat": "#,##0",
                    "background": "#777",
                    "color": "#fff",
                    "borderTop": "#ddd"
                }
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
            },
            "footer": {
                "expression": "sum",
                "styles": {
                    "prefix": "$",
                    "numberFormat": "#,##0"
                }
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
            },
            "footer": {
                "expression": "varp",
                "text": "분산",
                "styles": {
                    "prefix": "분산=>$",
                    "numberFormat": "#,##0"
                }
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
            },
            "footer": {
                "expression": "sum",
                "styles": {
                    "prefix": "$",
                    "numberFormat": "#,##0"
                }
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
            },
            "footer": {
                "styles": {
                    "prefix": "$",
                    "textAlignment": "far",
                    "numberFormat": "0,000",
                    "postfix": " $",
                    "font": "Arial,12"
                },
                "text": "SUM",
                "expression": "sum",
                "dynamicStyles": [{
                    "criteria": "value > 10000",
                    "styles": "color=#ff0000"
                }]
            }
        }, {
            "name": "SoldAmount2",
            "fieldName": "sold_amount",
            "width": 80,
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "SoldAmount" + '2'
            },
            "footer": {
                "expression": "'TOTAL'"
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
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);

        //grid options
        grdMain.setOptions({
            header: {
                height: 30,
                head: {
                    popupMenu: {
                        label: 'DataLudi Grid Version',
                        callback: function () { alert(DataLudi.getVersion()); }
                    }
                }
            },
            footer: {
                head: {
                    text: "\u03A3",
                    styles: {
                        fontItalic: true
                    }
                }
            },
            checkBar: {
                visible: false
            },
            hscrollBar: {
                barWidth: 12
            },
            vscrollBar: {
                barWidth: 12
            },
            display: {
                rowHoverMask: {
                    visible: true,
                    styles: {
                        background: "#1000ff00"
                    }
                }
            },
            autoFill: true
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url: "data/loan_statement_small.csv",
            dataType: 'text',
            success: function (data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start: 1,
                    quoted: true,
                    currency: true
                });
            },
            error: function (xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events
        grdMain.onColumnChecked = function(grid, column, checked) {
            console.log('Column "' + column.name() + '" is ' + (checked ? 'checked' : 'unchecked'));
            column.styles().setBackground(checked ? '#200000ff' : '#ffffff');
        };

        // buttons
        $('#edtMinHeight')[0].value = grdMain.footer().minHeight();
        $('#chkVisible').click(function() {
            var checked = document.getElementById('chkVisible').checked;
            grdMain.footer().setVisible(checked);
        });
        $('#chkHeight').click(function() {
            var checked = document.getElementById('chkHeight').checked;
            if (checked) {
                view.btnHeight_click();
            } else {
                grdMain.footer().setHeight(0);  
            }
        });
        $('#btnHeight').click(function() {
            if (document.getElementById('chkHeight').checked) {
                grdMain.footer().setHeight(document.getElementById('edtHeight').value);
            }
        });
        $('#btnMinHeight').click(function() {
            grdMain.footer().setMinHeight(document.getElementById('edtMinHeight').value);
        });
        $('#btnHeadText').click(function() {
            grdMain.footer().head().setText(document.getElementById('edtHeadText').value);
        });      
        $('#btnStyles1').click(function() {
            grdMain.loadStyles({
                footer: {
                    background: '#100000ff',
                    selectedBackground: '#300000ff',
                    color: '#000088',
                    selectedColor: undefined,
                    fontBold: true,
                    head: {
                    }
                }
            });
        });
        $('#btnStyles2').click(function() {
            grdMain.loadStyles({
                footer: {
                    background: '#20ffff00',
                    selectedBackground: '#100000ff',
                    selectedColor: undefined,
                    color: '#000088',
                    fontBold: false,
                    head: {
                    }
                }
            });
        });
        $('#btnStyles3').click(function() {
            grdMain.loadStyles({
                footer: {
                    background: '#c00088ff',
                    selectedBackground: '#c00000cc',
                    color: '#fff',
                    selectedColor: '#fff',
                    fontBold: false,
                    head: {
                    }
                }
            });
        });
    });
</script>
</head>
<body>
    <h3>Grid Footer</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkVisible" checked="checked">Footer Visible
    </div>
    <div>
        <input type="checkbox" id="chkHeight">Footer Height
        <input type="text" id="edtHeight" value="30">
        <button id="btnHeight">높이 변경</button>
        <input type="text" id="edtMinHeight" value="0">
        <button id="btnMinHeight">최소 높이 변경</button>
    </div>
    <div>
        <input type="text" id="edtHeadText" value="SUM">
        <button id="btnHeadText">Header Text</button>
    </div>
    <div>
        <button id="btnStyles1">Styles 1</button>
        <button id="btnStyles2">Styles 2</button>
        <button id="btnStyles3">Styles 3</button>
    </div>
</body>
</html>