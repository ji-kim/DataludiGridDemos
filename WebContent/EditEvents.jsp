<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Edit Events</title>
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

        var grdMain;
        var dsMain;
        var indexToStr = function(index) {
            return '(' + index.rowIndex + ', ' + index.column.header().displayText() + ')';
        };
        var $_isObject = function(obj) {
            return obj !== null && typeof obj === "object";
        };
        var $_objToStr = function(obj) {
            return JSON.stringify(obj, null, 2);
        };
        var $_showMemo = function(memo, title, text, appending) {
            var s = $('#' + memo)[0].value;
            text = $_isObject(text) ? $_objToStr(text) : text;
            appending && s && (text = s + '\r\n' + text);
            $('#' + memo + 'Title').text(title);
            //$('#' + memo).text(text);
            $('#' + memo)[0].value = text;
        };
        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "country"
        }, {
            fieldName : "year",
            dataType : "number"
        }, {
            fieldName : "comm_code"
        }, {
            fieldName : "commodity"
        }, {
            fieldName : "flow"
        }, {
            fieldName : "trade",
            dataType : "number"
        }, {
            fieldName : "weight",
            dataType : "number"
        }, {
            fieldName : "unit"
        } ]);

        // grid
        var columns = [ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            },
            "validations" : [ {
                "expression" : "value is not empty",
                "level" : DataLudi.ValidationLevel.WARNING,
                "message" : "CommCodeMsg"
            } ]
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            },
            "validations" : [ {
                "expression" : "value >= 2000",
                "level" : DataLudi.ValidationLevel.ERROR,
                "message" : "YearMsg"
            } ]
        }, {
            "name" : "Flow",
            "fieldName" : "flow",
            "width" : 60,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Flow"
            }
        }, {
            "name" : "Trade",
            "fieldName" : "trade",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Trade"
            },
            "groupFooter" : {
                "expression" : "sum",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            },
            "validations" : {
                "callback" : function(scope) {
                    if (scope.value < 1000) {
                        return false;
                    }
                },
                "level" : DataLudi.ValidationLevel.ERROR,
                "message" : "TradeMsg"
            }
        }, {
            "name" : "Weight",
            "fieldName" : "weight",
            "width" : 70,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Weight"
            },
            "groupFooter" : {
                "expression" : "sum",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : 120,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);

        //grid options
        grdMain.setOptions({
            edit : {
                insertable : true,
                appendable : true,
                deletable : true
            },
            display : {},
            rowIndicator : {
                stateVisible : true
            },
            header : {
                head : {
                    popupMenu : {
                        label : 'DataLudi Grid Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_ss.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 5,
                    quoted : true,
                    currency : true
                });
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

        grdMain.onShowEditor = function(grid, index) {
            var s = 'onShowEditor: ' + indexToStr(index);
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onEditChanged = function(grid, index, value) {
            if ($('#chkChanged')[0].checked) {
                var s = 'onEditChanged: ' + indexToStr(index) + ', ' + value;
                $_showMemo('conMain', 'Edit Events', s, true);
            }
        };
        grdMain.onEditCanceled = function(grid, index) {
            var s = 'onEditCanceled: ' + indexToStr(index);
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onEditCommitted = function(grid, index, newValue, oldValue) {
            var s = 'onEditCommitted: ' + indexToStr(index) + ', ' + oldValue + ' => ' + newValue;
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onEditCellUpdated = function(grid, row, fieldIndex, newValue, oldValue) {
            var s = 'onEditCellUpdated: ' + row.index() + ', ' + fieldIndex + ', ' + oldValue + ' => ' + newValue;
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onEditRowCanceled = function(grid, orgRow, editingState) {
            var s = 'onEditRowCanceled: ' + orgRow.index() + ', ' + editingState;
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onEditRowCommitted = function(grid, orgRow, editingState) {
            var s = 'onEditRowCommitted: ' + orgRow.index() + ', ' + editingState;
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onUpdating = function(grid, rowIndex, editor) {
            var s = 'onUpdating: ' + rowIndex + (editor ? ' in editor' : '');
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onUpdateStarted = function(grid, row) {
            var s = 'onUpdateStarted: ' + row.index();
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onInserting = function(grid, rowIndex) {
            var s = 'onInserting: ' + rowIndex;
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onInsertStarted = function(grid, row, appending) {
            var s = 'onInsertStarted: ' + row.index() + (appending ? ', appending' : '');
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onDeleting = function(grid, rows) {
            var s = 'onDeleting: [' + String(rows) + ']';
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onValidateCell = function(grid, index, inserting, value) {
            var s = 'onValidateCell: ' + indexToStr(index) + (inserting ? ', inserting' : '') + ', ' + value;
            $_showMemo('conMain', 'Edit Events', s, true);
        };
        grdMain.onValidateRow = function(grid, row, inserting, values) {
            var s = 'onValidateRows: ' + row.index() + (inserting ? ', inserting' : '') + ', ' + JSON.stringify(values);
            $_showMemo('conMain', 'Edit Events', s, true);
        };

        // buttons
    });
</script>
</head>
<body>
    <h3>Edit Events</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkChanged" checked="checked">onEditChanged events
    </div>
    <textarea id="conMain" class="helpMemo" style="width: 730px; min-height: 200px;"></textarea>
</body>
</html>