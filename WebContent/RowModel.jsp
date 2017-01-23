<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Model</title>
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

        // grid
        var columns = [ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : "110",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "65",
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
            "width" : 80,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Trade",
                "subText" : "(USD)",
                "subStyles" : {
                    "color" : "#f00",
                    "fontSize" : 10,
                    "fontBold" : false
                }
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
            "width" : 90,
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
            "width" : 110,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns(columns);
        grdMain2.setColumns(columns);

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_s.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 500,
                    quoted : true,
                    currency : true
                });

                grdMain.groupBy([ 'country', 'comm_code' ]);
                grdMain.collapse(grdMain.getRow(0));
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        //grid options
        grdMain.vscrollBar().setBarWidth(14);
        grdMain.checkBar().setVisible(true);
        grdMain.footer().setVisible(false);
        grdMain.groupPanel().setVisible(true);
        grdMain.header().setHeight(30);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain.rowGroup().setDisplayMode("banded");

        grdMain2.setMaxRowCount(50);
        grdMain2.vscrollBar().setBarWidth(14);
        grdMain2.checkBar().setVisible(false);
        grdMain2.footer().setVisible(false);
        grdMain2.groupPanel().setVisible(false);
        grdMain2.header().setHeight(30);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain2.displayOptions().setSelectStyle(DataLudi.SelectionStyle.ROWS);
        
        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };

        // grid events
        // buttons
        $('#chkMerged').click(function() {
            var checked = ev.target.checked;
            grdMain.rowGroup().setDisplayMode(checked ? DataLudi.RowGroupDisplayMode.MERGED : DataLudi.RowGroupDisplayMode.BANDED);
        });
        $('#btnFindRow').click(function() {
            var country = $('#edtCountry').val();
            var year = $('#edtYear').val();
            var datarow = dsMain.findRow([ 'country', 'year' ], [ country, year ]);
            if (datarow >= 0) {
                var row = grdMain.getRowOfDataIndex(datarow);
                if ($('#chkRevealRow')[0].checked) {
                    grdMain.revealRow(row, true, true);
                }
            }
        });
        $('#btnGetParent').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                row = row.parent();
                row && grdMain.setFocusedRow(row, true);
            }
        });
        $('#btnGetAncestors').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                rows = row.getAncestors();
                grdMain.checkAll(false);
                grdMain.checkRows(rows, true);
            }
        });
        $('#btnGetSiblings').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                rows = row.getSiblings();
                grdMain.checkAll(false);
                grdMain.checkRows(rows, true);
            }
        });
        $('#btnGetUncles').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                rows = row.getUncles();
                grdMain.checkAll(false);
                grdMain.checkRows(rows, true);
            }
        });
        $('#btnGetLeaves').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                rows = row.getLeaves(false, $('#chkDataOnly')[0].checked);
                grdMain.checkAll(false);
                grdMain.checkRows(rows, true);
            }
        });
        $('#btnGetTopRows').click(function() {
            rows = grdMain.getTopRows();
            grdMain.checkAll(false);
            grdMain.checkRows(rows, true);
        });
        $('#btnGetLeafRows').click(function() {
            rows = grdMain.getLeafRows(false, $('#chkGridDataOnly')[0].checked);
            grdMain.checkAll(false);
            grdMain.checkRows(rows, true);
        });
        $('#btnGetAllRowsData').click(function() {
            var rows = grdMain2.getAllRows();
            rows = grdMain2.getDataIndicesOfRows(rows);
            rows = dsMain.getRows(rows);
            document.getElementById('conMain').value = JSON.stringify(rows);

        });
        $('#btnGetAllRowsObject').click(function() {
            var rows = grdMain2.getAllRows();
            rows = grdMain2.getDataIndicesOfRows(rows);
            rows = dsMain.getRowObjects(rows);
            document.getElementById('conMain').value = JSON.stringify(rows);
        });
        $('#btnGetRowsData').click(function() {
            var rows = grdMain2.getSelectedRows();
            rows = grdMain2.getDataIndicesOfRows(rows);
            rows = dsMain.getRows(rows);
            document.getElementById('conMain').value = JSON.stringify(rows);
        });
        $('#btnGetRowsObject').click(function() {
            var rows = grdMain2.getSelectedRows();
            rows = grdMain2.getDataIndicesOfRows(rows);
            rows = dsMain.getRowObjects(rows);
            document.getElementById('conMain').value = JSON.stringify(rows);
        });
    });
</script>
</head>
<body>
    <h3>Row Model</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkMerged">병합 모드 그룹핑 
        <br>
        <button id="btnFindRow">Find Row</button>
        국가:<input type="text" id="edtCountry" value="Albania">
        년도:<input type="text" id="edtYear" value="1999">
        <input type="checkbox" id="chkRevealRow" checked="checked">Reveal Row <br>
        <button id="btnGetParent">Get Parent</button>포커스 행의 부모 행을 선택한다.
        <br>
        <button id="btnGetAncestors">Get Ancestors</button>포커스 행의 조상 행들을 check한다.
        <br>
        <button id="btnGetSiblings">Get Siblings</button>포커스 행의 형제 행들을 check한다.
        <br>
        <button id="btnGetUncles">Get Uncles</button>포커스 행의 삼촌 행들을 check한다.
        <br>
        <button id="btnGetLeaves">Get Leaves</button>포커스 행에 포함된 Leaf 행들을 check한다.
        <input type="checkbox" id="chkDataOnly">데이터행들만 포함
        <br>
        <button id="btnGetTopRows">Grid Top Rows</button>그리드의 최상위 행들을 check한다.
        <br>
        <button id="btnGetLeafRows">Grid Leaf Rows</button>그리드의 최하위 행들을 check한다.
        <input type="checkbox" id="chkGridDataOnly">데이터행들만  포함
    </div>
    <p>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <div>
        <button id="btnGetAllRowsData">Get All Rows Data</button>그리드에 표시된 순서대로 행들의 데이터를 가져온다.
        <br>
        <button id="btnGetAllRowsObject">Get All Rows Object</button>그리드에 표시된 순서대로 행들의 데이터를 Json 객체로 가져온다.
        <br>
        <button id="btnGetRowsData">Get Selected Rows Data</button>그리드에 선택된 행들의 데이터를 가져온다.
        <br>
        <button id="btnGetRowsObject">Get Selected Rows Object</button>그리드에 선택된 행들의 데이터를 Json 객체로 가져온다.
    </div>
    <textarea id="conMain" class="helpMemo" style="width: 730px; min-height: 200px;"></textarea>
</body>
</html>