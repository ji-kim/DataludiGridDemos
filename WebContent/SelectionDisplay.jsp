<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Selection Display</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName: "loan_number"
        }, {
            fieldName: "country"
        }, {
            fieldName: "interest_rate",
            dataType: "number"
        }, {
            fieldName: "currency"
        }, {
            fieldName: "project_id"
        }, {
            fieldName: "original_amount",
            dataType: "number"
        }, {
            fieldName: "cancelled_amount",
            dataType: "number"
        }, {
            fieldName: "disbursed_amount",
            dataType: "number"
        }, {
            fieldName: "repaid_amount",
            dataType: "number"
        }, {
            fieldName: "sold_amount",
            dataType: "number"
        }, {
            fieldName: "first_date",
            dataType: "datetime",
            datetimeFormat: "MM/dd/yyyy"
        }, {
            fieldName: "last_date",
            dataType: "datetime",
            datetimeFormat: "MM/dd/yyyy"
        } ]);
        dsMain.setSoftDelete(true);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name": "LoanNumber",
            "fieldName": "loan_number",
            "width": 70,
            "styles": {
                textAlignment: "center"
            },
            "header": {
                "text": "LoanNumber"
            }
        }, {
            "name": "Country",
            "fieldName": "country",
            "width": 80,
            "styles": {
            },
            "header": {
                "text": "Country"
            }
        }, {
            "name": "InterestRate",
            "fieldName": "interest_rate",
            "width": 65,
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
            "name": "OriginalAmount",
            "fieldName": "original_amount",
            "width": 105,
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "OriginalAmount"
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
        
        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns([ {
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
            "width": 100,
            "styles": {
                "background": "#1000ff88"
            },
            "header": {
                "text": "Country"
            },
            "mergeExpression": "value"
        }, {
            "name": "InterestRate",
            "fieldName": "interest_rate",
            "width": "65",
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
            "name": "OriginalAmount",
            "fieldName": "original_amount",
            "width": 105,
            "styles": {
                "textAlignment": "far"
            },
            "header": {
                "text": "OriginalAmount"
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
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
        grdMain.footer().setVisible(false);
        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });
        grdMain.displayOptions().setCheckDataInited(true);
        grdMain.displayOptions().setSelectMode(DataLudi.SelectionMode.EXTENDED);

        grdMain2.setOptions({
            checkBar: false,
            footer: false,
            "header.height": 30,
            "header.head.popupMenu": {
                label: 'DataLudi Version',
                callback: function () { alert(DataLudi.getVersion()); }
            },
            display: {
                checkDataInited: true,
                selectMode: DataLudi.SelectionMode.EXTENDED,
                selectDisplay: DataLudi.SelectionDisplay.CELL
            }
        });
        
        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
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
            $("#rowCount2").css("color", "#800").text(ds.rowCount().toLocaleString());
        };

        // grid events
        
        // buttons
        $('input:radio[name=rgpSelectDisplay]').click(function () {
        	var val = $("input[name=rgpSelectDisplay]:checked").val();
            grdMain.displayOptions().setSelectDisplay(val);
        });
        $('#chkShowSingle').click(function () {
        	var checked = document.getElementById('chkShowSingle').checked;
            grdMain.displayOptions().setShowSingleSelection(checked);
        });
        $('#btnStyle1').click(function () {
            grdMain.loadStyles({
                body: {
                    cell: {
                        selectedBackground: "#333",
                        seleectedColor: "#fff"
                    }
                }
            });
        });
        $('#btnStyle2').click(function () {
            grdMain.loadStyles({
                body: {
                    cell: {
                        selectedBackground: "#a0522d",
                        seleectedColor: "#fff"
                    }
                }
            });
        });
        $('#btnResetStyle').click(function () {
            grdMain.loadStyles({
                body: {
                    cell: {
                        selectedBackground: undefined,
                        seleectedColor: undefined
                    }
                }
            });
        });
        $('#chkMergedSelection').click(function () {
        	var checked = document.getElementById('chkMergedSelection').checked;
            grdMain2.displayOptions().setMergedSelection(checked);
        });
    });
</script>
</head>
<body>
    <h3>Selection Display</h3>
    <div>
        <input type="radio" name="rgpSelectDisplay" value="mask" checked="checked">SelectionDisplay.MASK
        <input type="radio" name="rgpSelectDisplay" value="cell">CELL
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkShowSingle">Show Single Selection 단일 셀 선택일 때 스타일대로 표시한다.
    </div>
    <div>
        <button id="btnStyle1">Selection Style 1</button>
        <button id="btnStyle2">Style 2</button>
        <button id="btnResetStyle">Reset Style</button>
    </div>
    <p>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkMergedSelection">Merged Selection 병합 셀 기준으로 선택 영역이 설정된다.
    </div>
</body>
</html>