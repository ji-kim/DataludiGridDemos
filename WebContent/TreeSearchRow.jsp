<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Search Tree Row</title>
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

        var treeMain, treeMain;
        var dsMain;
        var prevField = -1;

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

        //tree 
        treeMain = DataLudi.createTreeView('container');
        treeMain.setColumns([ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "160",
            "styles" : {
                textAlignment : "left"
            },
            "header" : {
                "text" : "LoanNumber"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "120",
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
            },
            "footer" : {
                "expression" : "avg",
                "styles" : {
                    "prefix" : "Average" + ": ",
                    "numberFormat" : "#,##0.00"
                }
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
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "OriginalAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0",
                    "background" : "#777",
                    "color" : "#fff",
                    "borderTop" : "#ddd"
                }
            }
        }, {
            "name" : "CancelledAmount",
            "fieldName" : "cancelled_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "CancelledAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0"
                }
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
            },
            "footer" : {
                "expression" : "varp",
                "text" : "분산",
                "styles" : {
                    "prefix" : "분산=>$",
                    "numberFormat" : "#,##0"
                }
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

        // treeMain2
        treeMain2 = DataLudi.createTreeView('container2');
        treeMain2.setColumns([ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "160",
            "styles" : {
                textAlignment : "left"
            },
            "header" : {
                "text" : "LoanNumber"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "120",
            "styles" : {},
            "dynamicStyles" : [ {
                "expression" : "rowtag == '#found_0'",
                "styles" : {
                    "background" : "#333",
                    "color" : "#fff"
                }
            } ],
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
            },
            "footer" : {
                "expression" : "avg",
                "styles" : {
                    "prefix" : "Average" + ": ",
                    "numberFormat" : "#,##0.00"
                }
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
            "dynamicStyles" : [ {
                "expression" : "rowtag == '#found_1'",
                "styles" : {
                    "background" : "#333",
                    "color" : "#fff"
                }
            } ],
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
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "OriginalAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0",
                    "background" : "#777",
                    "color" : "#fff",
                    "borderTop" : "#ddd"
                }
            }
        }, {
            "name" : "CancelledAmount",
            "fieldName" : "cancelled_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "CancelledAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0"
                }
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
            },
            "footer" : {
                "expression" : "varp",
                "text" : "분산",
                "styles" : {
                    "prefix" : "분산=>$",
                    "numberFormat" : "#,##0"
                }
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

        // tree options
        treeMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

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

        // treeMain2 options
        treeMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        treeMain2.setOptions({
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

        // connet Dataset
        var rows = [
            [ "fr.png", "1", "IBRD00010", "France", "4.25", "USD", "P037383", "250", "000", "001.00", "11/01/1952", "05/01/1977" ],
            [ "fr.png", "1.1", "IBRD00020", "Netherlands", "4.25", "EUR", "P037452", "191", "044", "211.75", "04/01/1952", "10/01/1972" ],
            [ "fr.png", "1.2", "IBRD00021", "Netherlands", "4.25", "USD", "P037452", "3", "955", "788.25", "04/01/1953", "04/01/1954" ],
            [ "fr.png", "1.2.1", "IBRD00030", "Denmark", "4.25", "JPY", "P037362", "40", "000", "000.00", "02/01/1953", "08/01/1972" ],
            [ "fr.png", "1.2.2", "IBRD00040", "Luxembourg", "4.25", "USD", "P037451", "12", "000", "000.00", "07/15/1949", "07/15/1972" ],
            [ "fr.png", "1.3", "IBRD00050", "Chile", "4.5", "USD", "P006578", "13", "500", "000.00", "07/01/1953", "07/01/1968" ],
            [ 1, "2", "IBRD00060", "Chile", "3.75", "USD", "P006577", "2", "500", "000.00", "07/01/1950", "01/01/1955" ],
            [ 1, "2.1", "IBRD00070", "Netherlands", "3.56", "USD", "P037453", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
            [ 1, "2.1.1", "IBRD00071", "Netherlands", "3.56", "HKD", "P037453", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
            [ 1, "2.2", "IBRD00080", "France", "3.56", "EUR", "P037454", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
            [ 1, "2.3", "IBRD00090", "Netherlands", "3.56", "USD", "P037455", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
            [ 2, "3", "IBRD00100", "Netherlands", "3.56", "SGD", "P037456", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
            [ 2, "3.1", "IBRD00101", "Netherlands", "3.56", "USD", "P037456", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
            [ 2, "3.1.1", "IBRD00111", "Brazil", "4.5", "USD", "P006214", "75", "000", "000.00", "07/01/1953", "01/01/1974" ],
            [ 2, "3.1.2", "IBRD00112", "Brazil", "4.25", "CAD", "P006214", "15", "000", "000.00", "07/01/1955", "01/01/1976" ],
            [ 2, "3.2", "IBRD00120", "Mexico", "4.5", "USD", "P007497", "24", "100", "000.00", "02/01/1953", "08/01/1973" ],
            [ 2, "3.3", "IBRD00130", "Mexico", "4.5", "EUR", "P007498", "10", "000", "000.00", "01/01/1951", "01/01/1951" ],
            [ 2, "3.3.1", "IBRD00140", "Belgium", "4.25", "USD", "P037358", "16", "000", "000.00", "09/01/1953", "03/01/1969" ],
            [ 3, "4", "IBRD00150", "Netherlands", "4", "EUR", "P037457", "15", "000", "000.00", "12/01/1952", "06/01/1964" ],
            [ 3, "4.1", "IBRD00160", "Finland", "4", "USD", "P037366", "12", "500", "000.00", "02/01/1953", "08/01/1964" ],
            [ 3, "4.2", "IBRD00170", "India", "4", "USD", "P009588", "34", "000", "000.00", "08/15/1950", "08/15/1964" ],
            [ 3, "4.3", "IBRD00171", "France", "4", "USD", "P009588", "34", "000", "000.00", "08/15/1950", "08/15/1964" ],
            [ 3, "5", "IBRD00180", "Colombia", "3.5", "EUR", "P006682", "5", "000", "000.00", "05/15/1952", "11/15/1956" ],
            [ 4, "5.1", "IBRD00190", "India", "3.5", "USD", "P009586", "10", "000", "000.00", "06/01/1952", "12/01/1956" ],
            [ 4, "5.1.1", "IBRD00200", "Yugoslavia", "3", "USD", "P009133", "2", "700", "000.00", "06/15/1950", "09/15/1951" ],
            [ 4, "5.2", "IBRD00210", "Finland", "3", "USD", "P037365", "2", "300", "000.00", "06/15/1950", "09/15/1951" ],
            [ 4, "5.3", "IBRD00220", "El Salvador", "4.25", "USD", "P007137", "12", "545", "000.00", "07/15/1954", "01/15/1975" ],
            [ 5, "6", "IBRD00230", "India", "4", "EUR", "P009587", "18", "500", "000.00", "04/15/1955", "04/15/1970" ],
            [ 6, "7", "IBRD00240", "Mexico", "4.5", "USD", "P007499", "26", "000", "000.00", "08/01/1953", "02/01/1975" ],
            [ 6, "7.1", "IBRD00241", "France", "4.5", "EUR", "P007499", "26", "000", "000.00", "08/01/1953", "02/01/1975" ],
            [ 7, "8", "IBRD00250", "Brazil", "4.25", "EUR", "P006215", "15", "000", "000.00", "09/15/1954", "03/15/1975" ],
            [ 7, "8.1", "IBRD00260", "Iraq", "3.75", "JPY", "P005231", "12", "800", "000.00", "04/01/1956", "10/01/1965" ],
            [ 7, "8.2", "IBRD00270", "Turkey", "3.88", "USD", "P008872", "3", "900", "000.00", "04/01/1954", "10/01/1968" ],
            [ 8, "9", "IBRD00281", "Turkey", "4.25", "USD", "P008874", "12", "500", "000.00", "04/01/1956", "10/01/1975" ],
            [ 8, "9.1", "IBRD00282", "Turkey", "4.88", "JPY", "P008874", "3", "800", "000.00", "04/01/1956", "10/01/1975" ],
            [ 8, "9.2", "IBRD00290", "Australia", "4.25", "USD", "P037342", "100", "000", "000.00", "09/01/1955", "09/01/1975" ],
            [ 8, "9.3", "IBRD00300", "Uruguay", "4.25", "EUR", "P008109", "33", "000", "000.00", "02/15/1955", "08/15/1974" ],
            [ 9, "a0", "IBRD00310", "Ethiopia", "4", "USD", "P000659", "5", "000", "000.00", "03/01/1956", "03/01/1971" ],
            [ 9, "a0.1", "IBRD00320", "Ethiopia", "4", "EUR", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
            [ 9, "a0.2", "IBRD00330", "Mexico", "3.5", "USD", "P007500", "10", "000", "000.00", "03/15/1952", "09/15/1957" ],
            [ 10, "a1", "IBRD00340", "Turkey", "3.75", "GBP", "P008873", "9", "000", "000.00", "03/15/1957", "09/15/1965" ],
            [ 10, "a1.1", "IBRD00320", "Ethiopia", "4", "EUR", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
            [ 10, "a1.1.1.", "IBRD00330", "Mexico", "3.5", "USD", "P007500", "10", "000", "000.00", "03/15/1952", "09/15/1957" ],
            [ 10, "a1.1.2.", "IBRD00330", "France", "3.5", "USD", "P007500", "10", "000", "000.00", "03/15/1952", "09/15/1957" ],
            [ 10, "a1.2", "IBRD00320", "Ethiopia", "4", "EUR", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
            [ 10, "a1.3", "IBRD00320", "Ethiopia", "4", "USD", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
            [ 11, "a2", "IBRD00310", "Ethiopia", "4", "EUR", "P000659", "5", "000", "000.00", "03/01/1956", "03/01/1971" ],
            [ 11, "a2.1", "IBRD00320", "Ethiopia", "4", "EUR", "P000658", "2", "000", "000.00", "03/01/1956", "03/01/1971" ],
            [ 11, "a2.2", "IBRD00330", "Mexico", "3.5", "USD", "P007500", "10", "000", "000.00", "03/15/1952", "09/15/1957" ]
        ];
        dsMain.setRows(rows, 1);
        treeMain.setDataSource(dsMain);
        treeMain2.setDataSource(dsMain);

        // tree imageRegister
        treeMain.registerImageList({
            name : "images01",
            rootUrl : "assets/flags_iso/",
            items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
        });
        treeMain2.registerImageList({
            name : "images01",
            rootUrl : "assets/flags_iso/",
            items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
        });

        // treeMain style
        treeMain.loadStyles({
            grid : {
                border : "#008"
            },
            body : {
                rowDynamic : [ {
                    expression : "tag == '#found'",
                    styles : {
                        background : '#10ff00ff',
                        fontBold : true
                    }
                } ]
            }
        });

        var countries = [ 'France', 'Turkey', 'Mexico', 'India', 'Brazil' ];
        dsMain.visitAll(function(row) {
            var i = Math.floor(Math.random() * countries.length);
            dsMain.setValue(row, 'project_id', countries[i]);
        });

        treeMain.expandAll();
        treeMain2.expandAll();

        // dsMain events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnSearchRow').click(function() {
            var options = {
                caseSensitive : document.getElementById('chkSensitive_1').checked,
                partialMatch : document.getElementById('chkParital_1').checked
            };
            var wrap = document.getElementById('chkWrap_1').checked;
            var r = treeMain.focusedRowIndex() + 1;
            var v = $('#edtValue_1').val();
            r = treeMain.searchRow([ 'country' ], [ v ], options, r, wrap, true);
            if (r >= 0) {
                dsMain.clearRowTags();
                dsMain.setRowTag(treeMain.getRow(r).dataIndex(), '#found');
            }
        });
        $('#btnSearchRow2').click(function() {
            var options = {
                allFields : document.getElementById('chkAllFields').checked,
                caseSensitive : document.getElementById('chkSensitive_2').checked,
                partialMatch : document.getElementById('chkParital_2').checked
            };
            var wrap = document.getElementById('chkWrap_2').checked;
            var r = treeMain.focusedRowIndex() + 1;
            var country = $('#edtValue_2').val();
            var currency = $('#edtCurrency').val();
            r = treeMain.searchRow([ 'country', 'currency' ], [ country, currency ], options, r, wrap, true);
            if (r >= 0) {
                dsMain.clearRowTags();
                dsMain.setRowTag(r, '#found');
            }
        });
        $('#btnSearchCell').click(function() {
            var options = {
                caseSensitive : document.getElementById('chkSensitive_3').checked,
                partialMatch : document.getElementById('chkParital_3').checked
            };
            var wrap = document.getElementById('chkWrap_3').checked;
            var r = treeMain2.focusedRowIndex() + 1;
            var v = $('#edtValue_3').val();
            var result = treeMain2.searchCell([ 'country' ], v, options, r, 0, wrap, true);
            if (result) {
                dsMain.clearRowTags();
                dsMain.setRowTag(treeMain.getRow(result.rowIndex).dataIndex(), '#found_0');
            }
        });
        $('#btnSearchCell2').click(function() {
            var options = {
                caseSensitive : document.getElementById('chkSensitive_4').checked,
                partialMatch : document.getElementById('chkParital_4').checked
            };
            var wrap = document.getElementById('chkWrap_4').checked;
            var r = treeMain2.focusedRowIndex() + (prevField > 0 ? 1 : 0);
            var c = treeMain2.focusedColumn();
            var v = $('#edtValue_4').val()
            var result = treeMain2.searchCell([ 'country', 'project_id' ], v, options, r, prevField + 1, wrap, true);
            if (result) {
                dsMain.clearRowTags();
                dsMain.setRowTag(treeMain.getRow(result.rowIndex).dataIndex(), result.searchFieldIndex == 1 ? '#found_1' : '#found_0');
                prevField = result.searchFieldIndex;
            }
        });
    });
</script>
</head>
<body>
    <h3>Search Tree Row</h3>
    <div>
        <button id="btnSearchRow">Search Row</button>
        <span>국가 : </span>
        <input type="text" id="edtValue_1" value="France">
        <input type="checkbox" id="chkSensitive_1">Case Sensitive
        <input type="checkbox" id="chkParital_1">Partial Match
        <input type="checkbox" id="chkWrap_1" checked="checked">Wrap
    </div>
    <div>
        <button id="btnSearchRow2">Search Row</button>
        <span>국가 : </span>
        <input type="text" id="edtValue_2" value="France">
        <span>통화 : </span>
        <input type="text" id="edtCurrency" value="USD">
        <input type="checkbox" id="chkAllFields" checked="checked">All Fields
        <input type="checkbox" id="chkSensitive_2">Sensitive
        <input type="checkbox" id="chkParital_2">Partial
        <input type="checkbox" id="chkWrap_2" checked="checked">Wrap
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <span>'국가'필드의 값을 검색한다.</span>
        <br>
        <button id="btnSearchCell">Search Cell</button>
        <span>국가 : </span>
        <input type="text" id="edtValue_3" value="France">
        <input type="checkbox" id="chkSensitive_3">Case Sensitive
        <input type="checkbox" id="chkParital_3">Partial Match
        <input type="checkbox" id="chkWrap_3" checked="checked">Wrap
    </div>
    <div>
        <span>'국가', '프로젝트 아이디' 필드들의 값을 검색한다.</span>
        <br>
        <button id="btnSearchCell2">Search Cell</button>
        <span>국가 : </span>
        <input type="text" id="edtValue_4" value="France">
        <input type="checkbox" id="chkSensitive_4">Sensitive
        <input type="checkbox" id="chkParital_4" checked="checked">Partial
        <input type="checkbox" id="chkWrap_4" checked="checked">Wrap
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>