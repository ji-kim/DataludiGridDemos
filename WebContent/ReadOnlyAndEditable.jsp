<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ReadOnly & Editable</title>
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
        dsMain.setSoftDelete(true);
        dsMain.setRestoreMode(DataLudi.DataRestoreMode.EXPLICIT);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 60,
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : 80,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            }
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
            "width" : 100,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : 170,
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        } ]);
        grdMain2.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 60,
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : 80,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            }
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
            "width" : 100,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : 170,
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        } ]);

        //grid options
        grdMain.editOptions().setInsertable(true).setAppendable(true).setDeletable(true);
        grdMain.editOptions().setDeletedRowEditable(true);
        grdMain.displayOptions().setRowResizable(true);
        grdMain.rowIndicator().setStateVisible(true);
        grdMain.header().head().setPopupMenu([ {
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        } ]);

        grdMain2.editOptions().setInsertable(true).setAppendable(true).setDeletable(true);
        grdMain2.editOptions().setDeletedRowReadOnly(false);
        grdMain2.displayOptions().setRowResizable(true);
        grdMain2.rowIndicator().setStateVisible(true);
        grdMain2.header().head().setPopupMenu([ {
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        } ]);
        grdMain2.onShowEditor = function(grid, index) {
            return $('#chkShowEditor').is(':checked');
        };

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_ss.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 15,
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
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#chkReadMode').click(function() {
            var checked = document.getElementById('chkReadMode').checked;
            grdMain.setReadMode(checked);
        });

        $('#chkOptionsReadOnly').click(function() {
            var checked = document.getElementById('chkOptionsReadOnly').checked;
            grdMain.setEditOptions({
                readOnly : checked
            });
        });
        $('#chkFieldUpdatable').click(function() {
            var checked = document.getElementById('chkFieldUpdatable').checked;
            var col = grdMain.focusedColumn();
            var field = col.getField();
            if (field) {
                field.setUpdatable(checked);
            }
        });
        $('#chkColumnCallback').click(function() {
            var checked = document.getElementById('chkColumnCallback').checked;
            var col = grdMain.focusedColumn();
            if (checked) {
                col.setReadOnlyCallback(function(index) {
                    return index.rowIndex % 2 == 0;
                });
            } else {
                col.setReadOnlyCallback(null);
            }
        });
        $('#chkOptionsCallback').click(function() {
            var checked = document.getElementById('chkOptionsCallback').checked;
            if (checked) {
                grdMain.editOptions().setReadOnlyCallback(function(index) {
                    return index.rowIndex % 3 == 0;
                });
            } else {
                grdMain.editOptions().setReadOnlyCallback(null);
            }
        });

        $('#chkColumnReadOnly').click(function() {
            var checked = document.getElementById('chkColumnReadOnly').checked;
            var col = grdMain.focusedColumn();
            col.setReadOnly(checked);
        });
        $('#chkFixedColumnReadOnly').click(function() {
            var checked = document.getElementById('chkFixedColumnReadOnly').checked;
            grdMain.editOptions().setFixedColumnReadOnly(checked);
        });
        $('#chkFixedRowReadOnly').click(function() {
            var checked = document.getElementById('chkFixedRowReadOnly').checked;
            grdMain.editOptions().setFixedRowReadOnly(checked);
        });
        $('#chkDeletedRowReadOnly').click(function() {
            var checked = document.getElementById('chkDeletedRowReadOnly').checked;
            grdMain.editOptions().setDeletedRowReadOnly(checked);
        });

        $('#chkReadMode2').click(function() {
            var checked = document.getElementById('chkReadMode2').checked;
            grdMain2.setReadMode(checked);
        });

        $('#chkOptionsEditable').click(function() {
            var checked = document.getElementById('chkOptionsEditable').checked;
            grdMain2.setEditOptions({
                editable : checked
            });
        });
        $('#chkColumnEditableCallback').click(function() {
            var checked = document.getElementById('chkColumnEditableCallback').checked;
            var col = grdMain2.focusedColumn();
            if (checked) {
                col.setEditableCallback(function(index) {
                    return index.rowIndex % 2 == 0;
                });
            } else {
                col.setEditableCallback(null);
            }
        });
        $('#chkOptionsEditableCallback').click(function() {
            var checked = document.getElementById('chkOptionsEditableCallback').checked;
            if (checked) {
                grdMain2.editOptions().setEditableCallback(function(index) {
                    return index.rowIndex % 3 == 0;
                });
            } else {
                grdMain2.editOptions().setEditableCallback(null);
            }
        });
        $('#chkFixedColumnEditable').click(function() {
            var checked = document.getElementById('chkFixedColumnEditable').checked;
            grdMain2.editOptions().setFixedColumnEditable(checked);
        });
        $('#chkFixedRowEditable').click(function() {
            var checked = document.getElementById('chkFixedRowEditable').checked;
            grdMain2.editOptions().setFixedRowEditable(checked);
        });
        $('#chkDeletedRowEditable').click(function() {
            var checked = document.getElementById('chkDeletedRowEditable').checked;
            grdMain2.editOptions().setDeletedRowEditable(checked);
        });
        $('#btnFixedRow').click(function() {
            grdMain.displayOptions().setFixedRowCount(2);
        });
        $('#btnFixedColumn').click(function() {
            grdMain.displayOptions().setFixedColumnCount(2);
        });
        $('#btnFixedRow2').click(function() {
            grdMain2.displayOptions().setFixedRowCount(2);
        });
        $('#btnFixedColumn2').click(function() {
            grdMain2.displayOptions().setFixedColumnCount(2);
        });
    });
