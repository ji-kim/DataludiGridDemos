<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Counts</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
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
        grdMain.setColumns(columns);

        //grid options
        grdMain.vscrollBar().setBarWidth(14);
        grdMain.checkBar().setVisible(false);
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
        grdMain.setEditOptions({
            insertable : true,
            appendable : true,
            deletable : true
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_s.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
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

        // grid events
        grdMain.onRowCountChanged = function(grid, newCount, oldCount) {
            $('#txtRowCount').text(newCount.toLocaleString());
        };
        grdMain.onDisplayRowCountChanged = function(grid, newCount, oldCount) {
            $('#txtDisplayCount').text(newCount);
        };
        grdMain.onDescendantRowCountChanged = function(grid, newCount, oldCount) {
            $('#txtDescendantRowCount').text(newCount.toLocaleString());
        };
        grdMain.onDescendantDataCountChanged = function(grid, newCount, oldCount) {
            $('#txtDescendantDataCount').text(newCount.toLocaleString());
        };

        // buttons
        $('#btnRowCounts').click(function() {
            $('#txtRowCount2').text(grdMain.rowCount().toLocaleString());
            $('#txtDisplayCount2').text(grdMain.displayRowCount().toLocaleString());
            $('#txtDescendantRowCount2').text(grdMain.descendantRowCount().toLocaleString());
            $('#txtDescendantDataCount2').text(grdMain.descendantDataCount().toLocaleString());
        });
    });
</script>
</head>
<body>
    <h3>Row Counts</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <span>rowCount</span>
    <span id="txtRowCount"></span>
    <span id="txtRowCount2" style="color: red"></span>
    <br>
    <span>displayRowCount</span>
    <span id="txtDisplayCount"></span>
    <span id="txtDisplayCount2" style="color: red"></span>
    <br>
    <span>descendantRowCount</span>
    <span id="txtDescendantRowCount"></span>
    <span id="txtDescendantRowCount2" style="color: red"></span>
    <br>
    <span>descendantDataCount</span>
    <span id="txtDescendantDataCount"></span>
    <span id="txtDescendantDataCount2" style="color: red"></span>
    <br>
    <button id="btnRowCounts">Get Row Counts</button>각 개수 속성값을 가져와서 해당하는 위치의 우측에 붉은색으로 표시한다.
</body>
</html>