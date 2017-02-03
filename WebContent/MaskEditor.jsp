<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Mask Editor</title>
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
        var dsMain, dsMain2;

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

        dsMain2 = DataLudi.createGridDataSet();
        dsMain2.setFields([ {
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

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : 90,
            "styles" : {
                "textAlignment" : "center",
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "CommCode2",
            "fieldName" : "comm_code",
            "width" : 90,
            "styles" : {
                "color" : "#008",
                "textAlignment" : "center",
                "textFormat" : "(\\d{3})(\\d{0,3});$1-$2"
            },
            "header" : {
                "text" : '000-000'
            },
            "editor" : {
                "type" : "mask",
                "mask" : "000-000",
                "fontName" : "monospace",
                "fontSize" : 16
            }
        }, {
            "name" : "CommCode3",
            "fieldName" : "comm_code",
            "width" : 90,
            "styles" : {
                "color" : "#008",
                "textAlignment" : "center",
                "textFormat" : "(\\d{3})(\\d{3});$1-$2"
            },
            "header" : {
                "text" : '999-999'
            },
            "editor" : {
                "type" : "mask",
                "mask" : "999-999",
                "fontName" : "monospace",
                "fontSize" : 16
            }
        }, {
            "name" : "CommCode4",
            "fieldName" : "comm_code",
            "width" : 90,
            "styles" : {
                "color" : "#008",
                "textAlignment" : "center",
                "textFormat" : "(\\d{3})(\\d{0,3});($1)-$2"
            },
            "header" : {
                "text" : '(000)-999'
            },
            "editor" : {
                "type" : "mask",
                "mask" : "(000)-999",
                "fontName" : "monospace",
                "fontSize" : 16
            }
        }, {
            "name" : "CommCode5",
            "fieldName" : "comm_code",
            "width" : 90,
            "styles" : {
                "color" : "#008",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : '{000}-999'
            },
            "displayCallback" : function(index, value) {
                return '***-' + value.substr(3);
            },
            "editor" : {
                "type" : "mask",
                "mask" : "{000}-999",
                "fontName" : "monospace",
                "fontSize" : 16
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
            "name" : "Flow2",
            "fieldName" : "flow",
            "width" : 100,
            "styles" : {
                "textFormat" : "(\\w{3})(\\w{3});$1-$2",
                "color" : "#008",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : ">LLL>-<LLL<"
            },
            "editor": {
                "type": "mask",
                "mask": ">LLL>-<LLL<",
                "fontName" : "monospace",
                "fontSize" : 16
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : 60,
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
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : 200,
            "styles" : {},
            "header" : {
                "text" : "Commodity"
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

        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns([ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : 120,
            "styles" : {
                textAlignment : "center"
            },
            "header" : {
                "text" : "LoanNumber"
            }
        }, {
            "name" : "FirstDate",
            "fieldName" : "first_date",
            "width" : 120,
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "FirstDate",
                "subText" : "0000/00/00",
            },
            "editor" : {
                "type" : "mask",
                "mask" : "0000/00/00",
                "fontName" : "monospace",
                "fontSize" : 16
            }
        }, {
            "name" : "LastDate",
            "fieldName" : "last_date",
            "width" : 120,
            "styles" : {
                "datetimeFormat" : "hh:mm:ss",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "LastTime",
                "subText" : "00:00:00",
            },
            "editor" : {
                "type" : "mask",
                "mask" : "00:00:00",
                "datetimeFormat" : "hh:mm:ss;1",
                "fontName" : "monospace",
                "fontSize" : 16
            }
        }, {
            "name" : "LastDate2",
            "fieldName" : "last_date",
            "width" : 200,
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd hh:mm:ss",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "LastDateTime",
                "subText" : "0000/00/00 00:00:00",
            },
            "editor" : {
                "type" : "mask",
                "mask" : "0000/00/00 00:00:00",
                "includeLiterals" : true,
                "datetimeFormat" : "yyyy/MM/dd hh:mm:ss",
                "fontName" : "monospace",
                "fontSize" : 16
            }
        } ]);

        //grid options
        grdMain.editOptions().setInsertable(true).setAppendable(true);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain.setFooter(false);
        grdMain.vscrollBar().setBarWidth(12);
        grdMain.hscrollBar().setBarWidth(12);
        grdMain.loadStyles({
            body : {
                cell : {
                    fontSize : 16
                }
            }
        });

        grdMain2.editOptions().setInsertable(true).setAppendable(true);
        grdMain2.header().setHeight(35);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain2.header().setSubTextGap(5);
        grdMain2.header().setSubStyles({
            fontSize : 11,
            color : '#800'
        })
        grdMain2.setFooter(false);
        grdMain2.vscrollBar().setBarWidth(12);
        grdMain2.hscrollBar().setBarWidth(12);
        grdMain2.loadStyles({
            body : {
                cell : {
                    fontSize : 16
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

        grdMain2.setDataSource(dsMain2);
        $.ajax({
            url : "data/loan_statement_small.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain2).load("csv", data, {
                    start : 1,
                    count : 57,
                    quoted : true,
                    currency : true
                });
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        dsMain2.onRowCountChanged = function(ds) {
            $("#rowCount2").css("color", "blue").text(ds.rowCount().toLocaleString());
        };

        // grid events
        grdMain.onCurrentChanged = function(grid, index) {
            var col = index.column;
            if (col instanceof DataLudi.DataColumn) {
                var editor = col.editorOptions();

                $('#chkInsertMode')[0].checked = editor.insertMode !== false;
                $('#chkFillEnd')[0].checked = editor.fillFromEnd === true;
                $('#chkSep')[0].checked = !(editor.includeSeparators === true);
                $('#chkLit')[0].checked = editor.includeLiterals === true;
                $('#chkStripEnd')[0].checked = editor.stripEnd === true;
                $('#chkStripBegin')[0].checked = editor.stripBegin === true;
                $('#chkStripInner')[0].checked = editor.stripInner === true;
            }
        };

        grdMain2.onCurrentChanged = function(grid, index) {
            var col = index.column;
            if (col instanceof DataLudi.DataColumn) {
                var editor = col.editorOptions();

                $('#chkInsertMode2')[0].checked = editor.insertMode !== false;
                $('#chkFillEnd2')[0].checked = editor.fillFromEnd === true;
                $('#chkSep2')[0].checked = !(editor.includeSeparators === false);
                $('#chkLit2')[0].checked = editor.includeLiterals === true;
                $('#chkStripEnd2')[0].checked = editor.stripEnd === true;
                $('#chkStripBegin2')[0].checked = editor.stripBegin === true;
                $('#chkStripInner2')[0].checked = editor.stripInner === true;
            }
        };

        // buttons
        $('#chkCheckMaxValue').click(function() {
            var checked = $('#chkCheckMaxValue').is(':checked');
            var col = grdMain.columnByName('DisbursedAmount');
            col.setEditor({
                checkMaxValue : checked
            });
        });
        $('#chkInsertMode').click(function() {
            var checked = $('#chkInsertMode').is(':checked');
            var col = grdMain.focusedColumn();
            if (col) {
                col.setEditor({
                    insertMode : checked
                });
            }
        });
        $('#chkFillEnd').click(function() {
            var checked = $('#chkFillEnd').is(':checked');
            var col = grdMain.focusedColumn();
            if (col) {
                col.setEditor({
                    fillFromEnd : checked
                });
            }
        });
        $('#chkSep').click(function() {
            var checked = $('#chkSep').is(':checked');
            var col = grdMain.focusedColumn();
            if (col) {
                col.setEditor({
                    includeSeparators : checked
                });
            }
        });
        $('#chkLit').click(function() {
            var checked = $('#chkLit').is(':checked');
            var col = grdMain.focusedColumn();
            if (col) {
                col.setEditor({
                    includeLiterals : checked
                });
            }
        });
        $('#chkStripEnd').click(function() {
            var checked = $('#chkStripEnd').is(':checked');
            var col = grdMain.focusedColumn();
            if (col) {
                col.setEditor({
                    stripEnd : checked
                });
            }
        });
        $('#chkStripBegin').click(function() {
            var checked = $('#chkStripBegin').is(':checked');
            var col = grdMain.focusedColumn();
            if (col) {
                col.setEditor({
                    stripBegin : checked
                });
            }
        });
        $('#chkStripInner').click(function() {
            var checked = $('#chkStripInner').is(':checked');
            var col = grdMain.focusedColumn();
            if (col) {
                col.setEditor({
                    stripInner : checked
                });
            }
        });
        $('#chkInsertMode2').click(function() {
            var checked = $('#chkInsertMode2').is(':checked');
            var col = grdMain2.focusedColumn();
            if (col) {
                col.setEditor({
                    insertMode : checked
                });
            }
        });
        $('#chkFillEnd2').click(function() {
            var checked = $('#chkFillEnd2').is(':checked');
            var col = grdMain2.focusedColumn();
            if (col) {
                col.setEditor({
                    fillFromEnd : checked
                });
            }
        });
        $('#chkSep2').click(function() {
            var checked = $('#chkSep2').is(':checked');
            var col = grdMain2.focusedColumn();
            if (col) {
                col.setEditor({
                    includeSeparators : checked
                });
            }
        });
        $('#chkLit2').click(function() {
            var checked = $('#chkLit2').is(':checked');
            var col = grdMain2.focusedColumn();
            if (col) {
                col.setEditor({
                    includeLiterals : checked
                });
            }
        });
        $('#chkStripEnd2').click(function() {
            var checked = $('#chkStripEnd2').is(':checked');
            var col = grdMain2.focusedColumn();
            if (col) {
                col.setEditor({
                    stripEnd : checked
                });
            }
        });
        $('#chkStripBegin2').click(function() {
            var checked = $('#chkStripBegin2').is(':checked');
            var col = grdMain2.focusedColumn();
            if (col) {
                col.setEditor({
                    stripBegin : checked
                });
            }
        });
        $('#chkStripInner2').click(function(ev) {
            var checked = $('#chkStripInner2').is(':checked');
            var col = grdMain2.focusedColumn();
            if (col) {
                col.setEditor({
                    stripInner : ev.target.checked
                });
            }
        });
    });
</script>
</head>
<body>
    <h3>Mask Editor</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <table>
        <tr>
            <td><input type="checkbox" id="chkInsertMode" checked="checked">Insert Mode</td>
            <td><span>insertMode가 false면 덮어쓰기 방식으로 편집된다.</span></td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkFillEnd">Fill from End</td>
            <td><span>fillFromEnd가 true면 셀 값을 편집기로 가져갈 때 셀 값의 길이가 마지막부터 채운다. </span></td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkSep" checked="checked">Include Separators</td>
            <td><span>includeSeparators가 true면 셀 값을 저장할 때 구분 문자들을 포함시킨다. </span></td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkLit">Include Literals</td>
            <td><span>includeLiterals가 true면 셀 값을 저장할 때 Literal들을 포함시킨다.</span></td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkStripEnd">Strip End Blanks</td>
            <td><span>stripEnd가 true면 셀 값을 저장할 때 텍스트의 끝 공백들을 제거한다.</span></td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkStripBegin">Strip Begin Blanks</td>
            <td><span>stripBegin이 true면 셀 값을 저장할 때 시작 공백들을 제거한다</span></td>
        </tr>
        <tr>
            <td><input type="checkbox" id="chkStripInner">Strip Inner Blanks</td>
            <td><span>stripInner가 true면 셀 값을 저장할 때 중간 공백들을 제거한다. </span></td>
        </tr>
    </table>
    <p>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkInsertMode2" checked="checked">Insert Mode
        <input type="checkbox" id="chkFillEnd2">Fill from End
    </div>
    <div>
        <input type="checkbox" id="chkSep2" checked="checked">Include Separators
        <input type="checkbox" id="chkLit2">Include Literals
        <input type="checkbox" id="chkStripEnd2">Strip End
        <input type="checkbox" id="chkStripBegin2">Strip Begin
        <input type="checkbox" id="chkStripInner2">Strip Inner
    </div>
</body>
</html>