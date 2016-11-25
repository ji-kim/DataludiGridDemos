<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Load Tree Data</title>
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

        var treeMain, treeMain2, treeMain3;
        var dsMain, dsMain2, dsMain3;

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
        dsMain2 = DataLudi.createTreeDataSet();
        dsMain3 = DataLudi.createTreeDataSet();
        dsMain.setFields(fields);
        dsMain2.setFields(fields);
        dsMain3.setFields(fields);

        // tree
        var columns = [ {
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
                "textAlignment" : "far",
                "numberFormat" : "#,##0.00"
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
                "textAlignment" : "far",
                "numberFormat" : "#,##0.00"
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
                "textAlignment" : "far",
                "numberFormat" : "#,##0.00"
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
            "name" : "RepaidAmount",
            "fieldName" : "repaid_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0.00"
            },
            "header" : {
                "text" : "RepaidAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "SoldAmount",
            "fieldName" : "sold_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0.00"
            },
            "header" : {
                "text" : "SoldAmount"
            },
            "footer" : {
                "styles" : {
                    "prefix" : "$",
                    "textAlignment" : "far",
                    "numberFormat" : "0,000",
                    "postfix" : " $",
                    "font" : "Arial,12"
                },
                "text" : "SUM",
                "expression" : "sum",
                /*"expression": "sum[4]",*/
                "dynamicStyles" : [ {
                    "criteria" : "value > 10000",
                    "styles" : "color=#ff0000"
                } ]
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
        function createGrid(containerId) {
            tree = DataLudi.createTreeView(containerId);
            tree.setColumns(columns);
            tree.checkBar().setVisible(false);
            tree.header().setHeight(30);

            tree.registerImageList({
                name : "images01",
                rootUrl : "assets/flags_iso/",
                items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
            });
            tree.setOptions({
                display : {},
                header : {
                    height : 30
                },
                tree : {
                    expanderWithCellStyles : true,
                    iconField : 'icon',
                    iconList : "images01",
                    /*iconWidth: 20,*/
                    checkBoxVisible : true
                }
            });
            return tree;
        }

        treeMain = createGrid('container');
        treeMain.setDataSource(dsMain);
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

        treeMain2 = createGrid('container2');
        treeMain2.setDataSource(dsMain2);
        treeMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        treeMain3 = createGrid('container3');
        treeMain3.setDataSource(dsMain3);
        treeMain3.displayOptions().setEmptyDataMessage("조회된 데이터가 없습니다.\r\n\r\n");
        treeMain3.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // dsMain events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
        dsMain2.onRowCountChanged = function(ds, count) {
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };
        dsMain3.onRowCountChanged = function(ds, count) {
            $("#rowCount3").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnLoadCsv').click(function() {
            $.ajax({
                url : "data/loan_statement_tree.csv",
                dataType : 'text',
                success : function(data) {
                    DataLudi.loadCsvData(dsMain, data, {
                        start : 1,
                        quoted : true,
                        currency : true,
                        treeField : 1,
                        useTreeField : false
                    });
                },
                error : function(xhr, status, error) {
                    var err = status + ', ' + error;
                    alert("jQuery ajax() Failed: " + err);
                }
            });
        });
        $('#btnLoadJson').click(function() {
            $.ajax({
                url : "data/loan_statement_tree.json",
                dataType : 'text',
                success : function(data) {
                    DataLudi.loadJsonData(dsMain2, data, {
                        currency : true,
                        rows : "",
                        childRows : "rows"
                    });
                },
                error : function(xhr, status, error) {
                    var err = status + ', ' + error;
                    alert("jQuery ajax() Failed: " + err);
                }
            });
        });
        $('#btnLoadXml').click(function() {
            $.ajax({
                url : "data/loan_statement_tree.xml",
                dataType : 'text',
                success : function(data) {
                    DataLudi.loadXmlData(dsMain3, data, {
                        currency : true,
                        rows : "row",
                        childRows : "rows"
                    });
                },
                error : function(xhr, status, error) {
                    var err = status + ', ' + error;
                    alert("jQuery ajax() Failed: " + err);
                }
            });
        })
    });
</script>
</head>
<body>
    <h3>Load Tree Data</h3>
    <div>
        <button id="btnLoadCsv">Load Csv Data</button>
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnLoadJson">Load Json Data</button>
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnLoadXml">Load Xml Data</button>
    </div>
    <div id="container3" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>