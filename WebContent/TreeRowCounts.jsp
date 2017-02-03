<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Tree Row Counts</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var treeMain, treeMain2;
        var dsMain;

        // dataset
        dsMain = DataLudi.createTreeDataSet();
        dsMain.setFields([ {
            fieldName : "icon"
        }, {
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
            fieldName : "first_date",
            dataType : "datetime",
            datetimeFormat : "MM/dd/yyyy"
        }, {
            fieldName : "last_date",
            dataType : "datetime",
            datetimeFormat : "MM/dd/yyyy"
        } ]);
        dsMain.setProperties({
            datetimeFormat : "MM/dd/yyyy"
        });

        // grid
        var columns = [ {
            "name": "LoanNumber",
            "fieldName": "loan_number",
            "width": "160",
            "styles": {
                textAlignment: "left"
            },
            "header": {
                "text": "LoanNumber"
            }
        }, {
            "name": "Country",
            "fieldName": "country",
            "width": "120",
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
            "width": 110,
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
            },
            "filters": [{
                "name": "filter01",
                "text": "Less than 10",
                "expression": "value < 10"
            }, {
                "name": "filter02",
                "text": "Greater than 100",
                "expression": "value > 100"
            }]
        }, {
            "name": "CancelledAmount",
            "fieldName": "cancelled_amount",
            "width": 110,
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
        treeMain = DataLudi.createTreeView("treeMain");
        treeMain.setColumns(columns);
        treeMain.header().head().setPopupMenu([ {
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        }, {
            label : 'Expand All',
            callback : function() {
                treeMain.expandAll();
            }
        }, {
            label : 'Collapse All',
            callback : function() {
                treeMain.collapseAll();
            }
        } ]);

        treeMain.setOptions({
            "header.height" : 30,
            "checkBar.visible" : false,
            "rowIndicator.stateVisible" : true,
            tree : {
                expanderWithCellStyles : true,
                iconField : 'icon',
                iconList : "images01",
                checkBoxVisible : true
            },
            body : {
                rowDynamicStyles : [ {
                    expression : 'checked',
                    styles : {
                        background : '#100000ff'
                    }
                } ]
            },
            edit : {
                deletable : true
            }
        });
        treeMain.setEditOptions({
            insertable : true,
            appendable : true,
            deletable : true
        });

        treeMain.registerImageList({
            name : "images01",
            rootUrl : "assets/flags_iso/",
            items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
        });

        // connect dataset
        treeMain.setDataSource(dsMain);
        var rows = [ [ "fr.png", "1", "IBRD00010", "France", "4.25", "USD", "P037383", "250", "000", "001.00", "11/01/1952", "05/01/1977" ],
                [ "fr.png", "1.1", "IBRD00020", "Netherlands", "4.25", "USD", "P037452", "191", "044", "211.75", "04/01/1952", "10/01/1972" ],
                [ "fr.png", "1.2", "IBRD00021", "Netherlands", "4.25", "USD", "P037452", "3", "955", "788.25", "04/01/1953", "04/01/1954" ],
                [ "fr.png", "1.2.1", "IBRD00030", "Denmark", "4.25", "USD", "P037362", "40", "000", "000.00", "02/01/1953", "08/01/1972" ],
                [ "fr.png", "1.2.2", "IBRD00040", "Luxembourg", "4.25", "USD", "P037451", "12", "000", "000.00", "07/15/1949", "07/15/1972" ],
                [ "fr.png", "1.3", "IBRD00050", "Chile", "4.5", "USD", "P006578", "13", "500", "000.00", "07/01/1953", "07/01/1968" ],
                [ 1, "2", "IBRD00060", "Chile", "3.75", "USD", "P006577", "2", "500", "000.00", "07/01/1950", "01/01/1955" ],
                [ 1, "2.1", "IBRD00070", "Netherlands", "3.56", "USD", "P037453", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
                [ 1, "2.1.1", "IBRD00071", "Netherlands", "3.56", "USD", "P037453", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
                [ 1, "2.2", "IBRD00080", "Netherlands", "3.56", "USD", "P037454", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
                [ 1, "2.3", "IBRD00090", "Netherlands", "3.56", "USD", "P037455", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
                [ 2, "3", "IBRD00100", "Netherlands", "3.56", "USD", "P037456", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
                [ 2, "3.1", "IBRD00101", "Netherlands", "3.56", "USD", "P037456", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
                [ 2, "3.1.1", "IBRD00111", "Brazil", "4.5", "USD", "P006214", "75", "000", "000.00", "07/01/1953", "01/01/1974" ],
                [ 2, "3.1.2", "IBRD00112", "Brazil", "4.25", "USD", "P006214", "15", "000", "000.00", "07/01/1955", "01/01/1976" ],
                [ 2, "3.2", "IBRD00120", "Mexico", "4.5", "USD", "P007497", "24", "100", "000.00", "02/01/1953", "08/01/1973" ],
                [ 2, "3.3", "IBRD00130", "Mexico", "4.5", "USD", "P007498", "10", "000", "000.00", "01/01/1951", "01/01/1951" ],
                [ 2, "3.3.1", "IBRD00140", "Belgium", "4.25", "USD", "P037358", "16", "000", "000.00", "09/01/1953", "03/01/1969" ],
                [ 3, "4", "IBRD00150", "Netherlands", "4", "USD", "P037457", "15", "000", "000.00", "12/01/1952", "06/01/1964" ],
                [ 3, "4.1", "IBRD00160", "Finland", "4", "USD", "P037366", "12", "500", "000.00", "02/01/1953", "08/01/1964" ],
                [ 3, "4.2", "IBRD00170", "India", "4", "USD", "P009588", "34", "000", "000.00", "08/15/1950", "08/15/1964" ],
                [ 3, "5", "IBRD00180", "Colombia", "3.5", "USD", "P006682", "5", "000", "000.00", "05/15/1952", "11/15/1956" ],
                [ 4, "5.1", "IBRD00190", "India", "3.5", "USD", "P009586", "10", "000", "000.00", "06/01/1952", "12/01/1956" ],
                [ 4, "5.1.1", "IBRD00200", "Yugoslavia", "3", "USD", "P009133", "2", "700", "000.00", "06/15/1950", "09/15/1951" ],
                [ 4, "5.2", "IBRD00210", "Finland", "3", "USD", "P037365", "2", "300", "000.00", "06/15/1950", "09/15/1951" ],
                [ 4, "5.3", "IBRD00220", "El Salvador", "4.25", "USD", "P007137", "12", "545", "000.00", "07/15/1954", "01/15/1975" ],
                [ 5, "6", "IBRD00230", "India", "4", "USD", "P009587", "18", "500", "000.00", "04/15/1955", "04/15/1970" ],
                [ 6, "7", "IBRD00240", "Mexico", "4.5", "USD", "P007499", "26", "000", "000.00", "08/01/1953", "02/01/1975" ],
                [ 7, "8", "IBRD00250", "Brazil", "4.25", "USD", "P006215", "15", "000", "000.00", "09/15/1954", "03/15/1975" ],
                [ 7, "8.1", "IBRD00260", "Iraq", "3.75", "USD", "P005231", "12", "800", "000.00", "04/01/1956", "10/01/1965" ],
                [ 7, "8.2", "IBRD00270", "Turkey", "3.88", "USD", "P008872", "3", "900", "000.00", "04/01/1954", "10/01/1968" ],
                [ 8, "9", "IBRD00281", "Turkey", "4.25", "USD", "P008874", "12", "500", "000.00", "04/01/1956", "10/01/1975" ],
                [ 8, "9.1", "IBRD00282", "Turkey", "4.88", "USD", "P008874", "3", "800", "000.00", "04/01/1956", "10/01/1975" ],
                [ 8, "9.2", "IBRD00290", "Australia", "4.25", "USD", "P037342", "100", "000", "000.00", "09/01/1955", "09/01/1975" ],
                [ 8, "9.3", "IBRD00300", "Uruguay", "4.25", "USD", "P008109", "33", "000", "000.00", "02/15/1955", "08/15/1974" ],
                [ 9, "a0", "IBRD00310", "Ethiopia", "4", "USD", "P000659", "5", "000", "000.00", "03/01/1956", "03/01/1971" ],
                [ 9, "a0.1", "IBRD00320", "Ethiopia", "4", "USD", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
                [ 9, "a0.2", "IBRD00330", "Mexico", "3.5", "USD", "P007500", "10", "000", "000.00", "03/15/1952", "09/15/1957" ],
                [ 10, "a1", "IBRD00340", "Turkey", "3.75", "USD", "P008873", "9", "000", "000.00", "03/15/1957", "09/15/1965" ],
                [ 10, "a1.1", "IBRD00320", "Ethiopia", "4", "USD", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
                [ 10, "a1.1.1.", "IBRD00330", "Mexico", "3.5", "USD", "P007500", "10", "000", "000.00", "03/15/1952", "09/15/1957" ],
                [ 10, "a1.1.2.", "IBRD00330", "Mexico", "3.5", "USD", "P007500", "10", "000", "000.00", "03/15/1952", "09/15/1957" ],
                [ 10, "a1.2", "IBRD00320", "Ethiopia", "4", "USD", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
                [ 10, "a1.3", "IBRD00320", "Ethiopia", "4", "USD", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
                [ 11, "a2", "IBRD00310", "Ethiopia", "4", "USD", "P000659", "5", "000", "000.00", "03/01/1956", "03/01/1971" ],
                [ 11, "a2.1", "IBRD00320", "Ethiopia", "4", "USD", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
                [ 11, "a2.2", "IBRD00330", "Mexico", "3.5", "USD", "P007500", "10", "000", "000.00", "03/15/1952", "09/15/1957" ] ];
        dsMain.setRows(rows, 1);

        // dataset events
        dsMain.onRowCountChanged = function(ds) {
            $("#rowCount").css("color", "blue").text(ds.rowCount().toLocaleString())
        };
        dsMain.onRowDeleting = function (ds, row) {
            if (treeMain.rowCount() <= 1) {
                setTimeout(function () {
                    alert('I need at least one row!');
                }, 0);
                return false;
            }  
        };
        
        // tree events
        treeMain.onRowCountChanged = function(grid, newCount, oldCount) {
            $('#txtRowCount').text(newCount);
        };
        treeMain.onDisplayRowCountChanged = function(grid, newCount, oldCount) {
            $('#txtDisplayCount').text(newCount);
        };
        treeMain.onDescendantRowCountChanged = function(grid, newCount, oldCount) {
        	$('#txtDescendantRowCount').text(newCount);
        };
        treeMain.onDescendantDataCountChanged = function(grid, newCount, oldCount) {
        	$('#txtDescendantDataCount').text(newCount);
        };

        // buttons
        $('#btnRowCounts').click(function() {
            $('#txtRowCount2').text(treeMain.rowCount().toLocaleString());
            $('#txtDisplayCount2').text(treeMain.displayRowCount().toLocaleString());
            $('#txtDescendantRowCount2').text(treeMain.descendantRowCount().toLocaleString());
            $('#txtDescendantDataCount2').text(treeMain.descendantDataCount().toLocaleString());
        });
    });
</script>
</head>
<body>
    <h3>Tree Row Counts</h3>
    <div id="treeMain" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <span>rowCount</span>
    <span id="txtRowCount"></span>
    <span id="txtRowCount2" style="color: red"></span>
    <br>
    <span>displayRowCount</span>
    <span id="txtDisplayCount"></span>
    <span id="txtDisplayCount2" style="color: red"></span>
    <br>
    <span>descendantRowCount</span>
    <span id="txtDescendantRowCount"></span>
    <span id="txtDescendantRowCount2" style="color: red"></span>
    <br>
    <span>descendantDataCount</span>
    <span id="txtDescendantDataCount"></span>
    <span id="txtDescendantDataCount2" style="color: red"></span>
    <br>
    <button id="btnRowCounts">Get Row Counts</button>각 개수 속성값을 가져와서 해당하는 위치의 우측에 붉은색으로 표시한다.
</body>
</html>