</script>
<style>
table {
    border-collapse: collapse;
    width: 740px;
}

td, th {
    border: 1px solid #dddddd;
}
</style>
</head>
<body>
    <h3>ReadOnly & Editable</h3>
    <table>
        <tr>
            <td><input type="checkbox" id="chkReadMode">GridBase.readMode</td>
            <td>false</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkOptionsReadOnly">EditOptions.readOnly</td>
            <td>false</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkFieldUpdatable" checked="checked">DataField.updatable</td>
            <td>true</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkColumnCallback">DataColumn.readOnlyCallback</td>
            <td>null</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkOptionsCallback">EditOptions.readOnlyCallback</td>
            <td>null</td>
        </tr>
    </table>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <table>
        <tr>
            <td><input type="checkbox" id="chkColumnReadOnly">DataColumn.readOnly</td>
            <td>false</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkFixedColumnReadOnly">EditOptions.FixedColumnReadOnly</td>
            <td>false</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkFixedRowReadOnly">EditOptions.FixedRowReadOnly</td>
            <td>false</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkDeletedRowReadOnly" checked="checked">EditOptions.DeletedRowReadOnly</td>
            <td>true</td>
        </tr>
    </table>
    <div>
        <button id="btnFixedRow">Fixed Row</button>
        <button id="btnFixedColumn">Fixed Column</button>
    </div>
    <p>
    <table>
        <tr>
            <td><input type="checkbox" id="chkReadMode2">GridBase.readMode</td>
            <td>false</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkOptionsEditable" checked="checked">EditOptions.editable</td>
            <td>true</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkColumnEditableCallback">DataColumn.editableCallback</td>
            <td>null</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkOptionsEditableCallback">EditOptions.editableCallback</td>
            <td>null</td>
        </tr>
    </table>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <table>
        <tr>
            <td><input type="checkbox" id="chkColumnEditable" checked="checked">DataColumn.editable</td>
            <td>true</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkFixedColumnEditable" checked="checked">EditOptions.FixedColumnEditable</td>
            <td>true</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkFixedRowEditable" checked="checked">EditOptions.FixedRowEditable</td>
            <td>true</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkDeletedRowEditable">EditOptions.DeletedRowEditable</td>
            <td>false</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkShowEditor" checked="checked">GridBase.onShowEditor</td>
            <td></td>
        </tr>
    </table>
    <div>
        <button id="btnFixedRow2">Fixed Row</button>
        <button id="btnFixedColumn2">Fixed Column</button>
    </div>
</body>
</html>