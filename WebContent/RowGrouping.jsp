<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Grouping</title>
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
            fieldName: "country"
        }, {
            fieldName: "year",
            dataType: "number"
        }, {
            fieldName: "comm_code"
        }, {
            fieldName: "commodity"
        }, {
            fieldName: "flow"
        }, {
            fieldName: "trade",
            dataType: "number"
        }, {
            fieldName: "weight",
            dataType: "number"
        }, {
            fieldName: "unit"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name": "Country",
            "fieldName": "country",
            "width": "70",
            "styles": {
            },
            "header": {
                "text": "Country"
            }
        }, {
            "name": "CommCode",
            "fieldName": "comm_code",
            "width": "110",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "CommCode"
            }
        }, {
            "name": "Commodity",
            "fieldName": "commodity",
            "width": "90",
            "styles": {
            },
            "header": {
                "text": "Commodity"
            }
        }, {
            "name": "Year",
            "fieldName": "year",
            "width": "65",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "Year"
            }
        }, {
            "name": "Flow",
            "fieldName": "flow",
            "width": 60,
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "Flow"
            }
        }, {
            "name": "Trade",
            "fieldName": "trade",
            "width": 80,
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0"
            },
            "header": {
                "text": "Trade",
                "subText": "(USD)",
                "subStyles": {
                    "color": "#f00",
                    "fontSize": 10,
                    "fontBold": false
                }
            },
            "groupFooter": {
                "expression": "sum",
                "styles": {
                    "textAlignment": "far",
                    "numberFormat": "#,##0"
                }
            }
        }, {
            "name": "Weight",
            "fieldName": "weight",
            "width": 90,
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0"
            },
            "header": {
                "text": "Weight"
            },
            "groupFooter": {
                "expression": "sum",
                "styles": {
                    "textAlignment": "far",
                    "numberFormat": "#,##0"
                }
            }
        }, {
            "name": "Unit",
            "fieldName": "unit",
            "width": 110,
            "styles": {
            },
            "header": {
                "text": "Unit"
            }
        } ]);

        //grid options
        grdMain.vscrollBar().setBarWidth(14);
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(false);
        grdMain.groupPanel().setVisible(true);
        grdMain.header().setHeight(30);
        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url: "data/un_comtrade_of_goods_s.csv",
            dataType: 'text',
            success: function (data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start: 1,
                    quoted: true,
                    currency: true
                });
            },
            error: function (xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events
        grdMain.onGrouping = function (grid, fields) {
            if (!document.getElementById('chkGrouping').checked) {
                return false;
            }
        };
        grdMain.onGrouped = function () {
            console.log('Row grouping is changed.');
        };
        
        grdMain.rowGroup().setDisplayMode("banded")

        // buttons
        $('input:radio[name=rgpExpandedAdornments]').click(function() {
            var value = $("input[name=rgpExpandedAdornments]:checked").val();
            grdMain.rowGroup().setExpandedAdornments(value);
        });
        $('input:radio[name=rgpCollapsedAdornments]').click(function() {
            var value = $("input[name=rgpCollapsedAdornments]:checked").val();
            grdMain.rowGroup().setCollapsedAdornments(value);
        });
        $('#btnClear').click(function() {
            grdMain.clearGroupBy();
        });
        $('#btnGroupBy').click(function() {
            grdMain.groupBy(['country', 'flow']);
        });
        $('#btnRemove').click(function() {
            var column = grdMain.focusedColumn();
            if (grdMain.isGrouped(column)) {
                grdMain.removeGroupBy(column);
            }
        });        
        $('#btnPrompt').click(function() {
            grdMain.groupPanel().setPrompt(document.getElementById('edtPrompt').value);  
        });
        $('#btnSetStyles').click(function() {
            grdMain.loadStyles({
                groupPanel: {
                    background: "#fffad2",
                    item: {
                        background: "#eee8aa"
                    },
                    head: {
                        background: "#eeeea8"
                    }
                }
            });
        });
        $('#btnExport').click(function() {
        	new DataLudi.GridExcelExporter().export(grdMain, {
                target: "local",
                fileName: "dlgrid.xlsx",
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd"
            });
        });
    });
</script>
</head>
<body>
    <h3>Row Grouping</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <span>RowGroup.expandedAdornments : </span>
	    <input type="radio" name="rgpExpandedAdornments" value="both" checked="checked">RowGroupAdornments.BOTH
	    <input type="radio" name="rgpExpandedAdornments" value="header">HEADER
	    <input type="radio" name="rgpExpandedAdornments" value="footer">FOOTER
	    <input type="radio" name="rgpExpandedAdornments" value="none">NONE
    </div>
    <div>
        <span>RowGroup.collapsedAdornments : </span>
        <input type="radio" name="rgpCollapsedAdornments" value="both" checked="checked">RowGroupAdornments.BOTH
        <input type="radio" name="rgpCollapsedAdornments" value="header">HEADER
    </div>
    <div>
        <input type="checkbox" id="chkGrouping" checked="checked">Can Grouping
        <span>onGrouping 이벤트 내에서 명시적으로 false를 리턴하면 그룹핑 변경이 진행되지 않는다. </span>
    </div>
    <div>
        <button id="btnClear">Clear Grouping</button>
    </div>
    <div>
        <button id="btnGroupBy">Group By</button>
        <span>"국가" 와 "수출입" 필드로 그룹핑한다. </span>
    </div>
    <div>
        <button id="btnRemove">Remove Group By</button>
        <span>선택된 컬럼을 행그룹핑에서 제외시킨다.</span>
    </div>
    <div>
        <input type="text" id="edtPrompt" value="20">
        <button id="btnPrompt">Set Grouping Prompt</button>
    </div>
    <button id="btnSetStyles">Set Styles</button> 
    <button id="btnExport">Export</button>   
</body>
</html>