<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Text Cell Editors</title>
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
        grdMain = DataLudi.createGridView("container");
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Country"
            },
            "editor" : {
                "maxLength" : 20
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
            "button" : "action",
            "buttonVisibility" : "always",
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
            "footer" : {
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
            "footer" : {
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
        } ]);

        grdMain2.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Country"
            },
            "editor" : {
                "maxLength" : 20
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
            "width" : "300",
            "styles" : {
                "background" : "#0f0088ff",
                "textWrap" : DataLudi.TextWrap.EXPLICIT
            },
            "header" : {
                "text" : "Commodity"
            },
            "editor" : {
                "type" : "multiline",
                "maxLength" : 200
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
        } ]);

        //grid options
        grdMain.editOptions().setInsertable(true).setAppendable(true);
        grdMain.header().setHeight(0);
        grdMain.body().setCellDynamicStyles([ {
            expression : "tag == 'sel'",
            styles : {
                background : "#1000ff00"
            }
        } ]);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.editOptions().setInsertable(true).setAppendable(true);
        grdMain2.header().setHeight(0);
        grdMain2.displayOptions().setRowHeight(50);
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
                    count : 7,
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

        // grid events        
        grdMain.onCellButtonClicked = function(grid, index) {
            alert(index.column.name() + '컬럼 ' + index.rowIndex + '행 버튼 클릭');
        };
        grdMain.onCurrentChanged = function(grid, index) {
            grid.clearColumnTags(true);
            var col = index.column;

            if (col) {
                col.setTag("sel");

                var maxLength = col.editorOptions().maxLength;
                var textCase = col.editorOptions().textCase;
                $('#edtMaxLength').val(isNaN(maxLength) ? 0 : maxLength);

                if (textCase) {
                    $('input[name=rgpTextCase][value=' + textCase + ']').prop('checked', true);
                } else {
                    $('input[name=rgpTextCase][value=default]').prop('checked', true);
                }

                v = col.textInputCase();
                $('input[name=rgpColumnCase][value=' + v + ']').prop('checked', true);
            }
        };

        // buttons
        $('#btnMaxLength').click(function() {
            var col = grdMain.focusedColumn();
            if (col) {
                col.setEditor({
                    maxLength : Number($('#edtMaxLength').val())
                });
            }
        });
        $('input:radio[name=rgpTextCase]').click(function() {
            var col = grdMain.focusedColumn();
            if (col) {
                /*var c = $("input[name='rgpRowState']:checked").val();*/
                var c = $("input[name=rgpTextCase]:checked").val();
                col.setEditor({
                    textCase : c
                });
            }
        });
        $('input:radio[name=rgpColumnCase]').click(function() {
            var value = $("input[name=rgpColumnCase]:checked").val();
            var col = grdMain.focusedColumn();
            col && col.setTextInputCase(value);
        });
    });
</script>
</head>
<body>
    <h3>Text Cell Editors</h3>
    <div>
        <button id="btnMaxLength">Set Max Length</button>
        <input type="text" id="edtMaxLength" value="20">
    </div>
    <div>
        <span>Text Input Case: </span>
        <input type="radio" name="rgpTextCase" value="normal">DataLudi.TextInputCase.NORMAL
        <input type="radio" name="rgpTextCase" value="upper">UPPER
        <input type="radio" name="rgpTextCase" value="lower">LOWER
        <input type="radio" name="rgpTextCase" value="default" checked="checked">DEFAULT
    </div>
    <div>
        <span>Column Text Case: </span>
        <input type="radio" name="rgpColumnCase" value="normal" checked="checked">DataLudi.TextInputCase.NORMAL
        <input type="radio" name="rgpColumnCase" value="upper">UPPER
        <input type="radio" name="rgpColumnCase" value="lower">LOWER
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <p>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>