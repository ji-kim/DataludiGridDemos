<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Edit Keys</title>
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
            fieldName : "commodsity"
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
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
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
            "width" : 120,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);
        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns(columns);

        //grid options
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.editOptions().setInsertable(true).setAppendable(true).setDeletable(true).setCrossWhenExitLast(true);
        grdMain2.rowIndicator().setStateVisible(true);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_ss.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 10,
                    quoted : true,
                    currency : true
                });
                grid.setFocusedIndex(0, grid.getFirstColumn());
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

        // buttons
        $('#chkUseTabKey').click(function() {
            var checked = $('#chkUseTabKey').is(':checked');
            grdMain.setProperty('editOptions.useTabKey', checked).setFocus();
        });
        $('#chkEnterToTab').click(function() {
            var checked = $('#chkEnterToTab').is(':checked');
            grdMain.setProperty('editOptions.enterToTab', checked).setFocus();
        });
        $('#chkEnterToNextRow').click(function() {
            var checked = $('#chkEnterToNextRow').is(':checked');
            grdMain.setProperty('editOptions.enterToNextRow', checked).setFocus();
        });
        $('#chkEnterToEdit').click(function() {
            var checked = $('#chkEnterToEdit').is(':checked');
            grdMain.setProperty('editOptions.enterToEdit', checked).setFocus();
        });
        $('#chkCrossWhenExitLast').click(function() {
            var checked = $('#chkCrossWhenExitLast').is(':checked');
            grdMain.setProperty('editOptions.crossWhenExitLast', checked).setFocus();
        });
        $('#chkCrossWhenExitFirst').click(function() {
            var checked = $('#chkCrossWhenExitFirst').is(':checked');
            grdMain.setProperty('editOptions.crossWhenExitFirst', checked).setFocus();
        });
        $('#chkCrossWhenExitLast2').click(function() {
            var checked = $('#chkCrossWhenExitLast2').is(':checked');
            grdMain2.setProperty('editOptions.crossWhenExitLast', checked).setFocus();
        });
        $('#chkAppendWhenInsertKey').click(function() {
            var checked = $('#chkAppendWhenInsertKey').is(':checked');
            grdMain2.setProperty('editOptions.appendWhenInsertKey', checked).setFocus();
        });
        $('#chkAppendWhenExitLast').click(function() {
            var checked = $('#chkAppendWhenExitLast').is(':checked');
            grdMain2.setProperty('editOptions.appendWhenExitLast', checked).setFocus();
        });
        $('#chkCommitOnLastCell').click(function() {
            var checked = $('#chkCommitOnLastCell').is(':checked');
            grdMain2.setProperty('editOptions.commitOnLastCell', checked).setFocus();
        })
    });
</script>
</head>
<body>
    <h3>Edit Keys</h3>
    <div>
        <input type="checkbox" id="chkUseTabKey" checked="checked">use TabKey
        <br>
        <input type="checkbox" id="chkEnterToTab" checked="checked">enterToTab
        <br>
        <input type="checkbox" id="chkEnterToNextRow">enterToNextRow
        <br>
        <input type="checkbox" id="chkEnterToEdit">enterToEdit
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkCrossWhenExitLast">crossWhenExitLast
        <br>
        <input type="checkbox" id="chkCrossWhenExitFirst">crossWhenExitFirst
    </div>
    <p>
    <div>
        <input type="checkbox" id="chkAppendWhenInsertKey">appendWhenInsertKey
        <br>
        <input type="checkbox" id="chkCrossWhenExitLast2" checked="checked">crossWhenExitLast
        <br>
        <input type="checkbox" id="chkAppendWhenExitLast">appendWhenExitLast
        <br>
        <input type="checkbox" id="chkCommitOnLastCell">commitOnLastCell
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>