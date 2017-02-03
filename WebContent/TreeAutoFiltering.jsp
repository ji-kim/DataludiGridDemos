<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Tree Auto Filtering</title>
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
            "styles" : {
                "background" : "#1000ff88"
            },
            "header" : {
                "text" : "Country"
            },
            "autoFilter" : {
                "active" : true
            }
        }, {
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "65",
            "styles" : {
                "textAlignment" : "far",
                "background" : "#100088ff"
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
            },
            "filters" : [ {
                "name" : "Filter",
                "expression" : "value >= 4"
            } ],
            "autoFilter" : {
                "active" : true,
                "valueScale" : -1
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
            "hscrollBar.barWidth" : 12,
            "vscrollBar.barWidth" : 12,
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
                insertable : true,
                appendable : true,
                deletable : true
            },
            operate : {
                passiveFiltering : true
            }
        });
        treeMain.loadStyles(flatbluestyles, {
            grid : {
                border : "#800000ff"
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
                treeMain.expandAll();
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery ajax() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events

        // buttons
        $('#chkPassiveFiltering').click(function() {
            var checked = document.getElementById('chkPassiveFiltering').checked;
            treeMain.setOperateOptions({
                passiveFiltering : checked
            });
        });
        $('#chkActive').click(function() {
            var checked = document.getElementById('chkActive').checked;
            var col = treeMain.columnByName('InterestRate');
            if (col) {
                col.setAutoFilter(checked);
            }
        });
        $('#btnCheckValue').click(function() {
            var row = treeMain.focusedRow();
            if (row) {
                var col = treeMain.columnByName('Country');
                var v = row.getValue(col.dataIndex());
                col.autoFilter().checkValue(v, true);
            }
        });
        $('#btnCheckValues').click(function() {
            var rows = treeMain.getSelectedRows();
            if (rows && rows.length > 0) {
                var col = treeMain.columnByName('Country');
                var vals = treeMain.getFieldValues(col.dataIndex(), rows);
                col.autoFilter().checkValues(vals, true);
            }
        });
        $('#btnClearChecked').click(function() {
            var col = treeMain.columnByName('InterestRate');
            var col2 = treeMain.columnByName('Country');
            if (col && col2) {
                col.autoFilter().clearChecked();
                col2.autoFilter().clearChecked();
            }
        });
    });
</script>
</head>
<body>
    <h3>Tree Auto Filtering</h3>
    <input type="checkbox" id="chkExpandRecursive" checked="checked">OperateOptions.passiveFiltering true면 자손행이 해당되면 조상행들도 남긴다.
    <br>
    <input type="checkbox" id="chkExpandRecursive" checked="checked">ColumnAutoFilter.active "이율" 컬럼 Auto 필터 활성화.
    <div id="treeMain" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnCheckValue">Check Value</button> 선택 행의 "국가" 컬럼 Auto 필터 항목 선택.
        <br>
        <button id="btnCheckValues">Check Values</button> 선택 행들의 "국가" 컬럼 Auto 필터 항목 선택.
        <br>
        <button id="btnClearChecked">Clear Checked</button> "국가", "이율" 컬럼 Auto 필터 선택 모두 해제.
    </div>
</body>
</html>