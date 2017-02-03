<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Tree Data Tag</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var treeMain;
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
        dsMain.setProperties({
            datetimeFormat : "MM/dd/yyyy"
        });

        // grid
        var columns = [ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "160",
            "styles" : {
                textAlignment : "near"
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
        } ];
        treeMain = DataLudi.createTreeView("treeMain");
        treeMain.setColumns(columns);
        treeMain.header().head().setPopupMenu([ {
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        }, {
            label : '-'
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
            body : {},
            display : {
                selectStyle : DataLudi.SelectionStyle.ROWS,
            },
            edit : {
                insertable : true,
                appendable : true,
                deletable : true
            }
        });
        treeMain.loadStyles({
            body : {
                rowDynamic : [ {
                    expression : "tag == '#ludi'",
                    styles : {
                        background : '#200000ff'
                    }
                }, {
                    expression : "tag == '#data'",
                    styles : {
                        background : '#20ff0000'
                    }
                } ]
            }
        });

        treeMain.registerImageList({
            name : "images01",
            rootUrl : "assets/flags_iso/",
            items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
        });

        // connect dataset
        treeMain.setDataSource(dsMain);
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

        // dataset events
        dsMain.onRowAdded = function(ds, index, dataRow) {
            var row = treeMain.getRowOfDataRow(dataRow);
            row.setIconIndex(2);
        };
        dsMain.onRowCountChanged = function(ds) {
            $("#rowCount").css("color", "blue").text(ds.rowCount().toLocaleString())
        };

        // tree events
        treeMain.onRowCountChanged = function(tree, newCount, oldCount) {
            $("#rowCount").css("color", "blue").text(newCount.toLocaleString());
        };

        // buttons
        $('#btnSetLudiTag').click(function() {
            var row = treeMain.focusedRow();
            if (row) {
                dsMain.setRowTag(row.dataRow(), '#ludi');
            }
        });
        $('#btnSetDataTag').click(function() {
            var row = treeMain.focusedRow();
            if (row) {
                dsMain.setRowTag(row.dataRow(), '#data');
            }
        });
        $('#btnSetLudiTags').click(function() {
            var rows = treeMain.getSelectedRows();
            if (rows && rows.length > 0) {
                rows = treeMain.getDataRowsOfRows(rows);
                dsMain.setRowTags(rows, '#ludi');
            }
        });
        $('#btnSetDataTags').click(function() {
            var rows = treeMain.getSelectedRows();
            if (rows && rows.length > 0) {
                rows = treeMain.getDataRowsOfRows(rows);
                dsMain.setRowTags(rows, '#data');
            }
        });
        $('#btnClearTags').click(function() {
            dsMain.clearRowTags();
        });
        $('#btnSetRowFilter').click(function() {
            treeMain.setRowFilter({
                expression : "tag is not empty"
            });
        });
        $('#btnClearRowFilter').click(function() {
            treeMain.setRowFilter({
                expression : null,
                callback : null
            });
        });
        $('#chkPassiveFiltering').click(function() {
            var checked = document.getElementById('chkPassiveFiltering').checked;
            treeMain.setOperateOptions({
                passiveFiltering : checked
            });
        });
    });
</script>
</head>
<body>
    <h3>Tree Data Tag</h3>
    <button id="btnSetLudiTag">Set '#ludi' Tag</button>선택행의 tag를 '#ludi'로 지정한다.
    <button id="btnSetDataTag">Set '#data' Tag</button>선택행의 tag를 '#tag'로 지정한다.
    <br>
    <button id="btnSetLudiTags">Set '#ludi' Tags</button>선택행들의 tag를 '#ludi'로 지정한다.
    <button id="btnSetDataTags">Set '#data' Tags</button>선택행들의 tag를 '#tag'로 지정한다.
    <br>
    <button id="btnClearTags">Clear Tags</button>clearRowTags를 호출해서 설정된 tag들을 모두 제거한다.
    <div id="treeMain" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <button id="btnSetRowFilter">Get Row Counts</button> Data tag가 설정된 행들만 표시한다.
    <button id="btnClearRowFilter">Get Row Counts</button> Row Filter를 제거한다.
    <input type="checkbox" id="chkPassiveFiltering">Passive Filtering
</body>
</html>