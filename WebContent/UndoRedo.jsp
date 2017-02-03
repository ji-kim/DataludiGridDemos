<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Undo & Redo</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "product_id",
        }, {
            fieldName : "product_name",
        }, {
            fieldName : "customer_id",
        }, {
            fieldName : "customer_name",
        }, {
            fieldName : "country",
        }, {
            fieldName : "phone",
        }, {
            fieldName : "unit",
        }, {
            fieldName : "currency",
        }, {
            fieldName : "unit_price",
            dataType : "number"
        }, {
            fieldName : "quantity",
            dataType : "number"
        }, {
            fieldName : "order_date",
            dataType : "datetime",
            datetimeFormat : "yyyy-MM-dd"
        }, {
            fieldName : "ship_date",
            dataType : "datetime",
            datetimeFormat : "iso"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : 90,
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 50,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "filters" : [ {
                "name" : "High Price",
                "expression" : "value > 800"
            }, {
                "name" : "Mid Price",
                "expression" : "(value > 500) && (value <= 800)"
            }, {
                "name" : "Low Price",
                "expression" : "value <= 500"
            } ]
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 50,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "fontName" : "Arial",
                    "fontBold" : true,
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 70,
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : 60,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "50",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "CustomerName",
            "fieldName" : "customer_name",
            "width" : 80,
            "styles" : {},
            "header" : {
                "text" : "CustomerName"
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : 90,
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "OrderDate"
            }
        }, {
            "name" : "ShipDate",
            "fieldName" : "ship_date",
            "width" : 90,
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ShipDate"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            rowIndicator : {
                stateVisible : true
            },
            checkBar : true,
            header : {
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            vscrollBar : {
                barWidth : 12
            },
            hscrollBar : {
                barWidth : 12
            },
            edit : {
                insertable : true,
                appendable : true,
                deletable : true,
                erasable : true
            }
        });
        grdMain.setUndoable(true);
        document.getElementById('btnUndo').disabled = true;
        document.getElementById('btnRedo').disabled = true;
        grdMain.onUndoStateChanged = function(grid, canUndo, canRedo) {
            document.getElementById('btnUndo').disabled = !canUndo;
            document.getElementById('btnRedo').disabled = !canRedo;
        },

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/orders_s.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1
                });
                dsMain.setUndoable(true);
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });
        grdMain.setFocus();

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#chkDataSetUndoable').click(function() {
            var checked = $('#chkDataSetUndoable').is(':checked');
            dsMain.setUndoable(checked);
            grdMain.setFocus();
        });
        $('#chkGridUndoable').click(function() {
            var checked = $('#chkGridUndoable').is(':checked');
            grdMain.setUndoable(checked);
            grdMain.setFocus();
        });
        $('#btnUndo').click(function() {
            grdMain.undo();
            grdMain.setFocus();
        });
        $('#btnRedo').click(function() {
            grdMain.redo();
            grdMain.setFocus();
        });
        $('#chkErasable').click(function() {
            var checked = $('#chkErasable').is(':checked');
            grdMain.editOptions().setErasable(checked);
            grdMain.setFocus();
        });
        $('#chkUpdateByCell').click(function() {
            var checked = $('#chkUpdateByCell').is(':checked');
            grdMain.editOptions().setUpdateByCell(checked);
            grdMain.setFocus();
        });
        $('#chkInsertByCell').click(function() {
            var checked = $('#chkInsertByCell').is(':checked');
            grdMain.editOptions().setInsertByCell(checked);
            grdMain.setFocus();
        });
        $('#chkSoftDelete').click(function() {
            var checked = $('#chkSoftDelete').is(':checked');
            dsMain.setSoftDelete(checked);
            grdMain.setFocus();
        });
        $('#btnClearData').click(function() {
            grdMain.clearUndo(true);
            grdMain.setFocus();
        });
        $('#btnClearGrid').click(function() {
            grdMain.clearUndo(false);
            grdMain.setFocus();
        });
    });
</script>
</head>
<body>
    <h3>Undo & Redo</h3>
    <div>
        <button id="btnUndo">Undo</button>
        <button id="btnRedo">Redo</button>
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <table>
        <tr>
            <td><input type="checkbox" id="chkDataSetUndoable" checked="checked">DataSet.undoable</td>
            <td>이 값을 변경하면 기존 DataSet Undo 목록이 지워진다.</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkGridUndoable" checked="checked">GridBase.undoable</td>
            <td>이 값을 변경하면 기존 Grid Undo 목록이 지워진다.</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkErasable" checked="checked">EditOptions.erasable</td>
            <td>이 속성을 true로 지정하면 선택영역의 값들을 Delete 키로 지운다.</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkUpdateByCell">EditOptions.updateByCell</td>
            <td>이 속성을 true로 지정하면 수정 행에서 셀 단위로 커밋한다.</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkInsertByCell">EditOptions.insertByCell</td>
            <td>이 속성을 true로 지정하면 추가 행에서 셀 단위로 커밋한다.</td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkSoftDelete">DataSet.softDelete</td>
            <td></td>
        </tr>
    </table>
    <div>
        <button id="btnClearData">Clear DataSet Undo</button>
        <br>
        <button id="btnClearGrid">Clear Grid Undo</button>
    </div>
</body>
</html>