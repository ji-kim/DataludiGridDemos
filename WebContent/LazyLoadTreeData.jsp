<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Lazy Load Tree Data</title>
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

        var treeMain;
        var dsMain;

        function checkButtons() {
            var row = treeMain.focusedRow();
            $('#btnAddRow').prop('disabled', !row);
            $('#btnInsertRow').prop('disabled', !row);
            $('#btnDeleteRow').prop('disabled', !row);
            $('#btnUpdateRow').prop('disabled', !row);

            $('#edtCountry').val(row ? row.getValue('country') + '_' : '');
        }
        ;

        // dataset
        var fields = [ {
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
        } ];

        dsMain = DataLudi.createTreeDataSet();
        dsMain.setFields(fields);
        dsMain.setProperties({
            datetimeFormat : "MM/dd/yyyy"
        });

        // tree
        var columns = [ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "200",
            "styles" : {
                "textAlignment" : "near"
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
        } ];

        //tree 
        treeMain = DataLudi.createTreeView('container');
        treeMain.setColumns(columns);

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

        // connet Dataset
        treeMain.setDataSource(dsMain);
        var rows = [
            [ "fr.png", "1", "IBRD00010", "France", "4.25", "USD", "P037383", "250", "000", "001.00", "11/01/1952", "05/01/1977" ],
            [ 1, "2", "IBRD00060", "Chile", "3.75", "USD", "P006577", "2", "500", "000.00", "07/01/1950", "01/01/1955" ],
            [ 2, "3", "IBRD00100", "Netherlands", "3.56", "USD", "P037456", "2", "000", "000.00", "01/15/1949", "07/15/1958" ],
            [ 3, "4", "IBRD00150", "Netherlands", "4", "USD", "P037457", "15", "000", "000.00", "12/01/1952", "06/01/1964" ],
            [ 3, "5", "IBRD00180", "Colombia", "3.5", "USD", "P006682", "5", "000", "000.00", "05/15/1952", "11/15/1956" ],
            [ 5, "6", "IBRD00230", "India", "4", "USD", "P009587", "18", "500", "000.00", "04/15/1955", "04/15/1970" ],
            [ 6, "7", "IBRD00240", "Mexico", "4.5", "USD", "P007499", "26", "000", "000.00", "08/01/1953", "02/01/1975" ],
            [ 7, "8", "IBRD00250", "Brazil", "4.25", "USD", "P006215", "15", "000", "000.00", "09/15/1954", "03/15/1975" ],
            [ 8, "9", "IBRD00281", "Turkey", "4.25", "USD", "P008874", "12", "500", "000.00", "04/01/1956", "10/01/1975" ],
            [ 9, "a0", "IBRD00310", "Ethiopia", "4", "USD", "P000659", "5", "000", "000.00", "03/01/1956", "03/01/1971" ],
            [ 10, "a1", "IBRD00340", "Turkey", "3.75", "USD", "P008873", "9", "000", "000.00", "03/15/1957", "09/15/1965" ],
            [ 11, "a2", "IBRD00310", "Ethiopia", "4", "USD", "P000659", "5", "000", "000.00", "03/01/1956", "03/01/1971" ]
        ];
        setTimeout(function() {
            dsMain.setRows(rows, 1);
            treeMain.visitAllRows(function(row) {
                row.setHasChildren(true);
            });
        });

        treeMain.registerImageList({
            name : "images01",
            rootUrl : "assets/flags_iso/",
            items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
        });

        // dsMain events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // treeMain events
        treeMain.onExpanding = function(tree, row) {
            if (row.hasChildren()) {
                for (var i = 1; i <= 3; i++) {
                    var dataRow = row.dataRow();
                    var vals = dataRow.getObject();
                    vals['loan_number'] += '_' + i;
                    vals['country'] += '_2';
                    dsMain.addRow(dataRow, vals);

                    if (row.level() == 1) {
                        row.getChild(i - 1).setHasChildren(true);
                    }
                }
            }
        };
    });
</script>
</head>
<body>
    <h3>Lazy Load Tree Data</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>