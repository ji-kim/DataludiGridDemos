<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Inserting</title>
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

        // grid
        columns = [ {
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
            "defaultExpression" : "rand 1000000",
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
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns(columns);
        grdMain2.setColumns(columns);

        //grid options
        grdMain.editOptions().setInsertable(true).setAppendable(true);
        grdMain.header().setHeight(0);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.editOptions().setInsertable(true).setAppendable(true);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // grid styles
        grdMain2.loadStyles(flatbluestyles);

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
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
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };
        dsMain.onRowInserted = function(ds, row) {
            console.log('Data row inserted at ' + row);
        };

        // grid events        
        grdMain.onInserting = function(grid, rowIndex) {
            if ($('#chkEventInsertable').is(':checked')) {
                return false;
            }
        };

        // buttons
        $('#chkInsertable').click(function() {
            var checked = document.getElementById('chkInsertable').checked;
            grdMain.setEditOptions({
                insertable : checked
            });
        });
        $('#chkAppendable').click(function() {
            var checked = document.getElementById('chkAppendable').checked;
            grdMain.setEditOptions({
                appendable : checked
            });
        });
        $('#edtDefault').change(function() {
            var value = document.getElementById('edtDefault').val();
            grdMain.columnByName('Country').setDefaultValue(value);
        });
        $('#edtExpression').change(function() {
            var value = document.getElementById('edtExpression').val();
            grdMain.columnByName('CommCode').setDefaultExpression(value);
        });
        $('#btnInsert').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                grdMain2.insert(row);
                grdMain2.setFocus();
            }
        });
        $('#btnAppend').click(function() {
            grdMain2.append();
            grdMain2.setFocus();
        });
    });
</script>
</head>
<body>
    <h3>Row Inserting</h3>
    <div>
        <input type="checkbox" id="chkInsertable" checked="checked">Insertable
        <input type="checkbox" id="chkAppendable" checked="checked">Appendable
        <span>'국가'의 기본값</span>
        <input type="text" id="edtDefault" value="Japan">
        <span>'제품코드'의 기본값 수식</span>
        <input type="text" id="edtExpression" value="rand 1000000">
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkEventInsertable">Not Insertable in Event
    </div>
    <div>
        <button id="btnInsert">Insert Row</button>
        <button id="btnAppend">Append Row</button>
    </div>
    <p>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>